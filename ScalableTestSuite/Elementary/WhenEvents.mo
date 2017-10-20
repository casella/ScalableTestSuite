within ScalableTestSuite.Elementary;
package WhenEvents "Models large number of when statements and events"
  package Models
    model ManyEvents "Model with many events in when clauses"
      parameter Integer N = 5;
      Real x[N](each start = 0, each fixed = true);
      Boolean e[N](each start = false, each fixed = true);
    equation
      for i in 1:N loop
        der(x[i]) = 1/i;
        when x[i] > 1 then
          e[i] = true;
        end when;
      end for;
    end ManyEvents;
    
    model ManyEventsManyConditions "Model with many events in when clauses and a when clause with many triggering conditions"
      parameter Integer N = 5;
      Real x[N](each start = 0, each fixed = true);
      Boolean e[N](each start = false, each fixed = true);
      Integer v(start = 0, fixed = true);
    equation
      for i in 1:N loop
        der(x[i]) = 1/i;
        when x[i] > 1 then
          e[i] = true;
        end when;
      end for;
      when e then
        v = pre(v) + 1;
      end when;
    end ManyEventsManyConditions;
  end Models;
    
  package Verification
    model ManyEvents extends Models.ManyEvents(N = 100);
      annotation(experiment(StopTime = 10), 
        Documentation(info="<html><p>The model contains N integrators x[i] with different integration rates.
        When each state values crosses the value of one, a when clause is triggered, switching the
        corresponding boolean e[i] from false to true. </p>
        <p>If the model is run with StopTime = N/10, only about
        one tenth of the when clauses are actually triggered, to save on simulation time.</p></html>"));
    end ManyEvents;
    
    model ManyEventsManyConditions extends Models.ManyEventsManyConditions(N = 20);
      annotation(experiment(StopTime = 2), 
        Documentation(info="<html><p>The model contains N integrators x[i] with different integration rates.
        When each state values crosses the value of one, a when clause is triggered, switching the
        corresponding boolean e[i] from false to true. </p>
        <p>Additionally, a single when clause monitors the changes of the entire e vector, and increases the value
        of v by one each time any when clause is triggered.<p>
        <p>If the model is run with StopTime = N/10, only about
        one tenth of the when clauses are actually triggered, to save on simulation time.</p></html>"));
    end ManyEventsManyConditions;
    
  end Verification;
  package ScaledExperiments
    extends Modelica.Icons.ExamplesPackage;

    model ManyEvents_N_1000
      extends Models.ManyEvents(N = 1000);
      annotation(experiment(StopTime = 100, Tolerance = 1e-6),
        __OpenModelica_simulationFlags(s = "rungekuttaSsc"));
    end ManyEvents_N_1000;

    
    model ManyEvents_N_2000
      extends Models.ManyEvents(N = 2000);
      annotation(experiment(StopTime = 200, Tolerance = 1e-6),
        __OpenModelica_simulationFlags(s = "rungekuttaSsc"));
    end ManyEvents_N_2000;                      
  
    model ManyEvents_N_4000
      extends Models.ManyEvents(N = 4000);
      annotation(experiment(StopTime = 400, Tolerance = 1e-6),
        __OpenModelica_simulationFlags(s = "rungekuttaSsc"));
    end ManyEvents_N_4000;
    
    model ManyEvents_N_8000
      extends Models.ManyEvents(N=8000);
      annotation(experiment(StopTime = 800, Tolerance = 1e-6),
        __OpenModelica_simulationFlags(s = "rungekuttaSsc"));
    end ManyEvents_N_8000;
  
    model ManyEventsManyConditions_N_1000
      extends Models.ManyEventsManyConditions(N = 1000);
      annotation(experiment(StopTime = 100, Tolerance = 1e-6),
        __OpenModelica_simulationFlags(s = "rungekuttaSsc"));
    end ManyEventsManyConditions_N_1000;
    
    model ManyEventsManyConditions_N_2000
      extends Models.ManyEventsManyConditions(N = 2000);
      annotation(experiment(StopTime = 200, Tolerance = 1e-6),
        __OpenModelica_simulationFlags(s = "rungekuttaSsc"));
    end ManyEventsManyConditions_N_2000;
  
    model ManyEventsManyConditions_N_4000
      extends Models.ManyEventsManyConditions(N = 4000);
      annotation(experiment(StopTime = 400, Tolerance = 1e-6),
        __OpenModelica_simulationFlags(s = "rungekuttaSsc"));
    end ManyEventsManyConditions_N_4000;
    
    model ManyEventsManyConditions_N_8000               
      extends Models.ManyEventsManyConditions(N=8000);
      annotation(experiment(StopTime = 800, Tolerance = 1e-6),
        __OpenModelica_simulationFlags(s = "rungekuttaSsc"));
    end ManyEventsManyConditions_N_8000;
  end ScaledExperiments;
end WhenEvents;
