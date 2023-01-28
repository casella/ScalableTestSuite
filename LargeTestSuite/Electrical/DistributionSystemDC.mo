within LargeTestSuite.Electrical;

package DistributionSystemDC
  extends Modelica.Icons.ExamplesPackage;

  model DistributionSystemModelicaIndividual_N_80_M_80
    extends ScalableTestSuite.Electrical.DistributionSystemDC.ScaledExperiments.DistributionSystemModelicaIndividual_N_80_M_80;
  annotation(experiment(StopTime = 1, Interval=1e-3),
             __OpenModelica_simulationFlags(s = "euler"));
  end DistributionSystemModelicaIndividual_N_80_M_80;

  model DistributionSystemModelica_N_80_M_80
    extends ScalableTestSuite.Electrical.DistributionSystemDC.ScaledExperiments.DistributionSystemModelica_N_10_M_10(N = 80, M = 80);
  annotation(experiment(StopTime = 1, Interval=1e-3),
             __OpenModelica_simulationFlags(s = "euler"));
  end DistributionSystemModelica_N_80_M_80;
  
  model DistributionSystemModelica_N_112_M_112
    extends ScalableTestSuite.Electrical.DistributionSystemDC.ScaledExperiments.DistributionSystemModelica_N_10_M_10(N = 112, M = 112);
  annotation(experiment(StopTime = 1, Interval=1e-3),
             __OpenModelica_simulationFlags(s = "euler"));
  end DistributionSystemModelica_N_112_M_112;
  
  model DistributionSystemModelica_N_160_M_160
    extends ScalableTestSuite.Electrical.DistributionSystemDC.ScaledExperiments.DistributionSystemModelica_N_10_M_10(N = 160, M = 160);
  annotation(experiment(StopTime = 1, Interval=1e-3),
             __OpenModelica_simulationFlags(s = "euler"));
  end DistributionSystemModelica_N_160_M_160;

  model DistributionSystemModelica_N_224_M_224
    extends ScalableTestSuite.Electrical.DistributionSystemDC.ScaledExperiments.DistributionSystemModelica_N_10_M_10(N = 224, M = 224);
  annotation(experiment(StopTime = 1, Interval=1e-3),
             __OpenModelica_simulationFlags(s = "euler"));
  end DistributionSystemModelica_N_224_M_224;
end DistributionSystemDC;
