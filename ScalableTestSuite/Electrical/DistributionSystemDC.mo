within ScalableTestSuite.Electrical;
package DistributionSystemDC
  package Models
    model DistributionSystemModelica
      parameter Integer N = 4
        "Number of segments of the primary distribution line";
      parameter Integer M = N
        "Number of segments of each secondary distribution line";
      parameter Real alpha = 2 "Distribution line oversizing factor";
      parameter Modelica.SIunits.Resistance R_l = 1
        "Resistance of a single load";
      parameter Modelica.SIunits.Resistance R_d2 = R_l/(M^2*alpha)
        "Resistance of a secondary distribution segment";
      parameter Modelica.SIunits.Resistance R_d1 = R_l/(M^2*N^2*alpha)
        "Resistance of a primary distribution segment";

      Modelica.Electrical.Analog.Basic.Resistor primary[N](each R = R_d1)
        "Primary distribution line segments";
      Modelica.Electrical.Analog.Basic.Resistor secondary[N,M](each R = R_d2)
        "Secondary distribution line segments";
      Modelica.Electrical.Analog.Basic.Resistor load[N,M](each R = R_l)
        "Individual load resistors";
      Modelica.Electrical.Analog.Basic.Ground ground[N,M];
      Modelica.Electrical.Analog.Basic.Ground sourceGround;

      Modelica.Electrical.Analog.Sources.RampVoltage V_source(V = 600, duration = 1);
    equation
      connect(primary[1].p, V_source.p);
      connect(sourceGround.p, V_source.n);
      for i in 1:N-1 loop
        connect(primary[i].n, primary[i+1].p);
      end for;
      for i in 1:N loop
        connect(primary[i].n, secondary[i,1].p);
        for j in 1:M-1 loop
          connect(secondary[i,j].n, secondary[i,j+1].p);
        end for;
        for j in 1:M loop
          connect(secondary[i,j].n, load[i,j].p);
          connect(load[i,j].n, ground[i,j].p);
        end for;
      end for;

      annotation (Documentation(info="<html>
  <p>This model represnts a DC current distribution system, whose complexity depends on two parameters 
  N and M. A voltage source is connected to primary resistive distribution line which is split into
  N segments, each with a resistance R_d1. At the end of each segment, a secondary distribution
  line is attached with M elements each of resistance R_d2. At the end of each secondary segment,
  a load resistor of resistance R_l is connected, which is grounded on the other side.</p>
</html>"));
    end DistributionSystemModelica;
  end Models;

  package Verification

  end Verification;

  package ScaledExperiments
    extends Modelica.Icons.ExamplesPackage;
    model DistributionSystemModelica_N_10_M_10
      extends Models.DistributionSystemModelica(N = 10, M = 10);
      annotation(experiment(StopTime = 1, Interval = 1e-3));
    end DistributionSystemModelica_N_10_M_10;

    model DistributionSystemModelica_N_14_M_14
      extends Models.DistributionSystemModelica(N = 14, M = 14);
      annotation(experiment(StopTime = 1, Interval = 1e-3));
    end DistributionSystemModelica_N_14_M_14;

    model DistributionSystemModelica_N_20_M_20
      extends Models.DistributionSystemModelica(N = 20, M = 20);
      annotation(experiment(StopTime = 1, Interval = 1e-3));
    end DistributionSystemModelica_N_20_M_20;

    model DistributionSystemModelica_N_28_M_28
      extends Models.DistributionSystemModelica(N = 28, M = 28);
      annotation(experiment(StopTime = 1, Interval = 1e-3));
    end DistributionSystemModelica_N_28_M_28;

    model DistributionSystemModelica_N_40_M_40
      extends Models.DistributionSystemModelica(N = 40, M = 40);
      annotation(experiment(StopTime = 1, Interval = 1e-3));
    end DistributionSystemModelica_N_40_M_40;

    model DistributionSystemModelica_N_56_M_56
      extends Models.DistributionSystemModelica(N = 56, M = 56);
      annotation(experiment(StopTime = 1, Interval = 1e-3));
    end DistributionSystemModelica_N_56_M_56;

    model DistributionSystemModelica_N_80_M_80
      extends Models.DistributionSystemModelica(N = 80, M = 80);
      annotation(experiment(StopTime = 1, Interval = 1e-3));
    end DistributionSystemModelica_N_80_M_80;

    model DistributionSystemModelica_N_112_M_112
      extends Models.DistributionSystemModelica(N = 112, M = 112);
      annotation(experiment(StopTime = 1, Interval = 1e-3));
    end DistributionSystemModelica_N_112_M_112;

    model DistributionSystemModelica_N_160_M_160
      extends Models.DistributionSystemModelica(N = 160, M = 160);
      annotation(experiment(StopTime = 1, Interval = 1e-3));
    end DistributionSystemModelica_N_160_M_160;
  end ScaledExperiments;
end DistributionSystemDC;
