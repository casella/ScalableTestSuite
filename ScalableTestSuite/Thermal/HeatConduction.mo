within ScalableTestSuite.Thermal;
package HeatConduction "Models of 1-D heat conduction in solids"
  package Models
    model OneDHeatTransferTI_FD
      "One end at a fixed temperature, one end is insulated; implemented by FD method"
      import SIunits =
             Modelica.Units.SI;
      parameter SIunits.Length L "Length";
      parameter Integer N = 2 "number of nodes";
      parameter SIunits.Temperature T0 "Initial temperature";
      parameter SIunits.Temperature TN "Temperature at the last node";
      parameter SIunits.SpecificHeatCapacity cp "Material Heat Capacity";
      parameter SIunits.ThermalConductivity lambda
        "Material thermal conductivity";
      parameter Modelica.Units.SI.Density rho "Material Density";
      final parameter Modelica.Units.SI.Length dx=L/(N - 1) "Element length";
      SIunits.Temperature T[N] "temperature of the nodes";
    initial equation
      for i in 1:N - 1 loop
        T[i] = T0;
      end for;
    equation
      T[N] = TN;
      for i in 2:N - 1 loop
        der(T[i]) = lambda * ((T[i + 1] - T[i]) / dx + ((-T[i]) + T[i - 1]) / dx) / cp / rho / dx;
      end for;
      der(T[1]) = lambda * ((T[2] - T[1]) / dx) / cp / rho / dx;
      annotation(Documentation(info = "<html><p><img src=\"modelica://ScalableTestSuite/Resources/Images/HeatConduction/uniformrod.png\"/></p>A uniform rod has the length L, density ρ, specific heat capacity cp and thermal conductivity λ which are all assumed to be constant. Moreover, the sides of the rod are assumed to be insulated. In HeatConductionTI, one end is exposed to a fixed temperature while the other end is insulated. We considered a small portion of the rod which has a width of dx from a distance x, and by considering the conservation of energy the equations are defined. According to the conservation of energy, difference between the heat in from left boundary and heat out from the right boundary has to be equal to the heat change at the portion at Δx in time Δt.</p><p>The discretized equations are described in the following form:</p><img src=\"modelica://ScalableTestSuite/Resources/Images/HeatConduction/HeatConductionEq.png\"/><p>where i = 2,..,N−1 and they correspond to the temperature nodes along the rod excluding the temperature variables at the ends. In HeatConductionTI, TN has a constant temperature value and T1 is insulated. T1 has a boundary condition defined as:</p><img src=\"modelica://ScalableTestSuite/Resources/Images/HeatConduction/T1boundary.png\"/><p>The parameters for HeatConductionTI_FD are:</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Parameters</th>
      <th>Comment</th>
    </tr>
                <tr>
      <td valign=\"top\">L</td>
      <td valign=\"top\">Length of the rod</td>
    </tr>
                <tr>
      <td valign=\"top\">N</td>
      <td valign=\"top\">number of nodes</td>
    </tr>
   <tr>
      <td valign=\"top\">T0</td>
      <td valign=\"top\">Initial temperature</td>
    </tr>
    <tr>
      <td valign=\"top\">TN</td>
      <td valign=\"top\">temperature at the last node</td>
    </tr>
    <tr>
      <td valign=\"top\">cp</td>
      <td valign=\"top\">material specific heat capacity</td>
    </tr>
                <tr>
      <td valign=\"top\">lambda</td>
      <td valign=\"top\">material thermal conductivity</td>
    </tr>
                <tr>
      <td valign=\"top\">rho</td>
      <td valign=\"top\">material density</td>
    </tr>
                <tr>
      <td valign=\"top\">dx</td>
      <td valign=\"top\">element length</td>
    </tr>
</table>
</html>"));
    end OneDHeatTransferTI_FD;

    model OneDHeatTransferTI_Modelica
      "one end at a fixed temperature, one end is insulated; implemented by MSL"
      import SIunits =
             Modelica.Units.SI;
      import Modelica.Thermal;
      parameter SIunits.Length L "Length";
      parameter Integer N = 2 "Number of nodes";
      parameter SIunits.SpecificHeatCapacity cp "Material Heat Capacity";
      parameter SIunits.Density rho "Material Density";
      final parameter SIunits.Mass m = rho * v "mass";
      final parameter SIunits.Volume v = L * A "volume of the rod";
      parameter SIunits.ThermalConductivity lambda
        "Material thermal conductivity";
      parameter SIunits.Area A "Area";
      parameter SIunits.Temperature T0
        "Initial temperature of the heatcapacitors";
      parameter SIunits.Temperature TN "fixed temperature at the last node";
      Thermal.HeatTransfer.Sources.FixedTemperature fixedtemperature(T = TN)
        "fixed temperature at the last node";
      Thermal.HeatTransfer.Components.ThermalConductor thermalconductor[N - 1](each G = lambda * A / (L / (N - 1)))
        "thermal conductors";
      Thermal.HeatTransfer.Components.HeatCapacitor heatcapacitor[N - 1](each C = cp * m / (N - 1))
        "heat capacitors";
    initial equation
      for i in 1:N - 1 loop
        heatcapacitor[i].T = T0;
      end for;
    equation
      connect(fixedtemperature.port, thermalconductor[N - 1].port_b);
      connect(thermalconductor[N - 1].port_a, heatcapacitor[N - 1].port);
      for i in 1:N - 2 loop
        connect(heatcapacitor[i].port, thermalconductor[i].port_a);
        connect(thermalconductor[i].port_b, heatcapacitor[i + 1].port);
      end for;
      annotation(Documentation(info = "<html><p><img src=\"modelica://ScalableTestSuite/Resources/Images/HeatConduction/heatConductionModelica.png\"/></p>A HeatConductionTI model with N=4 nodes is shown above, in the same manner a larger model can be created. In the model, at each heat capacitor, a capacitance is defined which varies according to the mass. Moreover, between each heat capacitor a thermal conductor is placed which transports the heat without storing it.</p><p>For the each thermal conductor element, the conductance for a box geometry under the assumption that the heat flows along the box length is calculated as follows: G = lambda * A / (L / (N - 1)). Heat capacity of the heat capacitors is calculated as follows: C = cp * m / (N - 1)  </p><p>The parameters for HeatConductionTI_Modelica are:</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Parameters</th>
      <th>Comment</th>
    </tr>
                <tr>
      <td valign=\"top\">L</td>
      <td valign=\"top\">length of the rod</td>
    </tr>
                <tr>
      <td valign=\"top\">N</td>
      <td valign=\"top\">number of nodes</td>
    </tr>
    <tr>
      <td valign=\"top\">cp</td>
      <td valign=\"top\">material specific heat capacity</td>
    </tr>
                <tr>
      <td valign=\"top\">rho</td>
      <td valign=\"top\">material density</td>
    </tr>
                <tr>
      <td valign=\"top\">m</td>
      <td valign=\"top\">mass of the rod</td>
    </tr>
                <tr>
      <td valign=\"top\">v</td>
      <td valign=\"top\">volume of the rod</td>
    </tr>
                <tr>
      <td valign=\"top\">lambda</td>
      <td valign=\"top\">material thermal conductivity</td>
    </tr>
                <tr>
      <td valign=\"top\">A</td>
      <td valign=\"top\">cross section area of the rod</td>
    </tr>
                <tr>
      <td valign=\"top\">T0</td>
      <td valign=\"top\">Initial temperature</td>
    </tr>
    <tr>
      <td valign=\"top\">TN</td>
      <td valign=\"top\">temperature at the last node</td>
    </tr>
</table>
</html>"));
    end OneDHeatTransferTI_Modelica;

    model OneDHeatTransferTT_FD
      "Both ends are exposed to a fixed temperature, implemented by FD method"
      import SIunits =
             Modelica.Units.SI;
      parameter SIunits.Length L "length";
      parameter Integer N = 2 "number of nodes";
      parameter SIunits.Temperature T0 "Initial temperature";
      parameter SIunits.Temperature T1 "Initial temperature at first node";
      parameter SIunits.Temperature TN "Initial temperature at the last node";
      parameter SIunits.SpecificHeatCapacity cp "Material Heat Capacity";
      parameter SIunits.ThermalConductivity lambda
        "Material thermal conductivity";
      parameter SIunits.Density rho "Material Density";
      final parameter Modelica.Units.SI.Length dx=L/(N - 1) "Element length";
      SIunits.Temperature T[N] "temperature of the nodes";
    initial equation
      for i in 2:N - 1 loop
        T[i] = T0;
      end for;
    equation
      T[1] = T1;
      T[N] = TN;
      for i in 2:N - 1 loop
        der(T[i]) = lambda * ((T[i - 1] - T[i]) / dx + ((-T[i]) + T[i + 1]) / dx) / cp / rho / dx;
      end for;
      annotation(Documentation(info = "<html><p><img src=\"modelica://ScalableTestSuite/Resources/Images/HeatConduction/uniformrod.png\"/></p>A uniform rod has the length L, density ρ, specific heat capacity cp and thermal conductivity λ which are all assumed to be constant. Moreover, the sides of the rod are assumed to be insulated. In HeatConductionTT, both ends are exposed to a fixed temperature. We considered a small portion of the rod which has a width of dx from a distance x, and by considering the conservation of energy the equations are defined. According to the conservation of energy, difference between the heat in from left boundary and heat out from the right boundary has to be equal to the heat change at the portion at Δx in time Δt.</p><p>The discretized equations are described in the following form:</p><img src=\"modelica://ScalableTestSuite/Resources/Images/HeatConduction/HeatConductionEq.png\"/><p>where i = 2,..,N−1 and they correspond to the temperature nodes along the rod excluding the temperature variables at the ends. In HeatConductionTT, T1 and TN have constant temperature values.</p><p>The parameters for HeatConductionTT_FD are:</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Parameters</th>
      <th>Comment</th>
    </tr>
                <tr>
      <td valign=\"top\">L</td>
      <td valign=\"top\">Length of the rod</td>
    </tr>
                <tr>
      <td valign=\"top\">N</td>
      <td valign=\"top\">number of nodes</td>
    </tr>
   <tr>
      <td valign=\"top\">T0</td>
      <td valign=\"top\">Initial temperature</td>
    </tr>
    <tr>
      <td valign=\"top\">T1</td>
      <td valign=\"top\">temperature at the first node</td>
    </tr>
                <tr>
      <td valign=\"top\">TN</td>
      <td valign=\"top\">temperature at the last node</td>
    </tr>
    <tr>
      <td valign=\"top\">cp</td>
      <td valign=\"top\">material specific heat capacity</td>
    </tr>
                <tr>
      <td valign=\"top\">lambda</td>
      <td valign=\"top\">material thermal conductivity</td>
    </tr>
                <tr>
      <td valign=\"top\">rho</td>
      <td valign=\"top\">material density</td>
    </tr>
                <tr>
      <td valign=\"top\">dx</td>
      <td valign=\"top\">element length</td>
    </tr>
</table>
</html>"));
    end OneDHeatTransferTT_FD;

    model OneDHeatTransferTT_Modelica
      "both ends at a fixed temperature implemented by MSL"
      import SIunits =
             Modelica.Units.SI;
      import Modelica.Thermal;
      parameter SIunits.Length L "Length";
      parameter Integer N = 3 "Number of nodes";
      parameter SIunits.SpecificHeatCapacity cp "Material Heat Capacity";
      parameter Modelica.Units.SI.Density rho "Material Density";
      parameter SIunits.Area A "area";
      final parameter SIunits.Mass m = rho * v "Mass";
      final parameter SIunits.Volume v = L * A;
      parameter SIunits.ThermalConductivity lambda
        "Material thermal conductivity";
      parameter SIunits.Temperature T0
        "Initial temperature of the heat capacitors";
      parameter SIunits.Temperature T1 "fixed temperature at the first node";
      parameter SIunits.Temperature TN "fixed temperature at the last node";
      Thermal.HeatTransfer.Sources.FixedTemperature fixedtemperature1(T = T1)
        "fixed temperature at the first node";
      Thermal.HeatTransfer.Sources.FixedTemperature fixedtemperatureN(T = TN)
        "fixed temperature at the last node";
      Thermal.HeatTransfer.Components.ThermalConductor thermalconductor[N - 1](each G = lambda * A / (L / (N - 1)))
        "thermal conductors";
      Thermal.HeatTransfer.Components.HeatCapacitor heatcapacitor[N - 2](each C = cp * m / (N - 2))
        "heat capacitors";
    initial equation
      for i in 1:N - 2 loop
        heatcapacitor[i].T = T0;
      end for;
    equation
      connect(fixedtemperature1.port, thermalconductor[1].port_a);
      connect(thermalconductor[1].port_b, heatcapacitor[1].port);
      connect(heatcapacitor[N - 2].port, thermalconductor[N - 1].port_a);
      connect(thermalconductor[N - 1].port_b, fixedtemperatureN.port);
      for i in 1:N - 3 loop
        connect(thermalconductor[i + 1].port_a, heatcapacitor[i].port);
        connect(thermalconductor[i + 1].port_b, heatcapacitor[i + 1].port);
      end for;
      annotation(Documentation(info = "<html><p><img src=\"modelica://ScalableTestSuite/Resources/Images/HeatConduction/HeatConductionTT.png\"/></p>A HeatConductionTT model with N=5 nodes is shown above, in the same manner a larger model can be created. In the model, at each heat capacitor, a capacitance is defined which varies according to the mass. Moreover, between each heat capacitor a thermal conductor is placed which transports the heat without storing it.</p><p>For the each thermal conductor element, the conductance for a box geometry under the assumption that the heat flows along the box length is calculated as follows: G = lambda * A / (L / (N - 1)). Heat capacity of the heat capacitors is calculated as follows: C = cp * m / (N - 2)  </p><p>The parameters for HeatConductionTT_Modelica are:</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Parameters</th>
      <th>Comment</th>
    </tr>
                <tr>
      <td valign=\"top\">L</td>
      <td valign=\"top\">length of the rod</td>
    </tr>
                <tr>
      <td valign=\"top\">N</td>
      <td valign=\"top\">number of nodes</td>
    </tr>
    <tr>
      <td valign=\"top\">cp</td>
      <td valign=\"top\">material specific heat capacity</td>
    </tr>
                <tr>
      <td valign=\"top\">rho</td>
      <td valign=\"top\">material density</td>
    </tr>
                <tr>
      <td valign=\"top\">A</td>
      <td valign=\"top\">cross section area of the rod</td>
    </tr>
                <tr>
      <td valign=\"top\">m</td>
      <td valign=\"top\">mass of the rod</td>
    </tr>
                <tr>
      <td valign=\"top\">v</td>
      <td valign=\"top\">volume of the rod</td>
    </tr>
                <tr>
      <td valign=\"top\">lambda</td>
      <td valign=\"top\">material thermal conductivity</td>
    </tr>
                <tr>
      <td valign=\"top\">T0</td>
      <td valign=\"top\">Initial temperature of the heat capacitors</td>
    </tr>
                <tr>
      <td valign=\"top\">T1</td>
      <td valign=\"top\">fixed temperature at the first node</td>
    </tr>
    <tr>
      <td valign=\"top\">TN</td>
      <td valign=\"top\">fixed temperature at the last node</td>
    </tr>
</table>
</html>"));
    end OneDHeatTransferTT_Modelica;
  end Models;

  package Verification
    model OneDHeatTransferTI_Check "analytical solution for TI models"
      import SIunits =
             Modelica.Units.SI;
      parameter SIunits.Length L = 0.2 "Length of the rod";
      parameter Integer N = 30 "Number of nodes";
      parameter SIunits.Temperature TN = 330
        "Fixed temperature at the last node";
      parameter SIunits.Temperature T0 = 273.15 "Initial temperature";
      parameter SIunits.SpecificHeatCapacity cp = 910 "Material Heat Capacity";
      parameter SIunits.ThermalConductivity lambda = 237
        "Material thermal conductivity";
      parameter SIunits.Density rho = 2712 "Material Density";
      parameter SIunits.Area A = 0.05 "cross section area";

      function f
        input Real t "Time";
        input Real x "a point between 0 and l";
        input Real a "a=lambda/cp/rho";
        input Real l "length";
        input Real T_l "fixed temperature at x=l";
        input Real TK "initial temperature along rod";
        input Integer Nu = 200 "number of iterations";
        output Real y "output temperature";
      protected
        constant Real pi = Modelica.Constants.pi;
      algorithm
        y := 0;
        for n in 0:Nu loop
          y := y + 4 * T_l / pi * ((-1) ^ (n + 1) / (2 * n + 1)) * cos(pi * (2 * n + 1) * x / (2 * l)) * exp(-a * pi ^ 2 * (2 * n + 1) ^ 2 * t / (4 * l ^ 2)) + TK * (2 / l) * cos(pi * (2 * n + 1) * x / (2 * l)) * (2 * l / (pi * (2 * n + 1))) * sin((2 * n + 1) * pi / 2) * exp(-a * pi ^ 2 * t * (2 * n + 1) ^ 2 / (4 * l ^ 2));
        end for;
        y := T_l + y;
      end f;

      Modelica.Units.SI.Temperature T_mid_exact;
      Modelica.Units.SI.Temperature T_mid_numerical;
      Modelica.Units.SI.Temperature T_mid_modelica;
      Models.OneDHeatTransferTI_FD example(L = L, N = N, T0 = T0, TN = TN, cp = cp, lambda = lambda, rho = rho);
      Models.OneDHeatTransferTI_Modelica example2(L = L, N = N, cp = cp, rho = rho, lambda = lambda, A = A, T0 = T0, TN = TN);
    equation
      T_mid_exact = f(time, L / 2, lambda / rho / cp, L, TN, T0);
      T_mid_numerical = example.T[div(N, 2)];
      T_mid_modelica = example2.heatcapacitor[div(N + 1, 2)].T;
      annotation(experiment(StopTime = 1500, Tolerance = 1e-6), Documentation(info = "<html>In the verification of OneDHeatTransferTI_FD and OneDHeatTransferTI_Modelica, mid-nodes of the models are selected, and verified by the analytical solution. The temperature at the middle of the model implemented by analytical solution, the temperature at the mid-node of the model implemented by equations and the temperature of the heat capacitor at the middle of the model implemented by Modelica.Thermal library, are compared. <p>Analytical solutions are based on the solutions in “Handbook of Linear Partial Differential Equations for Engineers and Scientists” by Andrei D. Polyanin. If we consider one dimensional partial differential heat equation in the form:</p> <p><img src=\"modelica://ScalableTestSuite/Resources/Images/HeatConduction/PDE.png\"/></p>In HeatConductionTI models, one end of the rod is exposed to a fixed temperature while the other end is insulated. At the insulated end, heat flux is zero therefore derivative of the temperature will be zero.
The following conditions are prescribed for the model:<p><img src=\"modelica://ScalableTestSuite/Resources/Images/HeatConduction/boundaryTI.png\"/></p>Solution:<p><img src=\"modelica://ScalableTestSuite/Resources/Images/HeatConduction/solutionTI.png\"/></p>where:<p><img src=\"modelica://ScalableTestSuite/Resources/Images/HeatConduction/greenfunction.png\"/></p><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Parameters</th>
      <th>Comment</th>
    </tr>
		<tr>
      <td valign=\"top\">L</td>
      <td valign=\"top\">length of the rod</td>
    </tr>
		<tr>
      <td valign=\"top\">N</td>
      <td valign=\"top\">number of nodes</td>
    </tr>
		<tr>
      <td valign=\"top\">TN</td>
      <td valign=\"top\">fixed temperature at the last node</td>
    </tr>
		<tr>
      <td valign=\"top\">T0</td>
      <td valign=\"top\">Initial temperature of the heat capacitors</td>
    </tr>
    <tr>
      <td valign=\"top\">cp</td>
      <td valign=\"top\">material specific heat capacity</td>
    </tr>
		<tr>
      <td valign=\"top\">lambda</td>
      <td valign=\"top\">material thermal conductivity</td>
    </tr>
		<tr>
      <td valign=\"top\">rho</td>
      <td valign=\"top\">material density</td>
    </tr>
		<tr>
      <td valign=\"top\">A</td>
      <td valign=\"top\">cross section area of the rod</td>
    </tr>
</table>
</html>"));
    end OneDHeatTransferTI_Check;

    model OneDHeatTransferTT_Check "analytical solution for TT models"
      import SIunits =
             Modelica.Units.SI;
      parameter SIunits.Length L = 0.2 "Length of the rod";
      parameter Integer N = 30 "Number of nodes";
      parameter SIunits.Temperature T0 = 273.15 "Initial temperature";
      parameter SIunits.Temperature T1 = 330 "Fixed temperature at first node";
      parameter SIunits.Temperature TN = 300
        "Fixed temperature at the last node";
      parameter SIunits.SpecificHeatCapacity cp = 910 "Material Heat Capacity";
      parameter SIunits.ThermalConductivity lambda = 237
        "Material thermal conductivity";
      parameter SIunits.Area A = 0.05 "Area";
      parameter Modelica.Units.SI.Density rho=2712 "Material Density";

      function f
        input Real t "Time";
        input Real x "a point between 0 and l";
        input Real a "a=lambda/cp/rho";
        input Real l "length";
        input Real T_0 "fixed temperature at x=0";
        input Real T_l "fixed temperature at x=l";
        input Real TK "initial temperature along rod";
        input Integer Nu = 200 "number of iterations";
        output Real y "output temperature";
      protected
        constant Real pi = Modelica.Constants.pi;
      algorithm
        y := 0;
        for n in 1:Nu loop
          y := y + 2 / n / pi * ((-TK * (cos(n * pi) - 1)) - (T_0 - (-1) ^ n * T_l)) * sin(n * pi * x / l) * exp(-a * n ^ 2 * pi ^ 2 * t / l ^ 2);
        end for;
        y := T_0 + (T_l - T_0) * x / l + y;
      end f;

      Modelica.Units.SI.Temperature T_mid_exact
        "Temperature value that function returns";
      Modelica.Units.SI.Temperature T_mid_numerical
        "Temperature value that discretized equation returns";
      Modelica.Units.SI.Temperature T_mid_modelica
        "Temperature value that heat capacitor returns";
      Models.OneDHeatTransferTT_FD example(L = L, N = N, T0 = T0, T1 = T1, TN = TN, cp = cp, lambda = lambda, rho = rho);
      Models.OneDHeatTransferTT_Modelica example2(L = L, N = N, cp = cp, rho = rho, A = A, lambda = lambda, T0 = T0, T1 = T1, TN = TN);
    equation
      T_mid_exact = f(time, L / 2, lambda / cp / rho, L, T1, TN, T0, N);
      T_mid_numerical = example.T[div(N, 2)];
      T_mid_modelica = example2.heatcapacitor[div(N - 2, 2)].T;
      annotation(experiment(StopTime = 350, Tolerance = 1e-6), Documentation(info = "<html>In the verification of OneDHeatTransferTT_FD and OneDHeatTransferTT_Modelica, mid-nodes of the models are selected, and verified by the analytical solution. The temperature at the middle of the model implemented by analytical solution, the temperature at the mid-node of the model implemented by equations and the temperature of the heat capacitor at the middle of the model implemented by Modelica.Thermal library, are compared. <p>Analytical solutions are based on the solutions in “Handbook of Linear Partial Differential Equations for Engineers and Scientists” by Andrei D. Polyanin. If we consider one dimensional partial differential heat equation in the form:</p> <p><img src=\"modelica://ScalableTestSuite/Resources/Images/HeatConduction/PDE.png\"/></p>In HeatConductionTT, the ends are maintained at fixed temperatures. Therefore, the following conditions are prescribed:<p><img src=\"modelica://ScalableTestSuite/Resources/Images/HeatConduction/boundaryTT.png\"/></p>Solution:<p><img src=\"modelica://ScalableTestSuite/Resources/Images/HeatConduction/solutionTT.png\"/></p>where where Rn(t) can be written according to our boundary conditions:<p><img src=\"modelica://ScalableTestSuite/Resources/Images/HeatConduction/Rn.png\"/></p><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Parameters</th>
      <th>Comment</th>
    </tr>
		<tr>
      <td valign=\"top\">L</td>
      <td valign=\"top\">length of the rod</td>
    </tr>
		<tr>
      <td valign=\"top\">N</td>
      <td valign=\"top\">number of nodes</td>
    </tr>
		<tr>
      <td valign=\"top\">T0</td>
      <td valign=\"top\">Initial temperature of the heat capacitors</td>
    </tr>
		<tr>
      <td valign=\"top\">T1</td>
      <td valign=\"top\">fixed temperature at the first node</td>
    </tr>
		<tr>
      <td valign=\"top\">TN</td>
      <td valign=\"top\">fixed temperature at the last node</td>
    </tr>
    <tr>
      <td valign=\"top\">cp</td>
      <td valign=\"top\">material specific heat capacity</td>
    </tr>
		<tr>
      <td valign=\"top\">lambda</td>
      <td valign=\"top\">material thermal conductivity</td>
    </tr>
		<tr>
      <td valign=\"top\">rho</td>
      <td valign=\"top\">material density</td>
    </tr>
		<tr>
      <td valign=\"top\">A</td>
      <td valign=\"top\">cross section area of the rod</td>
    </tr>
</table>
</html>"));
    end OneDHeatTransferTT_Check;
  end Verification;

  package ScaledExperiments
    extends Modelica.Icons.ExamplesPackage;

    model OneDHeatTransferTT_FD_N_10
      extends Models.OneDHeatTransferTT_FD(L = 0.2, N = 10, T0 = 273.15, T1 = 330, TN = 300, cp = 910, lambda = 237, rho = 2712);
      annotation(experiment(StopTime = 350, Tolerance = 1e-6));
    end OneDHeatTransferTT_FD_N_10;

    model OneDHeatTransferTT_FD_N_20
      extends OneDHeatTransferTT_FD_N_10(N = 20);
      annotation(experiment(StopTime = 350, Tolerance = 1e-6));
    end OneDHeatTransferTT_FD_N_20;

    model OneDHeatTransferTT_FD_N_40
      extends OneDHeatTransferTT_FD_N_10(N = 40);
      annotation(experiment(StopTime = 350, Tolerance = 1e-6));
    end OneDHeatTransferTT_FD_N_40;

    model OneDHeatTransferTT_FD_N_80
      extends OneDHeatTransferTT_FD_N_10(N = 80);
      annotation(experiment(StopTime = 350, Tolerance = 1e-6));
    end OneDHeatTransferTT_FD_N_80;

    model OneDHeatTransferTT_FD_N_160
      extends OneDHeatTransferTT_FD_N_10(N = 160);
      annotation(experiment(StopTime = 350, Tolerance = 1e-6));
    end OneDHeatTransferTT_FD_N_160;

    model OneDHeatTransferTT_FD_N_320
      extends OneDHeatTransferTT_FD_N_10(N = 320);
      annotation(experiment(StopTime = 350, Tolerance = 1e-6));
    end OneDHeatTransferTT_FD_N_320;

    model OneDHeatTransferTT_FD_N_640
      extends OneDHeatTransferTT_FD_N_10(N = 640);
      annotation(experiment(StopTime = 350, Tolerance = 1e-6));
    end OneDHeatTransferTT_FD_N_640;

    model OneDHeatTransferTT_FD_N_1280
      extends OneDHeatTransferTT_FD_N_10(N = 1280);
      annotation(experiment(StopTime = 350, Tolerance = 1e-6));
    end OneDHeatTransferTT_FD_N_1280;

    model OneDHeatTransferTT_Modelica_N_10
      extends Models.OneDHeatTransferTT_Modelica(L = 0.2, N = 10, cp = 910, rho = 2712, A = 0.05, lambda = 237, T0 = 273.15, T1 = 330, TN = 300);
      annotation(experiment(StopTime = 350, Tolerance = 1e-6));
    end OneDHeatTransferTT_Modelica_N_10;

    model OneDHeatTransferTT_Modelica_N_20
      extends OneDHeatTransferTT_Modelica_N_10(N = 20);
      annotation(experiment(StopTime = 350, Tolerance = 1e-6));
    end OneDHeatTransferTT_Modelica_N_20;

    model OneDHeatTransferTT_Modelica_N_40
      extends OneDHeatTransferTT_Modelica_N_10(N = 40);
      annotation(experiment(StopTime = 350, Tolerance = 1e-6));
    end OneDHeatTransferTT_Modelica_N_40;

    model OneDHeatTransferTT_Modelica_N_80
      extends OneDHeatTransferTT_Modelica_N_10(N = 80);
      annotation(experiment(StopTime = 350, Tolerance = 1e-6));
    end OneDHeatTransferTT_Modelica_N_80;

    model OneDHeatTransferTT_Modelica_N_160
      extends OneDHeatTransferTT_Modelica_N_10(N = 160);
      annotation(experiment(StopTime = 350, Tolerance = 1e-6));
    end OneDHeatTransferTT_Modelica_N_160;

    model OneDHeatTransferTT_Modelica_N_320
      extends OneDHeatTransferTT_Modelica_N_10(N = 320);
      annotation(experiment(StopTime = 350, Tolerance = 1e-6));
    end OneDHeatTransferTT_Modelica_N_320;

    model OneDHeatTransferTT_Modelica_N_640
      extends OneDHeatTransferTT_Modelica_N_10(N = 640);
      annotation(experiment(StopTime = 350, Tolerance = 1e-6));
    end OneDHeatTransferTT_Modelica_N_640;

    model OneDHeatTransferTT_Modelica_N_1280
      extends OneDHeatTransferTT_Modelica_N_10(N = 1280);
      annotation(experiment(StopTime = 350, Tolerance = 1e-6));
    end OneDHeatTransferTT_Modelica_N_1280;

    model OneDHeatTransferTI_FD_N_10
      extends Models.OneDHeatTransferTI_FD(L = 0.2, N = 10, T0 = 273.15, TN = 330, cp = 910, lambda = 237, rho = 2712);
      annotation(experiment(StopTime = 1500, Tolerance = 1e-6));
    end OneDHeatTransferTI_FD_N_10;

    model OneDHeatTransferTI_FD_N_20
      extends OneDHeatTransferTI_FD_N_10(N = 20);
      annotation(experiment(StopTime = 1500, Tolerance = 1e-6));
    end OneDHeatTransferTI_FD_N_20;

    model OneDHeatTransferTI_FD_N_40
      extends OneDHeatTransferTI_FD_N_10(N = 40);
      annotation(experiment(StopTime = 1500, Tolerance = 1e-6));
    end OneDHeatTransferTI_FD_N_40;

    model OneDHeatTransferTI_FD_N_80
      extends OneDHeatTransferTI_FD_N_10(N = 80);
      annotation(experiment(StopTime = 1500, Tolerance = 1e-6));
    end OneDHeatTransferTI_FD_N_80;

    model OneDHeatTransferTI_FD_N_160
      extends OneDHeatTransferTI_FD_N_10(N = 160);
      annotation(experiment(StopTime = 1500, Tolerance = 1e-6));
    end OneDHeatTransferTI_FD_N_160;

    model OneDHeatTransferTI_FD_N_320
      extends OneDHeatTransferTI_FD_N_10(N = 320);
      annotation(experiment(StopTime = 1500, Tolerance = 1e-6));
    end OneDHeatTransferTI_FD_N_320;

    model OneDHeatTransferTI_FD_N_640
      extends OneDHeatTransferTI_FD_N_10(N = 640);
      annotation(experiment(StopTime = 1500, Tolerance = 1e-6));
    end OneDHeatTransferTI_FD_N_640;

    model OneDHeatTransferTI_FD_N_1280
      extends OneDHeatTransferTI_FD_N_10(N = 1280);
      annotation(experiment(StopTime = 1500, Tolerance = 1e-6));
    end OneDHeatTransferTI_FD_N_1280;

    model OneDHeatTransferTI_Modelica_N_10
      extends Models.OneDHeatTransferTI_Modelica(L = 0.2, N = 10, cp = 910, rho = 2712, lambda = 237, A = 0.05, T0 = 273.15, TN = 330);
      annotation(experiment(StopTime = 1500, Tolerance = 1e-6));
    end OneDHeatTransferTI_Modelica_N_10;

    model OneDHeatTransferTI_Modelica_N_20
      extends OneDHeatTransferTI_Modelica_N_10(N = 20);
      annotation(experiment(StopTime = 1500, Tolerance = 1e-6));
    end OneDHeatTransferTI_Modelica_N_20;

    model OneDHeatTransferTI_Modelica_N_40
      extends OneDHeatTransferTI_Modelica_N_10(N = 40);
      annotation(experiment(StopTime = 1500, Tolerance = 1e-6));
    end OneDHeatTransferTI_Modelica_N_40;

    model OneDHeatTransferTI_Modelica_N_80
      extends OneDHeatTransferTI_Modelica_N_10(N = 80);
      annotation(experiment(StopTime = 1500, Tolerance = 1e-6));
    end OneDHeatTransferTI_Modelica_N_80;

    model OneDHeatTransferTI_Modelica_N_160
      extends OneDHeatTransferTI_Modelica_N_10(N = 160);
      annotation(experiment(StopTime = 1500, Tolerance = 1e-6));
    end OneDHeatTransferTI_Modelica_N_160;

    model OneDHeatTransferTI_Modelica_N_320
      extends OneDHeatTransferTI_Modelica_N_10(N = 320);
      annotation(experiment(StopTime = 1500, Tolerance = 1e-6));
    end OneDHeatTransferTI_Modelica_N_320;

    model OneDHeatTransferTI_Modelica_N_640
      extends OneDHeatTransferTI_Modelica_N_10(N = 640);
      annotation(experiment(StopTime = 1500, Tolerance = 1e-6));
    end OneDHeatTransferTI_Modelica_N_640;

    model OneDHeatTransferTI_Modelica_N_1280
      extends OneDHeatTransferTI_Modelica_N_10(N = 1280);
      annotation(experiment(StopTime = 1500, Tolerance = 1e-6));
    end OneDHeatTransferTI_Modelica_N_1280;
    annotation(Documentation(info = "<html><p>In this package there are 32 tests for different N values; 8 for the OneDHeatTransferTT_FD, 8 for the OneDHeatTransferTT_Modelica, 8 for the OneDHeatTransferTI_FD and 8 for the OneDHeatTransferTI_Modelica.</p><p> The tests for the models are performed according to the N values as shown in the table below:</p><table border=\"1\">
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
</table><p>Parameter values for OneDHeatTransferTT models:</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Parameters</th>
      <th>Comment</th>
    </tr>
                <tr>
      <td valign=\"top\">L</td>
      <td valign=\"top\">0.2</td>
    </tr>
                <tr>
      <td valign=\"top\">N</td>
      <td valign=\"top\">10,20,40,80,160,320,640,1280</td>
    </tr>
   <tr>
      <td valign=\"top\">T0</td>
      <td valign=\"top\">273.15</td>
    </tr>
    <tr>
      <td valign=\"top\">T1</td>
      <td valign=\"top\">330</td>
    </tr>
    <tr>
      <td valign=\"top\">TN</td>
      <td valign=\"top\">330</td>
    </tr>
                <tr>
      <td valign=\"top\">cp</td>
      <td valign=\"top\">910</td>
    </tr>
                <tr>
      <td valign=\"top\">lambda</td>
      <td valign=\"top\">237</td>
    </tr>
                <tr>
      <td valign=\"top\">rho</td>
      <td valign=\"top\">2712</td>
    </tr>
</table><p>Parameter values for OneDHeatTransferTI models:</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Parameters</th>
      <th>Comment</th>
    </tr>
                <tr>
      <td valign=\"top\">L</td>
      <td valign=\"top\">0.2</td>
    </tr>
                <tr>
      <td valign=\"top\">N</td>
      <td valign=\"top\">10,20,40,80,160,320,640,1280</td>
    </tr>
   <tr>
      <td valign=\"top\">T0</td>
      <td valign=\"top\">273.15</td>
    </tr>
    <tr>
      <td valign=\"top\">TN</td>
      <td valign=\"top\">330</td>
    </tr>
                <tr>
      <td valign=\"top\">cp</td>
      <td valign=\"top\">910</td>
    </tr>
                <tr>
      <td valign=\"top\">lambda</td>
      <td valign=\"top\">237</td>
    </tr>
                <tr>
      <td valign=\"top\">rho</td>
      <td valign=\"top\">2712</td>
    </tr>
</table></html>"));
  end ScaledExperiments;
end HeatConduction;
