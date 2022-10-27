within ScalableTestSuite.Electrical;
package TransmissionLine "Models of transmission lines"
  package Models
    model TransmissionLine "Modular model of an electrical transmission line"
      import SIunits =
             Modelica.Units.SI;
      import Modelica.Electrical.Analog;
      SIunits.Voltage vpg "voltage of pin p of the transmission line";
      SIunits.Voltage vng "voltage of pin n of the transmission line";
      SIunits.Current ipin_p
        "current flows through pin p of the transmission line";
      SIunits.Current ipin_n
        "current flows through pin n of the transmission line";
      Analog.Interfaces.Pin pin_p annotation(Placement(transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}})));
      Analog.Interfaces.Pin pin_n annotation(Placement(transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}})));
      Analog.Interfaces.Pin pin_ground "pin of the ground";
      Analog.Basic.Ground ground "ground of the transmission line";
      parameter Integer N = 1 "number of segments";
      parameter Real r "resistance per meter";
      parameter Real l "inductance per meter";
      parameter Real c "capacitance per meter";
      parameter Real length "length of tranmission line";
      Analog.Basic.Inductor L[N](L = fill(l * length / N, N)) "N inductors";
      Analog.Basic.Capacitor C[N](C = fill(c * length / N, N)) "N capacitors";
      Analog.Basic.Resistor R[N](R = fill(r * length / N, N)) "N resistors";
    initial equation
      for i in 1:N loop
        C[i].v = 0;
        L[i].i = 0;
      end for;
    equation
      vpg = pin_p.v - pin_ground.v;
      vng = pin_n.v - pin_ground.v;
      ipin_p = pin_p.i;
      ipin_n = pin_n.i;
      connect(pin_p, R[1].p);
      for i in 1:N loop
        connect(R[i].n, L[i].p);
        connect(C[i].p, L[i].n);
        connect(C[i].n, pin_ground);
      end for;
      for i in 1:N - 1 loop
        connect(L[i].n, R[i + 1].p);
      end for;
      connect(L[N].n, pin_n);
      connect(pin_ground, ground.p);
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}), graphics={  Rectangle(origin = {-0.17, -0.18}, fillColor = {0, 0, 255},
                fillPattern =                                                                                                   FillPattern.HorizontalCylinder, extent = {{-99.82, 99.82}, {99.82, -99.82}}), Text(origin = {0.76, 7.01}, lineColor = {170, 0, 0}, fillColor = {0, 170, 0}, extent = {{-72.61, 47.88}, {72.61, -47.88}}, textString = "Transmission Line")}), Documentation(info = "<html><p>In the figure, it is given an example of the transmission line that is implemented which consists of a resistor, an inductor and a capacitor within each segment. Moreover, transmission line is implemented by connecting each segment together. In the figure, resistor1, inductor1 and capacitor1 describes the first segment and it is connected to second segment which has the same components as the first segment and so on. It transmits the electrical signal from a source to a load.</p><img src=\"modelica://ScalableTestSuite/Resources/Images/TransmissionLine/TransmissionLine.png\"/><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Parameters</th>
      <th>Comment</th>
    </tr>
                <tr>
      <td valign=\"top\">N</td>
      <td valign=\"top\">number of segments</td>
    </tr>
   <tr>
      <td valign=\"top\">r</td>
      <td valign=\"top\">resistance per meter</td>
    </tr>
    <tr>
      <td valign=\"top\">l</td>
      <td valign=\"top\">inductance per meter</td>
    </tr>
    <tr>
      <td valign=\"top\">c</td>
      <td valign=\"top\">capacitance per meter</td>
    </tr>
                <tr>
      <td valign=\"top\">length</td>
      <td valign=\"top\">length of the transmission line</td>
    </tr>
</table>
</html>"));
    end TransmissionLine;

    model TransmissionLineEquations
      "Transmission line circuit - Direct implementation by equations"
      import SIunits =
             Modelica.Units.SI;
      parameter Integer N = 1 "number of segments";
      parameter SIunits.Length L "length of the transmission line";
      final parameter SIunits.Length l = L / N "length of the each segment";
      parameter SIunits.Resistance res "resistance per meter";
      parameter SIunits.Capacitance cap "capacitance per meter";
      parameter SIunits.Inductance ind "inductance per meter";
      final parameter SIunits.Resistance RL = (ind / cap) ^ (1 / 2)
        "load resistance";
      parameter SIunits.AngularFrequency w;
      final parameter SIunits.Time TD = L / v
        "time delay of the transmission line";
      final parameter SIunits.Velocity v = 1 / (ind * cap) ^ (1 / 2)
        "velocity of the signal";
      SIunits.Voltage Vstep = if time > 0 then 1 else 0 "input step voltage";
      SIunits.Current cur[N](each start = 0)
        "current values at the nodes of the transmission line";
      SIunits.Voltage vol[N](each start = 0)
        "voltage values at the nodes of the transmission line";
      Real vvol "derivative of input voltage";
    equation
      vvol = der(vol[1]);
      //Vstep = vol[1] + 2 * Rf * Cf * der(vol[1]) + Rf ^ 2 * Cf ^ 2 * der(vvol);
      Vstep = vol[1] + 2 * (1 / w) * der(vol[1]) + 1 / w ^ 2 * der(vvol);
      vol[N] = cur[N] * RL;
      for i in 1:N - 1 loop
        cap * der(vol[i + 1]) = (cur[i] - cur[i + 1]) / l;
        ind * der(cur[i]) = (-res * cur[i]) - (vol[i + 1] - vol[i]) / l;
      end for;
    initial equation
      vol = zeros(N);
      cur[1:N-1] = zeros(N-1);
      vvol = 0;
      annotation(Documentation(info = "<html><p>In this model, a transmission line circuit is implemented by equations. Transmission line circuit is represented as in the figure below. The application is the same as the TransmissionLineModelica model.</p><p><img src=\"modelica://ScalableTestSuite/Resources/Images/TransmissionLine/TransmissionLineModelica.png\"/></p><p>Considering the nodes of the discrete transmission line(implemented in Electrical.Models.TransmissionLine), circuit equations are described. In the transmission line, there are N segments, therefore, there will be N+1 nodes and N+1 voltage and current variables.</p><p><img src=\"modelica://ScalableTestSuite/Resources/Images/TransmissionLine/tlmequation.png\"/></p><p>where j= 2,..,N and Rx is the resistance per meter, Cx is the capacitance per meter and Lx is the inductance per meter.</p><p>output voltage is described as:</p><p><img src=\"modelica://ScalableTestSuite/Resources/Images/TransmissionLine/tlmequation1.png\"/></p><p>Moreover, considering the form of the second order low pass filter, equation of the filter to a step input can be defined in the following way:</p><p><img src=\"modelica://ScalableTestSuite/Resources/Images/TransmissionLine/tlmequation2.png\"/></p><p>where Vstep  is the step voltage and v1is the output voltage of the filter. The parameters of the TransmissionLineEquations are:</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Parameters</th>
      <th>Comment</th>
    </tr>
                <tr>
      <td valign=\"top\">N</td>
      <td valign=\"top\">number of segments</td>
    </tr>
   <tr>
      <td valign=\"top\">L</td>
      <td valign=\"top\">length of transmission line</td>
    </tr>
    <tr>
      <td valign=\"top\">l</td>
      <td valign=\"top\">length of each segment</td>
    </tr>
    <tr>
      <td valign=\"top\">res</td>
      <td valign=\"top\">resistor per meter</td>
    </tr>
                <tr>
      <td valign=\"top\">cap</td>
      <td valign=\"top\">capacitance per meter</td>
    </tr>
                <tr>
      <td valign=\"top\">ind</td>
      <td valign=\"top\">inductance per meter</td>
    </tr>
                <tr>
      <td valign=\"top\">RL</td>
      <td valign=\"top\">load resistance</td>
    </tr>
                <tr>
      <td valign=\"top\">w</td>
      <td valign=\"top\">angular frequency</td>
    </tr>
                <tr>
      <td valign=\"top\">TD</td>
      <td valign=\"top\">time delay of transmission line</td>
    </tr>
                <tr>
      <td valign=\"top\">v</td>
      <td valign=\"top\">velocity of signal</td>
    </tr>
</table>
</html>"));
    end TransmissionLineEquations;

    model TransmissionLineModelica
      "Transmission line circuit - Implementation using the Modelica Standard Library"
      import SIunits =
             Modelica.Units.SI;
      parameter Integer N = 1 "number of segments of the transmission line";
      parameter SIunits.Resistance r "resistance per meter";
      parameter SIunits.Inductance l "inductance per meter";
      parameter SIunits.Capacitance c "capacitance per meter";
      parameter SIunits.Length length "length of the transmission line";
      parameter SIunits.AngularFrequency w "cut-off frequency";
      final parameter SIunits.Resistance RL = (l / c) ^ (1 / 2)
        "load resistance";
      final parameter SIunits.Time TD = length / v
        "time delay of the transmission line";
      final parameter SIunits.Velocity v = 1 / (l * c) ^ (1 / 2)
        "velocity of the signal";
      Modelica.Electrical.Analog.Sources.SignalVoltage signalvoltage annotation(Placement(transformation(origin = {-34, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(transformation(origin = {-56, 40}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Continuous.SecondOrder lowpassfilter(w = w, D = 1,
        initType=Modelica.Blocks.Types.Init.InitialState)                annotation(Placement(transformation(origin = {-50, 14}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Step step annotation(Placement(transformation(origin = {-84, 14}, extent = {{-10, -10}, {10, 10}})));
      Models.TransmissionLine transmissionline(N = N, r = r, l = l, c = c, length = length) annotation(Placement(transformation(origin = {-6, 54}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Electrical.Analog.Basic.Resistor resistor(R = RL) annotation(Placement(transformation(origin = {26, 54}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Electrical.Analog.Basic.Ground ground2 annotation(Placement(transformation(origin = {54, 40}, extent = {{-10, -10}, {10, 10}})));
    equation
      connect(resistor.n, ground2.p) annotation(Line(points = {{36, 54}, {54, 54}, {54, 50}}, color = {0, 0, 255}));
      connect(transmissionline.pin_n, resistor.p) annotation(Line(points = {{4, 54}, {16, 54}}, color = {0, 0, 255}));
      connect(signalvoltage.p, transmissionline.pin_p) annotation(Line(points = {{-24, 54}, {-16, 54}}, color = {0, 0, 255}));
      connect(step.y, lowpassfilter.u) annotation(Line(points = {{-73, 14}, {-62, 14}}, color = {0, 0, 127}));
      connect(lowpassfilter.y, signalvoltage.v) annotation(Line(points = {{-39, 14}, {-34, 14}, {-34, 47}}, color = {0, 0, 127}));
      connect(ground1.p, signalvoltage.n) annotation(Line(points = {{-56, 50}, {-56, 54}, {-44, 54}}, color = {0, 0, 255}));
      annotation(Documentation(info = "<html><p>In this model, a transmission line circuit is implemented by the Modelica Standard Library components. Transmission line circuit is represented as in the figure below. The application is the same as TransmissionLineEquations.</p><p><img src=\"modelica://ScalableTestSuite/Resources/Images/TransmissionLine/TransmissionLineModelica.png\"/></p><p>The parameters for the TransmissionLineModelica are: </p><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Parameters</th>
      <th>Comment</th>
    </tr>
                <tr>
      <td valign=\"top\">N</td>
      <td valign=\"top\">number of segments</td>
    </tr>
   <tr>
      <td valign=\"top\">r</td>
      <td valign=\"top\">resistance per meter</td>
    </tr>
    <tr>
      <td valign=\"top\">l</td>
      <td valign=\"top\">inductance per meter</td>
    </tr>
    <tr>
      <td valign=\"top\">c</td>
      <td valign=\"top\">capacitance per meter</td>
    </tr>
                <tr>
      <td valign=\"top\">length</td>
      <td valign=\"top\">length of the transmission line</td>
    </tr>
                <tr>
      <td valign=\"top\">w</td>
      <td valign=\"top\">cut-off frequency</td>
    </tr>
                <tr>
      <td valign=\"top\">RL</td>
      <td valign=\"top\">load resistance</td>
    </tr>
                <tr>
      <td valign=\"top\">TD</td>
      <td valign=\"top\">time delay of the transmission line</td>
    </tr>
                <tr>
      <td valign=\"top\">v</td>
      <td valign=\"top\">velocity of signal</td>
    </tr>
</table>
</html>"));
    end TransmissionLineModelica;
  end Models;

  package Verification
    model TransmissionLineCheck
      "Verification of the transmission line circuits by using time delay"
      import SIunits =
             Modelica.Units.SI;
      parameter Integer N = 30 "number of segments";
      parameter SIunits.Length L = 100 "length of the transmission line";
      parameter SIunits.Resistance res = 48e-6 "resistance per meter";
      parameter SIunits.Capacitance cap = 101e-12 "capacitance per meter";
      parameter SIunits.Inductance ind = 253e-9 "inductance per meter";
      parameter SIunits.Resistance RL = (ind / cap) ^ (1 / 2) "load resistance";
      parameter SIunits.AngularFrequency w = 5e6 "cut-off frequency";
      parameter SIunits.Time TD = L / v "time delay of the transmission line";
      parameter SIunits.Velocity v = 1 / (ind * cap) ^ (1 / 2)
        "velocity of the signal";
      Models.TransmissionLineEquations tlm2(N = N, L = L, res = res, cap = cap, ind = ind, w = w);
      Models.TransmissionLineModelica tlm1(N = N, r = res, l = ind, c = cap, length = L, w = w);
      SIunits.Voltage voltage_modelica;
      SIunits.Voltage voltage_equations;
      SIunits.Voltage voltage_modelica_delayed;
      SIunits.Voltage voltage_equations_delayed;
    equation
      voltage_modelica = tlm1.resistor.p.v;
      voltage_equations = tlm2.vol[N];
      voltage_equations_delayed = delay(tlm2.vol[1], TD);
      voltage_modelica_delayed = delay(tlm1.signalvoltage.p.v, TD);
      annotation(experiment(StopTime = 4e-6, Interval=2e-9, Tolerance = 1e-8), Documentation(info = "<html><p>In this model, the verification of the TransmissionLineModelica and the TransmissionLineEquations are performed.The formula of the time delay is used for the verification of the implemented transmission line circuit models to check whether the time delay of the models satisfies the theoretical one. Time delay between the ends of a transmission line can be calculated as follows:</p><p><img src=\"modelica://ScalableTestSuite/Resources/Images/TransmissionLine/timedelay.png\"/></p>Therefore, using the time delay formula, input voltages of the both models are delayed by the theoretical time delay. Moreover, it is checked whether the output voltages of the transmission line circuit models are matching with the delayed input voltages.<p>The parameters for the TransmissionLineCheck are: </p><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Parameters</th>
      <th>Comment</th>
    </tr>
		<tr>
      <td valign=\"top\">N</td>
      <td valign=\"top\">number of segments</td>
    </tr>
		<tr>
      <td valign=\"top\">L</td>
      <td valign=\"top\">length of the transmission line</td>
    </tr>
   <tr>
      <td valign=\"top\">res</td>
      <td valign=\"top\">resistance per meter</td>
    </tr>
    <tr>
      <td valign=\"top\">cap</td>
      <td valign=\"top\">capacitance per meter</td>
    </tr>
    <tr>
      <td valign=\"top\">ind</td>
      <td valign=\"top\">inductance per meter</td>
    </tr>
		<tr>
      <td valign=\"top\">RL</td>
      <td valign=\"top\">load resistance</td>
    </tr>
		<tr>
      <td valign=\"top\">w</td>
      <td valign=\"top\">cut-off frequency</td>
    </tr>
		<tr>
      <td valign=\"top\">TD</td>
      <td valign=\"top\">time delay of the transmission line</td>
    </tr>
		<tr>
      <td valign=\"top\">v</td>
      <td valign=\"top\">velocity of the signal</td>
    </tr>
</table>
</html>"));
    end TransmissionLineCheck;
  end Verification;

  package ScaledExperiments "Experiments with different scale factors"
    extends Modelica.Icons.ExamplesPackage;

    model TransmissionLineEquations_N_10
      extends Models.TransmissionLineEquations(N = 10, L = 100, res = 48e-6, cap = 101e-12, ind = 253e-9, w = 1 / 2e-7);
      annotation(experiment(StopTime = 4e-6, Interval=2e-9, Tolerance = 1e-8),
                 __OpenModelica_simulationFlags(s = "ida"));
    end TransmissionLineEquations_N_10;

    model TransmissionLineEquations_N_20
      extends TransmissionLineEquations_N_10(N = 20);
      annotation(experiment(StopTime = 4e-6, Interval=2e-9, Tolerance = 1e-8),
                 __OpenModelica_simulationFlags(s = "ida"));
    end TransmissionLineEquations_N_20;

    model TransmissionLineEquations_N_40
      extends TransmissionLineEquations_N_10(N = 40);
      annotation(experiment(StopTime = 4e-6, Interval=2e-9, Tolerance = 1e-8),
                 __OpenModelica_simulationFlags(s = "ida"));
    end TransmissionLineEquations_N_40;

    model TransmissionLineEquations_N_80
      extends TransmissionLineEquations_N_10(N = 80);
      annotation(experiment(StopTime = 4e-6, Interval=2e-9, Tolerance = 1e-8),
                 __OpenModelica_simulationFlags(s = "ida"));
    end TransmissionLineEquations_N_80;

    model TransmissionLineEquations_N_160
      extends TransmissionLineEquations_N_10(N = 160);
      annotation(experiment(StopTime = 4e-6, Interval=2e-9, Tolerance = 1e-8),
                 __OpenModelica_simulationFlags(s = "ida"));
    end TransmissionLineEquations_N_160;

    model TransmissionLineEquations_N_320
      extends TransmissionLineEquations_N_10(N = 320);
      annotation(experiment(StopTime = 4e-6, Interval=2e-9, Tolerance = 1e-8),
                 __OpenModelica_simulationFlags(s = "ida"));
    end TransmissionLineEquations_N_320;

    model TransmissionLineEquations_N_640
      extends TransmissionLineEquations_N_10(N = 640);
      annotation(experiment(StopTime = 4e-6, Interval=2e-9, Tolerance = 1e-8),
                 __OpenModelica_simulationFlags(s = "ida"));
    end TransmissionLineEquations_N_640;

    model TransmissionLineEquations_N_1280
      extends TransmissionLineEquations_N_10(N = 1280);
      annotation(experiment(StopTime = 4e-6, Interval=2e-9, Tolerance = 1e-8),
                 __OpenModelica_simulationFlags(s = "ida"));
    end TransmissionLineEquations_N_1280;

    model TransmissionLineModelica_N_10
      extends Models.TransmissionLineModelica(N = 10, r = 48e-6, c = 101e-12, l = 253e-9, length = 100, w = 1 / 2e-7);
      annotation(experiment(StopTime = 4e-6, Interval=2e-9, Tolerance = 1e-8),
                 __OpenModelica_simulationFlags(s = "ida"));
    end TransmissionLineModelica_N_10;

    model TransmissionLineModelica_N_20
      extends TransmissionLineModelica_N_10(N = 20);
      annotation(experiment(StopTime = 4e-6, Interval=2e-9, Tolerance = 1e-8),
                 __OpenModelica_simulationFlags(s = "ida"));
    end TransmissionLineModelica_N_20;

    model TransmissionLineModelica_N_40
      extends TransmissionLineModelica_N_10(N = 40);
      annotation(experiment(StopTime = 4e-6, Interval=2e-9, Tolerance = 1e-8),
                 __OpenModelica_simulationFlags(s = "ida"));
    end TransmissionLineModelica_N_40;

    model TransmissionLineModelica_N_80
      extends TransmissionLineModelica_N_10(N = 80);
      annotation(experiment(StopTime = 4e-6, Interval=2e-9, Tolerance = 1e-8),
                 __OpenModelica_simulationFlags(s = "ida"));
    end TransmissionLineModelica_N_80;

    model TransmissionLineModelica_N_160
      extends TransmissionLineModelica_N_10(N = 160);
      annotation(experiment(StopTime = 4e-6, Interval=2e-9, Tolerance = 1e-8),
                 __OpenModelica_simulationFlags(s = "ida"));
    end TransmissionLineModelica_N_160;

    model TransmissionLineModelica_N_320
      extends TransmissionLineModelica_N_10(N = 320);
      annotation(experiment(StopTime = 4e-6, Interval=2e-9, Tolerance = 1e-8),
                 __OpenModelica_simulationFlags(s = "ida"));
    end TransmissionLineModelica_N_320;

    model TransmissionLineModelica_N_640
      extends TransmissionLineModelica_N_10(N = 640);
      annotation(experiment(StopTime = 4e-6, Interval=2e-9, Tolerance = 1e-8),
                 __OpenModelica_simulationFlags(s = "ida"));
    end TransmissionLineModelica_N_640;


    model TransmissionLineModelica_N_1280
      extends TransmissionLineModelica_N_10(N = 1280);
      annotation(experiment(StopTime = 4e-6, Interval=2e-9, Tolerance = 1e-8),
                 __OpenModelica_simulationFlags(s = "ida"));
    end TransmissionLineModelica_N_1280;
    annotation(Documentation(info = "<html><p>In this package there are 16 tests for different N values; 8 for the TransmissionLineModelica and 8 for the TransmissionLineEquations.</p><p> The tests for the both models are performed according to the N values as shown in the table below:</p><table border=\"1\">
    <tr>
      <th>N</th>
    </tr>
		<tr>
      <td valign=\"top\">10</td>
    </tr>
   <tr>
      <td valign=\"top\">20</td>
    </tr>
    <tr>
      <td valign=\"top\">40</td>
    </tr>
    <tr>
      <td valign=\"top\">80</td>
    </tr>
		<tr>
      <td valign=\"top\">160</td>
    </tr>
		<tr>
      <td valign=\"top\">320</td>
    </tr>
		<tr>
      <td valign=\"top\">640</td>
    </tr>
		<tr>
      <td valign=\"top\">1280</td>
    </tr>
</table><p>Parameters for TransmissionLineEquations:</p><p><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Parameters</th>
      <th>Comment</th>
    </tr>
		<tr>
      <td valign=\"top\">N</td>
      <td valign=\"top\">10,20,40,80,160,320,640,1280</td>
    </tr>
		<tr>
      <td valign=\"top\">L</td>
      <td valign=\"top\">100</td>
    </tr>
   <tr>
      <td valign=\"top\">res</td>
      <td valign=\"top\">48e-6</td>
    </tr>
    <tr>
      <td valign=\"top\">cap</td>
      <td valign=\"top\">101e-12</td>
    </tr>
		<tr>
      <td valign=\"top\">ind</td>
      <td valign=\"top\">253e-9</td>
    </tr>
		<tr>
      <td valign=\"top\">w</td>
      <td valign=\"top\">5e6</td>
    </tr>
</table></p><p>Parameters for TransmissionLineModelica:</p><p><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Parameters</th>
      <th>Comment</th>
    </tr>
		<tr>
      <td valign=\"top\">N</td>
      <td valign=\"top\">10,20,40,80,160,320,640,1280</td>
    </tr>
   <tr>
      <td valign=\"top\">r</td>
      <td valign=\"top\">48e-6</td>
    </tr>
    <tr>
      <td valign=\"top\">c</td>
      <td valign=\"top\">101e-12</td>
    </tr>
		<tr>
      <td valign=\"top\">l</td>
      <td valign=\"top\">253e-9</td>
    </tr>
		<tr>
      <td valign=\"top\">length</td>
      <td valign=\"top\">100</td>
    </tr>
		<tr>
      <td valign=\"top\">w</td>
      <td valign=\"top\">5e6</td>
    </tr>
</table></p></html>"));
  end ScaledExperiments;
end TransmissionLine;
