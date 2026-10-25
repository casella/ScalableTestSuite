within LargeTestSuite.OpenSCALING;

package LSGreenH2Production
  extends Modelica.Icons.ExamplesPackage;

  model Plant_nTrafoHV_10
    extends .LSGreenH2Production.Plant(nTrafoHV = 10);
  annotation(experiment(StopTime = 1, Interval = 0.1));
  end Plant_nTrafoHV_10;

  model Plant_nTrafoHV_20
    extends Plant_nTrafoHV_10(nTrafoHV = 20);
  annotation(experiment(StopTime = 1, Interval = 0.1));
  end Plant_nTrafoHV_20;

  model Plant_nTrafoHV_40
    extends Plant_nTrafoHV_10(nTrafoHV = 40);
  annotation(experiment(StopTime = 1, Interval = 0.1));
  end Plant_nTrafoHV_40;

  model Plant_nTrafoHV_80
    extends Plant_nTrafoHV_10(nTrafoHV = 80);
  annotation(experiment(StopTime = 1, Interval = 0.1));
  end Plant_nTrafoHV_80;

  model Plant_nTrafoHV_160
    extends Plant_nTrafoHV_10(nTrafoHV = 160);
  annotation(experiment(StopTime = 1, Interval = 0.1));
  end Plant_nTrafoHV_160;

  model Plant_nTrafoHV_320
    extends Plant_nTrafoHV_10(nTrafoHV = 320);
  annotation(experiment(StopTime = 1, Interval = 0.1));
  end Plant_nTrafoHV_320;

  model Plant_nTrafoHV_640
    extends Plant_nTrafoHV_10(nTrafoHV = 640);
  annotation(experiment(StopTime = 1, Interval = 0.1));
  end Plant_nTrafoHV_640;

  model Plant_nTrafoHV_1280
    extends Plant_nTrafoHV_10(nTrafoHV = 1280);
  annotation(experiment(StopTime = 1, Interval = 0.1));
  end Plant_nTrafoHV_1280;
end LSGreenH2Production;
