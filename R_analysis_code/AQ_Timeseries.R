header <- "
############################# TIME SERIES PLOT ####################################
### AMET CODE: AQ_Timeseries.R
###
### This script is part of the AMET-AQ system.  It plots single timeseries for a 
### single species, single network for multiple simulations. Data are averaged across
### time and space to create single time series. The script also plots the bias, RMSE
### and correlation.
###
### Last updated by Wyat Appel: Mar 2021 
###################################################################################
"
## get some environmental variables and setup some directories
ametbase        <- Sys.getenv("AMETBASE")			# base directory of AMET
ametR           <- paste(ametbase,"/R_analysis_code",sep="")    # R directory

## source miscellaneous R input file 
source(paste(ametR,"/AQ_Misc_Functions.R",sep=""))     # Miscellanous AMET R-functions file

### Retrieve units label from database table ###
network <- network_names[1]
species <- species[1]
#units_qs <- paste("SELECT ",species," from project_units where proj_code = '",run_name1,"' and network = '",network,"'", sep="")
#model_name_qs <- paste("SELECT model from aq_project_log where proj_code ='",run_name1,"'", sep="")
################################################

### Set file names and titles ###
if(!exists("dates")) { dates <- paste(start_date,"-",end_date) }
{
   if (custom_title == "") { 
      main.title 	<- paste(run_name1,species,"for",network_label[1],"for",dates,sep=" ") 
      main.title.bias 	<- paste(run_name1,species,"for",network_label[1],"for",dates,sep=" ")
   }
   else { 
     main.title   <- custom_title
     main.title.bias <- custom_title
  }
}
sub.title	<- ""


filename_txt <- paste(run_name1,species,pid,"timeseries_data.csv",sep="_")

## Create a full path to file
filename_txt	<- paste(figdir,filename_txt,sep="/")           # Filename for diff spatial plot

#######################
### Set NULL values ###
#######################
Obs_Mean	<- NULL
Mod_Mean	<- NULL
Obs_Period_Mean	<- NULL
Mod_Period_Mean	<- NULL
Bias_Mean	<- NULL
CORR		<- NULL
RMSE		<- NULL
Dates		<- NULL
All_Data.df	<- NULL
Num_Obs		<- NULL
ymin		<- NULL
ymax		<- NULL
bias_min        <- NULL
bias_max        <- NULL
corr_min	<- NULL
corr_max	<- NULL
rmse_max	<- NULL
rmse_min	<- NULL
x_label		<- "Date"
#######################

labels <- c(network,run_names)
num_runs <- length(run_names)

