within ScalableTestSuite.Electrical;
package BreakerCircuits "Models of DC circuits with breakers"
  package Models
    model Breaker "Circuit breaker, immediate action"
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter Modelica.SIunits.Current Imax;
      parameter String name = "";
      parameter Modelica.SIunits.Conductance Gopen = 1e-6
        "Conductance when open";
      parameter Modelica.SIunits.Conductance Gclosed = 1e6
        "Conductance when closed";

      Boolean open(start = false, fixed = true) "State of the breaker";
      discrete Modelica.SIunits.Conductance G(start = Gclosed, fixed = true)
        "Conductance";

    equation
      i = G*v;
      when i > Imax then
        open = true;
      end when;
      when pre(open) then
        G = Gopen;
        Modelica.Utilities.Streams.print("Breaker " + name + " opens at time = "+String(time));
      end when;

      annotation (Icon(graphics={
            Rectangle(
              extent={{-60,40},{60,-40}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-94,0},{-40,0}}, color={28,108,200}),
            Line(points={{40,0},{100,0}}, color={28,108,200}),
            Line(points={{-40,0},{34,28}}, color={28,108,200}),
            Ellipse(
              extent={{-44,4},{-36,-4}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{36,4},{44,-4}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>When the current through the breaker goes above Imax, the breaker is tripped open and a message is printed out. The conductance of the breaker is Gclosed in the closed state and Gopen in the open state</p>
</html>"));
    end Breaker;

    model BreakerDelayed "Circuit Breaker, delayed action"
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter Modelica.SIunits.Current Imax;
      parameter String name = "";
      parameter Modelica.SIunits.Time delayTime = 1e-3
        "Delay between the threshold crossing and the breaker opening";
      parameter Modelica.SIunits.Conductance Gopen = 1e-6
        "Conductance when open";
      parameter Modelica.SIunits.Conductance Gclosed = 1e6
        "Conductance when closed";

      Boolean open(start = false, fixed = true) "State of the breaker";
      Boolean triggered(start = false, fixed = true)
        "The current threshold has been crossed";
      discrete Modelica.SIunits.Conductance G(start = Gclosed, fixed = true)
        "Conductance";
      discrete Modelica.SIunits.Time timeClose(start = 1e9, fixed = true);

    equation
      i = G*v;
      when triggered and time > timeClose then
        open = true;
      end when;
      when pre(open) then
        G = Gopen;
        Modelica.Utilities.Streams.print("Breaker " + name + " opens at time = "+String(time));
      end when;
    algorithm
      when i > Imax then
        triggered :=  true;
        timeClose := time + delayTime;
      elsewhen i < Imax and triggered then
        triggered :=false;
      end when;

      annotation (Icon(graphics={
            Rectangle(
              extent={{-60,40},{60,-40}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-94,0},{-40,0}}, color={28,108,200}),
            Line(points={{40,0},{100,0}}, color={28,108,200}),
            Line(points={{-40,0},{34,28}}, color={28,108,200}),
            Ellipse(
              extent={{-44,4},{-36,-4}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{36,4},{44,-4}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>When the current through the breaker goes above Imax and stays there for an interval of timeDelay seconds, the breaker is tripped open and a message is printed out. The conductance of the breaker is Gclosed in the closed state and Gopen in the open state</p>
</html>"));
    end BreakerDelayed;

    model BreakerNetwork "Network with N breakers"
      parameter Integer N = 3;
      parameter Modelica.SIunits.Current Imax[N](fixed = false);
      Modelica.Electrical.Analog.Sources.SignalCurrent source;
      Modelica.Electrical.Analog.Basic.Conductor G[N+1](each G=1);
      Models.Breaker B[N](name={String(i) for i in 1:N}, Imax=Imax);

      Modelica.Electrical.Analog.Basic.Ground ground;
      Modelica.Blocks.Sources.Step step;
      Modelica.Blocks.Continuous.FirstOrder firstOrder(
        T=1,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        k=3*(N+1));
    equation
      connect(firstOrder.u,step.y);
      connect(firstOrder.y, source.i);
      connect(source.p,ground.p);
      connect(G[1].n, ground.p);
      connect(G[1].p, source.n);
      connect(B[1].p, source.n);
      for i in 1:N loop
        connect(G[i+1].p, B[i].n);
        connect(G[i+1].n, ground.p);
      end for;
      for i in 1:N-1 loop
        connect(B[i].p, B[i+1].p);
      end for;
    initial equation
      for i in 1:N-1 loop
        Imax[i] = (N+1)/(i+1) - 0.5/N;
      end for;
      Imax[N] = 1;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>The goal of this model is to test the ability of a Modelica tool to handle a large number of cascading events. </p>
<p>The current generator feeds a growing current into a network which is made by N+1 equal conductive loads, N of which are protected by breakers. The current thus spreads equally through each load whose breaker is closed. </p>
<p>The last breaker is triggered when the current goes above 1 A; as a consequence, the same total current is spread over a number of loads which is one less than before, so that the current on each load is higher. The maximum currents of the remaining breakers is selected so that each breaker opening causes the current of one (and only one more) more breaker to exceed its maximum value. As a consequence, a chain of events is triggered that eventually causes all the breaker to open, one for each event iteration, leaving only one load to carry all the current once the event iteration has been processed.</p>
</html>"));
    end BreakerNetwork;

    model BreakerNetworkDelayed "Network with N delayed breakers"
      parameter Integer N = 3;
      parameter Modelica.SIunits.Current Imax[N](fixed = false);
      Modelica.Electrical.Analog.Sources.SignalCurrent source;
      Modelica.Electrical.Analog.Basic.Conductor G[N+1](each G=1);
      Models.BreakerDelayed B[N](name={String(i) for i in 1:N}, Imax=Imax);

      Modelica.Electrical.Analog.Basic.Ground ground;
      Modelica.Blocks.Sources.Step step;
      Modelica.Blocks.Continuous.FirstOrder firstOrder(
        T=1,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        k=3*(N+1));
    equation
      connect(firstOrder.u,step.y);
      connect(firstOrder.y, source.i);
      connect(source.p,ground.p);
      connect(G[1].n, ground.p);
      connect(G[1].p, source.n);
      connect(B[1].p, source.n);
      for i in 1:N loop
        connect(G[i+1].p, B[i].n);
        connect(G[i+1].n, ground.p);
      end for;
      for i in 1:N-1 loop
        connect(B[i].p, B[i+1].p);
      end for;
    initial equation
      for i in 1:N-1 loop
        Imax[i] = (N+1)/(i+1) - 0.5/N;
      end for;
      Imax[N] = 1;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>The goal of this model is to test the ability of a Modelica tool to handle a large number of closey spaced events. </p>
<p>The current generator feeds a growing current into a network which is made by N+1 equal conductive loads, N of which are protected by breakers. The current thus spreads equally through each load whose breaker is closed. </p>
<p>The last breaker is triggered when the current goes above 1 A. The breaker opens after 1ms; as a consequence, the same total current is spread over a number of loads which is one less than before, so that the current on each load is higher. The maximum currents of the remaining breakers is selected so that each breaker opening causes the current of one (and only one more) more breaker to exceed its maximum value. As a consequence, a chain of very closely spaced events is triggered, until all breakers are open.</p>
</html>"));
    end BreakerNetworkDelayed;
  end Models;

  package Verification

    model BreakerNetwork_3_Scalar
      "Network with three breakers built with scalar components"

      Modelica.Electrical.Analog.Sources.SignalCurrent source annotation (
          Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=-90,
            origin={-40,10})));
      Modelica.Electrical.Analog.Basic.Conductor G1(G=1) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={0,10})));
      Modelica.Electrical.Analog.Basic.Conductor G2(G=1) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={40,10})));
      Modelica.Electrical.Analog.Basic.Conductor G3(G=1) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={80,10})));
      Modelica.Electrical.Analog.Basic.Conductor G4(G=1) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={120,10})));
      Models.Breaker B1(name="B2", Imax=4/2 - 0.5/3) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={40,44})));
      Models.Breaker B2(name="B3", Imax=4/3 - 0.5/3) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={80,44})));
      Models.Breaker B3(name="B4", Imax=4/4) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={120,44})));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(extent={{-50,-60},{-30,-40}})));
      Modelica.Blocks.Sources.Step step
        annotation (Placement(transformation(extent={{-140,0},{-120,20}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder(
        T=1,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        k=4*3)
        annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
    equation
      connect(G1.n, G2.n) annotation (Line(points={{0,0},{0,-20},{40,-20},{40,0}},
            color={0,0,255}));
      connect(G2.n, G3.n) annotation (Line(points={{40,0},{40,-20},{80,-20},{80,
              0}}, color={0,0,255}));
      connect(G3.n, G4.n) annotation (Line(points={{80,0},{80,0},{80,-20},{120,
              -20},{120,0}}, color={0,0,255}));
      connect(step.y, firstOrder.u) annotation (Line(points={{-119,10},{-110,10},
              {-102,10}}, color={0,0,127}));
      connect(source.p, G1.n) annotation (Line(points={{-40,0},{-40,-20},{0,-20},
              {0,0}}, color={0,0,255}));
      connect(source.p, ground.p)
        annotation (Line(points={{-40,0},{-40,0},{-40,-40}}, color={0,0,255}));
      connect(firstOrder.y, source.i) annotation (Line(points={{-79,10},{-65.5,
              10},{-47,10}}, color={0,0,127}));
      connect(B3.n, G4.p) annotation (Line(points={{120,34},{120,27},{120,20}},
            color={0,0,255}));
      connect(B2.n, G3.p)
        annotation (Line(points={{80,34},{80,27},{80,20}}, color={0,0,255}));
      connect(B1.n, G2.p)
        annotation (Line(points={{40,34},{40,27},{40,20}}, color={0,0,255}));
      connect(B1.p, B2.p) annotation (Line(points={{40,54},{40,66},{80,66},{80,
              54}}, color={0,0,255}));
      connect(B2.p, B3.p) annotation (Line(points={{80,54},{80,54},{80,66},{120,
              66},{120,54}}, color={0,0,255}));
      connect(source.n, B2.p) annotation (Line(points={{-40,20},{-40,66},{80,66},
              {80,54}}, color={0,0,255}));
      connect(source.n, G1.p) annotation (Line(points={{-40,20},{-40,20},{-40,
              66},{0,66},{0,20}}, color={0,0,255}));
      annotation (
       experiment(StopTime = 1, Tolerance = 1e-6),
       Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(
            preserveAspectRatio=false,
            extent={{-200,-100},{200,100}},
            initialScale=0.1)));
    end BreakerNetwork_3_Scalar;

    model BreakerNetwork_3_Array
      "Network with three breakers, array  implementation"
      extends Models.BreakerNetwork(  N=3);
      annotation(experiment(StopTime = 1, Tolerance = 1e-6));
    end BreakerNetwork_3_Array;

    model BreakerNetworkDelayed_3_Scalar
      "Network with three delayed breakers built with scalar components"

      Modelica.Electrical.Analog.Sources.SignalCurrent source annotation (
          Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=-90,
            origin={-40,10})));
      Modelica.Electrical.Analog.Basic.Conductor G1(G=1) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={0,10})));
      Modelica.Electrical.Analog.Basic.Conductor G2(G=1) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={40,10})));
      Modelica.Electrical.Analog.Basic.Conductor G3(G=1) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={80,10})));
      Modelica.Electrical.Analog.Basic.Conductor G4(G=1) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={120,10})));
      Models.BreakerDelayed
                     B1(name="B2", Imax=4/2 - 0.5/3) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={40,44})));
      Models.BreakerDelayed
                     B2(name="B3", Imax=4/3 - 0.5/3) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={80,44})));
      Models.BreakerDelayed
                     B3(name="B4", Imax=4/4) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={120,44})));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(extent={{-50,-60},{-30,-40}})));
      Modelica.Blocks.Sources.Step step
        annotation (Placement(transformation(extent={{-140,0},{-120,20}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder(
        T=1,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        k=4*3)
        annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
    equation
      connect(G1.n, G2.n) annotation (Line(points={{0,0},{0,-20},{40,-20},{40,0}},
            color={0,0,255}));
      connect(G2.n, G3.n) annotation (Line(points={{40,0},{40,-20},{80,-20},{80,
              0}}, color={0,0,255}));
      connect(G3.n, G4.n) annotation (Line(points={{80,0},{80,0},{80,-20},{120,
              -20},{120,0}}, color={0,0,255}));
      connect(step.y, firstOrder.u) annotation (Line(points={{-119,10},{-110,10},
              {-102,10}}, color={0,0,127}));
      connect(source.p, G1.n) annotation (Line(points={{-40,0},{-40,-20},{0,-20},
              {0,0}}, color={0,0,255}));
      connect(source.p, ground.p)
        annotation (Line(points={{-40,0},{-40,0},{-40,-40}}, color={0,0,255}));
      connect(firstOrder.y, source.i) annotation (Line(points={{-79,10},{-65.5,
              10},{-47,10}}, color={0,0,127}));
      connect(B3.n, G4.p) annotation (Line(points={{120,34},{120,27},{120,20}},
            color={0,0,255}));
      connect(B2.n, G3.p)
        annotation (Line(points={{80,34},{80,27},{80,20}}, color={0,0,255}));
      connect(B1.n, G2.p)
        annotation (Line(points={{40,34},{40,27},{40,20}}, color={0,0,255}));
      connect(B1.p, B2.p) annotation (Line(points={{40,54},{40,66},{80,66},{80,
              54}}, color={0,0,255}));
      connect(B2.p, B3.p) annotation (Line(points={{80,54},{80,54},{80,66},{120,
              66},{120,54}}, color={0,0,255}));
      connect(source.n, B2.p) annotation (Line(points={{-40,20},{-40,66},{80,66},
              {80,54}}, color={0,0,255}));
      connect(source.n, G1.p) annotation (Line(points={{-40,20},{-40,20},{-40,
              66},{0,66},{0,20}}, color={0,0,255}));
      annotation (
        experiment(StopTime = 1, Tolerance = 1e-6),
        Icon(coordinateSystem(preserveAspectRatio=false)),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-200,-100},{200,100}},
            initialScale=0.1)));
    end BreakerNetworkDelayed_3_Scalar;

    model BreakerNetworkDelayed_3_Array
      "Network with three delayed breakers, array  implementation"
      extends Models.BreakerNetworkDelayed(N=3);
      annotation(experiment(StopTime = 1, Tolerance = 1e-6));
    end BreakerNetworkDelayed_3_Array;
  end Verification;

  package ScaledExperiments "Experiments with different scale factors"
    extends Modelica.Icons.ExamplesPackage;

    model BreakerNetwork_N_10
      extends Models.BreakerNetwork(N = 10);
      annotation(experiment(StopTime = 1, Tolerance = 1e-6));
    end BreakerNetwork_N_10;

    model BreakerNetwork_N_20
      extends Models.BreakerNetwork(N = 20);
      annotation(experiment(StopTime = 1, Tolerance = 1e-6));
    end BreakerNetwork_N_20;

    model BreakerNetwork_N_40
      extends Models.BreakerNetwork(N = 40);
      annotation(experiment(StopTime = 1, Tolerance = 1e-6));
    end BreakerNetwork_N_40;

    model BreakerNetwork_N_80
      extends Models.BreakerNetwork(N = 80);
      annotation(experiment(StopTime = 1, Tolerance = 1e-6));
    end BreakerNetwork_N_80;

    model BreakerNetwork_N_160
      extends Models.BreakerNetwork(N = 160);
      annotation(experiment(StopTime = 1, Tolerance = 1e-6));
    end BreakerNetwork_N_160;

    model BreakerNetwork_N_320
      extends Models.BreakerNetwork(N = 320);
      annotation(experiment(StopTime = 1, Tolerance = 1e-6));
    end BreakerNetwork_N_320;

    model BreakerNetwork_N_640
      extends Models.BreakerNetwork(N = 640);
      annotation(experiment(StopTime = 1, Tolerance = 1e-6));
    end BreakerNetwork_N_640;

    model BreakerNetwork_N_1280
      extends Models.BreakerNetwork(N = 1280);
      annotation(experiment(StopTime = 1, Tolerance = 1e-6));
    end BreakerNetwork_N_1280;

    model BreakerNetworkDelayed_N_10
      extends Models.BreakerNetworkDelayed(N = 10);
      annotation(experiment(StopTime = 10, Tolerance = 1e-6));
    end BreakerNetworkDelayed_N_10;

    model BreakerNetworkDelayed_N_20
      extends Models.BreakerNetworkDelayed(N = 20);
      annotation(experiment(StopTime = 10, Tolerance = 1e-6));
    end BreakerNetworkDelayed_N_20;

    model BreakerNetworkDelayed_N_40
      extends Models.BreakerNetworkDelayed(N = 40);
      annotation(experiment(StopTime = 10, Tolerance = 1e-6));
    end BreakerNetworkDelayed_N_40;

    model BreakerNetworkDelayed_N_80
      extends Models.BreakerNetworkDelayed(N = 80);
      annotation(experiment(StopTime = 10, Tolerance = 1e-6));
    end BreakerNetworkDelayed_N_80;

    model BreakerNetworkDelayed_N_160
      extends Models.BreakerNetworkDelayed(N = 160);
      annotation(experiment(StopTime = 10, Tolerance = 1e-6));
    end BreakerNetworkDelayed_N_160;

    model BreakerNetworkDelayed_N_320
      extends Models.BreakerNetworkDelayed(N = 320);
      annotation(experiment(StopTime = 10, Tolerance = 1e-6));
    end BreakerNetworkDelayed_N_320;

    model BreakerNetworkDelayed_N_640
      extends Models.BreakerNetworkDelayed(N = 640);
      annotation(experiment(StopTime = 10, Tolerance = 1e-6));
    end BreakerNetworkDelayed_N_640;

    model BreakerNetworkDelayed_N_1280
      extends Models.BreakerNetworkDelayed(N = 1280);
      annotation(experiment(StopTime = 10, Tolerance = 1e-6));
    end BreakerNetworkDelayed_N_1280;

  end ScaledExperiments;
  annotation (uses(Modelica(version="3.2.1")));
end BreakerCircuits;
