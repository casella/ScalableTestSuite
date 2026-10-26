within LargeTestSuite.OpenSCALING;

package LSGreenH2Production
  extends Modelica.Icons.ExamplesPackage;

  model Plant_nTrafoEHV_5_nTrafoHV_10
    extends .LSGreenH2Production.Plant(nTrafoEHV = 5, nTrafoHV = 10);
  annotation(experiment(StopTime = 1, Interval = 0.1));
  end Plant_nTrafoEHV_5_nTrafoHV_10;

  model Plant_nTrafoEHV_5_nTrafoHV_20
    extends Plant_nTrafoHV_10(nTrafoEHV = 5, nTrafoHV = 20);
  annotation(experiment(StopTime = 1, Interval = 0.1));
  end Plant_nTrafoEHV_5_nTrafoHV_20;

  model Plant_nTrafoEHV_5_nTrafoHV_40
    extends Plant_nTrafoHV_10(nTrafoEHV = 5, nTrafoHV = 40);
  annotation(experiment(StopTime = 1, Interval = 0.1));
  end Plant_nTrafoEHV_5_nTrafoHV_40;

  model Plant_nTrafoEHV_10_nTrafoHV_40
    extends Plant_nTrafoHV_10(nTrafoEHV = 10, nTrafoHV = 40);
  annotation(experiment(StopTime = 1, Interval = 0.1));
  end Plant_nTrafoEHV_10_nTrafoHV_40;

  model Plant_nTrafoEHV_10_nTrafoHV_80
    extends Plant_nTrafoHV_10(nTrafoEHV = 10, nTrafoHV = 80);
  annotation(experiment(StopTime = 1, Interval = 0.1));
  end Plant_nTrafoEHV_10_nTrafoHV_80;

  model Plant_nTrafoEHV_20_nTrafoHV_80
    extends Plant_nTrafoHV_10(nTrafoEHV = 20, nTrafoHV = 80);
  annotation(experiment(StopTime = 1, Interval = 0.1));
  end Plant_nTrafoEHV_20_nTrafoHV_80;

  model Plant_nTrafoEHV_20_nTrafoHV_160
    extends Plant_nTrafoHV_10(nTrafoEHV = 20, nTrafoHV = 160);
  annotation(experiment(StopTime = 1, Interval = 0.1));
  end Plant_nTrafoEHV_20_nTrafoHV_160;

  model Plant_nTrafoEHV_40_nTrafoHV_160
    extends Plant_nTrafoHV_10(nTrafoEHV = 40, nTrafoHV = 160);
  annotation(experiment(StopTime = 1, Interval = 0.1));
  end Plant_nTrafoEHV_40_nTrafoHV_160;

  model Plant_nTrafoEHV_40_nTrafoHV_320
    extends Plant_nTrafoHV_10(nTrafoEHV = 40, nTrafoHV = 320);
  annotation(experiment(StopTime = 1, Interval = 0.1));
  end Plant_nTrafoEHV_40_nTrafoHV_320;

  model Plant_nTrafoEHV_80_nTrafoHV_320
    extends Plant_nTrafoHV_10(nTrafoEHV = 80, nTrafoHV = 320);
  annotation(experiment(StopTime = 1, Interval = 0.1));
  end Plant_nTrafoEHV_80_nTrafoHV_320;
end LSGreenH2Production;
