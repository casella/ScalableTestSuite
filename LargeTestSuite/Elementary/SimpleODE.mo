within LargeTestSuite.Elementary;

package SimpleODE
  extends Modelica.Icons.ExamplesPackage;
  model CascadedFirstOrder_N_12800
    extends ScalableTestSuite.Elementary.SimpleODE.Models.CascadedFirstOrder(N=12800);
  annotation(experiment(StopTime = 2, Tolerance = 1e-6),
             __OpenModelica_simulationFlags(s = "ida"));
  end CascadedFirstOrder_N_12800;

  model CascadedFirstOrder_N_25600
    extends ScalableTestSuite.Elementary.SimpleODE.Models.CascadedFirstOrder(N=25600);
  annotation(experiment(StopTime = 2, Tolerance = 1e-6),
             __OpenModelica_simulationFlags(s = "ida"));
  end CascadedFirstOrder_N_25600;

  model CascadedFirstOrder_N_51200
    extends ScalableTestSuite.Elementary.SimpleODE.Models.CascadedFirstOrder(N=51200);
  annotation(experiment(StopTime = 2, Tolerance = 1e-6),
             __OpenModelica_simulationFlags(s = "ida"));
  end CascadedFirstOrder_N_51200;

  model CascadedFirstOrder_N_102400
    extends ScalableTestSuite.Elementary.SimpleODE.Models.CascadedFirstOrder(N=102400);
  annotation(experiment(StopTime = 2, Tolerance = 1e-6),
             __OpenModelica_simulationFlags(s = "ida"));
  end CascadedFirstOrder_N_102400;
end SimpleODE;