for (j in 1:num_runs) {	# For each simulation being plotted
   run_name <- run_names[j]
   #############################################
   ### Read sitex file or query the database ###
   #############################################
   {
      if (Sys.getenv("AMET_DB") == 'F') {
         outdir           <- "OUTDIR" 
         if (j >1) { outdir <- paste("OUTDIR",j,sep="") }
         sitex_info       <- read_sitex(Sys.getenv(outdir),network,run_name,species) 
         aqdat_query.df   <- sitex_info$sitex_data
         data_exists	  <- sitex_info$data_exists
         if (data_exists == "y") { units <- as.character(sitex_info$units[[1]]) }
      }
      else {
         query_result    <- query_dbase(run_name,network,species,orderby=c("ob_dates","ob_hour"))
         aqdat_query.df  <- query_result[[1]]
         data_exists     <- query_result[[2]]
         if (data_exists == "y") { units <- query_result[[3]] }
         model_name	 <- query_result[[4]]
      }
   }
   #############################################
   {
   if (data_exists == "n") {
      All_Data.df <- merge(All_Data.df,paste("No Data for ",run_name,sep=""))
      num_runs <- (num_runs-1)
      if (num_runs == 0) { stop("Stopping because num_runs is zero. Likely no data found for query.") }
   }
   else {
   ob_col_name <- paste(species,"_ob",sep="")
   mod_col_name <- paste(species,"_mod",sep="")
#   aqdat.df <- data.frame(Network=aqdat_query.df$network,Stat_ID=aqdat_query.df$stat_id,lat=aqdat_query.df$lat,lon=aqdat_query.df$lon,Obs_Value=aqdat_query.df[,10],Mod_Value=aqdat_query.df[,11],Hour=aqdat_query.df$ob_hour,Start_Date=I(aqdat_query.df[,5]),End_Date=I(aqdat_query.df[,6]),Month=aqdat_query.df$month)
   aqdat.df <- data.frame(Network=aqdat_query.df$network,Stat_ID=aqdat_query.df$stat_id,lat=aqdat_query.df$lat,lon=aqdat_query.df$lon,Obs_Value=aqdat_query.df[[ob_col_name]],Mod_Value=aqdat_query.df[[mod_col_name]],Hour=aqdat_query.df$ob_hour,Start_Date=I(aqdat_query.df[,5]),End_Date=I(aqdat_query.df[,6]),Month=aqdat_query.df$month)
   Date_Hour            <- paste(aqdat.df$Start_Date," ",aqdat.df$Hour,":00:00",sep="") # Create unique Date/Hour field
   aqdat.df$Date_Hour   <- Date_Hour                                                    # Add Date_Hour field to dataframe
   if (obs_per_day_limit > 0) {
      num_obs_value <- tapply(aqdat.df$Obs_Value,aqdat.df$Date_Hour,function(x)sum(!is.na(x)))
      drop_days <- names(num_obs_value)[num_obs_value < obs_per_day_limit]
      aqdat_new.df <- subset(aqdat.df,!(Date_Hour%in%drop_days))
      aqdat.df <- aqdat_new.df
   }

   if ((state != "All") && (custom_title == "")) {
      main.title      <- paste(run_name1,species,"for",network,"State:",aqdat_query.df$state[1],sep=" ")
      main.title.bias <- paste("Bias for",run_name1,species,"for",network,"Site:",site,"in",aqdat_query.df$county[1],"county,",aqdat_query.df$state[1],sep=" ")
   }
   if ((site != "All") && (custom_title == "")) {
      main.title      <- paste(run_name1,species,"for",network,"Site:",site,"in",aqdat_query.df$county[1],"county,",aqdat_query.df$state[1],sep=" ")
      main.title.bias <- paste("Bias for",run_name1,species,"for",network,"Site:",site,"in",aqdat_query.df$county[1],"county,",aqdat_query.df$state[1],sep=" ")
   }

   Date_Hour_Factor     <- factor(aqdat.df$Date_Hour,levels=unique(aqdat.df$Date_Hour))                   # Create unique levels so tapply maintains correct time order

   ### Calculate Obs and Model Means ###
   Obs_Period_Mean[[j]]	<- mean(aqdat.df$Obs_Value)
   Mod_Period_Mean[[j]]	<- mean(aqdat.df$Mod_Value)
   Obs_Mean[[j]]	<- tapply(aqdat.df$Obs_Value,Date_Hour_Factor,FUN=avg_func)
   Mod_Mean[[j]]	<- tapply(aqdat.df$Mod_Value,Date_Hour_Factor,FUN=avg_func)
   Num_Obs[[j]]         <- length(aqdat.df$Obs_Value)

   if ((units == "kg/ha") || (units == "mm")){	# Accumulate values if using precip/dep species
      Obs_Period_Mean[[j]] <- median(aqdat.df$Obs_Value)
      Mod_Period_Mean[[j]] <- median(aqdat.df$Mod_Value)
   }
   if (use_var_mean == "y") {
      Obs_Mean[[j]]	<- Obs_Mean[[j]] - Obs_Period_Mean[[j]]
      Mod_Mean[[j]]	<- Mod_Mean[[j]] - Mod_Period_Mean[[j]]
   }
   Bias_Mean[[j]]	<- Mod_Mean[[j]]-Obs_Mean[[j]]
   CORR[[j]]            <- as.matrix(by(aqdat.df[,c("Obs_Value","Mod_Value")],aqdat.df$Date_Hour,function(dfrm)cor(dfrm$Obs_Value,dfrm$Mod_Value)))
   RMSE[[j]]            <- as.matrix(by(aqdat.df[,c("Obs_Value","Mod_Value")],aqdat.df$Date_Hour,function(dfrm)sqrt(mean((dfrm$Mod_Value-dfrm$Obs_Value)^2))))
   Dates[[j]]		<- as.POSIXct(unique(aqdat.df$Date_Hour),origin="1970-01-01")
   if (averaging == "ym") {
      years                     <- substr(aqdat.df$Start_Date,1,4)
      months                    <- substr(aqdat.df$Start_Date,6,7)
      yearmonth                 <- paste(years,months,sep="-")
      aqdat.df$Year		<- years
      aqdat.df$YearMonth	<- yearmonth
      Obs_Mean[[j]]		<- tapply(aqdat.df$Obs_Value,aqdat.df$YearMonth,FUN=avg_func)
      Mod_Mean[[j]]		<- tapply(aqdat.df$Mod_Value,aqdat.df$YearMonth,FUN=avg_func)
      Bias_Mean[[j]]       <- Mod_Mean[[j]]-Obs_Mean[[j]]
      CORR[[j]]            <- as.matrix(by(aqdat.df[,c("Obs_Value","Mod_Value")],aqdat.df$YearMonth,function(dfrm)cor(dfrm$Obs_Value,dfrm$Mod_Value)))
      RMSE[[j]]            <- as.matrix(by(aqdat.df[,c("Obs_Value","Mod_Value")],aqdat.df$YearMonth,function(dfrm)sqrt(mean((dfrm$Mod_Value - dfrm$Obs_Value)^2))))
      Dates[[j]]           <- as.POSIXct(paste(unique(aqdat.df$YearMonth),"-01",sep=""),origin="1970-01-01")
      x_label              <- "Month"
   }
   if (averaging == "m") {
      Obs_Mean[[j]]        <- tapply(aqdat.df$Obs_Value,aqdat.df$Month,FUN=avg_func)
      Mod_Mean[[j]]        <- tapply(aqdat.df$Mod_Value,aqdat.df$Month,FUN=avg_func)
      Bias_Mean[[j]]       <- Mod_Mean[[j]]-Obs_Mean[[j]]
      CORR[[j]]            <- as.matrix(by(aqdat.df[,c("Obs_Value","Mod_Value")],aqdat.df$Month,function(dfrm)cor(dfrm$Obs_Value,dfrm$Mod_Value)))
      RMSE[[j]]            <- as.matrix(by(aqdat.df[,c("Obs_Value","Mod_Value")],aqdat.df$Month,function(dfrm)sqrt(mean((dfrm$Mod_Value-dfrm$Obs_Value)^2))))
      Dates[[j]]            <- unique(aqdat.df$Month)
      x_label		   <- "Month"
   }
   if (averaging == "d") {
      Obs_Mean[[j]]        <- tapply(aqdat.df$Obs_Value,aqdat.df$Start_Date,FUN=avg_func)
      Mod_Mean[[j]]        <- tapply(aqdat.df$Mod_Value,aqdat.df$Start_Date,FUN=avg_func)
      Bias_Mean[[j]]       <- Mod_Mean[[j]]-Obs_Mean[[j]]
      CORR[[j]]            <- as.matrix(by(aqdat.df[,c("Obs_Value","Mod_Value")],aqdat.df$Start_Date,function(dfrm)cor(dfrm$Obs_Value,dfrm$Mod_Value)))
      RMSE[[j]]            <- as.matrix(by(aqdat.df[,c("Obs_Value","Mod_Value")],aqdat.df$Start_Date,function(dfrm)sqrt(mean((dfrm$Mod_Value-dfrm$Obs_Value)^2))))
      Dates[[j]]           <- as.POSIXct(unique(aqdat.df$Start_Date),origin="1970-01-01")
   }
   if (averaging == "h") {
      Obs_Mean[[j]]        <- tapply(aqdat.df$Obs_Value,aqdat.df$Hour,FUN=avg_func)
      Mod_Mean[[j]]        <- tapply(aqdat.df$Mod_Value,aqdat.df$Hour,FUN=avg_func)
      Bias_Mean[[j]]       <- Mod_Mean[[j]]-Obs_Mean[[j]]
      CORR[[j]]            <- as.matrix(by(aqdat.df[,c("Obs_Value","Mod_Value")],aqdat.df$Hour,function(dfrm)cor(dfrm$Obs_Value,dfrm$Mod_Value)))
      RMSE[[j]]            <- as.matrix(by(aqdat.df[,c("Obs_Value","Mod_Value")],aqdat.df$Hour,function(dfrm)sqrt(mean((dfrm$Mod_Value-dfrm$Obs_Value)^2))))
      Dates[[j]]           <- unique(aqdat.df$Hour)
      x_label		   <- "Hour (LST)"
   }
   if (averaging == "a") {
      years                <- substr(aqdat.df$Start_Date,1,4)
      aqdat.df$Year        <- years
      Obs_Mean[[j]]        <- tapply(aqdat.df$Obs_Value,aqdat.df$Year,FUN=avg_func)
      Mod_Mean[[j]]        <- tapply(aqdat.df$Mod_Value,aqdat.df$Year,FUN=avg_func)
      Bias_Mean[[j]]       <- Mod_Mean[[j]]-Obs_Mean[[j]]
      CORR[[j]]            <- as.matrix(by(aqdat.df[,c("Obs_Value","Mod_Value")],aqdat.df$Year,function(dfrm)cor(dfrm$Obs_Value,dfrm$Mod_Value)))
      RMSE[[j]]            <- as.matrix(by(aqdat.df[,c("Obs_Value","Mod_Value")],aqdat.df$Year,function(dfrm)sqrt(mean((dfrm$Mod_Value-dfrm$Obs_Value)^2))))
      Dates[[j]]           <- unique(aqdat.df$Year)
      x_label              <- "Year"
   }
   if (j == 1) { # Set number of sites based on first run loaded (applies if runs have different number of sites)
      num_sites    <- length(unique(aqdat.df$Stat_ID))
   }
   if (num_sites == 1) {	# If only one site, CORR is calculated as NA, and therefore must be replaced with zeros to keep the code working (hack)
      CORR[[j]][is.na(CORR[[j]])] <- 0
   }
   Num_Obs[[j]]		<- length(aqdat.df$Obs_Value)
   ymin			<- min(ymin,Obs_Mean[[j]], Mod_Mean[[j]])
   ymax			<- max(ymax,Obs_Mean[[j]], Mod_Mean[[j]])
   bias_min		<- min(bias_min,Bias_Mean[[j]])
   bias_max		<- max(bias_max,Bias_Mean[[j]])
   corr_min             <- min(corr_min,CORR[[j]],na.rm=T)
   if (corr_min == "Inf") {
      corr_min <- 0
   }
   corr_max             <- max(corr_max,CORR[[j]],na.rm=T)
   if (corr_max == "-Inf") {
      corr_max <- 1
   }
   rmse_max		<- max(rmse_max,RMSE[[j]])
   rmse_min		<- min(rmse_min,RMSE[[j]])
   {
   if (j == 1) {
      col_name1		      <- paste(run_names[1],"_Obs_Average",sep="")
      col_name2               <- paste(run_names[1],"_Model_Average",sep="")
      col_name3               <- paste(run_names[1],"_Bias_Average",sep="")
      col_name4               <- paste(run_names[1],"_RMSE_Average",sep="")
      col_name5               <- paste(run_names[1],"_Corr_Average",sep="")
      All_Data.df	      <- data.frame(Date=Dates[[j]])
      All_Data.df[,col_name1] <- signif((Obs_Mean[[j]]),6)
      All_Data.df[,col_name2] <- signif((Mod_Mean[[j]]),6)
      All_Data.df[,col_name3] <- signif((Bias_Mean[[j]]),6)
      All_Data.df[,col_name4] <- signif((RMSE[[j]]),6)
      All_Data.df[,col_name5] <- signif((CORR[[j]]),3)
   }
   else {
      col_name1 <- paste(run_names[j],"_Obs_Average",sep="")
      col_name2 <- paste(run_names[j],"_Model_Average",sep="")
      col_name3 <- paste(run_names[j],"_Bias_Average",sep="")
      col_name4 <- paste(run_names[j],"_RMSE_Average",sep="")
      col_name5 <- paste(run_names[j],"_Corr_Average",sep="")
      temp.df <- data.frame(Date=Dates[[j]])
      temp.df[,col_name1] <- signif((Obs_Mean[[j]]),6)
      temp.df[,col_name2] <- signif((Mod_Mean[[j]]),6)
      temp.df[,col_name3] <- signif((Bias_Mean[[j]]),6)
      temp.df[,col_name4] <- signif((RMSE[[j]]),6)      
      temp.df[,col_name5] <- signif((CORR[[j]]),3)
      All_Data.df <- merge(All_Data.df,temp.df,by="Date",all.x=T)
   }
   }
   #####################################

} # Close else statement
} # Close if/else statement
} # End num_runs loop

