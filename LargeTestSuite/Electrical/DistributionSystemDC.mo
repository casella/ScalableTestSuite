within LargeTestSuite.Electrical;

package DistributionSystemDC
  extends Modelica.Icons.ExamplesPackage;

  model DistributionSystemModelicaIndividual_N_10_M_10
    parameter Integer N = 10
      " Number of segments of the primary distribution line";
    parameter Integer M = 10
      " Number of segments of each secondary distribution line";
    parameter Real alpha = 2 "Distribution line oversizing factor";
    parameter Modelica.Units.SI.Resistance R_l=1
      "Resistance of a single load";
    parameter Modelica.Units.SI.Resistance R_d2=R_l/(M^2*alpha)
      "Resistance of a secondary distribution segment";
    parameter Modelica.Units.SI.Resistance R_d1=R_l/(M^2*N^2*alpha)
      "Resistance of a primary distribution segment";
    parameter Modelica.Units.SI.Voltage V_ref=600 "Reference source voltage";

    Modelica.Electrical.Analog.Basic.Resistor primary_1(R = R_d1)
      "Primary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor secondary_1_1(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_1_1(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_1_1
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_1_2(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_1_2(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_1_2
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_1_3(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_1_3(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_1_3
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_1_4(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_1_4(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_1_4
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_1_5(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_1_5(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_1_5
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_1_6(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_1_6(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_1_6
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_1_7(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_1_7(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_1_7
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_1_8(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_1_8(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_1_8
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_1_9(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_1_9(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_1_9
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_1_10(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_1_10(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_1_10
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor primary_2(R = R_d1)
      "Primary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor secondary_2_1(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_2_1(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_2_1
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_2_2(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_2_2(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_2_2
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_2_3(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_2_3(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_2_3
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_2_4(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_2_4(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_2_4
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_2_5(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_2_5(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_2_5
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_2_6(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_2_6(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_2_6
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_2_7(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_2_7(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_2_7
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_2_8(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_2_8(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_2_8
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_2_9(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_2_9(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_2_9
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_2_10(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_2_10(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_2_10
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor primary_3(R = R_d1)
      "Primary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor secondary_3_1(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_3_1(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_3_1
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_3_2(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_3_2(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_3_2
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_3_3(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_3_3(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_3_3
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_3_4(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_3_4(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_3_4
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_3_5(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_3_5(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_3_5
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_3_6(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_3_6(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_3_6
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_3_7(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_3_7(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_3_7
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_3_8(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_3_8(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_3_8
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_3_9(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_3_9(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_3_9
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_3_10(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_3_10(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_3_10
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor primary_4(R = R_d1)
      "Primary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor secondary_4_1(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_4_1(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_4_1
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_4_2(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_4_2(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_4_2
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_4_3(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_4_3(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_4_3
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_4_4(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_4_4(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_4_4
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_4_5(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_4_5(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_4_5
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_4_6(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_4_6(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_4_6
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_4_7(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_4_7(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_4_7
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_4_8(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_4_8(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_4_8
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_4_9(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_4_9(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_4_9
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_4_10(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_4_10(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_4_10
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor primary_5(R = R_d1)
      "Primary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor secondary_5_1(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_5_1(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_5_1
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_5_2(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_5_2(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_5_2
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_5_3(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_5_3(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_5_3
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_5_4(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_5_4(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_5_4
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_5_5(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_5_5(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_5_5
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_5_6(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_5_6(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_5_6
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_5_7(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_5_7(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_5_7
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_5_8(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_5_8(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_5_8
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_5_9(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_5_9(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_5_9
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_5_10(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_5_10(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_5_10
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor primary_6(R = R_d1)
      "Primary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor secondary_6_1(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_6_1(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_6_1
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_6_2(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_6_2(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_6_2
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_6_3(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_6_3(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_6_3
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_6_4(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_6_4(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_6_4
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_6_5(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_6_5(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_6_5
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_6_6(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_6_6(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_6_6
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_6_7(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_6_7(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_6_7
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_6_8(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_6_8(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_6_8
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_6_9(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_6_9(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_6_9
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_6_10(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_6_10(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_6_10
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor primary_7(R = R_d1)
      "Primary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor secondary_7_1(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_7_1(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_7_1
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_7_2(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_7_2(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_7_2
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_7_3(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_7_3(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_7_3
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_7_4(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_7_4(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_7_4
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_7_5(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_7_5(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_7_5
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_7_6(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_7_6(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_7_6
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_7_7(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_7_7(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_7_7
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_7_8(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_7_8(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_7_8
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_7_9(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_7_9(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_7_9
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_7_10(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_7_10(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_7_10
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor primary_8(R = R_d1)
      "Primary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor secondary_8_1(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_8_1(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_8_1
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_8_2(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_8_2(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_8_2
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_8_3(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_8_3(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_8_3
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_8_4(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_8_4(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_8_4
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_8_5(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_8_5(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_8_5
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_8_6(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_8_6(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_8_6
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_8_7(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_8_7(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_8_7
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_8_8(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_8_8(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_8_8
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_8_9(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_8_9(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_8_9
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_8_10(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_8_10(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_8_10
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor primary_9(R = R_d1)
      "Primary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor secondary_9_1(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_9_1(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_9_1
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_9_2(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_9_2(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_9_2
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_9_3(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_9_3(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_9_3
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_9_4(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_9_4(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_9_4
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_9_5(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_9_5(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_9_5
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_9_6(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_9_6(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_9_6
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_9_7(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_9_7(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_9_7
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_9_8(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_9_8(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_9_8
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_9_9(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_9_9(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_9_9
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_9_10(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_9_10(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_9_10
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor primary_10(R = R_d1)
      "Primary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor secondary_10_1(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_10_1(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_10_1
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_10_2(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_10_2(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_10_2
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_10_3(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_10_3(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_10_3
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_10_4(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_10_4(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_10_4
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_10_5(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_10_5(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_10_5
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_10_6(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_10_6(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_10_6
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_10_7(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_10_7(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_10_7
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_10_8(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_10_8(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_10_8
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_10_9(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_10_9(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_10_9
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Resistor secondary_10_10(R = R_d2)
      "Secondary distribution line segment";
    Modelica.Electrical.Analog.Basic.Resistor load_10_10(R = R_l)
      "Individual load resistor";
    Modelica.Electrical.Analog.Basic.Ground ground_10_10
      "Individual load ground";
    Modelica.Electrical.Analog.Basic.Ground sourceGround "Source ground";
    Modelica.Electrical.Analog.Sources.RampVoltage V_source(V = V_ref, duration = 1)
      "Voltage source";
  equation
    connect(primary_1.p, V_source.p);
    connect(sourceGround.p, V_source.n);
    connect(primary_1.n, primary_2.p);
    connect(primary_2.n, primary_3.p);
    connect(primary_3.n, primary_4.p);
    connect(primary_4.n, primary_5.p);
    connect(primary_5.n, primary_6.p);
    connect(primary_6.n, primary_7.p);
    connect(primary_7.n, primary_8.p);
    connect(primary_8.n, primary_9.p);
    connect(primary_9.n, primary_10.p);
    connect(primary_1.n, secondary_1_1.p);
    connect(secondary_1_1.n, secondary_1_2.p);
    connect(secondary_1_2.n, secondary_1_3.p);
    connect(secondary_1_3.n, secondary_1_4.p);
    connect(secondary_1_4.n, secondary_1_5.p);
    connect(secondary_1_5.n, secondary_1_6.p);
    connect(secondary_1_6.n, secondary_1_7.p);
    connect(secondary_1_7.n, secondary_1_8.p);
    connect(secondary_1_8.n, secondary_1_9.p);
    connect(secondary_1_9.n, secondary_1_10.p);
    connect(secondary_1_1.n, load_1_1.p);
    connect(load_1_1.n, ground_1_1.p);
    connect(secondary_1_2.n, load_1_2.p);
    connect(load_1_2.n, ground_1_2.p);
    connect(secondary_1_3.n, load_1_3.p);
    connect(load_1_3.n, ground_1_3.p);
    connect(secondary_1_4.n, load_1_4.p);
    connect(load_1_4.n, ground_1_4.p);
    connect(secondary_1_5.n, load_1_5.p);
    connect(load_1_5.n, ground_1_5.p);
    connect(secondary_1_6.n, load_1_6.p);
    connect(load_1_6.n, ground_1_6.p);
    connect(secondary_1_7.n, load_1_7.p);
    connect(load_1_7.n, ground_1_7.p);
    connect(secondary_1_8.n, load_1_8.p);
    connect(load_1_8.n, ground_1_8.p);
    connect(secondary_1_9.n, load_1_9.p);
    connect(load_1_9.n, ground_1_9.p);
    connect(secondary_1_10.n, load_1_10.p);
    connect(load_1_10.n, ground_1_10.p);
    connect(primary_2.n, secondary_2_1.p);
    connect(secondary_2_1.n, secondary_2_2.p);
    connect(secondary_2_2.n, secondary_2_3.p);
    connect(secondary_2_3.n, secondary_2_4.p);
    connect(secondary_2_4.n, secondary_2_5.p);
    connect(secondary_2_5.n, secondary_2_6.p);
    connect(secondary_2_6.n, secondary_2_7.p);
    connect(secondary_2_7.n, secondary_2_8.p);
    connect(secondary_2_8.n, secondary_2_9.p);
    connect(secondary_2_9.n, secondary_2_10.p);
    connect(secondary_2_1.n, load_2_1.p);
    connect(load_2_1.n, ground_2_1.p);
    connect(secondary_2_2.n, load_2_2.p);
    connect(load_2_2.n, ground_2_2.p);
    connect(secondary_2_3.n, load_2_3.p);
    connect(load_2_3.n, ground_2_3.p);
    connect(secondary_2_4.n, load_2_4.p);
    connect(load_2_4.n, ground_2_4.p);
    connect(secondary_2_5.n, load_2_5.p);
    connect(load_2_5.n, ground_2_5.p);
    connect(secondary_2_6.n, load_2_6.p);
    connect(load_2_6.n, ground_2_6.p);
    connect(secondary_2_7.n, load_2_7.p);
    connect(load_2_7.n, ground_2_7.p);
    connect(secondary_2_8.n, load_2_8.p);
    connect(load_2_8.n, ground_2_8.p);
    connect(secondary_2_9.n, load_2_9.p);
    connect(load_2_9.n, ground_2_9.p);
    connect(secondary_2_10.n, load_2_10.p);
    connect(load_2_10.n, ground_2_10.p);
    connect(primary_3.n, secondary_3_1.p);
    connect(secondary_3_1.n, secondary_3_2.p);
    connect(secondary_3_2.n, secondary_3_3.p);
    connect(secondary_3_3.n, secondary_3_4.p);
    connect(secondary_3_4.n, secondary_3_5.p);
    connect(secondary_3_5.n, secondary_3_6.p);
    connect(secondary_3_6.n, secondary_3_7.p);
    connect(secondary_3_7.n, secondary_3_8.p);
    connect(secondary_3_8.n, secondary_3_9.p);
    connect(secondary_3_9.n, secondary_3_10.p);
    connect(secondary_3_1.n, load_3_1.p);
    connect(load_3_1.n, ground_3_1.p);
    connect(secondary_3_2.n, load_3_2.p);
    connect(load_3_2.n, ground_3_2.p);
    connect(secondary_3_3.n, load_3_3.p);
    connect(load_3_3.n, ground_3_3.p);
    connect(secondary_3_4.n, load_3_4.p);
    connect(load_3_4.n, ground_3_4.p);
    connect(secondary_3_5.n, load_3_5.p);
    connect(load_3_5.n, ground_3_5.p);
    connect(secondary_3_6.n, load_3_6.p);
    connect(load_3_6.n, ground_3_6.p);
    connect(secondary_3_7.n, load_3_7.p);
    connect(load_3_7.n, ground_3_7.p);
    connect(secondary_3_8.n, load_3_8.p);
    connect(load_3_8.n, ground_3_8.p);
    connect(secondary_3_9.n, load_3_9.p);
    connect(load_3_9.n, ground_3_9.p);
    connect(secondary_3_10.n, load_3_10.p);
    connect(load_3_10.n, ground_3_10.p);
    connect(primary_4.n, secondary_4_1.p);
    connect(secondary_4_1.n, secondary_4_2.p);
    connect(secondary_4_2.n, secondary_4_3.p);
    connect(secondary_4_3.n, secondary_4_4.p);
    connect(secondary_4_4.n, secondary_4_5.p);
    connect(secondary_4_5.n, secondary_4_6.p);
    connect(secondary_4_6.n, secondary_4_7.p);
    connect(secondary_4_7.n, secondary_4_8.p);
    connect(secondary_4_8.n, secondary_4_9.p);
    connect(secondary_4_9.n, secondary_4_10.p);
    connect(secondary_4_1.n, load_4_1.p);
    connect(load_4_1.n, ground_4_1.p);
    connect(secondary_4_2.n, load_4_2.p);
    connect(load_4_2.n, ground_4_2.p);
    connect(secondary_4_3.n, load_4_3.p);
    connect(load_4_3.n, ground_4_3.p);
    connect(secondary_4_4.n, load_4_4.p);
    connect(load_4_4.n, ground_4_4.p);
    connect(secondary_4_5.n, load_4_5.p);
    connect(load_4_5.n, ground_4_5.p);
    connect(secondary_4_6.n, load_4_6.p);
    connect(load_4_6.n, ground_4_6.p);
    connect(secondary_4_7.n, load_4_7.p);
    connect(load_4_7.n, ground_4_7.p);
    connect(secondary_4_8.n, load_4_8.p);
    connect(load_4_8.n, ground_4_8.p);
    connect(secondary_4_9.n, load_4_9.p);
    connect(load_4_9.n, ground_4_9.p);
    connect(secondary_4_10.n, load_4_10.p);
    connect(load_4_10.n, ground_4_10.p);
    connect(primary_5.n, secondary_5_1.p);
    connect(secondary_5_1.n, secondary_5_2.p);
    connect(secondary_5_2.n, secondary_5_3.p);
    connect(secondary_5_3.n, secondary_5_4.p);
    connect(secondary_5_4.n, secondary_5_5.p);
    connect(secondary_5_5.n, secondary_5_6.p);
    connect(secondary_5_6.n, secondary_5_7.p);
    connect(secondary_5_7.n, secondary_5_8.p);
    connect(secondary_5_8.n, secondary_5_9.p);
    connect(secondary_5_9.n, secondary_5_10.p);
    connect(secondary_5_1.n, load_5_1.p);
    connect(load_5_1.n, ground_5_1.p);
    connect(secondary_5_2.n, load_5_2.p);
    connect(load_5_2.n, ground_5_2.p);
    connect(secondary_5_3.n, load_5_3.p);
    connect(load_5_3.n, ground_5_3.p);
    connect(secondary_5_4.n, load_5_4.p);
    connect(load_5_4.n, ground_5_4.p);
    connect(secondary_5_5.n, load_5_5.p);
    connect(load_5_5.n, ground_5_5.p);
    connect(secondary_5_6.n, load_5_6.p);
    connect(load_5_6.n, ground_5_6.p);
    connect(secondary_5_7.n, load_5_7.p);
    connect(load_5_7.n, ground_5_7.p);
    connect(secondary_5_8.n, load_5_8.p);
    connect(load_5_8.n, ground_5_8.p);
    connect(secondary_5_9.n, load_5_9.p);
    connect(load_5_9.n, ground_5_9.p);
    connect(secondary_5_10.n, load_5_10.p);
    connect(load_5_10.n, ground_5_10.p);
    connect(primary_6.n, secondary_6_1.p);
    connect(secondary_6_1.n, secondary_6_2.p);
    connect(secondary_6_2.n, secondary_6_3.p);
    connect(secondary_6_3.n, secondary_6_4.p);
    connect(secondary_6_4.n, secondary_6_5.p);
    connect(secondary_6_5.n, secondary_6_6.p);
    connect(secondary_6_6.n, secondary_6_7.p);
    connect(secondary_6_7.n, secondary_6_8.p);
    connect(secondary_6_8.n, secondary_6_9.p);
    connect(secondary_6_9.n, secondary_6_10.p);
    connect(secondary_6_1.n, load_6_1.p);
    connect(load_6_1.n, ground_6_1.p);
    connect(secondary_6_2.n, load_6_2.p);
    connect(load_6_2.n, ground_6_2.p);
    connect(secondary_6_3.n, load_6_3.p);
    connect(load_6_3.n, ground_6_3.p);
    connect(secondary_6_4.n, load_6_4.p);
    connect(load_6_4.n, ground_6_4.p);
    connect(secondary_6_5.n, load_6_5.p);
    connect(load_6_5.n, ground_6_5.p);
    connect(secondary_6_6.n, load_6_6.p);
    connect(load_6_6.n, ground_6_6.p);
    connect(secondary_6_7.n, load_6_7.p);
    connect(load_6_7.n, ground_6_7.p);
    connect(secondary_6_8.n, load_6_8.p);
    connect(load_6_8.n, ground_6_8.p);
    connect(secondary_6_9.n, load_6_9.p);
    connect(load_6_9.n, ground_6_9.p);
    connect(secondary_6_10.n, load_6_10.p);
    connect(load_6_10.n, ground_6_10.p);
    connect(primary_7.n, secondary_7_1.p);
    connect(secondary_7_1.n, secondary_7_2.p);
    connect(secondary_7_2.n, secondary_7_3.p);
    connect(secondary_7_3.n, secondary_7_4.p);
    connect(secondary_7_4.n, secondary_7_5.p);
    connect(secondary_7_5.n, secondary_7_6.p);
    connect(secondary_7_6.n, secondary_7_7.p);
    connect(secondary_7_7.n, secondary_7_8.p);
    connect(secondary_7_8.n, secondary_7_9.p);
    connect(secondary_7_9.n, secondary_7_10.p);
    connect(secondary_7_1.n, load_7_1.p);
    connect(load_7_1.n, ground_7_1.p);
    connect(secondary_7_2.n, load_7_2.p);
    connect(load_7_2.n, ground_7_2.p);
    connect(secondary_7_3.n, load_7_3.p);
    connect(load_7_3.n, ground_7_3.p);
    connect(secondary_7_4.n, load_7_4.p);
    connect(load_7_4.n, ground_7_4.p);
    connect(secondary_7_5.n, load_7_5.p);
    connect(load_7_5.n, ground_7_5.p);
    connect(secondary_7_6.n, load_7_6.p);
    connect(load_7_6.n, ground_7_6.p);
    connect(secondary_7_7.n, load_7_7.p);
    connect(load_7_7.n, ground_7_7.p);
    connect(secondary_7_8.n, load_7_8.p);
    connect(load_7_8.n, ground_7_8.p);
    connect(secondary_7_9.n, load_7_9.p);
    connect(load_7_9.n, ground_7_9.p);
    connect(secondary_7_10.n, load_7_10.p);
    connect(load_7_10.n, ground_7_10.p);
    connect(primary_8.n, secondary_8_1.p);
    connect(secondary_8_1.n, secondary_8_2.p);
    connect(secondary_8_2.n, secondary_8_3.p);
    connect(secondary_8_3.n, secondary_8_4.p);
    connect(secondary_8_4.n, secondary_8_5.p);
    connect(secondary_8_5.n, secondary_8_6.p);
    connect(secondary_8_6.n, secondary_8_7.p);
    connect(secondary_8_7.n, secondary_8_8.p);
    connect(secondary_8_8.n, secondary_8_9.p);
    connect(secondary_8_9.n, secondary_8_10.p);
    connect(secondary_8_1.n, load_8_1.p);
    connect(load_8_1.n, ground_8_1.p);
    connect(secondary_8_2.n, load_8_2.p);
    connect(load_8_2.n, ground_8_2.p);
    connect(secondary_8_3.n, load_8_3.p);
    connect(load_8_3.n, ground_8_3.p);
    connect(secondary_8_4.n, load_8_4.p);
    connect(load_8_4.n, ground_8_4.p);
    connect(secondary_8_5.n, load_8_5.p);
    connect(load_8_5.n, ground_8_5.p);
    connect(secondary_8_6.n, load_8_6.p);
    connect(load_8_6.n, ground_8_6.p);
    connect(secondary_8_7.n, load_8_7.p);
    connect(load_8_7.n, ground_8_7.p);
    connect(secondary_8_8.n, load_8_8.p);
    connect(load_8_8.n, ground_8_8.p);
    connect(secondary_8_9.n, load_8_9.p);
    connect(load_8_9.n, ground_8_9.p);
    connect(secondary_8_10.n, load_8_10.p);
    connect(load_8_10.n, ground_8_10.p);
    connect(primary_9.n, secondary_9_1.p);
    connect(secondary_9_1.n, secondary_9_2.p);
    connect(secondary_9_2.n, secondary_9_3.p);
    connect(secondary_9_3.n, secondary_9_4.p);
    connect(secondary_9_4.n, secondary_9_5.p);
    connect(secondary_9_5.n, secondary_9_6.p);
    connect(secondary_9_6.n, secondary_9_7.p);
    connect(secondary_9_7.n, secondary_9_8.p);
    connect(secondary_9_8.n, secondary_9_9.p);
    connect(secondary_9_9.n, secondary_9_10.p);
    connect(secondary_9_1.n, load_9_1.p);
    connect(load_9_1.n, ground_9_1.p);
    connect(secondary_9_2.n, load_9_2.p);
    connect(load_9_2.n, ground_9_2.p);
    connect(secondary_9_3.n, load_9_3.p);
    connect(load_9_3.n, ground_9_3.p);
    connect(secondary_9_4.n, load_9_4.p);
    connect(load_9_4.n, ground_9_4.p);
    connect(secondary_9_5.n, load_9_5.p);
    connect(load_9_5.n, ground_9_5.p);
    connect(secondary_9_6.n, load_9_6.p);
    connect(load_9_6.n, ground_9_6.p);
    connect(secondary_9_7.n, load_9_7.p);
    connect(load_9_7.n, ground_9_7.p);
    connect(secondary_9_8.n, load_9_8.p);
    connect(load_9_8.n, ground_9_8.p);
    connect(secondary_9_9.n, load_9_9.p);
    connect(load_9_9.n, ground_9_9.p);
    connect(secondary_9_10.n, load_9_10.p);
    connect(load_9_10.n, ground_9_10.p);
    connect(primary_10.n, secondary_10_1.p);
    connect(secondary_10_1.n, secondary_10_2.p);
    connect(secondary_10_2.n, secondary_10_3.p);
    connect(secondary_10_3.n, secondary_10_4.p);
    connect(secondary_10_4.n, secondary_10_5.p);
    connect(secondary_10_5.n, secondary_10_6.p);
    connect(secondary_10_6.n, secondary_10_7.p);
    connect(secondary_10_7.n, secondary_10_8.p);
    connect(secondary_10_8.n, secondary_10_9.p);
    connect(secondary_10_9.n, secondary_10_10.p);
    connect(secondary_10_1.n, load_10_1.p);
    connect(load_10_1.n, ground_10_1.p);
    connect(secondary_10_2.n, load_10_2.p);
    connect(load_10_2.n, ground_10_2.p);
    connect(secondary_10_3.n, load_10_3.p);
    connect(load_10_3.n, ground_10_3.p);
    connect(secondary_10_4.n, load_10_4.p);
    connect(load_10_4.n, ground_10_4.p);
    connect(secondary_10_5.n, load_10_5.p);
    connect(load_10_5.n, ground_10_5.p);
    connect(secondary_10_6.n, load_10_6.p);
    connect(load_10_6.n, ground_10_6.p);
    connect(secondary_10_7.n, load_10_7.p);
    connect(load_10_7.n, ground_10_7.p);
    connect(secondary_10_8.n, load_10_8.p);
    connect(load_10_8.n, ground_10_8.p);
    connect(secondary_10_9.n, load_10_9.p);
    connect(load_10_9.n, ground_10_9.p);
    connect(secondary_10_10.n, load_10_10.p);
    connect(load_10_10.n, ground_10_10.p);
    annotation(experiment(StopTime = 1, Interval = 1e-3),
           __OpenModelica_commandLineOptions = "--newBackend -d=mergeComponents",
           __OpenModelica_simulationFlags(s = "euler"));
  end DistributionSystemModelicaIndividual_N_10_M_10;

  model DistributionSystemModelica_N_80_M_80
    extends ScalableTestSuite.Electrical.DistributionSystemDC.ScaledExperiments.DistributionSystemModelica_N_10_M_10(N = 80, M = 80);
  annotation(experiment(StopTime = 1, Interval=1e-3),
             __OpenModelica_simulationFlags(s = "euler"));
  end DistributionSystemModelica_N_80_M_80;
  
  model DistributionSystemModelica_N_112_M_112
    extends ScalableTestSuite.Electrical.DistributionSystemDC.ScaledExperiments.DistributionSystemModelica_N_10_M_10(N = 112, M = 112);
  end DistributionSystemModelica_N_112_M_112;
  
  model DistributionSystemModelica_N_160_M_160
    extends ScalableTestSuite.Electrical.DistributionSystemDC.ScaledExperiments.DistributionSystemModelica_N_10_M_10(N = 160, M = 160);
  end DistributionSystemModelica_N_160_M_160;

  model DistributionSystemModelica_N_224_M_224
    extends ScalableTestSuite.Electrical.DistributionSystemDC.ScaledExperiments.DistributionSystemModelica_N_10_M_10(N = 224, M = 224);
  end DistributionSystemModelica_N_224_M_224;
end DistributionSystemDC;
