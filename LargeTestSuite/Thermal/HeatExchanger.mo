within LargeTestSuite.Thermal;

package HeatExchanger
  extends Modelica.Icons.ExamplesPackage;

  model CounterCurrentHeatExchangerEquations_N_160
    extends  ScalableTestSuite.Thermal.HeatExchanger.ScaledExperiments.CounterCurrentHeatExchangerEquations_N_10(N = 160);
    annotation(experiment(StopTime = 20, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end CounterCurrentHeatExchangerEquations_N_160;

  model CounterCurrentHeatExchangerEquations_N_320
    extends  ScalableTestSuite.Thermal.HeatExchanger.ScaledExperiments.CounterCurrentHeatExchangerEquations_N_10(N = 320);
    annotation(experiment(StopTime = 20, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end CounterCurrentHeatExchangerEquations_N_320;

  model CounterCurrentHeatExchangerEquations_N_640
    extends  ScalableTestSuite.Thermal.HeatExchanger.ScaledExperiments.CounterCurrentHeatExchangerEquations_N_10(N = 640);
    annotation(experiment(StopTime = 20, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end CounterCurrentHeatExchangerEquations_N_640;

  model CounterCurrentHeatExchangerEquations_N_1280
    extends  ScalableTestSuite.Thermal.HeatExchanger.ScaledExperiments.CounterCurrentHeatExchangerEquations_N_10(N = 1280);
    annotation(experiment(StopTime = 20, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end CounterCurrentHeatExchangerEquations_N_1280;

  model CounterCurrentHeatExchangerEquations_N_2560
    extends CounterCurrentHeatExchangerEquations_N_1280(N = 2560);
    annotation(experiment(StopTime = 20, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end CounterCurrentHeatExchangerEquations_N_2560;

  model CounterCurrentHeatExchangerEquations_N_5120
    extends CounterCurrentHeatExchangerEquations_N_1280(N = 5120);
    annotation(experiment(StopTime = 20, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end CounterCurrentHeatExchangerEquations_N_5120;

  model CounterCurrentHeatExchangerEquations_N_10240
    extends CounterCurrentHeatExchangerEquations_N_1280(N = 10240);
    annotation(experiment(StopTime = 20, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end CounterCurrentHeatExchangerEquations_N_10240;

  model CounterCurrentHeatExchangerEquations_N_20480
    extends CounterCurrentHeatExchangerEquations_N_1280(N = 20480);
    annotation(experiment(StopTime = 20, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end CounterCurrentHeatExchangerEquations_N_20480;

  model CounterCurrentHeatExchangerEquations_N_40960
    extends CounterCurrentHeatExchangerEquations_N_1280(N = 40960);
    annotation(experiment(StopTime = 20, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end CounterCurrentHeatExchangerEquations_N_40960;

  model CounterCurrentHeatExchangerEquations_N_81920
    extends CounterCurrentHeatExchangerEquations_N_1280(N = 81920);
    annotation(experiment(StopTime = 20, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end CounterCurrentHeatExchangerEquations_N_81920;

  model CocurrentHeatExchangerEquations_N_160
    extends  ScalableTestSuite.Thermal.HeatExchanger.ScaledExperiments.CocurrentHeatExchangerEquations_N_10(N = 160);
    annotation(experiment(StopTime = 20, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end CocurrentHeatExchangerEquations_N_160;

  model CocurrentHeatExchangerEquations_N_320
    extends  ScalableTestSuite.Thermal.HeatExchanger.ScaledExperiments.CocurrentHeatExchangerEquations_N_10(N = 320);
    annotation(experiment(StopTime = 20, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end CocurrentHeatExchangerEquations_N_320;

  model CocurrentHeatExchangerEquations_N_640
    extends  ScalableTestSuite.Thermal.HeatExchanger.ScaledExperiments.CocurrentHeatExchangerEquations_N_10(N = 640);
    annotation(experiment(StopTime = 20, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end CocurrentHeatExchangerEquations_N_640;

  model CocurrentHeatExchangerEquations_N_1280
    extends  ScalableTestSuite.Thermal.HeatExchanger.ScaledExperiments.CocurrentHeatExchangerEquations_N_10(N = 1280);
    annotation(experiment(StopTime = 20, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end CocurrentHeatExchangerEquations_N_1280;

  model CocurrentHeatExchangerEquations_N_2560
    extends CocurrentHeatExchangerEquations_N_1280(N = 2560);
    annotation(experiment(StopTime = 20, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end CocurrentHeatExchangerEquations_N_2560;

  model CocurrentHeatExchangerEquations_N_5120
    extends CocurrentHeatExchangerEquations_N_1280(N = 5120);
    annotation(experiment(StopTime = 20, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end CocurrentHeatExchangerEquations_N_5120;

  model CocurrentHeatExchangerEquations_N_10240
    extends CocurrentHeatExchangerEquations_N_1280(N = 10240);
    annotation(experiment(StopTime = 20, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end CocurrentHeatExchangerEquations_N_10240;

  model CocurrentHeatExchangerEquations_N_20480
    extends CocurrentHeatExchangerEquations_N_1280(N = 20480);
    annotation(experiment(StopTime = 20, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end CocurrentHeatExchangerEquations_N_20480;

  model CocurrentHeatExchangerEquations_N_40960
    extends CocurrentHeatExchangerEquations_N_1280(N = 40960);
    annotation(experiment(StopTime = 20, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end CocurrentHeatExchangerEquations_N_40960;

  model CocurrentHeatExchangerEquations_N_81920
    extends CocurrentHeatExchangerEquations_N_1280(N = 81920);
    annotation(experiment(StopTime = 20, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end CocurrentHeatExchangerEquations_N_81920;

end HeatExchanger;
