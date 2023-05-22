within LargeTestSuite.Thermal;

package HeatConduction
  extends Modelica.Icons.ExamplesPackage;

  model OneDHeatTransferTT_FD_N_160
    extends  ScalableTestSuite.Thermal.HeatConduction.ScaledExperiments.OneDHeatTransferTT_FD_N_10(N = 160);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTT_FD_N_160;

  model OneDHeatTransferTT_FD_N_320
    extends  ScalableTestSuite.Thermal.HeatConduction.ScaledExperiments.OneDHeatTransferTT_FD_N_10(N = 320);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTT_FD_N_320;

  model OneDHeatTransferTT_FD_N_640
    extends  ScalableTestSuite.Thermal.HeatConduction.ScaledExperiments.OneDHeatTransferTT_FD_N_10(N = 640);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTT_FD_N_640;

  model OneDHeatTransferTT_FD_N_1280
    extends  ScalableTestSuite.Thermal.HeatConduction.ScaledExperiments.OneDHeatTransferTT_FD_N_10(N = 1280);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTT_FD_N_1280;

  model OneDHeatTransferTT_FD_N_2560
    extends  OneDHeatTransferTT_FD_N_1280(N = 2560);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTT_FD_N_2560;

  model OneDHeatTransferTT_FD_N_5120
    extends  OneDHeatTransferTT_FD_N_1280(N = 5120);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTT_FD_N_5120;

  model OneDHeatTransferTT_FD_N_10240
    extends  OneDHeatTransferTT_FD_N_1280(N = 10240);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTT_FD_N_10240;

  model OneDHeatTransferTT_FD_N_20480
    extends  OneDHeatTransferTT_FD_N_1280(N = 20480);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTT_FD_N_20480;

  model OneDHeatTransferTT_FD_N_40960
    extends  OneDHeatTransferTT_FD_N_1280(N = 40960);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTT_FD_N_40960;

  model OneDHeatTransferTT_FD_N_81920
    extends  OneDHeatTransferTT_FD_N_1280(N = 81920);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTT_FD_N_81920;

  model OneDHeatTransferTT_FD_N_163840
    extends  OneDHeatTransferTT_FD_N_1280(N = 163840);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTT_FD_N_163840;

  model OneDHeatTransferTT_FD_N_327680
    extends  OneDHeatTransferTT_FD_N_1280(N = 327680);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTT_FD_N_327680;

  model OneDHeatTransferTT_FD_N_655360
    extends  OneDHeatTransferTT_FD_N_1280(N = 655360);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTT_FD_N_655360;

  model OneDHeatTransferTT_FD_N_1310720
    extends  OneDHeatTransferTT_FD_N_1280(N = 1310720);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTT_FD_N_1310720;

  model OneDHeatTransferTT_Modelica_N_160
    extends  ScalableTestSuite.Thermal.HeatConduction.ScaledExperiments.OneDHeatTransferTT_Modelica_N_10(N = 160);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTT_Modelica_N_160;

  model OneDHeatTransferTT_Modelica_N_320
    extends  ScalableTestSuite.Thermal.HeatConduction.ScaledExperiments.OneDHeatTransferTT_Modelica_N_10(N = 320);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTT_Modelica_N_320;

  model OneDHeatTransferTT_Modelica_N_640
    extends  ScalableTestSuite.Thermal.HeatConduction.ScaledExperiments.OneDHeatTransferTT_Modelica_N_10(N = 640);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTT_Modelica_N_640;

  model OneDHeatTransferTT_Modelica_N_1280
    extends  ScalableTestSuite.Thermal.HeatConduction.ScaledExperiments.OneDHeatTransferTT_Modelica_N_10(N = 1280);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTT_Modelica_N_1280;

  model OneDHeatTransferTT_Modelica_N_2560
    extends  OneDHeatTransferTT_Modelica_N_1280(N = 2560);
  end OneDHeatTransferTT_Modelica_N_2560;

  model OneDHeatTransferTT_Modelica_N_5120
    extends  OneDHeatTransferTT_Modelica_N_1280(N = 5120);
  end OneDHeatTransferTT_Modelica_N_5120;

  model OneDHeatTransferTT_Modelica_N_10240
    extends  OneDHeatTransferTT_Modelica_N_1280(N = 10240);
  end OneDHeatTransferTT_Modelica_N_10240;

  model OneDHeatTransferTI_FD_N_1280
    extends  ScalableTestSuite.Thermal.HeatConduction.ScaledExperiments.OneDHeatTransferTI_FD_N_10(N = 1280);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTI_FD_N_1280;

  model OneDHeatTransferTI_FD_N_2560
    extends  OneDHeatTransferTI_FD_N_1280(N = 2560);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTI_FD_N_2560;

  model OneDHeatTransferTI_FD_N_5120
    extends  OneDHeatTransferTI_FD_N_1280(N = 5120);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTI_FD_N_5120;

  model OneDHeatTransferTI_FD_N_10240
    extends  OneDHeatTransferTI_FD_N_1280(N = 10240);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTI_FD_N_10240;

  model OneDHeatTransferTI_FD_N_20480
    extends  OneDHeatTransferTI_FD_N_1280(N = 20480);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTI_FD_N_20480;

  model OneDHeatTransferTI_FD_N_40960
    extends  OneDHeatTransferTI_FD_N_1280(N = 40960);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTI_FD_N_40960;

  model OneDHeatTransferTI_FD_N_81920
    extends  OneDHeatTransferTI_FD_N_1280(N = 81920);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTI_FD_N_81920;

  model OneDHeatTransferTI_FD_N_163840
    extends  OneDHeatTransferTI_FD_N_1280(N = 163840);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTI_FD_N_163840;

  model OneDHeatTransferTI_FD_N_327680
    extends  OneDHeatTransferTI_FD_N_1280(N = 327680);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTI_FD_N_327680;

  model OneDHeatTransferTI_FD_N_655360
    extends  OneDHeatTransferTI_FD_N_1280(N = 655360);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTI_FD_N_655360;

  model OneDHeatTransferTI_FD_N_1310720
    extends  OneDHeatTransferTI_FD_N_1280(N = 1310720);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTI_FD_N_1310720;

  model OneDHeatTransferTI_Modelica_N_1280
    extends  ScalableTestSuite.Thermal.HeatConduction.ScaledExperiments.OneDHeatTransferTI_Modelica_N_10(N = 1280);
    annotation(experiment(StopTime = 350, Tolerance = 1e-4),
               __OpenModelica_simulationFlags(s = "ida"));
  end OneDHeatTransferTI_Modelica_N_1280;

  model OneDHeatTransferTI_Modelica_N_2560
    extends  OneDHeatTransferTI_Modelica_N_1280(N = 2560);
  end OneDHeatTransferTI_Modelica_N_2560;

  model OneDHeatTransferTI_Modelica_N_5120
    extends  OneDHeatTransferTI_Modelica_N_1280(N = 5120);
  end OneDHeatTransferTI_Modelica_N_5120;

  model OneDHeatTransferTI_Modelica_N_10240
    extends  OneDHeatTransferTI_Modelica_N_1280(N = 10240);
  end OneDHeatTransferTI_Modelica_N_10240;

end HeatConduction;
