within LargeTestSuite.Elementary;

package SimpleODE
  extends Modelica.Icons.ExamplesPackage;

  function smoothStep
    input Real u;
    input Real a = 0.01;
    input Real b = 10;
    output Real y;
  algorithm
    y := (1 + tanh((u - a*b)/a))/2;
  annotation(Inline = true);
  end smoothStep;

  model CascadedFirstOrder_N_12800
    extends ScalableTestSuite.Elementary.SimpleODE.Models.CascadedFirstOrder(
      N=12800, u = smoothStep(time));
  annotation(experiment(StopTime = 2, Tolerance = 1e-5),
             __OpenModelica_simulationFlags(s = "ida"));
  end CascadedFirstOrder_N_12800;

  model CascadedFirstOrder_N_25600
    extends CascadedFirstOrder_N_12800(N=25600);
  annotation(experiment(StopTime = 2, Tolerance = 1e-5),
             __OpenModelica_simulationFlags(s = "ida"));
  end CascadedFirstOrder_N_25600;

  model CascadedFirstOrder_N_51200
    extends CascadedFirstOrder_N_12800(N=51200);
  annotation(experiment(StopTime = 2, Tolerance = 1e-5),
             __OpenModelica_simulationFlags(s = "ida"));
  end CascadedFirstOrder_N_51200;

  model CascadedFirstOrder_N_102400
    extends CascadedFirstOrder_N_12800(N=102400);
  annotation(experiment(StopTime = 2, Tolerance = 1e-5),
             __OpenModelica_simulationFlags(s = "ida"));
  end CascadedFirstOrder_N_102400;

  model CascadedFirstOrder_N_204800
    extends CascadedFirstOrder_N_12800(N=204800);
  annotation(experiment(StopTime = 2, Tolerance = 1e-5),
             __OpenModelica_simulationFlags(s = "ida"));
  end CascadedFirstOrder_N_204800;

  model CascadedFirstOrder_N_409600
    extends CascadedFirstOrder_N_12800(N=409600);
  annotation(experiment(StopTime = 2, Tolerance = 1e-5),
             __OpenModelica_simulationFlags(s = "ida"));
  end CascadedFirstOrder_N_409600;
end SimpleODE;
