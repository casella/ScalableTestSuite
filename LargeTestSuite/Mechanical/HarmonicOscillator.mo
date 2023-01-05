within LargeTestSuite.Mechanical;

package HarmonicOscillator
  extends Modelica.Icons.ExamplesPackage;

  model HarmonicOscillator_N_3200
    extends ScalableTestSuite.Mechanical.HarmonicOscillator.ScaledExperiments.HarmonicOscillator_N_100(N = 3200);
    annotation(
      experiment(StopTime = 10),
             __OpenModelica_simulationFlags(s = "ida"));
  end HarmonicOscillator_N_3200;

  model HarmonicOscillator_N_6400
    extends HarmonicOscillator_N_3200(N = 6400);
    annotation(
      experiment(StopTime = 10),
             __OpenModelica_simulationFlags(s = "ida"));
  end HarmonicOscillator_N_6400;
  
  model HarmonicOscillator_N_12800
    extends HarmonicOscillator_N_3200(N = 12800);
    annotation(
      experiment(StopTime = 10),
             __OpenModelica_simulationFlags(s = "ida"));
  end HarmonicOscillator_N_12800;
  
  model HarmonicOscillator_N_25600
    extends HarmonicOscillator_N_3200(N = 25600);
    annotation(
      experiment(StopTime = 10),
             __OpenModelica_simulationFlags(s = "ida"));
  end HarmonicOscillator_N_25600;
  
end HarmonicOscillator;
