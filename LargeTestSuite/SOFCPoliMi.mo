within LargeTestSuite;

package SOFCPoliMi
  extends Modelica.Icons.Package;

  model BenchmarkCammarata
    extends .SOFCPoliMi.Tests.BenchmarkCammarata;
  annotation (
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl"));
  end BenchmarkCammarata;

  model BenchmarkCammarataIndex1
    extends .SOFCPoliMi.Tests.BenchmarkCammarataIndex1;
  annotation (
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl"));
  end BenchmarkCammarataIndex1;
end SOFCPoliMi;
