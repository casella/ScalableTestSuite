within ScalableTestSuite.Elementary;

package ParameterArrays "Models containing large parameter arrays"
  package Models
    model Table "Model containing a 2D Real array, initialized with a function"
      parameter Integer N = 2 "Number of table rows";
      parameter Integer M = 2 "Number of table columns";
      parameter Real tab[N,M] = f_tab(N,M);
    end Table;

    
    function f_tab "Computes initial parameter value"
      input Integer N;
      input Integer M;
      output Real y[N, M];
    algorithm
      for i in 1:N loop
        for j in 1:M loop
          y[i, j] := i*M + j;
        end for;
      end for;
    end f_tab;

  end Models;

  
  package Verification
    model Table "Verification model with N = 10, M = 5"
      extends Models.Table(N = 10, M = 5);
      annotation(experiment(StopTime = 1));
    end Table;
  end Verification;

  
  package ScaledExperiments
    model Table_N_50_M_50
      extends Models.Table(N = 50, M=50);
      annotation(experiment(Interval = 1, StopTime = 1));
    end Table_N_50_M_50;

    
    model Table_N_70_M_70
      extends Models.Table(N = 70, M=70);
      annotation(experiment(Interval = 1, StopTime = 1));
    end Table_N_70_M_70;

    
    model Table_N_100_M_100
      extends Models.Table(N = 100, M=100);
      annotation(experiment(Interval = 1, StopTime = 1));
    end Table_N_100_M_100;
  
    model Table_N_140_M_140
      extends Models.Table(N = 140, M=140);
      annotation(experiment(Interval = 1, StopTime = 1));
    end Table_N_140_M_140;
  
    model Table_N_200_M_200
      extends Models.Table(N = 200, M=200);
      annotation(experiment(Interval = 1, StopTime = 1));
    end Table_N_200_M_200;
  
    model Table_N_400_M_100
      extends Models.Table(N = 400, M=100);
      annotation(experiment(Interval = 1, StopTime = 1));
    end Table_N_400_M_100;
  
    model Table_N_800_M_50
      extends Models.Table(N = 800, M=50);
      annotation(experiment(Interval = 1, StopTime = 1));
    end Table_N_800_M_50;
  end ScaledExperiments;






end ParameterArrays;
