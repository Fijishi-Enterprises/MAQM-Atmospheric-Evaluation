/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ametjavagui.METAdvancedForms;

import ametjavagui.MeteorologyForm;

/**
 *
 * @author Michael Morton
 */
public class SummaryPlotOptions extends javax.swing.JFrame {

    /**
     * Creates new form SummaryPlotOptions
     */
    
    MeteorologyForm form;
    
    public SummaryPlotOptions(MeteorologyForm form) {
        this.form = form;
        initComponents();
        RunNameTextField.setText(form.run_id);
        AMETPlotCheckBox.setSelected(form.ametplot);        
        DiurnalPlotCheckBox.setSelected(form.diurnal_summary);        
        ErrorTempTextField.setText(form.qc_error_temp);        
        ErrorWindSpeedTextField.setText(form.qc_error_wind);        
        ErrorMoistureTextField.setText(form.qc_error_moisture);        
                
    }

    /**
     * This method is called from within the constructor to initialize the form. WARNING: Do NOT modify this code. The content of this method is always regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel1 = new javax.swing.JPanel();
        SummaryPlotOptionsLabel = new javax.swing.JLabel();
        RunNameLabel = new javax.swing.JLabel();
        RunNameTextField = new javax.swing.JTextField();
        AMETPlotCheckBox = new javax.swing.JCheckBox();
        DiurnalPlotCheckBox = new javax.swing.JCheckBox();
        QCLimitSettingsLabel = new javax.swing.JLabel();
        ErrorTempLabel = new javax.swing.JLabel();
        ErrorTempTextField = new javax.swing.JTextField();
        ErrorTempUnitLabel = new javax.swing.JLabel();
        ErrorWindSpeedLabel = new javax.swing.JLabel();
        ErrorWindSpeedTextField = new javax.swing.JTextField();
        ErrorWindSpeedUnitLabel = new javax.swing.JLabel();
        ErrorMoistureLabel = new javax.swing.JLabel();
        ErrorMoistureTextField = new javax.swing.JTextField();
        ErrorMoistureUnitLabel = new javax.swing.JLabel();
        SaveButton = new javax.swing.JButton();
        CancelButton = new javax.swing.JButton();
        RunNameLabel1 = new javax.swing.JLabel();
        RunNameLabel2 = new javax.swing.JLabel();
        ResetButton = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setTitle("Diurnal Statistics / Summary Plot Options");
        setAlwaysOnTop(true);
        setBackground(new java.awt.Color(255, 255, 255));

        jPanel1.setBackground(new java.awt.Color(255, 255, 255));
        jPanel1.setPreferredSize(new java.awt.Dimension(483, 391));

        SummaryPlotOptionsLabel.setBackground(new java.awt.Color(255, 255, 255));
        SummaryPlotOptionsLabel.setFont(new java.awt.Font("Times New Roman", 1, 18)); // NOI18N
        SummaryPlotOptionsLabel.setForeground(new java.awt.Color(0, 63, 105));
        SummaryPlotOptionsLabel.setText("Diurnal Statistics / Summary Plot Options");

        RunNameLabel.setBackground(new java.awt.Color(255, 255, 255));
        RunNameLabel.setFont(new java.awt.Font("Times New Roman", 1, 14)); // NOI18N
        RunNameLabel.setForeground(new java.awt.Color(0, 112, 185));
        RunNameLabel.setText("Plot ID (used to distinguish analyses):");

        RunNameTextField.setBackground(new java.awt.Color(191, 182, 172));
        RunNameTextField.setFont(new java.awt.Font("Times New Roman", 1, 14)); // NOI18N
        RunNameTextField.setForeground(new java.awt.Color(0, 63, 105));
        RunNameTextField.setText("AMET_GUI");
        RunNameTextField.setMaximumSize(new java.awt.Dimension(178, 23));
        RunNameTextField.setMinimumSize(new java.awt.Dimension(139, 23));
        RunNameTextField.setPreferredSize(new java.awt.Dimension(139, 23));

        AMETPlotCheckBox.setBackground(new java.awt.Color(255, 255, 255));
        AMETPlotCheckBox.setFont(new java.awt.Font("Times New Roman", 1, 14)); // NOI18N
        AMETPlotCheckBox.setForeground(new java.awt.Color(0, 112, 185));
        AMETPlotCheckBox.setSelected(true);
        AMETPlotCheckBox.setText("Create AMET summary statistical plots");

        DiurnalPlotCheckBox.setBackground(new java.awt.Color(255, 255, 255));
        DiurnalPlotCheckBox.setFont(new java.awt.Font("Times New Roman", 1, 14)); // NOI18N
        DiurnalPlotCheckBox.setForeground(new java.awt.Color(0, 112, 185));
        DiurnalPlotCheckBox.setSelected(true);
        DiurnalPlotCheckBox.setText("Create diurnal summary statistical plots");

        QCLimitSettingsLabel.setBackground(new java.awt.Color(255, 255, 255));
        QCLimitSettingsLabel.setFont(new java.awt.Font("Times New Roman", 1, 18)); // NOI18N
        QCLimitSettingsLabel.setForeground(new java.awt.Color(0, 63, 105));
        QCLimitSettingsLabel.setText("Quality Control Settings");

        ErrorTempLabel.setBackground(new java.awt.Color(255, 255, 255));
        ErrorTempLabel.setFont(new java.awt.Font("Times New Roman", 1, 14)); // NOI18N
        ErrorTempLabel.setForeground(new java.awt.Color(0, 112, 185));
        ErrorTempLabel.setText("Error Limit for Temperature:");

        ErrorTempTextField.setBackground(new java.awt.Color(191, 182, 172));
        ErrorTempTextField.setFont(new java.awt.Font("Times New Roman", 1, 14)); // NOI18N
        ErrorTempTextField.setForeground(new java.awt.Color(0, 63, 105));
        ErrorTempTextField.setText("15");
        ErrorTempTextField.setMaximumSize(new java.awt.Dimension(65, 23));
        ErrorTempTextField.setMinimumSize(new java.awt.Dimension(65, 23));
        ErrorTempTextField.setPreferredSize(new java.awt.Dimension(65, 23));

        ErrorTempUnitLabel.setBackground(new java.awt.Color(255, 255, 255));
        ErrorTempUnitLabel.setFont(new java.awt.Font("Times New Roman", 1, 14)); // NOI18N
        ErrorTempUnitLabel.setForeground(new java.awt.Color(0, 112, 185));
        ErrorTempUnitLabel.setText("K");

        ErrorWindSpeedLabel.setBackground(new java.awt.Color(255, 255, 255));
        ErrorWindSpeedLabel.setFont(new java.awt.Font("Times New Roman", 1, 14)); // NOI18N
        ErrorWindSpeedLabel.setForeground(new java.awt.Color(0, 112, 185));
        ErrorWindSpeedLabel.setText("Error Limit for Wind Speed:");

        ErrorWindSpeedTextField.setBackground(new java.awt.Color(191, 182, 172));
        ErrorWindSpeedTextField.setFont(new java.awt.Font("Times New Roman", 1, 14)); // NOI18N
        ErrorWindSpeedTextField.setForeground(new java.awt.Color(0, 63, 105));
        ErrorWindSpeedTextField.setText("15");
        ErrorWindSpeedTextField.setMaximumSize(new java.awt.Dimension(65, 23));
        ErrorWindSpeedTextField.setMinimumSize(new java.awt.Dimension(65, 23));
        ErrorWindSpeedTextField.setPreferredSize(new java.awt.Dimension(65, 23));

        ErrorWindSpeedUnitLabel.setBackground(new java.awt.Color(255, 255, 255));
        ErrorWindSpeedUnitLabel.setFont(new java.awt.Font("Times New Roman", 1, 14)); // NOI18N
        ErrorWindSpeedUnitLabel.setForeground(new java.awt.Color(0, 112, 185));
        ErrorWindSpeedUnitLabel.setText("m/s");

        ErrorMoistureLabel.setBackground(new java.awt.Color(255, 255, 255));
        ErrorMoistureLabel.setFont(new java.awt.Font("Times New Roman", 1, 14)); // NOI18N
        ErrorMoistureLabel.setForeground(new java.awt.Color(0, 112, 185));
        ErrorMoistureLabel.setText("Error Limit for Moisture:");

        ErrorMoistureTextField.setBackground(new java.awt.Color(191, 182, 172));
        ErrorMoistureTextField.setFont(new java.awt.Font("Times New Roman", 1, 14)); // NOI18N
        ErrorMoistureTextField.setForeground(new java.awt.Color(0, 63, 105));
        ErrorMoistureTextField.setText("10");
        ErrorMoistureTextField.setMaximumSize(new java.awt.Dimension(65, 23));
        ErrorMoistureTextField.setMinimumSize(new java.awt.Dimension(65, 23));
        ErrorMoistureTextField.setPreferredSize(new java.awt.Dimension(65, 23));

        ErrorMoistureUnitLabel.setBackground(new java.awt.Color(255, 255, 255));
        ErrorMoistureUnitLabel.setFont(new java.awt.Font("Times New Roman", 1, 14)); // NOI18N
        ErrorMoistureUnitLabel.setForeground(new java.awt.Color(0, 112, 185));
        ErrorMoistureUnitLabel.setText("k/kg");

        SaveButton.setBackground(new java.awt.Color(0, 63, 105));
        SaveButton.setFont(new java.awt.Font("Times New Roman", 1, 14)); // NOI18N
        SaveButton.setForeground(new java.awt.Color(191, 182, 172));
        SaveButton.setText("Save");
        SaveButton.setMaximumSize(new java.awt.Dimension(100, 26));
        SaveButton.setMinimumSize(new java.awt.Dimension(75, 26));
        SaveButton.setPreferredSize(new java.awt.Dimension(75, 26));
        SaveButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                SaveButtonActionPerformed(evt);
            }
        });

        CancelButton.setBackground(new java.awt.Color(0, 63, 105));
        CancelButton.setFont(new java.awt.Font("Times New Roman", 1, 14)); // NOI18N
        CancelButton.setForeground(new java.awt.Color(191, 182, 172));
        CancelButton.setText("Cancel");
        CancelButton.setMaximumSize(new java.awt.Dimension(100, 26));
        CancelButton.setMinimumSize(new java.awt.Dimension(90, 26));
        CancelButton.setPreferredSize(new java.awt.Dimension(90, 26));
        CancelButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                CancelButtonActionPerformed(evt);
            }
        });

        RunNameLabel1.setBackground(new java.awt.Color(255, 255, 255));
        RunNameLabel1.setFont(new java.awt.Font("Times New Roman", 1, 14)); // NOI18N
        RunNameLabel1.setForeground(new java.awt.Color(0, 112, 185));
        RunNameLabel1.setText("Used to remove extreme differences between ");

        RunNameLabel2.setBackground(new java.awt.Color(255, 255, 255));
        RunNameLabel2.setFont(new java.awt.Font("Times New Roman", 1, 14)); // NOI18N
        RunNameLabel2.setForeground(new java.awt.Color(0, 112, 185));
        RunNameLabel2.setText("the model and observations.");

        ResetButton.setBackground(new java.awt.Color(0, 63, 105));
        ResetButton.setFont(new java.awt.Font("Times New Roman", 1, 14)); // NOI18N
        ResetButton.setForeground(new java.awt.Color(191, 182, 172));
        ResetButton.setText("Reset");
        ResetButton.setMaximumSize(new java.awt.Dimension(100, 26));
        ResetButton.setMinimumSize(new java.awt.Dimension(100, 26));
        ResetButton.setPreferredSize(new java.awt.Dimension(80, 26));
        ResetButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                ResetButtonActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(20, 20, 20)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addComponent(ErrorTempLabel)
                                .addGap(44, 44, 44)
                                .addComponent(ErrorTempTextField, javax.swing.GroupLayout.PREFERRED_SIZE, 65, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                                .addGroup(jPanel1Layout.createSequentialGroup()
                                    .addComponent(ErrorMoistureLabel)
                                    .addGap(78, 78, 78)
                                    .addComponent(ErrorMoistureTextField, javax.swing.GroupLayout.PREFERRED_SIZE, 65, javax.swing.GroupLayout.PREFERRED_SIZE))
                                .addGroup(jPanel1Layout.createSequentialGroup()
                                    .addComponent(ErrorWindSpeedLabel)
                                    .addGap(53, 53, 53)
                                    .addComponent(ErrorWindSpeedTextField, javax.swing.GroupLayout.PREFERRED_SIZE, 65, javax.swing.GroupLayout.PREFERRED_SIZE))))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(ErrorTempUnitLabel)
                            .addComponent(ErrorWindSpeedUnitLabel)
                            .addComponent(ErrorMoistureUnitLabel)))
                    .addComponent(DiurnalPlotCheckBox, javax.swing.GroupLayout.PREFERRED_SIZE, 344, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(QCLimitSettingsLabel)
                    .addComponent(SummaryPlotOptionsLabel)
                    .addComponent(AMETPlotCheckBox)
                    .addComponent(RunNameLabel1)
                    .addComponent(RunNameLabel2)
                    .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
                        .addGroup(jPanel1Layout.createSequentialGroup()
                            .addComponent(ResetButton, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(SaveButton, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addGap(40, 40, 40)
                            .addComponent(CancelButton, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGroup(javax.swing.GroupLayout.Alignment.LEADING, jPanel1Layout.createSequentialGroup()
                            .addComponent(RunNameLabel)
                            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                            .addComponent(RunNameTextField, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))))
                .addContainerGap(20, Short.MAX_VALUE))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(SummaryPlotOptionsLabel)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(RunNameLabel)
                    .addComponent(RunNameTextField, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(AMETPlotCheckBox)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(DiurnalPlotCheckBox)
                .addGap(18, 18, 18)
                .addComponent(QCLimitSettingsLabel)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(RunNameLabel1)
                .addGap(0, 0, 0)
                .addComponent(RunNameLabel2)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(ErrorTempLabel)
                    .addComponent(ErrorTempTextField, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(ErrorTempUnitLabel))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(ErrorWindSpeedLabel)
                    .addComponent(ErrorWindSpeedTextField, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(ErrorWindSpeedUnitLabel))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(ErrorMoistureTextField, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(ErrorMoistureUnitLabel)
                    .addComponent(ErrorMoistureLabel))
                .addGap(31, 31, 31)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(SaveButton, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(CancelButton, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(ResetButton, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(20, Short.MAX_VALUE))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void SaveButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_SaveButtonActionPerformed
        form.run_id = RunNameTextField.getText();
        form.ametp = form.checkBoxFormat(AMETPlotCheckBox);
        form.ametplot = AMETPlotCheckBox.isSelected();
        form.diurnal = form.checkBoxFormat(DiurnalPlotCheckBox);
        form.diurnal_summary = DiurnalPlotCheckBox.isSelected();
        form.qc_error_temp = form.numNullFormat(ErrorTempTextField.getText());
        form.qc_error_wind = form.numNullFormat(ErrorWindSpeedTextField.getText());
        form.qc_error_moisture = form.numNullFormat(ErrorMoistureTextField.getText());
        System.out.println("Summary Analysis Options Saved");
        setVisible(false);
        dispose();
    }//GEN-LAST:event_SaveButtonActionPerformed

    private void CancelButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_CancelButtonActionPerformed
        setVisible(false);
        dispose();
    }//GEN-LAST:event_CancelButtonActionPerformed

    private void ResetButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_ResetButtonActionPerformed
        RunNameTextField.setText(form.run_id_reset);
        AMETPlotCheckBox.setSelected(form.ametplot_reset);        
        DiurnalPlotCheckBox.setSelected(form.diurnal_summary_reset);        
        ErrorTempTextField.setText(form.qc_error_temp_reset);        
        ErrorWindSpeedTextField.setText(form.qc_error_wind_reset);        
        ErrorMoistureTextField.setText(form.qc_error_moisture_reset);
        System.out.println("Summary Analysis Options Reset to Default Values");
    }//GEN-LAST:event_ResetButtonActionPerformed

    /**
     * @param args the command line arguments
     */


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JCheckBox AMETPlotCheckBox;
    private javax.swing.JButton CancelButton;
    private javax.swing.JCheckBox DiurnalPlotCheckBox;
    private javax.swing.JLabel ErrorMoistureLabel;
    private javax.swing.JTextField ErrorMoistureTextField;
    private javax.swing.JLabel ErrorMoistureUnitLabel;
    private javax.swing.JLabel ErrorTempLabel;
    private javax.swing.JTextField ErrorTempTextField;
    private javax.swing.JLabel ErrorTempUnitLabel;
    private javax.swing.JLabel ErrorWindSpeedLabel;
    private javax.swing.JTextField ErrorWindSpeedTextField;
    private javax.swing.JLabel ErrorWindSpeedUnitLabel;
    private javax.swing.JLabel QCLimitSettingsLabel;
    private javax.swing.JButton ResetButton;
    private javax.swing.JLabel RunNameLabel;
    private javax.swing.JLabel RunNameLabel1;
    private javax.swing.JLabel RunNameLabel2;
    private javax.swing.JTextField RunNameTextField;
    private javax.swing.JButton SaveButton;
    private javax.swing.JLabel SummaryPlotOptionsLabel;
    private javax.swing.JPanel jPanel1;
    // End of variables declaration//GEN-END:variables
}
