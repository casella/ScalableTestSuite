within ScalableTestSuite.Mechanical;
package Strings "Models of strings suspended in a gravitational field"
  package Models
    model StringModelica
      import Modelica.SIunits;
      parameter Integer N = 1 "number of joints";
      parameter SIunits.Length L "length of the string";
      final parameter SIunits.Length l = L / (N + 1) "length of each bodbox";
      parameter SIunits.RotationalDampingConstant damping "damping coefficient";
      parameter SIunits.Length W "width of the beam";
      parameter SIunits.Height H "height of the beam";
      parameter SIunits.Density D "density of the material";
      inner Modelica.Mechanics.MultiBody.World world(gravityType = Modelica.Mechanics.MultiBody.Types.GravityTypes.UniformGravity, n = {1, 0, 0})
        "uniform gravity on x-axis";
      Modelica.Mechanics.MultiBody.Joints.Revolute revolute[N](each useAxisFlange = true)
        "N revolute joints";
      Modelica.Mechanics.Rotational.Components.Damper damper[N](each d = damping)
        "N dampers";
      Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic1(useAxisFlange = true, n = {0, 1, 0}, boxWidthDirection = {0, 1, 0})
        "prismatic joint moves along y-axis";
      Modelica.Blocks.Sources.Pulse pulse1(amplitude = 0.01, period = 0.5, nperiod = 1, startTime = 0.1)
        "pulse input";
      Modelica.Mechanics.MultiBody.Parts.BodyBox bodybox[N + 1](each r = {l, 0, 0}, each length = l, each width = W, each height = H, each density = D)
        "N+1 bodybox";
      Modelica.Mechanics.Translational.Sources.Position position1(useSupport = true, f_crit = 2)
        "position component to move prismatic joint";
    equation
      connect(world.frame_b, prismatic1.frame_a);
      connect(pulse1.y, position1.s_ref);
      connect(position1.support, prismatic1.support);
      connect(position1.flange, prismatic1.axis);
      connect(prismatic1.frame_b, bodybox[1].frame_a);
      for i in 1:N loop
        connect(bodybox[i].frame_b, revolute[i].frame_a);
        connect(revolute[i].frame_b, bodybox[i + 1].frame_a);
        connect(damper[i].flange_a, revolute[i].support);
        connect(damper[i].flange_b, revolute[i].axis);
      end for;
      annotation(Documentation(info = "<html><p>The string is modeled by considering the behavior of a travelling wave on a string. The prescribed transversal displacement at one end creates a wave on the string. From one end of the string model, a pulse is given and a travelling wave is observed along the string and it is modeled by using MultiBody library.</p><p>In order to be able to observe the characteristics of a string, a pulse is given on the horizontal axis and while there is a uniform gravity on the vertical axis, movement of the pulse is observed along the created model. The main idea is to see a movement of the rigid bodies such that reflects a travelling wave when a pulse is applied from one end of the string model.
The main body of the string is created by body boxes and revolute joints coupled with dampers. The travelling wave is determined by the coupling between inertia and tension due to gravity. Moreover, by using necessary components of MSL a pulse is applied to the string.With the world component gravity is applied on the vertical axis. The prismatic joint is coupled with a position component which provides a horizontal movement to the prismatic joint. And, position component is controlled with a pulse input which has 1 period. A string model example is given below.</p><img src=\"modelica://ScalableTestSuite/Resources/Images/String/stringmodel.png\"/><p>An example of a string model is given when N=2 where N corresponds to the number of revolute joints in the model, therefore, there are N+1 body boxes. Position component enables one to filter the input signal in order to eliminate the high frequency components. Hence, in the string model, pulse signal is filtered by the position component in order to provide a slow pulse to the string and by that way the response of the body boxes is observed.</p>
</html>"));
    end StringModelica;
  end Models;

  package Verification

  end Verification;

  package ScaledExperiments
    extends Modelica.Icons.ExamplesPackage;

    model StringModelica_N_2
      extends Models.StringModelica(N = 2, L = 0.5, damping = 1e-5, W = 0.001, H = 0.001, D = 2000);
      annotation(experiment(StopTime = 0.8, Tolerance = 1e-6));
    end StringModelica_N_2;

    model StringModelica_N_4
      extends StringModelica_N_2(N = 4);
      annotation(experiment(StopTime = 0.8, Tolerance = 1e-6));
    end StringModelica_N_4;

    model StringModelica_N_8
      extends StringModelica_N_2(N = 8);
      annotation(experiment(StopTime = 0.8, Tolerance = 1e-6));
    end StringModelica_N_8;

    model StringModelica_N_16
      extends StringModelica_N_2(N = 16);
      annotation(experiment(StopTime = 0.8, Tolerance = 1e-6));
    end StringModelica_N_16;

    model StringModelica_N_32
      extends StringModelica_N_2(N = 32);
      annotation(experiment(StopTime = 0.8, Tolerance = 1e-6));
    end StringModelica_N_32;

    model StringModelica_N_64
      extends StringModelica_N_2(N = 64);
      annotation(experiment(StopTime = 0.8, Tolerance = 1e-6));
    end StringModelica_N_64;
    annotation(Documentation(info = "<html><p>In this package there are 6 tests for StringModelica for different N values.</p><p> The tests are performed according to the N values as shown in the table below:</p><table border=\"1\">
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
</table><p>Parameters for StringModelica:</p><p><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
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
      <td valign=\"top\">damping</td>
      <td valign=\"top\">1e-5</td>
    </tr>
    <tr>
      <td valign=\"top\">W</td>
      <td valign=\"top\">0.001</td>
    </tr>
		<tr>
      <td valign=\"top\">H</td>
      <td valign=\"top\">0.001</td>
    </tr>
		<tr>
      <td valign=\"top\">D</td>
      <td valign=\"top\">2000</td>
    </tr>
</table></p></html>"));
  end ScaledExperiments;
end Strings;