### Stop script if no data available ###
if (length(Dates[[1]]) == 0) { stop("Stopping because length of dates was zero. Likely no data found for query.") }
########################################

### Write data to be plotted to file ###
write.table(All_Data.df,file=filename_txt,append=F,row.names=F,sep=",")      # Write raw data to csv file
########################################

### Calculate some values for plot formatting ###
range		<- ymax-ymin
ymax		<- ymax+(0.3*range)
bias_range	<- bias_max-bias_min
bias_max	<- bias_max+(0.3*bias_range)
corr_range      <- corr_max-corr_min
corr_max        <- corr_max+(0.3*corr_range)
rmse_range	<- rmse_max-rmse_min
rmse_max	<- rmse_max+(0.3*rmse_range)

if (length(y_axis_max) > 0) {
   ymax		<- y_axis_max
}
if (length(y_axis_min) > 0) {
   ymin		<- y_axis_min
}
if (length(bias_y_axis_max) > 0) { 
    bias_max   <- bias_y_axis_max
}
if (length(bias_y_axis_min) > 0) {
    bias_min   <- bias_y_axis_min
}

#################################################

filename_pdf         <- paste(run_name1,species,pid,"timeseries.pdf",sep="_")              # Set output file name
filename_png         <- paste(run_name1,species,pid,"timeseries.png",sep="_")

