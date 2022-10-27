within ScalableTestSuite.Thermal;
package Advection "1D advection models"
  package Models
    model SimpleAdvection "Basic thermal advection model with uniform speed"
      parameter Integer N = 2 "Number of nodes";
      parameter Modelica.Units.SI.Temperature Tstart[N]=ones(N)*300
        "Start value of the temperature distribution";
      parameter Modelica.Units.SI.Length L=10 "Pipe length";
      final parameter Modelica.Units.SI.Length l=L/N "Length of one volume";
      Modelica.Units.SI.Velocity u=1 "Fluid speed";
      Modelica.Units.SI.Temperature Tin=300 "Inlet temperature";
      Modelica.Units.SI.Temperature T[N] "Node temperatures";
      Modelica.Units.SI.Temperature Ttilde[N - 1](start=Tstart[2:N], each fixed
          =true) "Temperature states";
      Modelica.Units.SI.Temperature Tout;
    equation
      for j in 1:N-1 loop
        der(Ttilde[j]) = u/l*(T[j]-T[j+1]);
      end for;
      T[1] = Tin;
      T[N] = Tout;
      Ttilde = T[2:N];
      annotation(Documentation(info="<html>
<p>This models solves the temperature advection problem represented by the following PDEs by means of the finite volume method.</p>
<p><img src=\"modelica://ScalableTestSuite/Resources/Images/SimpleAdvection/eq_advection.png\"/></p>
<p><img src=\"modelica://ScalableTestSuite/Resources/Images/SimpleAdvection/bc_advection.png\"/></p>
<p>The boundary condition at the inlet Tin and the fluid speed u are specified by suitable binding equations.</p>
</html>"));
    end SimpleAdvection;

    model AdvectionReaction
      "Model of an advection process with chemical reaction"
      parameter Integer N = 10 "Number of volumes";
      parameter Real mu = 1000 "Kinetic coefficient of the reaction";
      constant Real alpha = 0.5 "Parameter of the reaction model";
      Real u_in = 1 "Inlet concentration";
      Real u[N](each start = 0, each fixed = true)
        "Concentration at each volume outlet";
    equation
      der(u[1]) = ((-u[1]) + 1)*N - mu*u[1]*(u[1] - alpha)*(u[1] - 1);
      for j in 2:N loop
        der(u[j]) = ((-u[j]) + u[j-1])*N - mu*u[j]*(u[j] - alpha)*(u[j] - 1);
      end for;
      annotation(Documentation(info="<html>
<p>This models solves the problem represented by the following PDE by means of the finite volume method, on a spatial domain of unit length and assuming unit velocity v.</p>
<p><img src=\"modelica://ScalableTestSuite/Resources/Images/AdvectionReaction/eq_advection_reaction.png\"/></p>
<p>If &mu; = 0, the model represent the transport of a certain chemical species in a fluid, similar to <a href = \"modelica://ScalableTestSuite.Thermal.Advection.Models.SimpleAdvection\">SimpleAdvection</a>. If mu is increased, a chemical reaction is added with two stable equilibria, one at u = 0 and one at u = 1, with an unstable equilibrium at u = &alpha;.</p>
<p> The chemical reaction sharpens the concentration wave front, which would be otherwise be smoothed out by the numerical diffusion effect of the finite volume method.</p>
<p>The boundary condition u_in at the inlet, i.e., u(0,t), is specified by suitable binding equations.</p>
</html>"));
    end AdvectionReaction;

    model SteamPipe
      "Detailed thermal advection model with thermal expansion effects using IF97 water vapour"
      import      Modelica.Units.SI;
      replaceable package Medium = Modelica.Media.Water.StandardWater
        constrainedby Modelica.Media.Interfaces.PartialMedium;
      parameter Integer N = 10 "Number of nodes";
      parameter SI.Volume Vtot = 1 "Total volume";
      parameter Real w_nom = 2 "Nominal mass flow rate";
      parameter Real dp_nom = 1e5
        "Nominal total pressure loss at full flow rate";
      parameter Real p_nom = 10e5 "Nominal pressure at outlet";
      parameter Real h_nom = 3.1e6 "Nominal specific enthalpy";
      parameter SI.Pressure p_start = p_nom "Initial value of pressure states";
      parameter SI.SpecificEnthalpy h_start = h_nom
        "Initial value of enthalpy states";
      final parameter Real kf = w_nom / (dp_nom/N) "Friction coefficient";
      final parameter SI.Volume V=Vtot/N "Total volume";
      final parameter SI.Density rho_av = Medium.density_ph(p_nom+dp_nom/2, h_nom)
        "Average density";
      final parameter SI.Time tau = Vtot*rho_av/w_nom
        "Estimated transport delay at nominal conditions";
      SI.MassFlowRate w_in_pipe = 0 + (if time>1 then w_nom else 0)
        "Inlet mass flow rate";
      SI.SpecificEnthalpy h_in_pipe = h_nom + (if time > 10 then 5000 else 0)
        "Inlet specific enthalpy";

      SI.Mass M[N] "Fluid mass within each volume";
      SI.Energy E[N] "Fluid internal energy within each volume";
      SI.MassFlowRate w_in[N] "Inlet flow rate of each volume";
      SI.MassFlowRate w_out[N] "Outlet flow rate of each volume";
      SI.Pressure p[N](each stateSelect=StateSelect.prefer,
                       each start = p_start, each fixed = true)
        "Pressure states";
      SI.SpecificEnthalpy h[N](each stateSelect=StateSelect.prefer,
                               each start = h_start, each fixed = true)
        "Specific enthalpy states";
      SI.SpecificEnthalpy h_in[N] "Inlet specific enthalpy of each volume";
      SI.SpecificEnthalpy h_out[N] "Outlet specific enthalpy of each volume";
      SI.Density rho[N] "Volume density";
      Medium.ThermodynamicState state[N] "Volume thermodynamic state";
      SI.Pressure p_in_pipe "Inlet pressure";
      SI.Pressure p_out_pipe "Outlet pressure";
      SI.MassFlowRate w_out_pipe "Inlet flow rate";
      SI.SpecificEnthalpy h_out_pipe " Outlet flow rate";
    equation
      for i in 1:N loop
        M[i]= V*rho[i];
        E[i]=M[i]*h[i]-p[i]*V;
        der(M[i]) = w_in[i] - w_out[i];
        der(E[i]) = w_in[i]*h_in[i]-w_out[i]*h_out[i];
        state[i]=Medium.setState_ph(p[i],h[i]);
        rho[i]=Medium.density(state[i]);
        h_out[i] = h[i];
      end for;
      for i in 1:N-1 loop
        w_out[i]=w_in[i+1];
        w_out[i]= kf*(p[i]-p[i+1]);
        h_in[i+1] = h_out[i];
      end for;
      w_out[N] = kf*(p[N]-p_nom);
      p_in_pipe = p[1];
      p_out_pipe = p[N];
      w_in_pipe = w_in[1];
      w_out_pipe = w_out[N];
      h_in_pipe = h_in[1];
      h_out_pipe = h[N];

      annotation(Documentation(info="<html>
<p>This models shows the mass, energy, and momentum balance equations for 1D flow of steam in a pipe, using the finite volume method. The pressure loss is assumed to be linear with the flow rate for simplicity. The inertial term and the kinetic term are neglected in the momentum balance equations, hence the pressure wave dynamics is not represented. The pipe is adiabatic, with zero energy storage in the walls. The industry-standard IF97 model is used to compute the steam properties.</p>
<p>The boundary conditions at the inlet are prescribed mass flow w_in_pipe and specific enthalpy h_in_pipe. The boundary condition at the outlet is constant pressure. At time = 0 the inlet flow is zero; at time = 1 the inlet flow is changed to 2 kg/s and at time = 10 the inlet specific enthalpy is raised by 5000 J/kg.</p>
</html>"));
    end SteamPipe;
  end Models;

  package Verification
    model SimpleAdvection
      extends Models.SimpleAdvection(
        N = 1000,
        Tin = 300 + dT*(0.5*tanh((time-t0)/dt)+0.5));
      parameter Modelica.Units.SI.Time t0=2
        "Instant of smooth step temperature increase at inlet";
      parameter Modelica.Units.SI.Time dt=0.1
        "Transition time of temperature increase";
      parameter Modelica.Units.SI.TemperatureDifference dT=10
        "Temperature increase at inlet";
      Modelica.Units.SI.Temperature Tout_ex
        "Exact outlet temperature from analytical solution";
    equation
      Tout_ex = 300 + dT*(0.5*tanh((time-t0-L/u)/dt)+0.5);
      annotation(experiment(StopTime=15, Interval=4e-3, Tolerance = 1e-6),
          Documentation(info="<html>
<p>At constant fluid speed u, the exact analytical solution of the PDEs is</p>
<p><img src=\"modelica://ScalableTestSuite/Resources/Images/SimpleAdvection/as_advection.png\"/></p>
</html>"));
    end SimpleAdvection;

    model AdvectionReaction
      parameter Integer N = 100 "Number of volumes";
      Models.AdvectionReaction adv(N = N, mu = 0) "Pure advection model";
      Models.AdvectionReaction adv_reac(N = N, mu = 100)
        "Advection-reaction model";
      Real u_out_th = if time < 1 then 0 else 1
        "Theoretical outlet concentration of the pure advection model";
      Real u_out_adv = adv.u[N]
        "Outlet concentration of the pure advection model";
      Real u_out_adv_reac = adv_reac.u[N]
        "Outlet concentration of the advection-reaction model";
      annotation(experiment(StopTime=1.2, Interval=4e-3, Tolerance = 1e-6),
          Documentation(info="<html>
      <p>The exact analytical solution of the pure advection model <tt>adv</tt> is the inlet
      value delayed by one time unit, <tt>u_out_th</tt>. The numerical solution
      approximates the sharp dealyed rise of the concentration with a smooth curve, see <tt>u_out_adv</tt>.</p>
      <p>Adding the chemical reaction, the concentration wavefront sharpens, and it
      its speed towards the outlet is slightly reduced, see <tt>u_out_adv_reac</tt></p>
</html>"));
    end AdvectionReaction;

    model SteamPipe
      extends Models.SteamPipe(w_in_pipe = 2, N = 100);
      Medium.SpecificEnthalpy h_out_pipe_th = delay(h_in_pipe, tau);
      annotation(experiment(StopTime=15, Interval=4e-3, Tolerance = 1e-7),
                  Documentation(info="<html>
<p>After the initial transient has settled down, the step change of the specific enthalpy at the inlet is propagated to the outlet at a velocity roughly equal to that of the fluid. The outlet specific enthalpy is approximately equal to the inlet enthalpy delayed by the ratio tau between the total mass and the mass flow rate. There is a significant effect of numerical diffusion even for large values of N.</p>
</html>"));
    end SteamPipe;
  end Verification;

  package ScaledExperiments
    extends Modelica.Icons.ExamplesPackage;
    model SimpleAdvection_N_100
      extends Models.SimpleAdvection(
        N = 100,
        Tin = 300 + dT*(0.5*tanh((time-t0)/dt)+0.5),
        u = 1 + sin(time*2*pi*f));
      constant Real pi = Modelica.Constants.pi;
      parameter Modelica.Units.SI.Time t0=2
        "Instant of smooth step temperature increase at inlet";
      parameter Modelica.Units.SI.Time dt=0.1
        "Transition time of temperature increase";
      parameter Modelica.Units.SI.TemperatureDifference dT=10
        "Temperature increase at inlet";
      parameter Modelica.Units.SI.Frequency f=0.5
        "Frequency of fluid speed oscillations";
      annotation(experiment(StopTime=20, Interval=4e-3, Tolerance = 1e-6));
    end SimpleAdvection_N_100;

    model SimpleAdvection_N_200
      extends SimpleAdvection_N_100(N = 200);
      annotation(experiment(StopTime=20, Interval=4e-3, Tolerance = 1e-6));
    end SimpleAdvection_N_200;

    model SimpleAdvection_N_400
      extends SimpleAdvection_N_100(N = 400);
      annotation(experiment(StopTime=20, Interval=4e-3, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end SimpleAdvection_N_400;

    model SimpleAdvection_N_800
      extends SimpleAdvection_N_100(N = 800);
      annotation(experiment(StopTime=20, Interval=4e-3, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end SimpleAdvection_N_800;

    model SimpleAdvection_N_1600
      extends SimpleAdvection_N_100(N = 1600);
      annotation(experiment(StopTime=20, Interval=4e-3, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end SimpleAdvection_N_1600;

    model SimpleAdvection_N_3200
      extends SimpleAdvection_N_100(N = 3200);
      annotation(experiment(StopTime=20, Interval=4e-3, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end SimpleAdvection_N_3200;

    model SimpleAdvection_N_6400
      extends SimpleAdvection_N_100(N = 6400);
      annotation(experiment(StopTime=20, Interval=4e-3, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end SimpleAdvection_N_6400;

    model SimpleAdvection_N_12800
      extends SimpleAdvection_N_100(N = 12800);
      annotation(experiment(StopTime=20, Interval=4e-3, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end SimpleAdvection_N_12800;

    model AdvectionReaction_N_100
      extends Models.AdvectionReaction(
        N = 100,
        mu = 500);
      annotation(experiment(StopTime=1, Interval=4e-3, Tolerance = 1e-6));
    end AdvectionReaction_N_100;

    model AdvectionReaction_N_200
      extends Models.AdvectionReaction(
        N = 200,
        mu = 1000);
      annotation(experiment(StopTime=1, Interval=4e-3, Tolerance = 1e-6));
    end AdvectionReaction_N_200;

    model AdvectionReaction_N_400
      extends Models.AdvectionReaction(
        N = 400,
        mu = 2000);
      annotation(experiment(StopTime=1, Interval=4e-3, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end AdvectionReaction_N_400;

    model AdvectionReaction_N_800
      extends Models.AdvectionReaction(
        N = 800,
        mu = 4000);
      annotation(experiment(StopTime=1, Interval=4e-3, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end AdvectionReaction_N_800;

    model AdvectionReaction_N_1600
      extends Models.AdvectionReaction(
        N = 1600,
        mu = 8000);
      annotation(experiment(StopTime=1, Interval=4e-3, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end AdvectionReaction_N_1600;

    model AdvectionReaction_N_3200
      extends Models.AdvectionReaction(
        N = 3200,
        mu = 16000);
      annotation(experiment(StopTime=1, Interval=4e-3, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end AdvectionReaction_N_3200;

    model AdvectionReaction_N_6400
      extends Models.AdvectionReaction(
        N = 6400,
        mu = 32000);
      annotation(experiment(StopTime=1, Interval=4e-3, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end AdvectionReaction_N_6400;

    model AdvectionReaction_N_12800
      extends Models.AdvectionReaction(
        N = 12800,
        mu = 64000);
      annotation(experiment(StopTime=1, Interval=4e-3, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end AdvectionReaction_N_12800;

    model SteamPipe_N_10
      extends Models.SteamPipe(N = 10);
      annotation(experiment(
          StopTime=20,
          Interval=4e-3,
          Tolerance=1e-008));
    end SteamPipe_N_10;

    model SteamPipe_N_20
      extends Models.SteamPipe(N = 20);
      annotation(experiment(
          StopTime=20,
          Interval=4e-3,
          Tolerance=1e-008));
    end SteamPipe_N_20;

    model SteamPipe_N_40
      extends Models.SteamPipe(N = 40);
      annotation(experiment(
          StopTime=20,
          Interval=4e-3,
          Tolerance=1e-008));
    end SteamPipe_N_40;

    model SteamPipe_N_80
      extends Models.SteamPipe(N = 80);
      annotation(experiment(
          StopTime=20,
          Interval=4e-3,
          Tolerance=1e-008));
    end SteamPipe_N_80;

    model SteamPipe_N_160
      extends Models.SteamPipe(N = 160);
      annotation(experiment(
          StopTime=20,
          Interval=4e-3,
          Tolerance=1e-008));
    end SteamPipe_N_160;

    model SteamPipe_N_320
      extends Models.SteamPipe(N = 320);
      annotation(experiment(
          StopTime=20,
          Interval=4e-3,
          Tolerance=1e-008));
    end SteamPipe_N_320;

    model SteamPipe_N_640
      extends Models.SteamPipe(N = 640);
      annotation(experiment(
          StopTime=20,
          Interval=4e-3,
          Tolerance=1e-008));
    end SteamPipe_N_640;

    model SteamPipe_N_1280
      extends Models.SteamPipe(N = 1280);
      annotation(experiment(
          StopTime=20,
          Interval=4e-3,
          Tolerance=1e-008));
    end SteamPipe_N_1280;

    model SteamPipe_N_2560
      extends Models.SteamPipe(N = 2560);
      annotation(experiment(
          StopTime=20,
          Interval=4e-3,
          Tolerance=1e-008));
    end SteamPipe_N_2560;
  end ScaledExperiments;
end Advection;
