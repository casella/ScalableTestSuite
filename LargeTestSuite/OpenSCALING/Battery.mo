within LargeTestSuite.OpenSCALING;

package Battery
  extends Modelica.Icons.ExamplesPackage;

  model ElectricBattery_nWE_5_nNS_5_nTB_5
    extends .Battery.Examples.ElectricBattery(
      battery(nWE=5, nNS=5, nTB=5));
  annotation(experiment(StopTime = 1800));
  end ElectricBattery_nWE_5_nNS_5_nTB_5;

  model ElectricBattery_nWE_10_nNS_5_nTB_5
    extends .Battery.Examples.ElectricBattery(
      battery(nWE=10, nNS=5, nTB=5));
  annotation(experiment(StopTime = 1800));
  end ElectricBattery_nWE_10_nNS_5_nTB_5;

  model ElectricBattery_nWE_10_nNS_10_nTB_5
    extends .Battery.Examples.ElectricBattery(
      battery(nWE=10, nNS=10, nTB=5));
  annotation(experiment(StopTime = 1800));
  end ElectricBattery_nWE_10_nNS_10_nTB_5;

  model ElectricBattery_nWE_10_nNS_10_nTB_10
    extends .Battery.Examples.ElectricBattery(
      battery(nWE=10, nNS=10, nTB=10));
  annotation(experiment(StopTime = 1800));
  end ElectricBattery_nWE_10_nNS_10_nTB_10;
end Battery;
