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
