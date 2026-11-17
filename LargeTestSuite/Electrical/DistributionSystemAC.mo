within LargeTestSuite.Electrical;

package DistributionSystemAC
  extends Modelica.Icons.ExamplesPackage;

  model DistributionSystemLinear_N_10_M_10
    extends ScalableTestSuite.Electrical.DistributionSystemAC.ScaledExperiments.DistributionSystemLinear_N_10_M_10;
  annotation(experiment(StopTime = 1, Interval = 1e-3));
  end DistributionSystemLinear_N_10_M_10;

  model DistributionSystemLinearIndividual_N_10_M_10
    extends ScalableTestSuite.Electrical.DistributionSystemAC.ScaledExperiments.DistributionSystemLinearIndividual_N_10_M_10;
  annotation(experiment(StopTime = 1, Interval = 1e-3));
  end DistributionSystemLinearIndividual_N_10_M_10;

  model DistributionSystemLinearIndividual_N_14_M_14
    extends ScalableTestSuite.Electrical.DistributionSystemAC.ScaledExperiments.DistributionSystemLinearIndividual_N_14_M_14;
  annotation(experiment(StopTime = 1, Interval = 1e-3));
  end DistributionSystemLinearIndividual_N_14_M_14;

  model DistributionSystemLinearIndividual_N_20_M_20
    extends ScalableTestSuite.Electrical.DistributionSystemAC.ScaledExperiments.DistributionSystemLinearIndividual_N_20_M_20;
  annotation(experiment(StopTime = 1, Interval = 1e-3));
  end DistributionSystemLinearIndividual_N_20_M_20;
end DistributionSystemAC;
