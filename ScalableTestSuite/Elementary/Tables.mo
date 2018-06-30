within ScalableTestSuite.Elementary;
package Tables "Models with tables"
  package Models
    partial model TableBase "Time table base"
      parameter Integer N = 10 "Order of the system" annotation(Evaluate=true);
      constant Real pi = Modelica.Constants.pi;
      final parameter Real tableX[N] = linspace(0,1,N) "Table axis X";
      final parameter Real tableY[N] = sin(linspace(0, 2*pi,N)) "Table axis Y";
    end TableBase;


    model TimeTable "Time table"
      extends TableBase;
      Modelica.Blocks.Sources.TimeTable timeTable(
        final table=[tableX, tableY]) annotation(Placement(transformation(extent={{-95,-15},{-75,5}})));
      annotation(
        experiment(StopTime = 1),
        Documentation(info = "<html><p>This model is meant to try out the tool performance on large arrays passed to functions.</p>
<p>Additionally, <em>N</em> time events occur at simulation time.</p></html>"));
    end TimeTable;

    model CombiTimeTable "Combi time table"
      extends TableBase;
      Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
        final table=[tableX, tableY],
        final smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments /* force time events to have it comparable with TimeTable */) annotation(Placement(transformation(extent={{-95,-15},{-75,5}})));
      annotation(
        experiment(StopTime = 1),
        Documentation(info = "<html><p>This model is meant to try out the tool performance on large arrays passed to external objects.</p>
<p>Additionally, <em>N</em> time events occur at simulation time.</p></html>"));
    end CombiTimeTable;
  end Models;

  package ScaledExperiments
    model TimeTable_N_125
      extends Models.TimeTable(final N=125);
    annotation(experiment(StopTime = 1));
    end TimeTable_N_125;

    model TimeTable_N_250
      extends Models.TimeTable(final N=250);
    annotation(experiment(StopTime = 1));
    end TimeTable_N_250;

    model TimeTable_N_500
      extends Models.TimeTable(final N=500);
    annotation(experiment(StopTime = 1));
    end TimeTable_N_500;

    model TimeTable_N_1000
      extends Models.TimeTable(final N=1000);
    annotation(experiment(StopTime = 1));
    end TimeTable_N_1000;

    model TimeTable_N_2000
      extends Models.TimeTable(final N=2000);
    annotation(experiment(StopTime = 1));
    end TimeTable_N_2000;

    model TimeTable_N_4000
      extends Models.TimeTable(final N=4000);
    annotation(experiment(StopTime = 1));
    end TimeTable_N_4000;

    model TimeTable_N_8000
      extends Models.TimeTable(final N=8000);
    annotation(experiment(StopTime = 1));
    end TimeTable_N_8000;

    model TimeTable_N_16000
      extends Models.TimeTable(final N=16000);
    annotation(experiment(StopTime = 1));
    end TimeTable_N_16000;
/*
    model TimeTable_N_32000
      extends Models.TimeTable(final N=32000);
    annotation(experiment(StopTime = 1));
    end TimeTable_N_32000;

    model TimeTable_N_64000
      extends Models.TimeTable(final N=64000);
    annotation(experiment(StopTime = 1));
    end TimeTable_N_64000;

    model TimeTable_N_128000
      extends Models.TimeTable(final N=128000);
    annotation(experiment(StopTime = 1));
    end TimeTable_N_128000;

    model TimeTable_N_256000
      extends Models.TimeTable(final N=256000);
    annotation(experiment(StopTime = 1));
    end TimeTable_N_256000;

    model TimeTable_N_512000
      extends Models.TimeTable(final N=512000);
    annotation(experiment(StopTime = 1));
    end TimeTable_N_512000;

    model TimeTable_N_1024000
      extends Models.TimeTable(final N=1024000);
    annotation(experiment(StopTime = 1));
    end TimeTable_N_1024000;
*/
    model CombiTimeTable_N_125
      extends Models.CombiTimeTable(final N=125);
    annotation(experiment(StopTime = 1));
    end CombiTimeTable_N_125;

    model CombiTimeTable_N_250
      extends Models.CombiTimeTable(final N=250);
    annotation(experiment(StopTime = 1));
    end CombiTimeTable_N_250;

    model CombiTimeTable_N_500
      extends Models.CombiTimeTable(final N=500);
    annotation(experiment(StopTime = 1));
    end CombiTimeTable_N_500;

    model CombiTimeTable_N_1000
      extends Models.CombiTimeTable(final N=1000);
    annotation(experiment(StopTime = 1));
    end CombiTimeTable_N_1000;

    model CombiTimeTable_N_2000
      extends Models.CombiTimeTable(final N=2000);
    annotation(experiment(StopTime = 1));
    end CombiTimeTable_N_2000;

    model CombiTimeTable_N_4000
      extends Models.CombiTimeTable(final N=4000);
    annotation(experiment(StopTime = 1));
    end CombiTimeTable_N_4000;

    model CombiTimeTable_N_8000
      extends Models.CombiTimeTable(final N=8000);
    annotation(experiment(StopTime = 1));
    end CombiTimeTable_N_8000;

    model CombiTimeTable_N_16000
      extends Models.CombiTimeTable(final N=16000);
    annotation(experiment(StopTime = 1));
    end CombiTimeTable_N_16000;
/*
    model CombiTimeTable_N_32000
      extends Models.CombiTimeTable(final N=32000);
    annotation(experiment(StopTime = 1));
    end CombiTimeTable_N_32000;

    model CombiTimeTable_N_64000
      extends Models.CombiTimeTable(final N=64000);
    annotation(experiment(StopTime = 1));
    end CombiTimeTable_N_64000;

    model CombiTimeTable_N_128000
      extends Models.CombiTimeTable(final N=128000);
    annotation(experiment(StopTime = 1));
    end CombiTimeTable_N_128000;

    model CombiTimeTable_N_256000
      extends Models.CombiTimeTable(final N=256000);
    annotation(experiment(StopTime = 1));
    end CombiTimeTable_N_256000;

    model CombiTimeTable_N_512000
      extends Models.CombiTimeTable(final N=512000);
    annotation(experiment(StopTime = 1));
    end CombiTimeTable_N_512000;

    model CombiTimeTable_N_1024000
      extends Models.CombiTimeTable(final N=1024000);
    annotation(experiment(StopTime = 1));
    end CombiTimeTable_N_1024000;
*/
  end ScaledExperiments;
  annotation(Documentation(info = "<html><p>For performance reasons, large tables should preferably be read from file, and thus be all dealt with in external C code.</p></html>"));
end Tables;
