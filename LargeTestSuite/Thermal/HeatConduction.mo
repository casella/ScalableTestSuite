within LargeTestSuite.Thermal;

package HeatConduction
  extends Modelica.Icons.ExamplesPackage;

  model OneDHeatTransferTT_FD_N_1280
    extends  ScalableTestSuite.Thermal.HeatConduction.ScaledExperiments.OneDHeatTransferTT_FD_N_10(N = 1280);
    annotation(experiment(StopTime = 350, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTT_FD_N_1280;

  model OneDHeatTransferTT_FD_N_2560
    extends  OneDHeatTransferTT_FD_N_1280(N = 2560);
    annotation(experiment(StopTime = 350, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTT_FD_N_2560;

  model OneDHeatTransferTT_FD_N_5120
    extends  OneDHeatTransferTT_FD_N_1280(N = 5120);
    annotation(experiment(StopTime = 350, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTT_FD_N_5120;

  model OneDHeatTransferTT_FD_N_10240
    extends  OneDHeatTransferTT_FD_N_1280(N = 10240);
    annotation(experiment(StopTime = 350, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTT_FD_N_10240;

  model OneDHeatTransferTT_Modelica_N_1280
    extends  ScalableTestSuite.Thermal.HeatConduction.ScaledExperiments.OneDHeatTransferTT_Modelica_N_10(N = 1280);
    annotation(experiment(StopTime = 350, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTT_Modelica_N_1280;

  model OneDHeatTransferTT_Modelica_N_2560
    extends  OneDHeatTransferTT_Modelica_N_1280(N = 2560);
    annotation(experiment(StopTime = 350, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTT_Modelica_N_2560;

  model OneDHeatTransferTT_Modelica_N_5120
    extends  OneDHeatTransferTT_Modelica_N_1280(N = 5120);
    annotation(experiment(StopTime = 350, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTT_Modelica_N_5120;

  model OneDHeatTransferTT_Modelica_N_10240
    extends  OneDHeatTransferTT_Modelica_N_1280(N = 10240);
    annotation(experiment(StopTime = 350, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTT_Modelica_N_10240;

  model OneDHeatTransferTI_FD_N_1280
    extends  ScalableTestSuite.Thermal.HeatConduction.ScaledExperiments.OneDHeatTransferTI_FD_N_10(N = 1280);
    annotation(experiment(StopTime = 350, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTI_FD_N_1280;

  model OneDHeatTransferTI_FD_N_2560
    extends  OneDHeatTransferTI_FD_N_1280(N = 2560);
    annotation(experiment(StopTime = 350, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTI_FD_N_2560;

  model OneDHeatTransferTI_FD_N_5120
    extends  OneDHeatTransferTI_FD_N_1280(N = 5120);
    annotation(experiment(StopTime = 350, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTI_FD_N_5120;

  model OneDHeatTransferTI_FD_N_10240
    extends  OneDHeatTransferTI_FD_N_1280(N = 10240);
    annotation(experiment(StopTime = 350, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTI_FD_N_10240;

  model OneDHeatTransferTI_Modelica_N_1280
    extends  ScalableTestSuite.Thermal.HeatConduction.ScaledExperiments.OneDHeatTransferTI_Modelica_N_10(N = 1280);
    annotation(experiment(StopTime = 350, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTI_Modelica_N_1280;

  model OneDHeatTransferTI_Modelica_N_2560
    extends  OneDHeatTransferTI_Modelica_N_1280(N = 2560);
    annotation(experiment(StopTime = 350, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTI_Modelica_N_2560;

  model OneDHeatTransferTI_Modelica_N_5120
    extends  OneDHeatTransferTI_Modelica_N_1280(N = 5120);
    annotation(experiment(StopTime = 350, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTI_Modelica_N_5120;

  model OneDHeatTransferTI_Modelica_N_10240
    extends  OneDHeatTransferTI_Modelica_N_1280(N = 10240);
    annotation(experiment(StopTime = 350, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTI_Modelica_N_10240;

end HeatConduction;
