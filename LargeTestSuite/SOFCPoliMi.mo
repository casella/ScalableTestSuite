within LargeTestSuite;

package SOFCPoliMi
  extends Modelica.Icons.Package;

  model BenchmarkCammarata
    extends .SOFCPoliMi.Tests.BenchmarkCammarata;
  annotation (
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS"));
  end BenchmarkCammarata;

  model BenchmarkCammarataIndex1
    extends .SOFCPoliMi.Tests.BenchmarkCammarataIndex1;
  annotation (
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS"));
  end BenchmarkCammarataIndex1;

  model BenchmarkCammarataIndex1_N5
    extends .SOFCPoliMi.Tests.BenchmarkCammarataIndex1_N5;
  annotation (
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS"));
  end BenchmarkCammarataIndex1_N5;

  model BenchmarkCammarataIndex1_N10
    extends .SOFCPoliMi.Tests.BenchmarkCammarataIndex1_N10;
  annotation (
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS"));
  end BenchmarkCammarataIndex1_N10;

  model BenchmarkCammarataIndex1_N20
    extends .SOFCPoliMi.Tests.BenchmarkCammarataIndex1_N20;
  annotation (
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS"));
  end BenchmarkCammarataIndex1_N20;

  model BenchmarkCammarataIndex1_N40
    extends .SOFCPoliMi.Tests.BenchmarkCammarataIndex1_N40;
  annotation (
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS"));
  end BenchmarkCammarataIndex1_N40;

  model BenchmarkCammarataIndex1_N80
    extends .SOFCPoliMi.Tests.BenchmarkCammarataIndex1_N80;
  annotation (
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS"));
  end BenchmarkCammarataIndex1_N80;

  model BenchmarkCammarataIndex1_N160
    extends .SOFCPoliMi.Tests.BenchmarkCammarataIndex1_N160;
  annotation (
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS"));
  end BenchmarkCammarataIndex1_N160;
end SOFCPoliMi;