filename_pdf         <- paste(figdir,filename_pdf,sep="/")           # Filename for obs spatial plot
filename_png         <- paste(figdir,filename_png,sep="/")           # Filename for model spatial plot

#####################################
### Plot Model vs. Ob Time Series ###
#####################################
pdf(file=filename_pdf,width=11,height=13)
par(mfrow = c(4,1),mai=c(.7,1,.4,1))
par(cex.axis=1,las=1,mfg=c(1,1),lab=c(5,10,7))

plot(Dates[[1]],Mod_Mean[[1]], axes=TRUE, ylim=c(ymin,ymax),type='l',ylab=paste(species,"(",units,")",sep=" "),xlab=x_label,lty=1,col=plot_colors[2],cex=.8, xaxt="n",lwd=line_width, cex.lab=1.5)  # Plot model data
#mtext(x_label, side=1, line=3, cex=1.5)

if (inc_points == 'y') {
   points(Dates[[1]],Mod_Mean[[1]],col=plot_colors[[2]])
}
{
   if ((averaging == "h") || (averaging == "m") || (averaging == "a")) {
      axis(side=1, at=Dates[[1]])
   }
   else if (averaging == "ym") {
      axis.POSIXct(side=1, at=Dates[[1]],format="%b %Y")
   }
   else {
      axis.POSIXct(side=1, at=Dates[[1]],format="%b %d")
   }
}
lines(Dates[[1]],Obs_Mean[[1]],col=plot_colors[1],lty=1,lwd=line_width)
if (inc_points == 'y') {
   points(Dates[[1]],Obs_Mean[[1]],col=plot_colors[1])
}
legend_names <- c(network_label[1],run_names[1])
legend_colors <- c(plot_colors[1],plot_colors[2])
if (num_runs > 1) {
   for (k in 2:num_runs) {
      lines(Dates[[k]],Mod_Mean[[k]],col=plot_colors[k+1],lty=1,lwd=line_width)
      if (inc_points == 'y') {
         points(Dates[[k]],Mod_Mean[[k]],col=plot_colors[k+1])
      }
      legend_names <- c(legend_names,run_names[k])
      legend_colors <- c(legend_colors,plot_colors[k+1])
      if (Num_Obs[[k]] != Num_Obs[[1]]) {
         num_diff <- abs(Num_Obs[[k]]-Num_Obs[[1]])
         sub.title <- paste("Warning: Number of observations differ by",num_diff,"between simulations",sep=" ")
      }
   }   
}
usr <- par("usr")
text(usr[2],usr[4],paste("# of Sites: ",num_sites,sep=""),adj=c(1.1,1.1),cex=1.1)
if (inc_legend == 'y') {
   legend("topleft",legend=legend_names,col=legend_colors,lty=c(1,1,1), merge=TRUE,cex=1.1, bty='n')  # Add legend
}

