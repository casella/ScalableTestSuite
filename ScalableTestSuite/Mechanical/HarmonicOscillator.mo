within ScalableTestSuite.Mechanical;

package HarmonicOscillator "Models of N-dimensional 1D spring-mass oscillators"
  package Models
    model HarmonicOscillator
      import Modelica.SIunits;
      parameter Integer N = 2 "Number of masses in the system";
      parameter SIunits.Mass m = 1 "Mass of each node";
      parameter SIunits.TranslationalSpringConstant k = 10 "Elastic constant of each spring";
      SIunits.Position x[N] "Positions of the masses";
      SIunits.Velocity v[N] "Velocity of the masses";
    equation
      for i in 1:N loop
        der(x[i]) = v[i];
      end for;
      m*der(v[1]) = k*(x[2]-x[1]);
      for i in 2:N - 1 loop
        m*der(v[i]) = k*(x[i-1] - x[i]) + k*(x[i+1] - x[i]);
      end for;
      m*der(v[N]) = k*(x[N-1]-x[N]);
    initial equation
      x[1] = N;
      v[1] = 0;
      for i in 2:N loop
        x[i] = 0;
        v[i] = 0;
      end for;
      annotation(
        experiment(StopTime = 10),
        Documentation(info = "<html>
    <p>This model represents an N-dimensional mechanical translational system. The masses are not directly connected by springs; rather, a linear network of massless springs connects N massless nodes, which are in turn connected to the masses via other massless springs. As a consequence, a large system of sparse linear equations needs to be solved to compute the accelerations of the masses. </p>
    
    <p>The most interesting feature of this simple system is that the DAE formulation is sparse, since each system equations refer to at most three nodes at a time, while the ODE formulation is dense, because the acceleration of each point mass depends on the posistion of all other masses.</p>
    
    <p>This type of coupling is also found in other more complex models, such as multi-body systems with many rigid links (see models in the <a href=\"modelica://ScalableTestSuite.Mechanical.FlexibleBeam\">FlexibleBeam</a> and <a href=\"modelica://ScalableTestSuite.Mechanical.Strings\">Strings</a> packages) and electro-mechanical models of power generation and transmission systems. The present model can be used to demonstrate the effect of this structural property with the minimum amount of overhead.</p>
    
    <p>The transient is initiated by perturbing the initial condition of the first point mass with respect to the rest equilibrium condition.</p>
    </html>"));
    end HarmonicOscillator;

    model HarmonicOscillatorNetwork
      import Modelica.SIunits;
      parameter Integer N = 2 "Number of masses in the system";
      parameter SIunits.Mass m = 1 "Mass of each node";
      parameter SIunits.TranslationalSpringConstant k = 10 "Elastic constant of each spring";
      SIunits.Position xm[N] "Positions of the masses";
      SIunits.Velocity v[N] "Velocity of the masses";
      SIunits.Position xs[N] "Positions of the spring network nodes";
    equation
      for i in 1:N loop
        der(xm[i]) = v[i];
        m * der(v[i]) = k * (xs[i] - xm[i]);
      end for;
      k*(xs[1] - xm[1]) + k*(xs[1] - 0) + k*(xs[1] - xs[2]) = 0;
      for i in 2:N - 1 loop
        k * (xs[i] - xm[i]) + k * (xs[i] - xs[i - 1]) + k * (xs[i] - xs[i + 1]) = 0;
      end for;
      k*(xs[N] - xm[N]) + k*(xs[N] - xs[N - 1]) + k*(xs[N] - 0) = 0;
    initial equation
      xm[1] = N;
      v[1] = 0;
      for i in 2:N loop
        xm[i] = 0;
        v[i] = 0;
      end for;
      annotation(
        Documentation(info = "<html>
    <p>This model represents an N-dimensional mechanical translational system. Each mass is connected to the two neighboring masses by two massless springs. </p>
    
    <p>This system has a sparse DAE formulation, since each system equation refer to at most three nodes at a time; also the ODE formulation is sparse, because the acceleration of each mass only depends on its position and on that of its two neigbours.</p>
        
    <p>The transient is initiated by perturbing the initial condition of the first point mass with respect to the rest equilibrium condition.</p>
    </html>"));
    end HarmonicOscillatorNetwork;







  end Models;


  package Verification
    model HarmonicOscillatorCheck
      extends Models.HarmonicOscillator(N = 4);
      annotation(
        experiment(StopTime = 10));
    end HarmonicOscillatorCheck;

    model HarmonicOscillatorNetworkCheck
      extends Models.HarmonicOscillatorNetwork(N = 4);
      annotation(
        experiment(StopTime=10));
    end HarmonicOscillatorNetworkCheck;



















  end Verification;

  package ScaledExperiments
    extends Modelica.Icons.ExamplesPackage;
    model HarmonicOscillator_N_100
      extends Models.HarmonicOscillator(N = 100);
      annotation(
        experiment(StopTime = 10));
    end HarmonicOscillator_N_100;
  
    model HarmonicOscillator_N_200
      extends Models.HarmonicOscillator(N = 200);
      annotation(
        experiment(StopTime = 10));
    end HarmonicOscillator_N_200;
  
    model HarmonicOscillator_N_400
      extends Models.HarmonicOscillator(N = 400);
      annotation(
        experiment(StopTime = 10));
    end HarmonicOscillator_N_400;
  
    model HarmonicOscillator_N_800
      extends Models.HarmonicOscillator(N = 800);
      annotation(
        experiment(StopTime = 10));
    end HarmonicOscillator_N_800;
  
    model HarmonicOscillator_N_1600
      extends Models.HarmonicOscillator(N = 1600);
      annotation(
        experiment(StopTime = 10));
    end HarmonicOscillator_N_1600;
  
    model HarmonicOscillator_N_3200
      extends Models.HarmonicOscillator(N = 3200);
      annotation(
        experiment(StopTime = 10));
    end HarmonicOscillator_N_3200;
  
    model HarmonicOscillatorNetwork_N_10
      extends Models.HarmonicOscillatorNetwork(N = 10);
      annotation(
        experiment(StopTime = 10));
    end HarmonicOscillatorNetwork_N_10;

  
    model HarmonicOscillatorNetwork_N_20
      extends Models.HarmonicOscillatorNetwork(N = 20);
      annotation(
        experiment(StopTime = 10));
    end HarmonicOscillatorNetwork_N_20;

  
    model HarmonicOscillatorNetwork_N_40
      extends Models.HarmonicOscillatorNetwork(N = 40);
      annotation(
        experiment(StopTime = 10));
    end HarmonicOscillatorNetwork_N_40;

  
    model HarmonicOscillatorNetwork_N_80
      extends Models.HarmonicOscillatorNetwork(N = 80);
      annotation(
        experiment(StopTime = 10));
    end HarmonicOscillatorNetwork_N_80;

  
    model HarmonicOscillatorNetwork_N_160
      extends Models.HarmonicOscillatorNetwork(N = 160);
      annotation(
        experiment(StopTime = 10));
    end HarmonicOscillatorNetwork_N_160;

  
    model HarmonicOscillatorNetwork_N_320
      extends Models.HarmonicOscillatorNetwork(N = 320);
      annotation(
        experiment(StopTime = 10));
    end HarmonicOscillatorNetwork_N_320;

  
  end ScaledExperiments;


end HarmonicOscillator;
