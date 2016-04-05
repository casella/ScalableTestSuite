within ScalableTestSuite.Elementary;
package SimpleODE
  package Models
    model CascadedFirstOrder
      parameter Integer N = 10 "Order of the system";
      parameter Modelica.SIunits.Time T = 1 "System time constant";
      final parameter Modelica.SIunits.Time tau = T/N "Individual time constant";
      Real x[N] (each start = 0, each fixed = true);
    equation
      tau*der(x[1]) = 1;
      for i in 2:N loop
        tau*der(x[i]) = x[i-i] - x[i];
      end for;
    end CascadedFirstOrder;
  end Models;
  package ScaledExperiments
    model CascadedFirstOrder_N_100
      extends Models.CascadedFirstOrder(N=100);
    annotation(experiment(StopTime = 5, Tolerance = 1e-6));
    end CascadedFirstOrder_N_100;

    model CascadedFirstOrder_N_200
      extends Models.CascadedFirstOrder(N=200);
    annotation(experiment(StopTime = 5, Tolerance = 1e-6));
    end CascadedFirstOrder_N_200;

    model CascadedFirstOrder_N_400
      extends Models.CascadedFirstOrder(N=400);
    annotation(experiment(StopTime = 5, Tolerance = 1e-6));
    end CascadedFirstOrder_N_400;

    model CascadedFirstOrder_N_800
      extends Models.CascadedFirstOrder(N=800);
    annotation(experiment(StopTime = 5, Tolerance = 1e-6));
    end CascadedFirstOrder_N_800;

    model CascadedFirstOrder_N_1600
      extends Models.CascadedFirstOrder(N=1600);
    annotation(experiment(StopTime = 5, Tolerance = 1e-6));
    end CascadedFirstOrder_N_1600;

    model CascadedFirstOrder_N_3200
      extends Models.CascadedFirstOrder(N=3200);
    annotation(experiment(StopTime = 5, Tolerance = 1e-6));
    end CascadedFirstOrder_N_3200;

    model CascadedFirstOrder_N_6400
      extends Models.CascadedFirstOrder(N=6400);
    annotation(experiment(StopTime = 5, Tolerance = 1e-6));
    end CascadedFirstOrder_N_6400;

    model CascadedFirstOrder_N_12800
      extends Models.CascadedFirstOrder(N=12800);
    annotation(experiment(StopTime = 5, Tolerance = 1e-6));
    end CascadedFirstOrder_N_12800;

    model CascadedFirstOrder_N_25600
      extends Models.CascadedFirstOrder(N=25600);
    annotation(experiment(StopTime = 5, Tolerance = 1e-6));
    end CascadedFirstOrder_N_25600;
  end ScaledExperiments;
end SimpleODE;
