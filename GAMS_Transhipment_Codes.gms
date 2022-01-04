\$title Transportation problem
Sets
    n global set /Memphis, Denver,New_York, Chicago, Los_Angles, Boston /
    i(n) Suppliers /Memphis, Denver/
    j(n) Transshipment points / New_York, Chicago/
    k(n) Destination /Los_Angles, Boston/;
alias (n, nn);

Table c(n,nn) from n to nn
            Memphis Denver  New_York    Chicago Los_Angles  Boston
Memphis     99999   99999   8           13      25          28
Denver      99999   99999   15          12      26          25
New_York    99999   99999   99999       6       16          17
Chicago     99999   99999   6           99999   14          16
Los_Angles  99999   99999   99999       99999   99999       99999
Boston      99999   99999   99999       99999   99999       99999;

Table A(n,nn) from n to nn
            Memphis Denver  New_York    Chicago Los_Angles  Boston
Memphis     0          0        1           1      1          1
Denver      0          0        1           1      1          1
New_York    0          0        0           1      1          1
Chicago     0          0        1           0      1          1
Los_Angles  0          0        0           0      0          0
Boston      0          0        0           0      0          0;


parameter CAP(n)/
Memphis 150
Denver 200
/;

parameter DEM(n)/
Los_Angles 130
Boston 130
/;

variable z;
positive variables  x(n,nn);

equations
eq1
eq2
eq3
obj
;
*Constratrains
eq1(i).. sum(j$(A(i,j)=1),x(i,j)) + sum (k$(A(i,k)=1),x(i,k)) =l= CAP(i);
eq2(k).. sum(j$(A(j,k)=1),x(j,k)) + sum (i$(A(i,k)=1),x(i,k)) =g= DEM(k);
eq3(j).. sum(i$(A(i,j)=1),x(i,j)) + sum(k$(A(k,j)=1),x(k,j)) =e= sum(k$(A(j,k)=1),x(j,k)) + sum (i$(A(j,i)=1),x(j,i)) ;
*eq3(j).. sum(i$(A(i,j)=1),x(i,j)) + sum(k$(A(k,j)=1),x(k,j))+ sum(j$(A(j,j)=1),x(j,j)) =e= sum(k$(A(j,k)=1),x(j,k)) + sum (i$(A(j,i)=1),x(j,i))+ sum(j$(A(j,j)=1),x(j,j));
*Objective Function
obj.. z =e= sum((i,j),c(i,j)*x(i,j))+ sum((j,k),c(j,k)*x(j,k))+ sum((i,k),c(i,k)*x(i,k)) ;
*obj.. z =e= sum((i,j),c(i,j)*x(i,j))+ sum((j,k),c(j,k)*x(j,k))+ sum((i,k),c(i,k)*x(i,k))+ sum((j,j),c(j,j)*x(j,j)) ;

Model problem_2 /all/;
solve problem_2 using LP minimizing z;

display x.l;
display z.l;
