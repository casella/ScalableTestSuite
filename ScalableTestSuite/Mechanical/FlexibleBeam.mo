within ScalableTestSuite.Mechanical;
package FlexibleBeam "Models of flexible beams"
  package Models
    model FlexibleBeamModelica
      "Cantilever beam implementation by the Modelica Standard Library"
      import Modelica.SIunits;
      inner Modelica.Mechanics.MultiBody.World world(gravityType = Modelica.Mechanics.MultiBody.Types.GravityTypes.NoGravity);
      parameter Integer N = 1 "number of elements";
      parameter SIunits.Length L "length of the beam";
      final parameter SIunits.Length l = L / N "length of the each BodyBox";
      parameter SIunits.Length W "width of the beam";
      parameter SIunits.Height H "height of the beam";
      parameter SIunits.Density D "density of the material";
      parameter SIunits.ModulusOfElasticity E "young's modulus of the material";
      final parameter SIunits.SecondMomentOfArea J = W * H ^ 3 / 12
        "area moment of inertia";
      parameter SIunits.RotationalDampingConstant DampCoeff
        "damping coefficient";
      final parameter SIunits.RotationalSpringConstant SpringCoeff = E * J / l
        "spring coefficient";
      parameter SIunits.PerUnit F "force component at y-axis";
      Modelica.Mechanics.MultiBody.Joints.Revolute revolute[N](each useAxisFlange = true)
        "N revolute joint";
      Modelica.Mechanics.Rotational.Components.SpringDamper springdamper[N](each c = SpringCoeff, each d = DampCoeff)
        "N spring damper to connect to N revolute";
      Modelica.Mechanics.MultiBody.Parts.BodyBox bodybox1(length = l / 2, width = W, height = H, r = {l / 2, 0, 0}, density = D)
        "first bodybox connected to world";
      Modelica.Mechanics.MultiBody.Parts.BodyBox bodyboxN(length = l / 2, width = W, height = H, r = {l / 2, 0, 0}, density = D)
        "last bodybox which is free end";
      Modelica.Mechanics.MultiBody.Parts.BodyBox bodybox[N - 1](each length = l, each width = W, each height = H, each r = {l, 0, 0}, each density = D)
        "discretization of the element";
      Modelica.Mechanics.MultiBody.Forces.WorldForce force(resolveInFrame = Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world)
        "force component";
    equation
      force.force = if time < 0.001 then {0, 0, 0} else if time < 0.002 then {0, F, 0} else {0, 0, 0};
      connect(world.frame_b, bodybox1.frame_a);
      connect(bodybox1.frame_b, revolute[1].frame_a);
      for i in 1:N loop
        connect(revolute[i].axis, springdamper[i].flange_b);
        connect(revolute[i].support, springdamper[i].flange_a);
      end for;
      for i in 1:N - 1 loop
        connect(revolute[i].frame_b, bodybox[i].frame_a);
        connect(bodybox[i].frame_b, revolute[i + 1].frame_a);
      end for;
      connect(revolute[N].frame_b, bodyboxN.frame_a);
      connect(bodyboxN.frame_b, force.frame_b);
      annotation(experiment(StopTime = 0.15, Tolerance = 1e-6), Documentation(info = "<html><p>The flexible beam is created using the Modelica.Mechanics.MultiBody library components. Flexible beam is approximated by the rigid bodies and joints coupled with springs and dampers. Flexible beam is discretized into N+1 body boxes and N revolute joints which provides the flexibility features to the model. And, N spring-damper components are placed to the revolute joints. The spring stiffness coefficients are determined depending on the material properties and the geometry of the flexible beam while damping coefficients are taken very small.
Modeling was adopted from the paper “Modeling Flexible Bodies in SimMechanics” by Victor Chudnovsky, Arnav Mukherjee, Jeff Wendlandt and Dallas Kennedy which was intended for MATLAB and Simulink environment.</p><p>
The flexible beam is discretized into elements, and a single element is considered to be consisted of 2 body boxes and a revolute joint between these body boxes. If we assign length l to a single element, each body box in this element will have the length of l/2. By connecting each element together a flexible beam is obtained. Each element along the length of the beam is taken to be identical, therefore, the flexibility of the beam is uniform along its length. A single element of the flexible beam is as in the figure below.<img src=\"modelica://ScalableTestSuite/Resources/Images/FlexibleBeam/singleelement.png\"/></p><p>A flexible beam containing 2 elements is as shown in the figure below:<img src=\"modelica://ScalableTestSuite/Resources/Images/FlexibleBeam/flexiblebeam.png\"/><p>A force is applied for a period of time at the tip of the flexible beam in order to create vibration. Parameters for the FlexibleBeamModelica: </p> 
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Parameters</th>
      <th>Comment</th>
    </tr>
                <tr>
      <td valign=\"top\">N</td>
      <td valign=\"top\">number of elements</td>
    </tr>
   <tr>
      <td valign=\"top\">L</td>
      <td valign=\"top\">length of the flexible beam</td>
    </tr>
    <tr>
      <td valign=\"top\">l</td>
      <td valign=\"top\">length of each bodybox</td>
    </tr>
    <tr>
      <td valign=\"top\">W</td>
      <td valign=\"top\">width of the beam</td>
    </tr>
                <tr>
      <td valign=\"top\">H</td>
      <td valign=\"top\">heigth of the beam</td>
    </tr>
                <tr>
      <td valign=\"top\">D</td>
      <td valign=\"top\">density of the material</td>
    </tr>
                <tr>
      <td valign=\"top\">E</td>
      <td valign=\"top\">young's modulus of the material</td>
    </tr>
                <tr>
      <td valign=\"top\">J</td>
      <td valign=\"top\">area moment of inertia</td>
    </tr>
                <tr>
      <td valign=\"top\">DampCoeff</td>
      <td valign=\"top\">rotational damping constant</td>
    </tr>
                <tr>
      <td valign=\"top\">SpringCoeff</td>
      <td valign=\"top\">rotational spring constant</td>
    </tr>
                <tr>
      <td valign=\"top\">F</td>
      <td valign=\"top\">force component at y-axis</td>
    </tr>
</table>
</html>"));
    end FlexibleBeamModelica;
  end Models;

  package Verification
    model FlexibleBeamCheck "cantilever beam analytical solution"
      import Modelica.SIunits;
      parameter Integer N = 10 "number of elements";
      parameter SIunits.Length L = 0.5 "length of the beam";
      parameter SIunits.Length W = 0.05 "width of the beam";
      parameter SIunits.Height H = 0.02 "height of the beam";
      parameter SIunits.Density D = 2700 "density of the material";
      parameter SIunits.ModulusOfElasticity E = 6.9e10
        "young's modulus of the material";
      parameter SIunits.RotationalDampingConstant DampCoeff = 0.00001
        "damping coefficient";
      parameter SIunits.PerUnit F = -100 "Force component at y-axis";
      parameter SIunits.SecondMomentOfArea J = W * H ^ 3 / 12
        "area moment of inertia";

      function f
        input Real t "Time";
        input Real force "force";
        input Real m " linear mass of the material";
        input Real length "length of the beam";
        input Real EE "young's modulus of the material";
        input Real JJ "area moment of inertia";
        input Real beta1L = 1.875
          "first root of the function cos(betaL)cosh(betaL)+1=0";
        input Real beta2L = 4.694
          "second root of the function cos(betaL)cosh(betaL)+1=0";
        input Real beta3L = 7.855
          "third root of the function cos(betaL)cosh(betaL)+1=0";
        input Real beta4L = 10.955
          "fourth root of the function cos(betaL)cosh(betaL)+1=0";
        input Real beta5L = 14.1371
          "fifth root of the function cos(betaL)cosh(betaL)+1=0";
        input Real beta6L = 17.2787
          "sixth root of the function cos(betaL)cosh(betaL)+1=0";
        input Real beta1 = beta1L / length "first beta";
        input Real beta2 = beta2L / length "second beta";
        input Real beta3 = beta3L / length "third beta";
        input Real beta4 = beta4L / length "fourth beta";
        input Real beta5 = beta5L / length "fifth beta";
        input Real beta6 = beta6L / length "sixth beta";
        input SIunits.PerUnit A1 = 4 * force * length / (EE * JJ * (m / length) * beta1 ^ 4 * (sin(beta1L) * exp(beta1L) + exp(2 * beta1L) - 1)) * (3 * sin(beta1L) * (exp(2 * beta1L) + 1) - 2 * beta1L ^ 3 * exp(beta1L) + cos(beta1L) * (3 - beta1L ^ 3 * (exp(2 * beta1L) + 1) - 3 * exp(2 * beta1L)))
          "amplitude of first cos function";
        input SIunits.PerUnit A2 = 4 * force * length / (EE * JJ * (m / length) * beta2 ^ 4 * (sin(beta2L) * exp(beta2L) + exp(2 * beta2L) - 1)) * (3 * sin(beta2L) * (exp(2 * beta2L) + 1) - 2 * beta2L ^ 3 * exp(beta2L) + cos(beta2L) * (3 - beta2L ^ 3 * (exp(2 * beta2L) + 1) - 3 * exp(2 * beta2L)))
          "amplitude of second cos function";
        input SIunits.PerUnit A3 = 4 * force * length / (EE * JJ * (m / length) * beta3 ^ 4 * (sin(beta3L) * exp(beta3L) + exp(2 * beta3L) - 1)) * (3 * sin(beta3L) * (exp(2 * beta3L) + 1) - 2 * beta3L ^ 3 * exp(beta3L) + cos(beta3L) * (3 - beta3L ^ 3 * (exp(2 * beta3L) + 1) - 3 * exp(2 * beta3L)))
          "amplitude of third function";
        input SIunits.PerUnit A4 = 4 * force * length / (EE * JJ * (m / length) * beta4 ^ 4 * (sin(beta4L) * exp(beta4L) + exp(2 * beta4L) - 1)) * (3 * sin(beta4L) * (exp(2 * beta4L) + 1) - 2 * beta4L ^ 3 * exp(beta4L) + cos(beta4L) * (3 - beta4L ^ 3 * (exp(2 * beta4L) + 1) - 3 * exp(2 * beta4L)))
          "amplitude of fourth function";
        input SIunits.PerUnit A5 = 4 * force * length / (EE * JJ * (m / length) * beta5 ^ 4 * (sin(beta5L) * exp(beta5L) + exp(2 * beta5L) - 1)) * (3 * sin(beta5L) * (exp(2 * beta5L) + 1) - 2 * beta5L ^ 3 * exp(beta5L) + cos(beta5L) * (3 - beta5L ^ 3 * (exp(2 * beta5L) + 1) - 3 * exp(2 * beta5L)))
          "amplitude of fifth cos function";
        input SIunits.PerUnit A6 = 4 * force * length / (EE * JJ * (m / length) * beta6 ^ 4 * (sin(beta6L) * exp(beta6L) + exp(2 * beta6L) - 1)) * (3 * sin(beta6L) * (exp(2 * beta6L) + 1) - 2 * beta6L ^ 3 * exp(beta6L) + cos(beta6L) * (3 - beta6L ^ 3 * (exp(2 * beta6L) + 1) - 3 * exp(2 * beta6L)))
          "amplitude of sixth cos function";
        input SIunits.Length x = length
          "a distance between 0 and length L of the beam";
        input SIunits.AngularFrequency wk1 = (EE * JJ / m) ^ (1 / 2) * beta1 ^ 2
          "1st natural frequency";
        input SIunits.AngularFrequency wk2 = (EE * JJ / m) ^ (1 / 2) * beta2 ^ 2
          "2nd natural frequency";
        input SIunits.AngularFrequency wk3 = (EE * JJ / m) ^ (1 / 2) * beta3 ^ 2
          "3rd natural frequency";
        input SIunits.AngularFrequency wk4 = (EE * JJ / m) ^ (1 / 2) * beta4 ^ 2
          "4th natural frequency";
        input SIunits.AngularFrequency wk5 = (EE * JJ / m) ^ (1 / 2) * beta5 ^ 2
          "5th natural frequency";
        input SIunits.AngularFrequency wk6 = (EE * JJ / m) ^ (1 / 2) * beta6 ^ 2
          "6th natural frequency";
        input Real shape1 = A1 / 2 * ((-cosh(beta1 * x)) + cos(beta1 * x) + ((-cos(beta1L)) - cosh(beta1L)) * (sin(beta1 * x) - sinh(beta1 * x)) / (sin(beta1L) - sinh(beta1L)));
        input Real shape2 = A2 / 2 * ((-cosh(beta2 * x)) + cos(beta2 * x) + ((-cos(beta2L)) - cosh(beta2L)) * (sin(beta2 * x) - sinh(beta2 * x)) / (sin(beta2L) - sinh(beta2L)));
        input Real shape3 = A3 / 2 * ((-cosh(beta3 * x)) + cos(beta3 * x) + ((-cos(beta3L)) - cosh(beta3L)) * (sin(beta3 * x) - sinh(beta3 * x)) / (sin(beta3L) - sinh(beta3L)));
        input Real shape4 = A4 / 2 * ((-cosh(beta4 * x)) + cos(beta4 * x) + ((-cos(beta4L)) - cosh(beta4L)) * (sin(beta4 * x) - sinh(beta4 * x)) / (sin(beta4L) - sinh(beta4L)));
        input Real shape5 = A5 / 2 * ((-cosh(beta5 * x)) + cos(beta5 * x) + ((-cos(beta5L)) - cosh(beta5L)) * (sin(beta5 * x) - sinh(beta5 * x)) / (sin(beta5L) - sinh(beta5L)));
        input Real shape6 = A6 / 2 * ((-cosh(beta6 * x)) + cos(beta6 * x) + ((-cos(beta6L)) - cosh(beta6L)) * (sin(beta6 * x) - sinh(beta6 * x)) / (sin(beta6L) - sinh(beta6L)));
        output Real w;
      algorithm
        w := shape1 * cos(wk1 * t);
        //+ shape2 * cos(wk2 * t) + shape3 * cos(wk3 * t) + shape4 * cos(wk4 * t) + shape5 * cos(wk5 * t) + shape6 * cos(wk6 * t);
      end f;

      Models.FlexibleBeamModelica beammod(N = N, L = L, W = W, H = H, D = D, E = E, DampCoeff = DampCoeff, F = F);
      SIunits.Length beam_exact;
      SIunits.Length beam_modelica;
    equation
      beam_modelica = beammod.bodyboxN.frame_b.r_0[2]
        "displacement of the free end of the flexible beam";
      beam_exact = f(time, F, W * H * D, L, E, J)
        "displacement of the free end of the analytical solution";
      annotation(experiment(StopTime = 0.15, Tolerance = 1e-6), Documentation(info = "<html><p>In the model, FlexibleBeamModelica is verified by an analytical solution in terms of the vibration frequency of the free end of the flexible beam. In this model, vibration of the free end of FlexibleBeamModelica and analytical solution are implemented.
<p>ANALYTICAL SOLUTION:</p><p>The partial differential equation describing the motion of the infinitesimal element is:</p><img src=\"modelica://ScalableTestSuite/Resources/Images/FlexibleBeam/PDE.png\"/></p>where m is the linear mass, w is the displacement, E is the young’s modulus and J is the area moment of inertia.<p>Assuming a stationary solution of the bending motion in the form:</p><p><img src=\"modelica://ScalableTestSuite/Resources/Images/FlexibleBeam/stationarysol.png\"/></p><p>where α(x) is a function of space alone describing the waveform of the stationary vibration and β(x) is a time dependent vibration amplitude coefficient.</p><p>By placing the stationary solution w(x,t) into the PDE and later defining:</p><p><img src=\"modelica://ScalableTestSuite/Resources/Images/FlexibleBeam/naturalfreq.png\"/></p><p>The natural frequencies and the modes of vibration of a beam in bending depend on physical parameters such as length, section, material and also boundary conditions. For the cantilever beam, there are four boundary conditions, two for the clamped end x=0 and two for the free end x=l.</p><img src=\"modelica://ScalableTestSuite/Resources/Images/FlexibleBeam/boundary.png\"/><p>The general solution becomes a linear combination of trigonometric equations:</p><img src=\"modelica://ScalableTestSuite/Resources/Images/FlexibleBeam/generalsol.png\"/><p>and after placing the boundary conditions into the function α(x), we reduce the function into a new form. Moreover, from the boundary conditions it is obtained: A=C=0 and;</p><img src=\"modelica://ScalableTestSuite/Resources/Images/FlexibleBeam/coeff.png\"/><p>Thus, it can be written in the form:</p><img src=\"modelica://ScalableTestSuite/Resources/Images/FlexibleBeam/generalsol1.png\"/><p>where B=1/2. Moreover, with the boundary conditions, we obtain the frequency equation for the cantilever beam:<p><img src=\"modelica://ScalableTestSuite/Resources/Images/FlexibleBeam/freqeq.png\"/></p>We have infinite number of solutions for<img src=\"modelica://ScalableTestSuite/Resources/Images/FlexibleBeam/naturalfreq1.png\"/>. And, we obtain the natural frequencies by using the equation:</p><p><img src=\"modelica://ScalableTestSuite/Resources/Images/FlexibleBeam/naturalfreq2.png\"/></p><p>By solving the frequency equation, obtained values for the first 6 modes are given in the table below:</p><img src=\"modelica://ScalableTestSuite/Resources/Images/FlexibleBeam/table.png\"/><p>Therefore, for each frequency, there is a characteristic vibration:</p><p><img src=\"modelica://ScalableTestSuite/Resources/Images/FlexibleBeam/characteristic.png\"/></p><p>An approximation for Ak is given below according to P which is force. It is calculated as if the beam starts vibration at t=0.</p><img src=\"modelica://ScalableTestSuite/Resources/Images/FlexibleBeam/Ak.png\"/>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Parameters</th>
      <th>Comment</th>
    </tr>
		<tr>
      <td valign=\"top\">N</td>
      <td valign=\"top\">number of elements</td>
    </tr>
   <tr>
      <td valign=\"top\">L</td>
      <td valign=\"top\">length of the flexible beam</td>
    </tr>
    <tr>
      <td valign=\"top\">W</td>
      <td valign=\"top\">width of the beam</td>
    </tr>
		<tr>
      <td valign=\"top\">H</td>
      <td valign=\"top\">heigth of the beam</td>
    </tr>
		<tr>
      <td valign=\"top\">D</td>
      <td valign=\"top\">density of the material</td>
    </tr>
		<tr>
      <td valign=\"top\">E</td>
      <td valign=\"top\">young's modulus of the material</td>
    </tr>
		<tr>
      <td valign=\"top\">DampCoeff</td>
      <td valign=\"top\">rotational damping constant</td>
    </tr>
		<tr>
      <td valign=\"top\">F</td>
      <td valign=\"top\">force component at y-axis</td>
    </tr>
		<tr>
      <td valign=\"top\">J</td>
      <td valign=\"top\">area moment of inertia</td>
    </tr>
</table>
</html>"));
    end FlexibleBeamCheck;
  end Verification;

  package ScaledExperiments
    extends Modelica.Icons.ExamplesPackage;

    model FlexibleBeamModelica_N_2
      extends Models.FlexibleBeamModelica(N = 2, L = 0.5, W = 0.05, H = 0.02, D = 2700, E = 6.9e10, DampCoeff = 0.00001, F = -100);
      annotation(experiment(StopTime = 0.15, Tolerance = 1e-6));
    end FlexibleBeamModelica_N_2;

    model FlexibleBeamModelica_N_4
      extends FlexibleBeamModelica_N_2(N = 4);
      annotation(experiment(StopTime = 0.15, Tolerance = 1e-6));
    end FlexibleBeamModelica_N_4;

    model FlexibleBeamModelica_N_8
      extends FlexibleBeamModelica_N_2(N = 8);
      annotation(experiment(StopTime = 0.15, Tolerance = 1e-6));
    end FlexibleBeamModelica_N_8;

    model FlexibleBeamModelica_N_16
      extends FlexibleBeamModelica_N_2(N = 16);
      annotation(experiment(StopTime = 0.15, Tolerance = 1e-6));
    end FlexibleBeamModelica_N_16;

    model FlexibleBeamModelica_N_32
      extends FlexibleBeamModelica_N_2(N = 32);
      annotation(experiment(StopTime = 0.15, Tolerance = 1e-6));
    end FlexibleBeamModelica_N_32;

    model FlexibleBeamModelica_N_64
      extends FlexibleBeamModelica_N_2(N = 64);
      annotation(experiment(StopTime = 0.15, Tolerance = 1e-6));
    end FlexibleBeamModelica_N_64;
    annotation(Documentation(info = "<html><p>In this package there are 6 tests for FlexibleBeamModelica for different N values.</p><p> The tests are performed according to the N values as shown in the table below:</p><table border=\"1\">
    <tr>
      <th>N</th>
    </tr>
		<tr>
      <td valign=\"top\">2</td>
    </tr>
   <tr>
      <td valign=\"top\">4</td>
    </tr>
    <tr>
      <td valign=\"top\">8</td>
    </tr>
    <tr>
      <td valign=\"top\">16</td>
    </tr>
		<tr>
      <td valign=\"top\">32</td>
    </tr>
		<tr>
      <td valign=\"top\">64</td>
    </tr>
</table><p>Parameters for FlexibleBeamModelica:</p><p><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Parameters</th>
      <th>Comment</th>
    </tr>
		<tr>
      <td valign=\"top\">N</td>
      <td valign=\"top\">2,4,8,16,32,64</td>
    </tr>
		<tr>
      <td valign=\"top\">L</td>
      <td valign=\"top\">0.5</td>
    </tr>
   <tr>
      <td valign=\"top\">W</td>
      <td valign=\"top\">0.05</td>
    </tr>
    <tr>
      <td valign=\"top\">H</td>
      <td valign=\"top\">0.02</td>
    </tr>
		<tr>
      <td valign=\"top\">D</td>
      <td valign=\"top\">2700</td>
    </tr>
		<tr>
      <td valign=\"top\">E</td>
      <td valign=\"top\">6.9e10</td>
    </tr>
		<tr>
      <td valign=\"top\">DampCoeff</td>
      <td valign=\"top\">0.00001</td>
    </tr>
		<tr>
      <td valign=\"top\">F</td>
      <td valign=\"top\">-100</td>
    </tr>
</table></p></html>"));
  end ScaledExperiments;
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end FlexibleBeam;
