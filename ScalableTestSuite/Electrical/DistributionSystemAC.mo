within ScalableTestSuite.Electrical;
package DistributionSystemAC
  import SI = Modelica.SIunits;
  package Models
    package Internals
      operator record ComplexVoltage = SI.ComplexVoltage(re(nominal = 1e3), im(nominal = 1e3));
      operator record ComplexCurrent = SI.ComplexCurrent(re(nominal = 1e3), im(nominal = 1e3));
      operator record ComplexPower = SI.ComplexPower(re(nominal = 1e4), im(nominal = 1e4));
      connector Pin "Pin of an electrical component"
        ComplexVoltage v "Potential at the pin";
        flow ComplexCurrent i "Current flowing into the pin";
        annotation(defaultComponentName = "pin", Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-160, 110}, {40, 50}}, lineColor = {0, 0, 255}, textString = "%name")}));
      end Pin;

      connector PositivePin "Positive pin of an electric component"
        ComplexVoltage v "Potential at the pin";
        flow ComplexCurrent i "Current flowing into the pin";
        annotation(defaultComponentName = "p", Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-160, 110}, {40, 50}}, lineColor = {0, 0, 255}, textString = "%name")}));
      end PositivePin;

      connector NegativePin "Negative pin of an electric component"
        ComplexVoltage v "Potential at the pin";
        flow ComplexCurrent i "Current flowing into the pin";
        annotation(defaultComponentName = "n", Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-40, 110}, {160, 50}}, textString = "%name", lineColor = {0, 0, 255})}));
      end NegativePin;

      model Ground "Ground model"
        ScalableTestSuite.Electrical.DistributionSystemAC.Models.Internals.Pin p annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        p.v = Complex(0,0);
        annotation(uses(ScalableTestSuite(version = "1.7.1")), Icon(graphics = {Line(origin = {0, -25}, points = {{0, 15}, {0, -15}}), Line(origin = {1, -40}, points = {{-59, 0}, {59, 0}}), Line(origin = {0, -60}, points = {{-40, 0}, {40, 0}}), Line(origin = {0, -79}, points = {{-20, -1}, {20, -1}}), Line(origin = {-1, -100}, points = {{-1, 0}, {3, 0}})}));
      end Ground;

      partial model OnePort "Generic one-port model with complex voltage and current"
        PositivePin p annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        NegativePin n annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SI.ComplexVoltage v "Voltage across component";
        SI.ComplexCurrent i "Current through component";
      equation
        v = p.v - n.v;
        p.i + n.i = Complex(0, 0);
        i = p.i;
        annotation(Icon(coordinateSystem(initialScale = 0.1)));
      end OnePort;

      model VoltageSource "Fixed Real voltage source"
        extends Internals.OnePort;
        parameter SI.Voltage V "Fixed (real) source voltage";
      equation
        v = Complex(V, 0) "Enforce prescribed voltage";
        annotation(Icon(graphics = {Line(origin = {1, -1}, points = {{-91, 1}, {89, 1}}), Ellipse(origin = {0, 1}, extent = {{-40, 39}, {40, -41}}, endAngle = 360)}, coordinateSystem(initialScale = 0.1)));
      end VoltageSource;

      model ActivePowerSensor
        extends Modelica.Icons.RotationalSensor;
  PositivePin s "Connect to the power source" annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PositivePin p "Connect to the load positive pin" annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      NegativePin n "Connect to the load negative pin" annotation(Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      
        SI.ComplexVoltage v "Voltage across load";
        SI.ComplexCurrent i "Current through load";
        Modelica.Blocks.Interfaces.RealOutput P annotation(Placement(visible = true, transformation(origin = {4, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        SI.ComplexPower S "Complex power flow through the component";
      equation
        s.v = p.v "Ideal sensor with zero impedance";
        v = p.v - n.v "Load voltage drop";
        s.i + p.i = Complex(0, 0) "Current going to load";
        n.i = Complex(0, 0) "No current into n pin";
        i = s.i "Current through load";
        S = v * Modelica.ComplexMath.conj(i) "Complex power";
        P = S.re;
        annotation(Icon(graphics = {Line(origin = {-79, 0}, points = {{-11, 0}, {9, 0}, {9, 0}}), Line(origin = {80, 1}, points = {{-10, -1}, {10, -1}}), Line(origin = {0, -80}, points = {{0, 10}, {0, -10}, {0, -10}}), Line(origin = {0, 80}, points = {{0, 10}, {0, -8}, {0, -10}})}, coordinateSystem(initialScale = 0.1)), uses(ScalableTestSuite(version = "1.7.1")));
      end ActivePowerSensor;

      partial model PartialImpedance "Generic complex impedance model"
        extends OnePort;
        SI.ComplexImpedance Z_ "Impedance - internal variable";
      equation
        v = Z_ * i;
        annotation(Icon(graphics = {Line(origin = {-75, 0}, points = {{-15, 0}, {15, 0}}), Line(origin = {75, 0}, points = {{15, 0}, {-15, 0}}), Rectangle(origin = {-1, 0}, extent = {{-59, 20}, {61, -20}})}, coordinateSystem(initialScale = 0.1)));
      end PartialImpedance;

      model Impedance "Generic complex impedance model"
        extends PartialImpedance(final Z_ = Z);
        parameter SI.ComplexImpedance Z "Fixed impedance";
      end Impedance;

      model VariableResistor "Resistor model with variable resistance"
        extends PartialImpedance(Z_(re = R, im = 0));
        Modelica.Blocks.Interfaces.RealInput R annotation(Placement(visible = true, transformation(origin = {2, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      
        annotation(uses(ScalableTestSuite(version = "1.7.1")), Icon(graphics = {Line(origin = {-75, 0}, points = {{-15, 0}, {13, 0}}), Line(origin = {75, 0}, points = {{15, 0}, {-15, 0}}), Rectangle(origin = {-1, 0}, extent = {{-61, 20}, {61, -20}})}, coordinateSystem(initialScale = 0.1)));
      end VariableResistor;

      model VariableActivePowerLoad "Purely active load model with variable consumption"
        extends OnePort;
        Modelica.Blocks.Interfaces.RealInput P annotation(Placement(visible = true, transformation(origin = {2, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      equation
        v*Modelica.ComplexMath.conj(i) = Complex(P, 0);
        annotation(Icon(graphics = {Line(origin = {-75, 0}, points = {{-15, 0}, {13, 0}}), Line(origin = {75, 0}, points = {{15, 0}, {-15, 0}}), Rectangle(origin = {-1, 0}, extent = {{-61, 20}, {61, -20}})}, coordinateSystem(initialScale = 0.1)));
      end VariableActivePowerLoad;

      model LinearControlledLoad
        parameter SI.Voltage V_nom = 600 "Nominal voltage";
        parameter SI.Power P_nom "Nominal power";
        parameter SI.Time T = 0.1 "Time constant of power controller";
        final parameter SI.Resistance R_nom = V_nom^2/P_nom;
        PositivePin p annotation(Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      VariableResistor R annotation(Placement(visible = true, transformation(origin = {-3.55271e-15, -8}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  ScalableTestSuite.Electrical.DistributionSystemAC.Models.Internals.Ground ground1 annotation(Placement(visible = true, transformation(origin = {-3.55271e-15, -78}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ScalableTestSuite.Electrical.DistributionSystemAC.Models.Internals.ActivePowerSensor sensor annotation(Placement(visible = true, transformation(origin = {0, 60}, extent = {{-14, -14}, {14, 14}}, rotation = -90)));
    Modelica.Blocks.Continuous.Integrator controller(initType = Modelica.Blocks.Types.Init.InitialOutput, k = -R_nom / P_nom /T, y_start = R_nom)  annotation(Placement(visible = true, transformation(origin = {-26, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Feedback feedback annotation(Placement(visible = true, transformation(origin = {-54, -8}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression powerSetpoint(y = P_nom) annotation(Placement(visible = true, transformation(origin = {-84, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(sensor.s, p) annotation(Line(points = {{0, 74}, {0, 74}, {0, 100}, {0, 100}}, color = {0, 0, 255}));
        connect(sensor.p, R.p) annotation(Line(points = {{0, 46}, {0, 12}}, color = {0, 0, 255}));
        connect(sensor.n, R.n) annotation(Line(points = {{14, 60}, {40, 60}, {40, -28}, {0, -28}}, color = {0, 0, 255}));
        connect(feedback.u2, sensor.P) annotation(Line(points = {{-54, 0}, {-54, 60}, {-14, 60}}, color = {0, 0, 127}));
        connect(ground1.p, R.n) annotation(Line(points = {{0, -78}, {0, -78}, {0, -28}, {0, -28}}, color = {0, 0, 255}));
        connect(powerSetpoint.y, feedback.u1) annotation(Line(points = {{-72, -8}, {-64, -8}, {-64, -8}, {-62, -8}}, color = {0, 0, 127}));
        connect(controller.u, feedback.y) annotation(Line(points = {{-38, -8}, {-45, -8}}, color = {0, 0, 127}));
        connect(R.R, controller.y) annotation(Line(points = {{-6, -8}, {-15, -8}}, color = {0, 0, 127}));
        annotation(Icon(graphics = {Rectangle(origin = {-1, 0}, extent = {{-99, 100}, {101, -100}}), Line(origin = {0, 75}, points = {{0, 15}, {0, -15}}), Rectangle(origin = {-1, 4}, extent = {{-19, 56}, {21, -24}}), Line(origin = {0, -50}, points = {{0, 30}, {0, -10}, {0, -10}}), Line(origin = {-1, -60}, points = {{-19, 0}, {21, 0}}), Line(origin = {0, -68}, points = {{-10, 0}, {10, 0}}), Line(origin = {0, -76}, points = {{-4, 0}, {4, 0}})}, coordinateSystem(initialScale = 0.1)));
      end LinearControlledLoad;

      model NoninearControlledLoad
        parameter SI.Voltage V_nom = 600 "Nominal voltage";
        parameter SI.Power P_nom "Nominal power";
        PositivePin p annotation(Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        VariableActivePowerLoad load annotation(Placement(visible = true, transformation(origin = {-3.55271e-15, -8}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
        Ground ground1 annotation(Placement(visible = true, transformation(origin = {-3.55271e-15, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        ActivePowerSensor sensor annotation(Placement(visible = true, transformation(origin = {0, 66}, extent = {{-14, -14}, {14, 14}}, rotation = -90)));
        Modelica.Blocks.Continuous.Integrator controller(initType = Modelica.Blocks.Types.Init.SteadyState, k = 1, y_start = P_nom / V_nom) annotation(Placement(visible = true, transformation(origin = {-26, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Math.Feedback feedback annotation(Placement(visible = true, transformation(origin = {-54, -8}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
        Modelica.Blocks.Sources.RealExpression powerSetpoint(y = P_nom) annotation(Placement(visible = true, transformation(origin = {-84, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(sensor.n, load.n) annotation(Line(points = {{14, 66}, {40, 66}, {40, -28}, {0, -28}, {0, -28}}, color = {0, 0, 255}));
        connect(powerSetpoint.y, feedback.u1) annotation(Line(points = {{-72, -8}, {-64, -8}, {-64, -8}, {-62, -8}}, color = {0, 0, 127}));
        connect(controller.u, feedback.y) annotation(Line(points = {{-38, -8}, {-45, -8}}, color = {0, 0, 127}));
        connect(feedback.u2, sensor.P) annotation(Line(points = {{-54, 0}, {-54, 66}, {-14, 66}}, color = {0, 0, 127}));
        connect(load.P, controller.y) annotation(Line(points = {{-6, -8}, {-15, -8}}, color = {0, 0, 127}));
        connect(load.n, ground1.p) annotation(Line(points = {{0, -28}, {0, -28}, {0, -60}, {0, -60}}, color = {0, 0, 255}));
        connect(sensor.n, load.p) annotation(Line(points = {{0, 52}, {0, 52}, {0, 12}, {0, 12}}, color = {0, 0, 255}));
        connect(p, sensor.p) annotation(Line(points = {{0, 100}, {0, 100}, {0, 80}, {0, 80}}, color = {0, 0, 255}));
        annotation(Icon(graphics = {Rectangle(origin = {-1, 0}, extent = {{-99, 100}, {101, -100}}), Line(origin = {0, 75}, points = {{0, 15}, {0, -15}}), Rectangle(origin = {-1, 4}, extent = {{-19, 56}, {21, -24}}), Line(origin = {0, -50}, points = {{0, 30}, {0, -10}, {0, -10}}), Line(origin = {-1, -60}, points = {{-19, 0}, {21, 0}}), Line(origin = {0, -68}, points = {{-10, 0}, {10, 0}}), Line(origin = {0, -76}, points = {{-4, 0}, {4, 0}})}, coordinateSystem(initialScale = 0.1)));
      end NoninearControlledLoad;
    end Internals;

    model DistributionSystemLinearControlledLoads
      parameter Integer N = 4
        "Number of segments of the primary distribution line";
      parameter Integer M = N
        "Number of segments of each secondary distribution line";
      parameter Real alpha = 10 "Distribution line oversizing factor";
      parameter Real beta = 2 "Ratio between line inductance and line resistance";
      parameter SI.Resistance R_l = 1
        "Resistance of a single load";
      parameter SI.Resistance R_d2 = R_l/(M^2*alpha)
        "Resistance of a secondary distribution segment";
      parameter SI.Resistance R_d1 = R_l/(M^2*N^2*alpha)
        "Resistance of a primary distribution segment";
      parameter Modelica.SIunits.Voltage V_ref = 600 "Reference source voltage";
    
      Internals.Impedance primary[N](each Z(re = R_d1, im = R_d1*beta))
        "Primary distribution line segments";
      Internals.Impedance secondary[N,M](each Z(re = R_d2, im = R_d2*beta))
        "Secondary distribution line segments";
      Internals.Impedance load[N,M](each Z(re = R_l, im = 0))
        "Individual load resistors";
      Internals.Ground ground[N,M] "Load ground";
      Internals.Ground sourceGround "Source ground";
    
      Internals.VoltageSource V_source(V = V_ref) "Voltage source";
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
    end DistributionSystemLinearControlledLoads;

    model DistributionSystemLinear
      parameter Integer N = 4 "Number of segments of the primary distribution line";
      parameter Integer M = N "Number of segments of each secondary distribution line";
      parameter Real alpha = 10 "Distribution line oversizing factor";
      parameter Real beta = 2 "Ratio between line inductance and line resistance";
      parameter SI.Resistance R_l = 100 "Resistance of a single load";
      parameter SI.Resistance R_d2 = R_l / (M ^ 2 * alpha) "Resistance of a secondary distribution segment";
      parameter SI.Resistance R_d1 = R_l / (M ^ 2 * N ^ 2 * alpha) "Resistance of a primary distribution segment";
      parameter Modelica.SIunits.Voltage V_ref = 600 "Reference source voltage";
      Internals.Impedance primary[N](each Z(re = R_d1, im = R_d1 * beta)) "Primary distribution line segments";
      Internals.Impedance secondary[N, M](each Z(re = R_d2, im = R_d2 * beta)) "Secondary distribution line segments";
      Internals.LinearControlledLoad load[N, M](each V_nom = V_ref, each P_nom = V_ref^2/R_l) "Individual load resistors";
      Internals.Ground sourceGround "Source ground";
      Internals.VoltageSource V_source(V = V_ref) "Voltage source";
    equation
      connect(primary[1].p, V_source.p);
      connect(sourceGround.p, V_source.n);
      for i in 1:N - 1 loop
        connect(primary[i].n, primary[i + 1].p);
      end for;
      for i in 1:N loop
        connect(primary[i].n, secondary[i, 1].p);
        for j in 1:M - 1 loop
          connect(secondary[i, j].n, secondary[i, j + 1].p);
        end for;
        for j in 1:M loop
          connect(secondary[i, j].n, load[i, j].p);
        end for;
      end for;
      annotation(Documentation(info = "<html>
    <p>This model represnts an AC current distribution system, whose complexity depends on two parameters
    N and M.</p><p>A constant voltage source is connected to a primary resistive distribution line which is split into
    N segments, each with an impedance R_d1 + j*beta*R_d1. At the end of each segment, a secondary distribution
    line is attached with M elements each of impedance R_d2 + j*beta*R_d2. At the end of each secondary segment,
    a linear load connected, which is internally grounded on the other side.</p>
    <p>Each load measures its absorbed active power and adapts its internal resistance to match the required active
    power set point.
    </html>"));
    end DistributionSystemLinear;

    model DistributionSystemLinearIndividual
    
      impure function print
        input String s;
      algorithm
        Modelica.Utilities.Streams.print(s, "code.mo");
      end print;
    
      function printModel
      protected
        Integer N = 2
          "Number of segments of the primary distribution line";
        Integer M = N
          "Number of segments of each secondary distribution line";
        Real alpha = 10 "Distribution line oversizing factor";
        Real beta = 2 "Ratio between line inductance and line resistance";
        Modelica.SIunits.Resistance R_l = 100
          "Resistance of a single load";
      algorithm
        Modelica.Utilities.Files.removeFile("code.mo");
        print("model DistributionSystemLinearIndividual_N_"+String(N)+"_M_"+String(M));
        print("  parameter Integer N = "+String(N)+" \"Number of segments of the primary distribution line\";");
        print("  parameter Integer M = "+String(M)+" \"Number of segments of each secondary distribution line\";");
        print("  parameter Real alpha = "+String(alpha)+" \"Distribution line oversizing factor\";");
        print("  parameter Real beta = "+String(beta)+" \"Ratio between line inductance and line resistance\";");
        print("  parameter Modelica.SIunits.Resistance R_l = "+String(R_l)+ " \"Resistance of a single load\";");
        print("  parameter Modelica.SIunits.Resistance R_d2 = R_l/(M^2*alpha) \"Resistance of a secondary distribution segment\";");
        print("  parameter Modelica.SIunits.Resistance R_d1 = R_l/(M^2*N^2*alpha) \"Resistance of a primary distribution segment\";");
        print("  parameter Modelica.SIunits.Voltage V_ref = 600 \"Reference source voltage\";");
        print("");
        for i in 1:N loop
          print("  Models.Internals.Impedance primary_"+String(i)+"(Z(re = R_d1, im = R_d1 * beta)) \"Primary distribution line segment\";");
          for j in 1:M loop
            print("  Models.Internals.Impedance secondary_"+String(i)+"_"+String(j)+"(Z(re = R_d2, im = R_d2 * beta)) \"Secondary distribution line segment\";");
            print("  Models.Internals.LinearControlledLoad load_"+String(i)+"_"+String(j)+"(V_nom = V_ref, P_nom = V_ref^2/R_l) \"Individual load resistor\";");
          end for;
        end for;
        print("  Models.Internals.Ground sourceGround \"Source ground\";");
        print("  Models.Internals.VoltageSource V_source(V = V_ref) \"Voltage source\";");
        print("equation");
        print("  connect(primary_1.p, V_source.p);");
        print("  connect(sourceGround.p, V_source.n);");
        for i in 1:N-1 loop
          print("  connect(primary_"+String(i)+".n, primary_"+String(i+1)+".p);");
        end for;
        for i in 1:N loop
          print("  connect(primary_"+String(i)+".n, secondary_"+String(i)+"_1.p);");
          for j in 1:M-1 loop
            print("  connect(secondary_"+String(i)+"_"+String(j)+".n, secondary_"+String(i)+"_"+String(j+1)+".p);");
          end for;
          for j in 1:M loop
            print("  connect(secondary_"+String(i)+"_"+String(j)+".n, load_"+String(i)+"_"+String(j)+".p);");
          end for;
        end for;
        print("  annotation(experiment(StopTime = 1, Interval = 1e-3));");
        print("end DistributionSystemLinearIndividual_N_"+String(N)+"_M_"+String(M)+";");
      end printModel;
    
    algorithm
      when terminal() then
        printModel();
      end when;
      annotation(experiment(StopTime = 1, Interval = 1e-3),
                 Documentation(info="<html>
    <p>This model generates Modelica code of models equivalent to DistributionSystemLinear which don&apos;t use arrays and for loops, but rather declare each model and each connection individually.</p>
    <p>This model can be used to check the overhead of instantiating large numbesr of individual models compared to arrays, and also to check the ability of compilers to factor out the code of instances of the same component.</p>
    </html>"));
    end DistributionSystemLinearIndividual;
  end Models;

  package Verification
    model DistributionSystemLinear_N_2_M_2
      extends Models.DistributionSystemLinear(N = 2, M = 2);
      annotation(experiment(StopTime = 1, Interval = 1e-3));
    end DistributionSystemLinear_N_2_M_2;

    model DistributionSystemLinearIndividual_N_2_M_2 "Automatically generated by DistributionSystemLinearIndividual"
      parameter Integer N = 2 "Number of segments of the primary distribution line";
      parameter Integer M = 2 "Number of segments of each secondary distribution line";
      parameter Real alpha = 10 "Distribution line oversizing factor";
      parameter Real beta = 2 "Ratio between line inductance and line resistance";
      parameter Modelica.SIunits.Resistance R_l = 100 "Resistance of a single load";
      parameter Modelica.SIunits.Resistance R_d2 = R_l/(M^2*alpha) "Resistance of a secondary distribution segment";
      parameter Modelica.SIunits.Resistance R_d1 = R_l/(M^2*N^2*alpha) "Resistance of a primary distribution segment";
      parameter Modelica.SIunits.Voltage V_ref = 600 "Reference source voltage";
    
      Models.Internals.Impedance primary_1(Z(re = R_d1, im = R_d1 * beta)) "Primary distribution line segment";
      Models.Internals.Impedance secondary_1_1(Z(re = R_d2, im = R_d2 * beta)) "Secondary distribution line segment";
      Models.Internals.LinearControlledLoad load_1_1(V_nom = V_ref, P_nom = V_ref^2/R_l) "Individual load resistor";
      Models.Internals.Impedance secondary_1_2(Z(re = R_d2, im = R_d2 * beta)) "Secondary distribution line segment";
      Models.Internals.LinearControlledLoad load_1_2(V_nom = V_ref, P_nom = V_ref^2/R_l) "Individual load resistor";
      Models.Internals.Impedance primary_2(Z(re = R_d1, im = R_d1 * beta)) "Primary distribution line segment";
      Models.Internals.Impedance secondary_2_1(Z(re = R_d2, im = R_d2 * beta)) "Secondary distribution line segment";
      Models.Internals.LinearControlledLoad load_2_1(V_nom = V_ref, P_nom = V_ref^2/R_l) "Individual load resistor";
      Models.Internals.Impedance secondary_2_2(Z(re = R_d2, im = R_d2 * beta)) "Secondary distribution line segment";
      Models.Internals.LinearControlledLoad load_2_2(V_nom = V_ref, P_nom = V_ref^2/R_l) "Individual load resistor";
      Models.Internals.Ground sourceGround "Source ground";
      Models.Internals.VoltageSource V_source(V = V_ref) "Voltage source";
    equation
      connect(primary_1.p, V_source.p);
      connect(sourceGround.p, V_source.n);
      connect(primary_1.n, primary_2.p);
      connect(primary_1.n, secondary_1_1.p);
      connect(secondary_1_1.n, secondary_1_2.p);
      connect(secondary_1_1.n, load_1_1.p);
      connect(secondary_1_2.n, load_1_2.p);
      connect(primary_2.n, secondary_2_1.p);
      connect(secondary_2_1.n, secondary_2_2.p);
      connect(secondary_2_1.n, load_2_1.p);
      connect(secondary_2_2.n, load_2_2.p);
      annotation(experiment(StopTime = 1, Interval = 1e-3));
    end DistributionSystemLinearIndividual_N_2_M_2;
  
  
    model LinearControlledLoad
      Models.Internals.LinearControlledLoad linearControlledLoad(P_nom = 3600)  annotation(Placement(visible = true, transformation(origin = {0, 8.88178e-16}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Models.Internals.VoltageSource voltageSource(V = 650)  annotation(Placement(visible = true, transformation(origin = {-50, 3.55271e-15}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Models.Internals.Ground ground annotation(Placement(visible = true, transformation(origin = {-50, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      equation
      connect(voltageSource.p, linearControlledLoad.p) annotation(Line(points = {{-50, 20}, {-50, 40}, {0, 40}, {0, 20}}, color = {0, 0, 255}));
      connect(ground.p, voltageSource.n) annotation(Line(points = {{-50, -40}, {-50, -40}, {-50, -20}, {-50, -20}}, color = {0, 0, 255}));
      annotation(Documentation(info="<html>Test of the Linear Controlled Load Model. The applied voltage is slightly higher than the nominal one, so the controller reacts by adapting the resistance to restore the nominal power consumption</html>"));
    end LinearControlledLoad;

    model VariableResistor "Checks the behaviour of the variable resistor and power flow sensor"
  Models.Internals.Ground ground annotation(Placement(visible = true, transformation(origin = {1.77636e-15, -56}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Models.Internals.VariableResistor resistor annotation(Placement(visible = true, transformation(origin = {3.55271e-15, -16}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Models.Internals.VoltageSource voltageSource(V = 600) annotation(Placement(visible = true, transformation(origin = {40, 4}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Sources.RealExpression resistance(y = 300.0) annotation(Placement(visible = true, transformation(origin = {-52, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Models.Internals.ActivePowerSensor sensor annotation(Placement(visible = true, transformation(origin = {7.10543e-15, 44}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      equation
      connect(sensor.n, resistor.n) annotation(Line(points = {{20, 44}, {22, 44}, {22, 44}, {24, 44}, {24, 44}, {28, 44}, {28, -36}, {1.49012e-07, -36}, {1.49012e-07, -36}, {1.49012e-07, -36}, {1.49012e-07, -36}}, color = {0, 0, 255}));
      connect(voltageSource.p, sensor.s) annotation(Line(points = {{40, 24}, {40, 24}, {40, 24}, {40, 24}, {40, 24}, {40, 24}, {40, 64}, {0, 64}, {0, 64}, {0, 64}, {0, 64}}, color = {0, 0, 255}));
      connect(resistor.p, sensor.p) annotation(Line(points = {{3.55271e-15, 4}, {3.55271e-15, 24}}, color = {0, 0, 255}));
      connect(resistance.y, resistor.R) annotation(Line(points = {{-41, -16}, {-6, -16}}, color = {0, 0, 127}));
      connect(voltageSource.n, ground.p) annotation(Line(points = {{40, -16}, {40, -36}, {40, -36}, {40, -56}, {20, -56}, {20, -56}, {10, -56}, {10, -56}, {0, -56}}, color = {0, 0, 255}));
      connect(resistor.n, ground.p) annotation(Line(points = {{3.55271e-15, -36}, {3.55271e-15, -56}}, color = {0, 0, 255}));
      annotation(Documentation(info="<html>Test of the Variable Resistor model. A voltage of 600 V is applied to a resistor of 300 Ohms. The current is 2 A and the power is 1200 W.</html>"));
    end VariableResistor;
  end Verification;
                            
  package ScaledExperiments
    extends Modelica.Icons.ExamplesPackage;
    model DistributionSystemLinear_N_10_M_10
      extends Models.DistributionSystemLinear(N = 10, M = 10);
      annotation(experiment(StopTime = 1, Interval = 1e-3));
    end DistributionSystemLinear_N_10_M_10;
  
    model DistributionSystemLinear_N_14_M_14
      extends Models.DistributionSystemLinear(N = 14, M = 14);
      annotation(experiment(StopTime = 1, Interval = 1e-3));
    end DistributionSystemLinear_N_14_M_14;
  
    model DistributionSystemLinear_N_20_M_20
      extends Models.DistributionSystemLinear(N = 20, M = 20);
      annotation(experiment(StopTime = 1, Interval = 1e-3));
    end DistributionSystemLinear_N_20_M_20;
  
    model DistributionSystemLinear_N_28_M_28
      extends Models.DistributionSystemLinear(N = 28, M = 28);
      annotation(experiment(StopTime = 1, Interval = 1e-3));
    end DistributionSystemLinear_N_28_M_28;
  
    model DistributionSystemLinear_N_40_M_40
      extends Models.DistributionSystemLinear(N = 40, M = 40);
      annotation(experiment(StopTime = 1, Interval = 1e-3));
    end DistributionSystemLinear_N_40_M_40;
  
    model DistributionSystemLinear_N_56_M_56
      extends Models.DistributionSystemLinear(N = 56, M = 56);
      annotation(experiment(StopTime = 1, Interval = 1e-3));
    end DistributionSystemLinear_N_56_M_56;
  
    model DistributionSystemLinear_N_80_M_80
      extends Models.DistributionSystemLinear(N = 80, M = 80);
      //annotation(experiment(StopTime = 1, Interval = 1e-3));
    end DistributionSystemLinear_N_80_M_80;
  
    model DistributionSystemLinear_N_112_M_112
      extends Models.DistributionSystemLinear(N = 112, M = 112);
      //annotation(experiment(StopTime = 1, Interval = 1e-3));
    end DistributionSystemLinear_N_112_M_112;
  
    model DistributionSystemLinear_N_160_M_160
      extends Models.DistributionSystemLinear(N = 160, M = 160);
      //annotation(experiment(StopTime = 1, Interval = 1e-3));
    end DistributionSystemLinear_N_160_M_160;end ScaledExperiments;
end DistributionSystemAC;
