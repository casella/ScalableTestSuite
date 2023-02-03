within LargeTestSuite.Electrical;

package TransmissionLine
  extends Modelica.Icons.ExamplesPackage;

  model TransmissionLineEquations_N_1280
    extends ScalableTestSuite.Electrical.TransmissionLine.Models.TransmissionLineEquations(N = 1280, L = 100, res = 48e-6, cap = 101e-12, ind = 253e-9, w = 1 / 2e-7);
    annotation(experiment(StopTime = 4e-6, Interval=2e-9, Tolerance = 1e-8),
               __OpenModelica_simulationFlags(s = "ida"));
  end TransmissionLineEquations_N_1280;

  model TransmissionLineEquations_N_2560
    extends TransmissionLineEquations_N_1280(N = 2560);
  end TransmissionLineEquations_N_2560;

  model TransmissionLineEquations_N_5120
    extends TransmissionLineEquations_N_1280(N = 5120);
  end TransmissionLineEquations_N_5120;

  model TransmissionLineEquations_N_10240
    extends TransmissionLineEquations_N_1280(N = 10240);
  end TransmissionLineEquations_N_10240;

  model TransmissionLineModelica_N_1280
    extends ScalableTestSuite.Electrical.TransmissionLine.Models.TransmissionLineModelica(N = 1280, L = 100, res = 48e-6, cap = 101e-12, ind = 253e-9, w = 1 / 2e-7);
    annotation(experiment(StopTime = 4e-6, Interval=2e-9, Tolerance = 1e-8),
               __OpenModelica_simulationFlags(s = "ida"));
  end TransmissionLineModelica_N_1280;

  model TransmissionLineModelica_N_2560
    extends TransmissionLineModelica_N_1280(N = 2560);
  end TransmissionLineModelica_N_2560;

  model TransmissionLineModelica_N_5120
    extends TransmissionLineModelica_N_1280(N = 5120);
  end TransmissionLineModelica_N_5120;

  model TransmissionLineModelica_N_10240
    extends TransmissionLineModelica_N_1280(N = 10240);
  end TransmissionLineModelica_N_10240;
end TransmissionLine;
