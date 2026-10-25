within LargeTestSuite.OpenSCALING;

package IDADistricts
  extends Modelica.Icons.ExamplesPackage;

  model Network_2customers
    extends .IDADistricts.Benchmarks.Network_2customers;
 end Network_2customers;

  model Network_15customers
    extends .IDADistricts.Benchmarks.Network_15customers;
  annotation(experiment(StopTime = 5e+06),
             __OpenModelica_commandLineOptions = "-d=mergeComponents");
  end Network_15customers;

  model Network_45customers
    extends .IDADistricts.Benchmarks.Network_45customers;
  annotation(experiment(StopTime = 5e+06),
             __OpenModelica_commandLineOptions = "-d=mergeComponents");
  end Network_45customers;

  model Network_109customers
    extends .IDADistricts.Benchmarks.Network_109customers;
  annotation(experiment(StopTime = 5e+06),
             __OpenModelica_commandLineOptions = "-d=mergeComponents");
  end Network_109customers;

  model Network_1004customers
    extends .IDADistricts.Benchmarks.Network_1004customers;
  annotation(experiment(StopTime = 5e+06),
             __OpenModelica_commandLineOptions = "-d=mergeComponents");
  end Network_1004customers;



end IDADistricts;
