$title Shortest Path Problem
*LIMROW = 0, LIMCOL = 0
*OPTIONS  ITERLIM=100000, RESLIM = 1000000, SYSOUT = OFF, SOLPRINT = OFF, lp = COINGLPK, mip = COINGLPK, OPTCR= 0.1;

set i nodes /1*4/;
alias (i, j);

parameter w(i,j) link travel time /
1. 2   6
1. 3   1
2. 4   1
3. 4   6
3. 2   1   
/;

parameter origin(i);
origin('1') = 1;

parameter destination(i);
destination('4') = 1;

parameter intermediate_node(i);
intermediate_node(i) = (1- origin(i))*(1- destination(i));

variable z;
positive variables
x(i,j)  selection of flow between i and j;

equations
so_obj                              define objective function
flow_on_node_origin
flow_on_node_intermediate(i)
flow_on_node_destination
;

so_obj.. z =e= sum((i,j)$(w(i,j)),w(i,j)*x(i,j));
flow_on_node_origin.. sum(j$(w('1',j)), x('1',j)) =e= 1;
flow_on_node_intermediate(i)$(intermediate_node(i)=1).. sum(j$(w(i,j)), x(i,j))-sum(j$(w(j,i)), x(j,i))=e= 0;
flow_on_node_destination..  sum(j$(w(j,'4')), x(j,'4'))=e= 1;

Model shortest_path_problem /all/ ;

solve shortest_path_problem using LP minimizing z;

display x.l;
display z.l;

