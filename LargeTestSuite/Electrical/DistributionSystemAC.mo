within LargeTestSuite.Electrical;

package DistributionSystemAC
  model DistributionSystemLinear_N_10_M_10
    extends ScalableTestSuite.Electrical.DistributionSystemAC.ScaledExperiments.DistributionSystemLinear_N_10_M_10;
  annotation(experiment(StopTime = 1, Interval = 1e-3));
  end DistributionSystemLinear_N_10_M_10;

  model DistributionSystemLinearIndividual_N_10_M_10
    extends ScalableTestSuite.Electrical.DistributionSystemAC.ScaledExperiments.DistributionSystemLinearIndividual_N_10_M_10;
  annotation(experiment(StopTime = 1, Interval = 1e-3));
  end DistributionSystemLinearIndividual_N_10_M_10;
end DistributionSystemAC;
