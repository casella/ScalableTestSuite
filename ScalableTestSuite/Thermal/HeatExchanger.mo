within ScalableTestSuite.Thermal;
package HeatExchanger "Models of heat exchangers"
  package Models
    model CounterCurrentHeatExchangerEquations
      "countercurrent heat exchanger implemented by equations"
      import Modelica.SIunits;
      parameter SIunits.Length L "length of the channels";
      parameter Integer N "number of nodes";
      parameter SIunits.MassFlowRate wB "mass flow rate of fluid B";
      parameter SIunits.Area areaA "cross sectional area of channel A";
      parameter SIunits.Area areaB "cross sectional area of channel B";
      parameter SIunits.Density rhoA "density of fluid A";
      parameter SIunits.Density rhoB "density of fluid B";
      parameter SIunits.SpecificHeatCapacity cpA
        "specific heat capacity of fluid A";
      parameter SIunits.SpecificHeatCapacity cpB
        "specific heat capacity of fluid B";
      parameter SIunits.SpecificHeatCapacity cpW
        "specific heat capacity of the wall";
      parameter SIunits.CoefficientOfHeatTransfer gammaA
        "heat transfer coefficient of fluid A";
      parameter SIunits.CoefficientOfHeatTransfer gammaB
        "heat transfer coefficient of fluid B";
      parameter SIunits.Length omega "perimeter";
      final parameter SIunits.Length l = L / (N - 1)
        "length of the each wall segment";
      SIunits.MassFlowRate wA "mass flow rate of fluid A";
      SIunits.HeatFlowRate QA[N - 1]
        "heat flow rate of fluid A in the segments";
      SIunits.HeatFlowRate QB[N - 1]
        "heat flow rate of fluid B in the segments";
      SIunits.Temperature TA[N] "temperature nodes on channel A";
      SIunits.Temperature TB[N] "temperature nodes on channel B";
      SIunits.Temperature TW[N - 1] "temperatures on the wall segments";
      SIunits.HeatFlowRate QtotA "total heat flow rate of fluid A";
      SIunits.HeatFlowRate QtotB "total heat flow rate of fluid B";
    initial equation
      for i in 2:N loop
        TA[i] = 300;
        TB[i - 1] = 300;
        TW[i - 1] = 300;
      end for;
    equation
      TA[1] = if time < 8 then 300 else 301;
      TB[N] = 310;
      wA = if time < 15 then 1 else 1.1;
      for i in 1:N - 1 loop
        rhoA * l * areaA * cpA * der(TA[i + 1]) = wA * cpA * TA[i] - wA * cpA * TA[i + 1] + QA[i];
        rhoB * l * areaB * cpB * der(TB[N - i]) = wB * cpB * TB[N - i + 1] - wB * cpB * TB[N - i] - QB[N - i];
        QA[i] = (TW[i] - (TA[i] + TA[i + 1]) / 2) * gammaA * omega * l;
        QB[N - i] = ((TB[N - i + 1] + TB[N - i]) / 2 - TW[N - i]) * gammaB * omega * l;
        cpW / (N - 1) * der(TW[i]) = (-QA[i]) + QB[i];
      end for;
      QtotA = sum(QA);
      QtotB = sum(QB);
      annotation(Documentation(info = "<html><p>Countercurrent heat exchanger model consist of two channels A and B, and a separating heat transfer wall in between.  Fluids A and B are flowing in the channels A and B respectively. Heat exchanger is assumed to be insulated around the outside, therefore, heat transfer occurs just between the fluids A and B. Fluid B is considered as the hot fluid and fluid A is considered to be the cold fluid.</p><img src=\"modelica://ScalableTestSuite/Resources/Images/HeatExchanger/countercurrent.png\"/><p>Heat exchanger mass balance equations for the fluids can be written as:</p><img src=\"modelica://ScalableTestSuite/Resources/Images/HeatExchanger/massbalance.png\"/><p>where ρ is the density of the fluid, A is the cross section and w is the mass flow rate. Density and the cross section are assumed to be constant for the fluids, hence mass flow rate is considered constant along the channels.</p>Heat exchanger energy balance equations are described considering a small portion l=L/(N-1) on the channels where L is the length of each channel, and N is the number of nodes on the channels. Therefore, N-1 corresponds to the number of channel and wall segments. And, there are N-1 heat flow rates and N-1 temperature variables for the wall which are considered for the segments. Discretized energy balance equations for the countercurrent heat exchanger are described as:<img src=\"modelica://ScalableTestSuite/Resources/Images/HeatExchanger/energybalance.png\"/><p>for j=1…N-1 where A_A and A_B are the cross section areas of the channels, ρ_A and ρ_B are the densities, c_pA and c_pB are the specific heat capacities, w_A and w_B are the mass flow rates of the fluids A and B respectively. Moreover, T_A and T_B are the temperature variables of the fluids A and B respectively, entering and exiting the small portion l. And, Q_A is the heat flow rate from wall to channel A, and Q_B is the heat flow rate from channel B to wall. In addition to this, boundary conditions were defined for the first node for T_A and for the node N for T_B.</p><p>The wall between the channels is assumed to be very thin, so its thermal resistance is neglected. Heat transfer occurs from the fluid A in channel A to the wall and from the wall to the fluid B in channel B. Energy balance at the each wall segment:</p><img src=\"modelica://ScalableTestSuite/Resources/Images/HeatExchanger/energywallcounter.png\"/><p>for  j=1…N-1 where γ_A and γ_B are the heat transfer coefficients of fluids A and B respectively, and ω_A and ω_B are the perimeter of the channels A and B respectively. Moreover, c_w  is the specific heat capacity of the wall and T_w  is the temperature variable of the wall segment. Parameters in the CounterCurrentHeatExchangerEquations:</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Parameters</th>
      <th>Comment</th>
    </tr>
                <tr>
      <td valign=\"top\">L</td>
      <td valign=\"top\">length</td>
    </tr>
                <tr>
      <td valign=\"top\">N</td>
      <td valign=\"top\">number of nodes</td>
    </tr>
   <tr>
      <td valign=\"top\">wB</td>
      <td valign=\"top\">mass flow rate of B</td>
    </tr>
    <tr>
      <td valign=\"top\">areaA</td>
      <td valign=\"top\">cross sectional area of A</td>
    </tr>
    <tr>
      <td valign=\"top\">areaB</td>
      <td valign=\"top\">cross sectional area of B</td>
    </tr>
                <tr>
      <td valign=\"top\">rhoA</td>
      <td valign=\"top\">density of A</td>
    </tr>
                <tr>
      <td valign=\"top\">rhoB</td>
      <td valign=\"top\">density of B</td>
    </tr>
                <tr>
      <td valign=\"top\">cpA</td>
      <td valign=\"top\">specific heat capacity of A</td>
    </tr>
                <tr>
      <td valign=\"top\">cpB</td>
      <td valign=\"top\">specific heat capacity of B</td>
    </tr>
                <tr>
      <td valign=\"top\">cpW</td>
      <td valign=\"top\">specific heat capacity of the wall</td>
    </tr>
                <tr>
      <td valign=\"top\">gammaA</td>
      <td valign=\"top\">heat transfer coefficient of A</td>
    </tr>
                <tr>
      <td valign=\"top\">gammaB</td>
      <td valign=\"top\">heat transfer coefficient of B</td>
    </tr>
                <tr>
      <td valign=\"top\">omega</td>
      <td valign=\"top\">perimeter</td>
    </tr>
                <tr>
      <td valign=\"top\">l</td>
      <td valign=\"top\">length of each wall segment</td>
    </tr>
</table>
</html>"));
    end CounterCurrentHeatExchangerEquations;

    model CocurrentHeatExchangerEquations
      "cocurrent heat exchanger implemented by equations"
      import Modelica.SIunits;
      parameter SIunits.Length L "length of the channels";
      parameter Integer N "number of nodes";
      parameter SIunits.MassFlowRate wB "mass flow rate of fluid B";
      parameter SIunits.Area areaA "cross sectional area of channel A";
      parameter SIunits.Area areaB "cross sectional area of channel B";
      parameter SIunits.Density rhoA "density of fluid A";
      parameter SIunits.Density rhoB "density of fluid B";
      parameter SIunits.SpecificHeatCapacity cpA
        "specific heat capacity of fluid A";
      parameter SIunits.SpecificHeatCapacity cpB
        "specific heat capacity of fluid B";
      parameter SIunits.SpecificHeatCapacity cpW
        "specific heat capacity of the wall";
      parameter SIunits.CoefficientOfHeatTransfer gammaA
        "heat transfer coefficient of fluid A";
      parameter SIunits.CoefficientOfHeatTransfer gammaB
        "heat transfer coefficient of fluid B";
      parameter SIunits.Length omega "perimeter";
      final parameter SIunits.Length l = L / (N - 1)
        "length of the each wall segment";
      SIunits.MassFlowRate wA "mass flow rate of fluid A";
      SIunits.HeatFlowRate QA[N - 1]
        "heat flow rate of fluid A in the segments";
      SIunits.HeatFlowRate QB[N - 1]
        "heat flow rate of fluid B in the segments";
      SIunits.Temperature TA[N] "temperature nodes on channel A";
      SIunits.Temperature TB[N] "temperature nodes on channel B";
      SIunits.Temperature TW[N - 1] "temperatures on the wall segments";
      SIunits.HeatFlowRate QtotA "total heat flow rate of fluid A";
      SIunits.HeatFlowRate QtotB "total heat flow rate of fluid B";
    initial equation
      for i in 2:N loop
        TA[i] = 300;
        TB[i] = 300;
        TW[i - 1] = 300;
      end for;
    equation
      TA[1] = if time < 8 then 300 else 301;
      TB[1] = 310;
      wA = if time < 15 then 1 else 1.1;
      for i in 1:N - 1 loop
        rhoA * l * cpA * areaA * der(TA[i + 1]) = wA * cpA * TA[i] - wA * cpA * TA[i + 1] + QA[i];
        rhoB * l * cpB * areaB * der(TB[i + 1]) = wB * cpB * TB[i] - wB * cpB * TB[i + 1] - QB[i];
        QA[i] = (TW[i] - (TA[i] + TA[i + 1]) / 2) * gammaA * omega * l;
        QB[i] = ((TB[i] + TB[i + 1]) / 2 - TW[i]) * gammaB * omega * l;
        cpW / (N - 1) * der(TW[i]) = (-QA[i]) + QB[i];
      end for;
      QtotA = sum(QA);
      QtotB = sum(QB);
      annotation(Documentation(info = "<html><p>Cocurrent heat exchanger model consist of two channels A and B, and a separating heat transfer wall in between.  Fluids A and B are flowing in the channels A and B respectively. Heat exchanger is assumed to be insulated around the outside, therefore, heat transfer occurs just between the fluids A and B. Fluid B is considered as the hot fluid and fluid A is considered to be the cold fluid.</p><img src=\"modelica://ScalableTestSuite/Resources/Images/HeatExchanger/cocurrent.png\"/><p>Heat exchanger mass balance equations for the fluids can be written as:</p><img src=\"modelica://ScalableTestSuite/Resources/Images/HeatExchanger/massbalance.png\"/><p>where ρ is the density of the fluid, A is the cross section and w is the mass flow rate. Density and the cross section are assumed to be constant for the fluids, hence mass flow rate is considered constant along the channels.</p>Heat exchanger energy balance equations are described considering a small portion l=L/(N-1) on the channels where L is the length of each channel, and N is the number of nodes on the channels. Therefore, N-1 corresponds to the number of channel and wall segments. And, there are N-1 heat flow rates and N-1 temperature variables for the wall which are considered for the segments. <p>Energy balance equations for cocurrent heat exchanger is very similar to the equations of countercurrent heat exchanger. The difference occurs because of the flow direction of the fluid B, therefore, in cocurrent heat exchanger boundary condition of T_B is described for the first node. And, boundary condition of T_A remained again for the first node.</p> <img src=\"modelica://ScalableTestSuite/Resources/Images/HeatExchanger/energybalancecocurrent.png\"/><p>for j=1…N-1.
Energy balance at the each wall segment is modified in terms of temperature variables of fluid B:
</p><img src=\"modelica://ScalableTestSuite/Resources/Images/HeatExchanger/energywallcocurrent.png\"/><p>for j=1…N-1.</p><p>Parameters in the CounterCurrentHeatExchangerEquations:</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Parameters</th>
      <th>Comment</th>
    </tr>
                <tr>
      <td valign=\"top\">L</td>
      <td valign=\"top\">length of the channels</td>
    </tr>
                <tr>
      <td valign=\"top\">N</td>
      <td valign=\"top\">number of nodes</td>
    </tr>
   <tr>
      <td valign=\"top\">wB</td>
      <td valign=\"top\">mass flow rate of fluid B</td>
    </tr>
    <tr>
      <td valign=\"top\">areaA</td>
      <td valign=\"top\">cross sectional area of channel A</td>
    </tr>
    <tr>
      <td valign=\"top\">areaB</td>
      <td valign=\"top\">cross sectional area of channel B</td>
    </tr>
                <tr>
      <td valign=\"top\">rhoA</td>
      <td valign=\"top\">density of fluid A</td>
    </tr>
                <tr>
      <td valign=\"top\">rhoB</td>
      <td valign=\"top\">density of fluid B</td>
    </tr>
                <tr>
      <td valign=\"top\">cpA</td>
      <td valign=\"top\">specific heat capacity of fluid A</td>
    </tr>
                <tr>
      <td valign=\"top\">cpB</td>
      <td valign=\"top\">specific heat capacity of fluid B</td>
    </tr>
                <tr>
      <td valign=\"top\">cpW</td>
      <td valign=\"top\">specific heat capacity of the wall</td>
    </tr>
                <tr>
      <td valign=\"top\">gammaA</td>
      <td valign=\"top\">heat transfer coefficient of fluid A</td>
    </tr>
                <tr>
      <td valign=\"top\">gammaB</td>
      <td valign=\"top\">heat transfer coefficient of fluid B</td>
    </tr>
                <tr>
      <td valign=\"top\">omega</td>
      <td valign=\"top\">perimeter</td>
    </tr>
                <tr>
      <td valign=\"top\">l</td>
      <td valign=\"top\">length of each wall segment</td>
    </tr>
</table>
</html>"));
    end CocurrentHeatExchangerEquations;
  end Models;

  package Verification
    model SteadyStateAnalysis "steady state analysis for heat exchangers"
      import Modelica.SIunits;
      parameter SIunits.Length L = 10 "length of the channels";
      parameter Integer N = 20 "number of nodes";
      parameter SIunits.MassFlowRate wB = 1 "mass flow rate of fluid B";
      parameter SIunits.Area areaA = 5e-5 "cross sectional area of channel A";
      parameter SIunits.Area areaB = 5e-5 "cross sectional area of channel B";
      parameter SIunits.Density rhoA = 1000 "density of fluid A";
      parameter SIunits.Density rhoB = 1000 "density of fluid B";
      parameter SIunits.SpecificHeatCapacity cpA = 4200
        "specific heat capacity of fluid A";
      parameter SIunits.SpecificHeatCapacity cpB = 4200
        "specific heat capacity of fluid B";
      parameter SIunits.SpecificHeatCapacity cpW = 2000
        "specific heat capacity of wall";
      parameter SIunits.CoefficientOfHeatTransfer gammaA = 4000
        "heat transfer coefficient of fluid A";
      parameter SIunits.CoefficientOfHeatTransfer gammaB = 10000
        "heat transfer coefficient of fluid B";
      parameter SIunits.Length omega = 0.1 "perimeter";
      parameter SIunits.PerUnit UA = L * omega * gammaA * gammaB / (gammaA + gammaB);
      Models.CounterCurrentHeatExchangerEquations countercur(L = L, N = N, wB = wB, areaA = areaA, areaB = areaB, rhoA = rhoA, rhoB = rhoB, cpA = cpA, cpB = cpB, cpW = cpW, gammaA = gammaA, gammaB = gammaB, omega = omega);
      Models.CocurrentHeatExchangerEquations cocur(L = L, N = N, wB = wB, areaA = areaA, areaB = areaB, rhoA = rhoA, rhoB = rhoB, cpA = cpA, cpB = cpB, cpW = cpW, gammaA = gammaA, gammaB = gammaB, omega = omega);
      SIunits.Temperature dTeogCocur
        "average temperature driving force at cocurrent mode";
      SIunits.Temperature dTeogCountercur
        "average temperature driving force at countercurrent mode";
      SIunits.HeatFlowRate Qcocur_ss
        "steady state rate equation at cocurrent mode";
      SIunits.HeatFlowRate Qcocur_fluidA
        "total heat flow rate of fluid A at cocurrent mode";
      SIunits.HeatFlowRate Qcocur_fluidB
        "total heat flow rate of fluid B at cocurrent mode";
      SIunits.HeatFlowRate Qcountercur_ss
        "steady state rate equation at countercurrent mode";
      SIunits.HeatFlowRate Qcountercur_fluidA
        "total heat flow rate of fluid A at countercurrent mode";
      SIunits.HeatFlowRate Qcountercur_fluidB
        "total heat flow rate of fluid B at countercurrent mode";
      SIunits.Temperature P1
        "temperature difference between fluid A and B at node N at cocurrent mode";
      SIunits.Temperature P2
        "temperature difference between fluid A and B at node 1 at cocurrent mode";
      SIunits.Temperature P3
        "temperature difference between fluid A and B at node N at countercurrent mode";
      SIunits.Temperature P4
        "temperature difference between fluid A and B at node 1 at countercurrent mode";
    equation
      P1 = cocur.TB[N] - cocur.TA[N];
      P2 = cocur.TB[1] - cocur.TA[1];
      dTeogCocur = if time < 6 then 0 else if time < 7 then (P1 - P2) / log(P1 / P2) else if time < 13 then 0 else if time < 14 then (P1 - P2) / log(P1 / P2) else if time < 18 then 0 else if time < 19 then (P1 - P2) / log(P1 / P2) else 0;
      Qcocur_ss = UA * dTeogCocur;
      Qcocur_fluidA = cocur.QtotA;
      Qcocur_fluidB = cocur.QtotB;
      P3 = countercur.TB[N] - countercur.TA[N];
      P4 = countercur.TB[1] - countercur.TA[1];
      dTeogCountercur = if time < 6 then 0 else if time < 7 then (P3 - P4) / log(P3 / P4) else if time < 13 then 0 else if time < 14 then (P3 - P4) / log(P3 / P4) else if time < 18 then 0 else if time < 19 then (P3 - P4) / log(P3 / P4) else 0;
      Qcountercur_ss = UA * dTeogCountercur;
      Qcountercur_fluidA = countercur.QtotA;
      Qcountercur_fluidB = countercur.QtotB;
      annotation(experiment(StartTime = 0, StopTime = 20, Tolerance = 1e-6, Interval = 0.04), Documentation(info = "<html><p>Temperature distributions of the heat exchangers in cocurrent and countercurrent mode are given. T_H and T_c represent the temperature of the hot fluid and the cold fluid, respectively. </p><img src=\"modelica://ScalableTestSuite/Resources/Images/HeatExchanger/tempdistributions.png\"/><p>∆T represents the temperature difference between hot and cold fluids along the heat exchangers. And, x is a point along the channels of the heat exchanger. In the countercurrent mode, ∆T does not vary along the channels as much as the ∆T in the cocurrent mode. Moreover, in cocurrent mode, ∆T is very large at the inlet of the channels and getting smaller progressively. Countercurrent heat exchanger can be evaluated as more efficient with respect to cocurrent heat exchanger since countercurrent mode requires smaller heat transfer area to provide the same heat transfer rate.
</p><p>At the steady state, the total flow rates of Q_A and Q_B is equal to a steady state rate equation and it is used for the verification of the models.
Steady state heat rate equation for a heat exchanger is written as follows: </p><p>Q=UA∆Teog</p>
where U is the average overall heat transfer coefficient, A is the area of the heat transfer surface and ∆Teog is the average temperature driving force. UA is described as: <p>UA=Lω(γ_A γ_B)/(γ_A+γ_B )</p><p>where L is the length, ω is the perimeter of the channels, γ_A and γ_B are the heat transfer coefficients of fluid A and B respectively.</p>∆Teog is written as:<p><img src=\"modelica://ScalableTestSuite/Resources/Images/HeatExchanger/Teog.png\"/></p>where ∆T_L is the temperature difference of the fluids A and B at the outlet of the channels and ∆T_o is the temperature difference of the fluids A and B at the inlet of the channels.


</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Parameters</th>
      <th>Comment</th>
    </tr>
		<tr>
      <td valign=\"top\">L</td>
      <td valign=\"top\">length of the channels</td>
    </tr>
		<tr>
      <td valign=\"top\">N</td>
      <td valign=\"top\">number of nodes</td>
    </tr>
   <tr>
      <td valign=\"top\">wB</td>
      <td valign=\"top\">mass flow rate of fluid B</td>
    </tr>
    <tr>
      <td valign=\"top\">areaA</td>
      <td valign=\"top\">cross sectional area of channel A</td>
    </tr>
    <tr>
      <td valign=\"top\">areaB</td>
      <td valign=\"top\">cross sectional area of channel B</td>
    </tr>
		<tr>
      <td valign=\"top\">rhoA</td>
      <td valign=\"top\">density of fluid A</td>
    </tr>
		<tr>
      <td valign=\"top\">rhoB</td>
      <td valign=\"top\">density of fluid B</td>
    </tr>
		<tr>
      <td valign=\"top\">cpA</td>
      <td valign=\"top\">specific heat capacity of fluid A</td>
    </tr>
		<tr>
      <td valign=\"top\">cpB</td>
      <td valign=\"top\">specific heat capacity of fluid B</td>
    </tr>
		<tr>
      <td valign=\"top\">cpW</td>
      <td valign=\"top\">specific heat capacity of the wall</td>
    </tr>
		<tr>
      <td valign=\"top\">gammaA</td>
      <td valign=\"top\">heat transfer coefficient of fluid A</td>
    </tr>
		<tr>
      <td valign=\"top\">gammaB</td>
      <td valign=\"top\">heat transfer coefficient of fluid B</td>
    </tr>
		<tr>
      <td valign=\"top\">omega</td>
      <td valign=\"top\">perimeter</td>
    </tr>
		<tr>
      <td valign=\"top\">UA</td>
      <td valign=\"top\">average overall heat transfer coefficient * area of the heat transfer surface</td>
    </tr>
</table>
</html>"));
    end SteadyStateAnalysis;
  end Verification;

  package ScaledExperiments
    model CounterCurrentHeatExchangerEquations_N_10
      extends Models.CounterCurrentHeatExchangerEquations(L = 10, N = 10, wB = 1, areaA = 5e-5, areaB = 5e-5, rhoA = 1000, rhoB = 1000, cpA = 4200, cpB = 4200, cpW = 2000, gammaA = 4000, gammaB = 10000, omega = 0.1);
      annotation(experiment(StopTime = 20, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end CounterCurrentHeatExchangerEquations_N_10;

    model CounterCurrentHeatExchangerEquations_N_20
      extends CounterCurrentHeatExchangerEquations_N_10(N = 20);
      annotation(experiment(StopTime = 20, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end CounterCurrentHeatExchangerEquations_N_20;

    model CounterCurrentHeatExchangerEquations_N_40
      extends CounterCurrentHeatExchangerEquations_N_10(N = 40);
      annotation(experiment(StopTime = 20, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end CounterCurrentHeatExchangerEquations_N_40;

    model CounterCurrentHeatExchangerEquations_N_80
      extends CounterCurrentHeatExchangerEquations_N_10(N = 80);
      annotation(experiment(StopTime = 20, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end CounterCurrentHeatExchangerEquations_N_80;

    model CounterCurrentHeatExchangerEquations_N_160
      extends CounterCurrentHeatExchangerEquations_N_10(N = 160);
      annotation(experiment(StopTime = 20, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end CounterCurrentHeatExchangerEquations_N_160;

    model CounterCurrentHeatExchangerEquations_N_320
      extends CounterCurrentHeatExchangerEquations_N_10(N = 320);
      annotation(experiment(StopTime = 20, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end CounterCurrentHeatExchangerEquations_N_320;

    model CounterCurrentHeatExchangerEquations_N_640
      extends CounterCurrentHeatExchangerEquations_N_10(N = 640);
      annotation(experiment(StopTime = 20, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end CounterCurrentHeatExchangerEquations_N_640;

    model CounterCurrentHeatExchangerEquations_N_1280
      extends CounterCurrentHeatExchangerEquations_N_10(N = 1280);
      annotation(experiment(StopTime = 20, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end CounterCurrentHeatExchangerEquations_N_1280;

    model CocurrentHeatExchangerEquations_N_10
      extends Models.CocurrentHeatExchangerEquations(L = 10, N = 10, wB = 1, areaA = 5e-5, areaB = 5e-5, rhoA = 1000, rhoB = 1000, cpA = 4200, cpB = 4200, cpW = 2000, gammaA = 4000, gammaB = 10000, omega = 0.1);
      annotation(experiment(StopTime = 20, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end CocurrentHeatExchangerEquations_N_10;

    model CocurrentHeatExchangerEquations_N_20
      extends CocurrentHeatExchangerEquations_N_10(N = 20);
      annotation(experiment(StopTime = 20, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end CocurrentHeatExchangerEquations_N_20;

    model CocurrentHeatExchangerEquations_N_40
      extends CocurrentHeatExchangerEquations_N_10(N = 40);
      annotation(experiment(StopTime = 20, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end CocurrentHeatExchangerEquations_N_40;

    model CocurrentHeatExchangerEquations_N_80
      extends CocurrentHeatExchangerEquations_N_10(N = 80);
      annotation(experiment(StopTime = 20, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end CocurrentHeatExchangerEquations_N_80;

    model CocurrentHeatExchangerEquations_N_160
      extends CocurrentHeatExchangerEquations_N_10(N = 160);
      annotation(experiment(StopTime = 20, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end CocurrentHeatExchangerEquations_N_160;

    model CocurrentHeatExchangerEquations_N_320
      extends CocurrentHeatExchangerEquations_N_10(N = 320);
      annotation(experiment(StopTime = 20, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end CocurrentHeatExchangerEquations_N_320;

    model CocurrentHeatExchangerEquations_N_640
      extends CocurrentHeatExchangerEquations_N_10(N = 640);
      annotation(experiment(StopTime = 20, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end CocurrentHeatExchangerEquations_N_640;

    model CocurrentHeatExchangerEquations_N_1280
      extends CocurrentHeatExchangerEquations_N_10(N = 1280);
      annotation(experiment(StopTime = 20, Tolerance = 1e-6),
                 __OpenModelica_simulationFlags(s = "ida"));
    end CocurrentHeatExchangerEquations_N_1280;

    annotation(Documentation(info = "<html><p>In this package there are 16 tests for different N values; 8 for the CounterCurrentHeatExchangerEquations, 8 for the CocurrentHeatExchangerEquations.</p><p> The tests for the models are performed according to the N values as shown in the table below:</p><table border=\"1\">
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
</table><p>Parameter values for CounterCurrentHeatExchangerEquations and CocurrentHeatExchangerEquations:</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Parameters</th>
      <th>Comment</th>
    </tr>
		<tr>
      <td valign=\"top\">L</td>
      <td valign=\"top\">10</td>
    </tr>
		<tr>
      <td valign=\"top\">N</td>
      <td valign=\"top\">10,20,40,80,160,320,640,1280</td>
    </tr>
   <tr>
      <td valign=\"top\">wB</td>
      <td valign=\"top\">1</td>
    </tr>
    <tr>
      <td valign=\"top\">areaA</td>
      <td valign=\"top\">5e-5</td>
    </tr>
    <tr>
      <td valign=\"top\">areaB</td>
      <td valign=\"top\">5e-5</td>
    </tr>
		<tr>
      <td valign=\"top\">rhoA</td>
      <td valign=\"top\">1000</td>
    </tr>
		<tr>
      <td valign=\"top\">rhoB</td>
      <td valign=\"top\">1000</td>
    </tr>
		<tr>
      <td valign=\"top\">cpA</td>
      <td valign=\"top\">4200</td>
    </tr>
		<tr>
      <td valign=\"top\">cpB</td>
      <td valign=\"top\">4200</td>
    </tr>
		<tr>
      <td valign=\"top\">cpW</td>
      <td valign=\"top\">2000</td>
    </tr>
		<tr>
      <td valign=\"top\">gammaA</td>
      <td valign=\"top\">4000</td>
    </tr>
		<tr>
      <td valign=\"top\">gammaB</td>
      <td valign=\"top\">10000</td>
    </tr>
		<tr>
      <td valign=\"top\">omega</td>
      <td valign=\"top\">0.1</td>
    </tr>
</table></html>"));
  end ScaledExperiments;
end HeatExchanger;
