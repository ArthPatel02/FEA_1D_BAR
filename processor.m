% Prompt for material details 
E = input("Enter Eastic Modulus of bar in N/mm = ");
A = input("Enter Area of bar in m^2 =");
L = input("Enter Length of Bar in m = ");

% Prompt for element details
n = input("Enter the number of elements = ");

% function for element stiffness matrix
function Ke = elementStiffnessMatrix(E,A,L)
ke =  ((A*E)/L)*[[1 -1];[-1 1]];

% function for Global stiffness matrix
function K = globalStiffnessMatrix(n)
K = zeros(n,n);
ke = elementStiffnessMatrix(E,A,L);
for i= 1:n
K(i:i+1,i:i+1) = k(i:i+1,i:i+1) + ke;
end 

% function for Shape Function and its derivatives 
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
     