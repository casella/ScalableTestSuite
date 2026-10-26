within LargeTestSuite.OpenSCALING;

package Battery
  extends Modelica.Icons.ExamplesPackage;

  model ElectricBattery_nWE_10_nNS_10_nTB_10
    extends .Battery.Examples.ElectricBattery(
      battery(nWE=10, nNS=10, nTB=10));
  annotation(experiment(StopTime = 1800));
  end ElectricBattery_nWE_10_nNS_10_nTB_10;

  model ElectricBattery_nWE_20_nNS_10_nTB_10
    extends .Battery.Examples.ElectricBattery(
      battery(nWE=20, nNS=10, nTB=10));
  annotation(experiment(StopTime = 1800));
  end ElectricBattery_nWE_20_nNS_10_nTB_10;

  model ElectricBattery_nWE_20_nNS_20_nTB_10
    extends .Battery.Examples.ElectricBattery(
      battery(nWE=20, nNS=20, nTB=10));
  annotation(experiment(StopTime = 1800));
  end ElectricBattery_nWE_20_nNS_20_nTB_10;

  model ElectricBattery_nWE_20_nNS_20_nTB_20
    extends .Battery.Examples.ElectricBattery(
      battery(nWE=20, nNS=20, nTB=20));
  annotation(experiment(StopTime = 1800));
  end ElectricBattery_nWE_20_nNS_20_nTB_20;

  model ElectricBattery_nWE_40_nNS_20_nTB_20
    extends .Battery.Examples.ElectricBattery(
      battery(nWE=40, nNS=20, nTB=20));
  end ElectricBattery_nWE_40_nNS_20_nTB_20;

  model ElectricBattery_nWE_40_nNS_40_nTB_20
    extends .Battery.Examples.ElectricBattery(
      battery(nWE=40, nNS=40, nTB=20));
  end ElectricBattery_nWE_40_nNS_40_nTB_20;

  model ElectricBattery_nWE_40_nNS_40_nTB_40
    extends .Battery.Examples.ElectricBattery(
      battery(nWE=40, nNS=40, nTB=40));
  end ElectricBattery_nWE_40_nNS_40_nTB_40;
end Battery;
