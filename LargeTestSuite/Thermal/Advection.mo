within LargeTestSuite.Thermal;

package Advection
  extends Modelica.Icons.ExamplesPackage;
  model SimpleAdvection_N_12800
    extends ScalableTestSuite.Thermal.Advection.ScaledExperiments.SimpleAdvection_N_100(N = 12800);
    annotation(experiment(StopTime=20, Interval=4e-3, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end SimpleAdvection_N_12800;

  model SimpleAdvection_N_25600
    extends SimpleAdvection_N_12800(N = 25600);
    annotation(experiment(StopTime=20, Interval=4e-3, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end SimpleAdvection_N_25600;

  model SimpleAdvection_N_51200
    extends SimpleAdvection_N_12800(N = 51200);
    annotation(experiment(StopTime=20, Interval=4e-3, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end SimpleAdvection_N_51200;

  model SimpleAdvection_N_102400
    extends SimpleAdvection_N_12800(N = 102400);
    annotation(experiment(StopTime=20, Interval=4e-3, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end SimpleAdvection_N_102400;

  model AdvectionReaction_N_12800
    extends ScalableTestSuite.Thermal.Advection.ScaledExperiments.SimpleAdvection_N_100(N = 12800);
    annotation(experiment(StopTime=1, Interval=4e-3, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end AdvectionReaction_N_12800;

  model AdvectionReaction_N_25600
    extends AdvectionReaction_N_12800(N = 25600);
    annotation(experiment(StopTime=1, Interval=4e-3, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end AdvectionReaction_N_25600;

  model AdvectionReaction_N_51200
    extends AdvectionReaction_N_12800(N = 51200);
    annotation(experiment(StopTime=1, Interval=4e-3, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end AdvectionReaction_N_51200;

  model AdvectionReaction_N_102400
    extends AdvectionReaction_N_12800(N = 102400);
    annotation(experiment(StopTime=1, Interval=4e-3, Tolerance = 1e-6),
               __OpenModelica_simulationFlags(s = "ida"));
  end AdvectionReaction_N_102400;

end Advection;
