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
        annotation(Icon(graphics = {Line(origin = {-75, 0}, points = {{-15, 0}, {13, 0}}), Line(origin = {75, 0}, points = {{15, 0}, {-15, 0}}), Rectangle(origin = {-1, 0}, extent = {{-61, 20}, {61, -20}})}, coordinateSystem(initialScale = 0.1)));
      end OnePort;

      model VoltageSource "Fixed Real voltage source"
        extends Internals.OnePort;
        parameter SI.Voltage V "Fixed (real) source voltage";
      equation
        v = Complex(V, 0) "Enforce prescribed voltage";
        annotation(Icon(graphics = {Line(origin = {1, -1}, points = {{-1, 91}, {-1, -89}}), Ellipse(origin = {0, 1}, extent = {{-40, 39}, {40, -41}}, endAngle = 360)}));
      end VoltageSource;

      model ActivePowerSensor
        extends Modelica.Icons.RotationalSensor;
        extends OnePort;
        Modelica.Blocks.Interfaces.RealOutput P annotation(Placement(visible = true, transformation(origin = {4, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        SI.ComplexPower S "Complex power flow through the component";
      equation
        v = Complex(0, 0) "Ideal sensor with zero impedance";
        S = v*Modelica.ComplexMath.conj(i);
        P = S.re;
        annotation(Icon(graphics = {Line(origin = {-79, 0}, points = {{-11, 0}, {9, 0}, {9, 0}}), Line(origin = {80, 1}, points = {{-10, -1}, {10, -1}}), Line(origin = {0, -80}, points = {{0, 10}, {0, -10}, {0, -10}})}));
      end ActivePowerSensor;

      partial model PartialImpedance "Generic complex impedance model"
        extends OnePort;
        SI.ComplexImpedance Z_ "Impedance - internal variable";
      equation
        v = Z_ * i;
        annotation(Icon(graphics = {Line(origin = {-75, 0}, points = {{-15, 0}, {13, 0}}), Line(origin = {75, 0}, points = {{15, 0}, {-15, 0}}), Rectangle(origin = {-1, 0}, extent = {{-61, 20}, {61, -20}})}, coordinateSystem(initialScale = 0.1)));
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
        parameter SI.Time T = 1 "Time constant of power controller";
        final parameter SI.Resistance R_nom = V_nom^2/P_nom;
        PositivePin p annotation(Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      VariableResistor R annotation(Placement(visible = true, transformation(origin = {-3.55271e-15, -8}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
    Ground ground1 annotation(Placement(visible = true, transformation(origin = {-3.55271e-15, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    ActivePowerSensor sensor annotation(Placement(visible = true, transformation(origin = {0, 66}, extent = {{-14, -14}, {14, 14}}, rotation = -90)));
    Modelica.Blocks.Continuous.Integrator controller(initType = Modelica.Blocks.Types.Init.SteadyState, k = -(V_nom/R_nom)^2/T, y_start = R_nom)  annotation(Placement(visible = true, transformation(origin = {-26, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Feedback feedback annotation(Placement(visible = true, transformation(origin = {-54, -8}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression powerSetpoint(y = P_nom) annotation(Placement(visible = true, transformation(origin = {-84, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(powerSetpoint.y, feedback.u1) annotation(Line(points = {{-72, -8}, {-64, -8}, {-64, -8}, {-62, -8}}, color = {0, 0, 127}));
        connect(controller.u, feedback.y) annotation(Line(points = {{-38, -8}, {-45, -8}}, color = {0, 0, 127}));
        connect(feedback.u2, sensor.P) annotation(Line(points = {{-54, 0}, {-54, 66}, {-14, 66}}, color = {0, 0, 127}));
        connect(R.R, controller.y) annotation(Line(points = {{-6, -8}, {-15, -8}}, color = {0, 0, 127}));
        connect(R.n, ground1.p) annotation(Line(points = {{0, -28}, {0, -28}, {0, -60}, {0, -60}}, color = {0, 0, 255}));
        connect(sensor.n, R.p) annotation(Line(points = {{0, 52}, {0, 52}, {0, 12}, {0, 12}}, color = {0, 0, 255}));
        connect(p, sensor.p) annotation(Line(points = {{0, 100}, {0, 100}, {0, 80}, {0, 80}}, color = {0, 0, 255}));
        annotation(Icon(graphics = {Rectangle(origin = {-1, 0}, extent = {{-99, 100}, {101, -100}}), Line(origin = {0, 75}, points = {{0, 15}, {0, -15}}), Rectangle(origin = {-1, 4}, extent = {{-19, 56}, {19, -40}}), Line(origin = {0, -50}, points = {{0, 14}, {0, -10}, {0, -10}}), Line(origin = {-1, -60}, points = {{-19, 0}, {21, 0}}), Line(origin = {0, -68}, points = {{-10, 0}, {10, 0}}), Line(origin = {0, -76}, points = {{-4, 0}, {4, 0}})}));
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
        connect(powerSetpoint.y, feedback.u1) annotation(Line(points = {{-72, -8}, {-64, -8}, {-64, -8}, {-62, -8}}, color = {0, 0, 127}));
        connect(controller.u, feedback.y) annotation(Line(points = {{-38, -8}, {-45, -8}}, color = {0, 0, 127}));
        connect(feedback.u2, sensor.P) annotation(Line(points = {{-54, 0}, {-54, 66}, {-14, 66}}, color = {0, 0, 127}));
        connect(load.P, controller.y) annotation(Line(points = {{-6, -8}, {-15, -8}}, color = {0, 0, 127}));
        connect(load.n, ground1.p) annotation(Line(points = {{0, -28}, {0, -28}, {0, -60}, {0, -60}}, color = {0, 0, 255}));
        connect(sensor.n, load.p) annotation(Line(points = {{0, 52}, {0, 52}, {0, 12}, {0, 12}}, color = {0, 0, 255}));
        connect(p, sensor.p) annotation(Line(points = {{0, 100}, {0, 100}, {0, 80}, {0, 80}}, color = {0, 0, 255}));
        annotation(Icon(graphics = {Rectangle(origin = {-1, 0}, extent = {{-99, 100}, {101, -100}}), Line(origin = {0, 75}, points = {{0, 15}, {0, -15}}), Rectangle(origin = {-1, 4}, extent = {{-19, 56}, {19, -40}}), Line(origin = {0, -50}, points = {{0, 14}, {0, -10}, {0, -10}}), Line(origin = {-1, -60}, points = {{-19, 0}, {21, 0}}), Line(origin = {0, -68}, points = {{-10, 0}, {10, 0}}), Line(origin = {0, -76}, points = {{-4, 0}, {4, 0}})}));
      end NoninearControlledLoad;
    end Internals;

    model DistributionSystemLinearControlledLoads
      parameter Integer N = 4
        "Number of segments of the primary distribution line";
      parameter Integer M = N
        "Number of segments of each secondary distribution line";
      parameter Real alpha = 2 "Distribution line oversizing factor";
      parameter Real beta = 5 "Ratio between line inductance and line resistance";
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
      parameter Real alpha = 2 "Distribution line oversizing factor";
      parameter Real beta = 5 "Ratio between line inductance and line resistance";
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
    N and M. A constant voltage source is connected to a primary resistive distribution line which is split into
    N segments, each with an impedance R_d1 + j*beta*R_d1. At the end of each segment, a secondary distribution
    line is attached with M elements each of impedance R_d2 + j*beta*R_d2. At the end of each secondary segment,
    a linear load connected, which is internally grounded on the other side.</p>
    <p>Each load measures the absorbed active power and adapts its internal resistance to match the required active
    power set point.
    </html>"));
    end DistributionSystemLinear;
  end Models;

  package Verification
    model DistributionSystemLinear_N_2_M_2
      extends Models.DistributionSystemLinear(N = 2, M = 2);
      annotation(experiment(StopTime = 10));
    end DistributionSystemLinear_N_2_M_2;
  end Verification;
                            
  package ScaledExperiments
  end ScaledExperiments;
end DistributionSystemAC;
