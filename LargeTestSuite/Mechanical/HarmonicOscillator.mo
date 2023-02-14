within LargeTestSuite.Mechanical;

package HarmonicOscillator
  extends Modelica.Icons.ExamplesPackage;

  model HarmonicOscillator_N_3200
    extends ScalableTestSuite.Mechanical.HarmonicOscillator.ScaledExperiments.HarmonicOscillator_N_100(N = 3200);
    annotation(
      experiment(StopTime = 10, Tolerance = 1e-4),
             __OpenModelica_simulationFlags(s = "gbode", gbm = "dopri45"));
  end HarmonicOscillator_N_3200;

  model HarmonicOscillator_N_6400
    extends HarmonicOscillator_N_3200(N = 6400);
    annotation(
      experiment(StopTime = 10, Tolerance = 1e-4),
             __OpenModelica_simulationFlags(s = "gbode", gbm = "dopri45"));
  end HarmonicOscillator_N_6400;
  
  model HarmonicOscillator_N_12800
    extends HarmonicOscillator_N_3200(N = 12800);
    annotation(
      experiment(StopTime = 10, Tolerance = 1e-4),
             __OpenModelica_simulationFlags(s = "gbode", gbm = "dopri45"));
  end HarmonicOscillator_N_12800;
  
  model HarmonicOscillator_N_25600
    extends HarmonicOscillator_N_3200(N = 25600);
    annotation(
      experiment(StopTime = 10, Tolerance = 1e-4),
             __OpenModelica_simulationFlags(s = "gbode", gbm = "dopri45"));
  end HarmonicOscillator_N_25600;
  
  model HarmonicOscillator_N_51200
    extends HarmonicOscillator_N_3200(N = 51200);
    annotation(
      experiment(StopTime = 10, Tolerance = 1e-4),
             __OpenModelica_simulationFlags(s = "gbode", gbm = "dopri45"));
  end HarmonicOscillator_N_51200;

  model HarmonicOscillator_N_102400
    extends HarmonicOscillator_N_3200(N = 102400);
    annotation(
      experiment(StopTime = 10, Tolerance = 1e-4),
             __OpenModelica_simulationFlags(s = "gbode", gbm = "dopri45"));
  end HarmonicOscillator_N_102400;

  model HarmonicOscillator_N_204800
    extends HarmonicOscillator_N_3200(N = 204800);
    annotation(
      experiment(StopTime = 10, Tolerance = 1e-4),
             __OpenModelica_simulationFlags(s = "gbode", gbm = "dopri45"));
  end HarmonicOscillator_N_204800;
  
  model HarmonicOscillator_N_409600
    extends HarmonicOscillator_N_3200(N = 409600);
    annotation(
      experiment(StopTime = 10, Tolerance = 1e-4),
             __OpenModelica_simulationFlags(s = "gbode", gbm = "dopri45"));
  end HarmonicOscillator_N_409600;

  model HarmonicOscillator_N_819200
    extends HarmonicOscillator_N_3200(N = 819200);
    annotation(
      experiment(StopTime = 10, Tolerance = 1e-4),
             __OpenModelica_simulationFlags(s = "gbode", gbm = "dopri45"));
  end HarmonicOscillator_N_819200;
end HarmonicOscillator;
