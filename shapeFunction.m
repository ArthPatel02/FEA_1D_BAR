function [N1,N2,D1,D2] = shapeFunction(X)
syms x
numberofNodes = numel(X);
N1 = sym(zeros(1,numberofNodes-1));
N2 = sym(zeros(1,numberofNodes-1));
D1 = sym(zeros(1,numberofNodes-1));
D2 = sym(zeros(1,numberofNodes-1));

for i = 1:numberofNodes-1
N1(i) = (X(i+1)-x)/(X(i+1)-X(i));
N2(i) = (x-X(i))/(X(i+1)-X(i));
D1(i) = diff(N1(i),x);
D2(i) = diff(N2(i),x);
end
 