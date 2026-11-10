package LargeTestSuite "Library for testing of very large models"
  extends Modelica.Icons.Package;
annotation(uses(Modelica(version="4.1.0"),
                ScalableTestSuite(version="2.4.0"),
                LSGreenH2Production(version="main"),
                Battery(version="main"),
                IDADistricts(version="main"),
                SOFCPoliMi(version="master")),
           version = "2.4.0");
end LargeTestSuite;