title(main=main.title, cex.main = 1, sub=sub.title, cex.sub = 1, col.sub = "red")
######################################

if (run_info_text == "y") {
   if (rpo != "None") {
      text(max(Dates[[1]]),ymax-((ymax-ymin)*.25),paste("RPO: ",rpo,sep=""),pos=2,cex=1)
   }
   if (pca != "None") {
      text(max(Dates[[1]]),ymax-((ymax-ymin)*.20),paste("PCA: ",pca,sep=""),pos=2,cex=1)
   }
   if (state != "All") {
      text(max(Dates[[1]]),ymax-((ymax-ymin)*.15),paste("State: ",state,sep=""),pos=2,cex=1)
   }
   if (site != "All") {
      text(max(Dates[[1]]),ymax-((ymax-ymin)*.10),paste("Site: ",site,", ",aqdat_query.df$county[1]," county, ",aqdat_query.df$state[1],sep=""),pos=2,cex=1)
   }
}

#################################################
### Plot Model Bias,RMSE and Corr Time Series ###
#################################################

for (f in 1:3) {        # Loop for plotting Bias, RMSE and Correlation
   if (f == 3) {
      stat_func <- 'corr'
      main.title.bias <- paste("Correlation for",run_name1,species,"for",network,"for",dates,sep=" ")
      y_stat_max <- corr_max
      y_stat_min <- max(0,corr_min)
   }
   if (f == 2) {
      stat_func <- 'rmse'
      main.title.bias <- paste("RMSE for",run_name1,species,"for",network,"for",dates,sep=" ")
      y_stat_max <- rmse_max
      y_stat_min <- max(0,rmse_min)

   }
   if (f == 1) {
      stat_func <- 'bias'
      main.title.bias <- paste("Bias for",run_name1,species,"for",network,"for",dates,sep=" ")
      y_stat_max <- bias_max
      y_stat_min <- bias_min
   }

   par(new=T)
   par(mfg=c(f+1,1),mai=c(.52,1,.4,1))

   {
      if (stat_func == 'corr') { # If plotting correlation instead of bias
         plot(Dates[[1]],CORR[[1]], axes=TRUE, ylim=c(y_stat_min,y_stat_max),type='l',ylab="Correlation",xlab=x_label,lty=1,col=plot_colors[2],cex=.8, xaxt="n",lwd=line_width, cex.lab=1.5)
         if (inc_points == 'y') {
            points(Dates[[1]],CORR[[1]],col=plot_colors[2])
         }
      }
      else if (stat_func == 'rmse') {
         plot(Dates[[1]],RMSE[[1]], axes=TRUE, ylim=c(y_stat_min,y_stat_max),type='l',ylab=paste("RMSE (",units,")",sep=""),xlab=x_label,lty=1,col=plot_colors[2],cex=.7, xaxt="n",lwd=line_width,cex.lab=1.5)
         if (inc_points == 'y') {
            points(Dates[[1]],RMSE[[1]],col=plot_colors[2])
         }
      }
      else {
         plot(Dates[[1]],Bias_Mean[[1]], axes=TRUE, ylim=c(y_stat_min,y_stat_max),type='l',ylab=paste("Bias (",units,")",sep=" "),xlab=x_label,lty=1,col=plot_colors[2],cex=.7, xaxt="n",lwd=line_width,cex.lab=1.5)  # Plot model data
         if (inc_points == 'y') {
            points(Dates[[1]],Bias_Mean[[1]],col=plot_colors[2])
         }
      }
   }

   {
      if ((averaging == "h") || (averaging == "m") || (averaging == "a")) {
         axis(side=1, at=Dates[[1]])
      }
      else if (averaging == "ym") {
         axis.POSIXct(side=1, at=Dates[[1]],format="%b %Y")
      }
      else {
         axis.POSIXct(side=1, at=Dates[[1]],format="%b %d")
      }
   } 
   legend_names <- run_names[1]
   legend_colors <- plot_colors[2]

   if (num_runs > 1) {
      for (k in 2:num_runs) {
         {
            if (stat_func == 'corr') {
               lines(Dates[[k]],CORR[[k]],col=plot_colors[k+1],lty=1,lwd=line_width) 
               if (inc_points == 'y') {
                  points(Dates[[k]],CORR[[k]],col=plot_colors[k+1])
               }
            }
            else if (stat_func == 'rmse') {
               lines(Dates[[k]],RMSE[[k]],col=plot_colors[k+1],lty=1,lwd=line_width)
               if (inc_points == 'y') {
                  points(Dates[[k]],RMSE[[k]],col=plot_colors[k+1])
               }
            }
            else {
               lines(Dates[[k]],Bias_Mean[[k]],col=plot_colors[k+1],lty=1,lwd=line_width) 
               if (inc_points == 'y') {
                  points(Dates[[k]],Bias_Mean[[k]],col=plot_colors[k+1])
               }
            } 
         }
         legend_names <- c(legend_names,run_names[k])
         legend_colors <- c(legend_colors,plot_colors[k+1])
      } 
   }
   abline(h=0,col="black")
   usr <- par("usr")
   text(usr[2],usr[4],paste("# of Sites: ",num_sites,sep=""),adj=c(1.1,1.1),cex=1.1)
   if (inc_legend == 'y') {
      legend("topleft",legend=legend_names,col=legend_colors,lty=c(1,1,1), merge=TRUE,cex=1.1, bty='n')  # Add legend
   }
   title(main=main.title.bias, cex.main=1)
   ###################################

   if (run_info_text == "y") {
      if (rpo != "None") {
         text(max(Dates[[1]]),y_stat_max-((bias_max-bias_min)*.25),paste("RPO: ",rpo,sep=""),pos=2,cex=1)
      }
      if (pca != "None") {
         text(max(Dates[[1]]),y_stat_max-((bias_max-bias_min)*.20),paste("PCA: ",pca,sep=""),pos=2,cex=1)
      }
      if (state != "All") {
         text(max(Dates[[1]]),y_stat_max-((bias_max-bias_min)*.15),paste("State: ",state,sep=""),pos=2,cex=1)
      }
      if (site != "All") {
         text(max(Dates[[1]]),y_stat_max-((bias_max-bias_min)*.10),paste("Site: ",site,", ",aqdat_query.df$county[1]," county, ",aqdat_query.df$state[1],sep=""),pos=2,cex=1)
      } 
   }
}	# End loop for plotting Bias, RMSE and Correlation

#######################
### Create PNG Plot ###
#######################
dev.off()
if ((ametptype == "png") || (ametptype == "both")) {
   convert_command<-paste("convert -flatten -density ",png_res,"x",png_res," ",filename_pdf," png:",filename_png,sep="")
   system(convert_command)
    if (ametptype == "png") {
      remove_command <- paste("rm ",filename_pdf,sep="")
      system(remove_command)
   }
}

