within ScalableTestSuite.Power;
package ConceptualPowerSystem
  "Conceptual model of a power system that reproduces some of its key dynamic features"
  package Models
    type Power = SI.Power(nominal = 1e9);
    type AngularVelocity = SI.AngularVelocity(nominal = 300);
    type Frequency = SI.Frequency(nominal = 50);

    model Generator
      parameter Integer N = 4
        "Number of finite volumes for the superheater model";
      constant Real pi = Modelica.Constants.pi;
      parameter Power P_nom = 500e6 "Nominal power of the generator";
      parameter Frequency f_ref = 50 "Reference network frequency";
      parameter SI.Time T_a = 5 "Characteristic time of the generator";
      parameter SI.PerUnit alpha = 0.3
        "Fraction of turbine power provided by the high-pressure turbine";
      parameter SI.PerUnit T_source = 1.5
        "Normalized temperature of heat source for the superheater";
      parameter SI.PerUnit NTU = 2 "Number of thermal units in the superheater";
      parameter SI.Time tau_b = 200
        "Characteristic time of energy storage in the boiler";
      parameter SI.Time tau_t = 8
        "Characteristic response time of the low pressure turbine";
      parameter SI.Time tau_q = 3
        "Characteristic time of thermal generation process";
      parameter SI.Time tau_sh = 100
        "Characteristic time of the superheater thermal response";
      parameter SI.Time tau_y = 0.3 "Characteristic time of turbine governor";
      parameter SI.PerUnit droop = 0.1 "Primary frequency control droop";
      parameter SI.PerUnit Kp_p = 10 "Proportional gain of pressure controller";
      parameter SI.Time Ti_p = 70 "Integral time of pressure controller";
      parameter SI.PerUnit Kp_t = 2 "Proportional gain of power controller";
      parameter SI.Time Ti_t = 0.3 "Integral time of power controller";
      final parameter AngularVelocity omega_ref = 2*pi*f_ref;
      final parameter SI.MomentOfInertia J = P_nom*T_a/(omega_ref^2);
      Power P_a(nominal = 1e9) = P_nom
        "Active electrical power produced by the synchronous generator - replace the default binding";
      Power P_t_0(nominal = 1e9) = P_nom
        "Active power set point - replace the default binding";
      Power P_sfc(nominal = 1e9) = 0
        "Additional power request for secondary frequency control - replace the default binding";
      Power P_t(nominal = 1e9) "Mechanical power generated by the turbine [W]";
      SI.Angle theta
        "Rotor angle relative to reference rotating at nominal speed";
      AngularVelocity omega "Turbine angular speed";
      Frequency f "Generator frequency";
      SI.PerUnit delta_f "Normalized frequency error";
      SI.PerUnit p "Boiler pressure in p.u.";
      SI.PerUnit p_0 = 1 "Boiler pressure set point in p.u.";
      SI.PerUnit w_s "Steam flow rate in p.u.";
      SI.PerUnit q_ev "Thermal power to the boiler in p.u.";
      SI.PerUnit q_ev_0 "Thermal power set point in p.u.";
      SI.PerUnit y_t "Turbine admittance in p.u";
      SI.PerUnit y_t_0 "Turbine admittance set point in p.u.";
      SI.PerUnit p_t "Turbine power in p.u.";
      SI.PerUnit p_t_0 "Turbine power set point in p.u.";
      SI.PerUnit p_t_0_fc
        "Turbine power set point in p.u. with frequency control corrections";
      SI.PerUnit p_t_lp "Low-pressure turbine power in p.u.";

      SI.PerUnit T_s[N]
        "Normalized temperature states for the superheater model";
      SI.PerUnit T_s_b[N+1]
        "Normalized temperature at the boundaries of the superheater volumes";

      SI.PerUnit err_p_t "Power controller error in p.u.";
      SI.PerUnit err_p_t_int "Integral of power controller error";

      SI.PerUnit err_p "Pressure controller error in p.u.";
      SI.PerUnit err_p_int "Pressure controller integral error";

    equation
      // Rotor phase angle equation (relative to reference rotating at reference speed)
      der(theta) = omega - omega_ref;

      // Energy balance on the turbine-generator axis
      der(J*omega^2/2) = P_t - P_a;

      // Non-dimensional boiler model
      tau_b*der(p) = q_ev - w_s;

      // Non-dimensional turbine model
      w_s = y_t*p "steam flow";
      tau_t*der(p_t_lp) + p_t_lp = (1-alpha)*w_s "LP turbine power";
      p_t = alpha *w_s + p_t_lp "Total turbine power";

      // Non-dimensional steam temperature model
      T_s_b[1] = p "Boundary condion at inlet";
      T_s_b[2:end] = T_s "Upwind discretization scheme";

      for i in 1:N loop
        tau_sh/N * der(T_s[i]) = w_s*(T_s_b[i] - T_s_b[i+1]) + NTU/N*(T_source - T_s_b[i+1]);
      end for;

      // Actuation
      tau_y*der(y_t) = y_t_0 - y_t;
      tau_q*der(q_ev) = q_ev_0 - q_ev;

      // Normalization equations
      P_t = p_t*P_nom;
      P_t_0 = p_t_0*P_nom;

      // Boiler follows control strategy with primary and secondary frequency control
      f = omega/(2*pi);
      delta_f = (f - f_ref)/f_ref;
      p_t_0_fc = p_t_0 - 1/droop*delta_f + P_sfc/P_nom;

      err_p_t = p_t_0_fc - p_t;
      der(err_p_t_int) = err_p_t;

      err_p = p_0 - p;
      der(err_p_int) = err_p;

      q_ev_0 = p_t_0_fc + Kp_p*(err_p + 1/Ti_p * err_p_int);
      y_t_0 = p_t_0_fc + Kp_t*(err_p_t + 1/Ti_t *err_p_t_int);

    initial equation
      theta = 0;
      omega = omega_ref;
      p = 1;
      p_t_lp = (1-alpha);
      y_t = 1;
      q_ev = 1;
      err_p_t_int = 0;
      err_p_int = 0;
      T_s[1] = (p + NTU/N*T_source)/(1 + NTU/N);
      for i in 2:N loop
          T_s[i] = (T_s[i-1] + NTU/N*T_source)/(1 + NTU/N);
      end for;

      annotation(Documentation(info="<html>
<p>The Generator model is a conceptual model of a thermal power plant with a synchronous electrical generator. The goal is not to reproduce the dynamics of any real power plant accurately, but rather to replicate the mathematical structure and the type of dynamic behaviour that is to be found in real-life power plant models.</p>
<p>In particular, the goal is to represent the slow thermal dynamics and the fast electro-mechanical dynamics at the same time. This is a particularly interesting benchmark for multi-rate integration algorithms, that can exploit these dynamic feature by only refining the integration grid for the electro-mechanical states.</p>
<p>The thermal part comprises a simplified boiler - turbine model and a thermal model of the superheated steam temperature, assuming uniform thermal source temperature for simplicity. The model is written using normalized variables for simplicity.</p>
<p>The generator model is described by the classical swing equation, assuming ideal voltage control and neglecting reactive power flows. The actual power flows between generators and loads are computed by the <a href=\"modelica://ScalableTestSuite.Power.ConceptualPowerSystem.Models.PowerSystem\">PowerSystem</a></p>
<p>The model is completed by classical boiler-follows control strategy with primary and secondary frequency control. The primary frequency control input is computed locally and is proportional to the frequency deviation, while the secondary control input is determined by the the <a href=\"modelica://ScalableTestSuite.Power.ConceptualPowerSystem.Models.PowerSystem\">PowerSystem</a> model and passed via a modifier to the individual generator models. For simplicity, the superheated steam temperature is not controlled and fluctuates depending on the steam flow.</p>
<p>The initial equations initialize the generator at steady-state, assuming that a load with the nominal power of the plant is consuming the entire production locally.</p>
</html>"));
    end Generator;

    model PowerSystem
      parameter Integer N = 1 "Number of generators in the network";
      parameter Integer M = 4 "Number of volumes in the superheater models";
      parameter Power P_nom = 500e6 "Nominal power of a single generator";
      parameter Frequency f_ref = 50 "Reference network frequency";
      parameter AngularVelocity omega_ref = 2*pi*f_ref;
      parameter SI.Time T_sfc = 20
        "Time constant of secondary frequency control";
      parameter Real P_d = 0.5*P_nom/omega_ref "Power dissipation coefficient";
      parameter Real droop = 0.10 "Average network droop";
      constant Real pi = Modelica.Constants.pi;
      Frequency f
        "Network frequency measured at node 1 for secondary frequency control";
      Power P_load[N] = ones(N)*P_nom
        "Active power consumed by loads - replace the default binding";
      Power P_ex[N,N] "Power going from generator i to generator j";
      Power P_diss[N,N] "Power dissipated by the generators i and j";
      Power P_a[N] "Net active power out of generator i";
      Power P_f = P_nom
        "Power factor of a single trunk of transmission line";
      Power P_sfc "Additional power request for secondary frequency control";
      Generator generator[N](P_a = P_a,
                             each P_nom = P_nom,
                             each P_sfc = P_sfc/N,
                             each N = M);
    equation
      for i in 1:N loop
        P_a[i] = sum(P_ex[i,:]) + sum(P_diss[i,:]) + P_load[i];
        for j in 1:N loop
          if i == j then
            P_ex[i,j] = 0;
            P_diss[i,j] = 0;
          else
            P_ex[i,j] = P_f/(abs(i-j))*sin(generator[i].theta-generator[j].theta);
            P_diss[i,j] = P_d*(generator[i].omega - generator[j].omega);
          end if;
        end for;
      end for;

      f = generator[1].f;
      T_sfc*der(P_sfc) = (f_ref-f)/f_ref*P_nom*N/droop;
    initial equation
      P_sfc = 0;
      annotation(Documentation(info="<html>
<p>This model assembles a power system with a linear topology, obtained by connecting N power generators in a linear network with equal transmission lines, and with a load connected to each generator. For simplicity, the loads are described by prescribed active power consumptions.</p>
<p>The power transfer between the different generators is computed by the classical swing equation theory. An integral controllers provides secondary frequency control.</p>
</html>"));
    end PowerSystem;
  end Models;

  package Verification

    model OneGeneratorConstantLoad
      "One generator with constant load at equilibrium"
      extends Models.PowerSystem(generator(each P_t_0=P_nom), P_load=P_nom*ones(N));
      annotation(Documentation(info="<html>
<p>Test case with a single generator and matched load. All normalized variables should remain constant at 1 p.u. value.</p>
</html>"));
    end OneGeneratorConstantLoad;

    model OneGeneratorStepLoad
      "One generator with 5% step reduction from equilibrium"
      extends OneGeneratorConstantLoad(
        P_load=cat(1, {P_nom*0.95}, P_nom*ones(N - 1)));
      annotation(experiment(StopTime=500, Tolerance=1e-7, Interval = 0.05),
          __Dymola_experimentSetupOutput(equidistant=false),
        Documentation(info="<html>
<p>Test case with a single generator. At time = 0, the load is reduced by 5&percnt;. Primary frequency control limits the frequency deviation to about 0.2 Hz, then the secondary frequency controller brings the frequency back to 50 Hz.</p>
</html>"));
    end OneGeneratorStepLoad;

    model TwoGeneratorsConstantLoad
      "One generator with constant load at equilibrium"
      extends Models.PowerSystem(
        N = 2,
        generator(each P_t_0=P_nom), P_load=P_nom*ones(N));
      annotation(Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Test case with a two generator connected by a transmission line. Each generator has a local balanced load of 1 p.u. The model is at equilibrium, with zero power transfer along the line.</span></p>
</html>"));
    end TwoGeneratorsConstantLoad;

    model TwoGeneratorsStepLoad "First load disconnects"
      extends TwoGeneratorsConstantLoad(
        P_load=cat(1, {0.0}, P_nom*ones(N - 1)));
      annotation(experiment(StopTime=200, Tolerance=1e-7, Interval = 0.05),
          __Dymola_experimentSetupOutput(equidistant=false),
        Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Test case with a two generator connected by a transmission line. At time = 0 the load attached to the first generator is reduced by 50&percnt;. Fast electro-mechanical oscillations are triggered, along with slower thermal transients, until eventually the whole system re-settles at equilibrium in about 200 s.</span></p>
</html>"));
    end TwoGeneratorsStepLoad;

    model TenGeneratorsStepLoad
      extends TwoGeneratorsStepLoad(N = 10);
      annotation(experiment(StopTime=200, Tolerance=1e-7, Interval = 0.05),
          __Dymola_experimentSetupOutput(equidistant=false),
        Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Test case with ten generators connected in a linear fashion by transmission lines with the same impedance. At time = 0 the load attached to the first generator is reduced by 50&percnt;. Fast electro-mechanical oscillations are triggered, along with slower thermal transients, until eventually the whole system re-settles at equilibrium in about 200 s.</span></p>
</html>"));
    end TenGeneratorsStepLoad;



  end Verification;

  package ScaledExperiments
     model PowerSystemStepLoad_N_2_M_4
       extends Verification.TwoGeneratorsStepLoad(N = 2, M = 4);
       annotation(experiment(StopTime=200, Tolerance=1e-7, Interval = 0.05),
           __Dymola_experimentSetupOutput(equidistant=false));
     end PowerSystemStepLoad_N_2_M_4;

     model PowerSystemStepLoad_N_4_M_4
       extends Verification.TwoGeneratorsStepLoad(N = 4, M = 4);
       annotation(experiment(StopTime=200, Tolerance=1e-7, Interval = 0.05),
           __Dymola_experimentSetupOutput(equidistant=false));
     end PowerSystemStepLoad_N_4_M_4;

     model PowerSystemStepLoad_N_8_M_4
       extends Verification.TwoGeneratorsStepLoad(N = 8, M = 4);
       annotation(experiment(StopTime=200, Tolerance=1e-7, Interval = 0.05),
           __Dymola_experimentSetupOutput(equidistant=false));
     end PowerSystemStepLoad_N_8_M_4;

     model PowerSystemStepLoad_N_16_M_4
       extends Verification.TwoGeneratorsStepLoad(N = 16, M = 4);
       annotation(experiment(StopTime=200, Tolerance=1e-7, Interval = 0.05),
           __Dymola_experimentSetupOutput(equidistant=false));
     end PowerSystemStepLoad_N_16_M_4;

     model PowerSystemStepLoad_N_32_M_4
       extends Verification.TwoGeneratorsStepLoad(N = 32, M = 4);
       annotation(experiment(StopTime=200, Tolerance=1e-7, Interval = 0.05),
           __Dymola_experimentSetupOutput(equidistant=false));
     end PowerSystemStepLoad_N_32_M_4;

     model PowerSystemStepLoad_N_64_M_4
       extends Verification.TwoGeneratorsStepLoad(N = 64, M = 4);
       annotation(experiment(StopTime=200, Tolerance=1e-7, Interval = 0.05),
           __Dymola_experimentSetupOutput(equidistant=false));
     end PowerSystemStepLoad_N_64_M_4;

     model PowerSystemStepLoad_N_4_M_8
       extends Verification.TwoGeneratorsStepLoad(N = 4, M = 8);
       annotation(experiment(StopTime=200, Tolerance=1e-7, Interval = 0.05),
           __Dymola_experimentSetupOutput(equidistant=false));
     end PowerSystemStepLoad_N_4_M_8;


     model PowerSystemStepLoad_N_8_M_8
       extends Verification.TwoGeneratorsStepLoad(N = 8, M = 8);
       annotation(experiment(StopTime=200, Tolerance=1e-7, Interval = 0.05),
           __Dymola_experimentSetupOutput(equidistant=false));
     end PowerSystemStepLoad_N_8_M_8;

     model PowerSystemStepLoad_N_4_M_16
      extends Verification.TwoGeneratorsStepLoad(N=4, M = 16);
      annotation(experiment(StopTime=200, Tolerance=1e-7, Interval = 0.05),
           __Dymola_experimentSetupOutput(equidistant=false));
     end PowerSystemStepLoad_N_4_M_16;

     model PowerSystemStepLoad_N_64_M_8
       extends Verification.TwoGeneratorsStepLoad(N = 64, M = 8);
       annotation(experiment(StopTime=200, Tolerance=1e-7, Interval = 0.05),
           __Dymola_experimentSetupOutput(equidistant=false));
     end PowerSystemStepLoad_N_64_M_8;

     model PowerSystemStepLoad_N_64_M_16
      extends Verification.TwoGeneratorsStepLoad(N=64, M=16);
      annotation(experiment(StopTime=200, Tolerance=1e-7, Interval = 0.05),
           __Dymola_experimentSetupOutput(equidistant=false));
     end PowerSystemStepLoad_N_64_M_16;

  end ScaledExperiments;
end ConceptualPowerSystem;
