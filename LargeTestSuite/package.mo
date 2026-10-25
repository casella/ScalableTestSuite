package LargeTestSuite "Library for testing of very large models"
  extends Modelica.Icons.Package;
annotation(uses(Modelica(version="4.1.0"),
                ScalableTestSuite(version="2.4.0"),
                LSGreenH2Production,
                Battery,
                IDADistricts),
           version = "2.4.0");
end LargeTestSuite;
