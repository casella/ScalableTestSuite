within ScalableTestSuite.Thermal;
package Advection "1D advection models"
  package Models
    model SimpleAdvection "Basic thermal advection model with uniform speed"
      parameter Integer N = 2 "Number of nodes";
      parameter Modelica.SIunits.Temperature Tstart[N]=ones(N)*300
        "Start value of the temperature distribution";
      parameter Modelica.SIunits.Length L = 10 "Pipe length";
      final parameter Modelica.SIunits.Length l = L/N "Length of one volume";
      Modelica.SIunits.Velocity u = 1 "Fluid speed";
      Modelica.SIunits.Temperature Tin = 300 "Inlet temperature";
      Modelica.SIunits.Temperature T[N] "Node temperatures";
      Modelica.SIunits.Temperature Ttilde[N-1](start = Tstart[2:N], fixed = true)
        "Temperature states";
      Modelica.SIunits.Temperature Tout;
    equation
      for j in 1:N-1 loop
        der(Ttilde[j]) = u/l*(T[j]-T[j+1]);
      end for;
      T[1] = Tin;
      T[N] = Tout;
      Ttilde = T[2:N];
      annotation (Documentation(info="<html>
<p>This models solves the temperature advection problem represented by the following PDEs by means of the finite volume method.</p>
<p><img src=\"modelica://ScalableTestSuite/Resources/Images/SimpleAdvection/eq_advection.png\"/></p>
<p><img src=\"modelica://ScalableTestSuite/Resources/Images/SimpleAdvection/bc_advection.png\"/></p>
<p>The boundary condition at the inlet Tin and the fluid speed u are specified by suitable binding equations.</p>
</html>"));
    end SimpleAdvection;
  end Models;

  package Verification
    model SimpleAdvection
      extends Models.SimpleAdvection(
        N = 1000,
        Tin = 300 + dT*(0.5*tanh((time-t0)/dt)+0.5));
      parameter Modelica.SIunits.Time t0 = 2
        "Instant of smooth step temperature increase at inlet";
      parameter Modelica.SIunits.Time dt = 0.1
        "Transition time of temperature increase";
      parameter Modelica.SIunits.TemperatureDifference dT = 10
        "Temperature increase at inlet";
      Modelica.SIunits.Temperature Tout_ex
        "Exact outlet temperature from analytical solution";
    equation
      Tout_ex = 300 + dT*(0.5*tanh((time-t0-L/u)/dt)+0.5);
      annotation (experiment(StopTime=15, NumberOfIntervals=5000, Tolerance = 1e-6),
          Documentation(info="<html>
<p>At constant fluid speed u, the exact analytical solution of the PDEs is</p>
<p><img src=\"modelica://ScalableTestSuite/Resources/Images/SimpleAdvection/as_advection.png\"/></p>
</html>"));
    end SimpleAdvection;
  end Verification;

  package ScaledExperiments
    extends Modelica.Icons.ExamplesPackage;
    model SimpleAdvection_N_100
      extends Models.SimpleAdvection(
        N = 100,
        Tin = 300 + dT*(0.5*tanh((time-t0)/dt)+0.5),
        u = 1 + sin(time*2*pi*f));
      constant Real pi = Modelica.Constants.pi;
      parameter Modelica.SIunits.Time t0 = 2
        "Instant of smooth step temperature increase at inlet";
      parameter Modelica.SIunits.Time dt = 0.1
        "Transition time of temperature increase";
      parameter Modelica.SIunits.TemperatureDifference dT = 10
        "Temperature increase at inlet";
      parameter Modelica.SIunits.Frequency f = 0.5
        "Frequency of fluid speed oscillations";
      annotation (experiment(StopTime=20, NumberOfIntervals=5000, Tolerance = 1e-6));
    end SimpleAdvection_N_100;

    model SimpleAdvection_N_200
      extends SimpleAdvection_N_100(N = 200);
      annotation (experiment(StopTime=20, NumberOfIntervals=5000, Tolerance = 1e-6));
    end SimpleAdvection_N_200;

    model SimpleAdvection_N_400
      extends SimpleAdvection_N_100(N = 400);
      annotation (experiment(StopTime=20, NumberOfIntervals=5000, Tolerance = 1e-6));
    end SimpleAdvection_N_400;

    model SimpleAdvection_N_800
      extends SimpleAdvection_N_100(N = 800);
      annotation (experiment(StopTime=20, NumberOfIntervals=5000, Tolerance = 1e-6));
    end SimpleAdvection_N_800;

    model SimpleAdvection_N_1600
      extends SimpleAdvection_N_100(N = 1600);
      annotation (experiment(StopTime=20, NumberOfIntervals=5000, Tolerance = 1e-6));
    end SimpleAdvection_N_1600;

    model SimpleAdvection_N_3200
      extends SimpleAdvection_N_100(N = 3200);
      annotation (experiment(StopTime=20, NumberOfIntervals=5000, Tolerance = 1e-6));
    end SimpleAdvection_N_3200;

    model SimpleAdvection_N_6400
      extends SimpleAdvection_N_100(N = 6400);
      annotation (experiment(StopTime=20, NumberOfIntervals=5000, Tolerance = 1e-6));
    end SimpleAdvection_N_6400;

    model SimpleAdvection_N_12800
      extends SimpleAdvection_N_100(N = 12800);
      annotation (experiment(StopTime=20, NumberOfIntervals=5000, Tolerance = 1e-6));
    end SimpleAdvection_N_12800;
  end ScaledExperiments;
end Advection;
