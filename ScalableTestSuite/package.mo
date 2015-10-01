within ;
package ScalableTestSuite "A library of scalable Modelica test models"
annotation(version = "1.1.2",
             uses(Modelica(version = "3.2.1")),
             Documentation(info=
"<html>
<p>This library contains a collection of Modelica models whose size can be scaled by means of integer parameter(s). This is useful to test the ability of Modelica tools to compile and simulate models of  increasing size efficiently.</p>
<p>The library contains examples with a physical motivation, which are also verified against known analytical solutions wherever possible.</p>
<p>In some cases, when feasible, two mathematically equivalent models are provided, one built by raw equations and the other one built using the Modelica Standard Library. This makes it possible to evaluate how efficiently the Modelica tool can handle the overhead of a modular description both in terms of compilation time, which might be higher due to additional processing, and of simulation time, which should be the same.</p>
<p>This work was originally inspired by discussion at the <a href=\"http://www.eoolt.org/2014/index.php\">2014 EOOLT Workshop in Berlin</a>. Version 1.0.0 is the outcome of Kaan Sezginer&apos;s<a href=\"modelica://ScalableTestSuite/Resources/Docs/2015_04_SEZGINER_Thesis.pdf\"> master&apos;s thesis</a> work at Politecnico di Milano, under the supervision of prof. Francesco Casella. It is expected that the library grows and becomes a reference for the community, please contact<a href=\"mailto:francesco.casella@polimi.it\"> Francesco Casella</a> if you want to contribute.</p>
<p>Licensed by Politecnico di Milano under the Modelica License 2.</p>
<p>Copyright &copy; 2015 Politecnico di Milano</p>
<p>Main Authors</p>
<ul>
<li>Kaan Sezginer</li>
<li>Francesco Casella</li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,50},{50,-100}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,0},{0,-100}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,-40},{-40,-100}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,-70},{-68,-100}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}));
end ScalableTestSuite;
