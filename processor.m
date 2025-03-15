% Prompt for material details 
E = input("Enter Eastic Modulus of bar in N/mm = ");
A = input("Enter Area of bar in m^2 =");
L = input("Enter Length of Bar in m = ");

% Prompt for element details
n = input("Enter the number of elements = ");

% function for element stiffness matrix
function Ke = elementStiffnessMatrix(E,A,L)
ke =  ((A*E)/L)*[[1 -1];[-1 1]];
end

% function for Global stiffness matrix
function K = globalStiffnessMatrix(n)
     K = zeros(n,n);
     ke = elementStiffnessMatrix(E,A,L);
   for i= 1:n
   K(i:i+1,i:i+1) = K(i:i+1,i:i+1) + ke;
   end 
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
end
     
    % function for internal and external force
    function [bi,F] = forceFunction(q,R,n)
        [N1,N2] = shapeFunction([0 2 4 6]);
        X = [0 2 4 6];
        numberofNodes = n;
                syms U1 U2 x
                U = N1*U1 + N2*U2;
                b1 = sym(zeros(numberofNodes-1,1));
                b2 = sym(zeros(numberofNodes-1,1));
                F = sym(zeros(numberofNodes-1,1));
        
        
              for j = 1:numberofNodes-1
                    f1(x) = N1(j)*R;
                    g1(x) = N1(j)*q;
                      f2(x) = N2(j)*R;
                    g2(x) = N2(j)*q;
        
                    b1(j) = int(g1,x,X(j),X(j+1)) + f1(X(4));
                    b2(j) = int(g2,x,X(j),X(j+1)) + f2(X(4));
                    
              end
              b1_padded = [b1;0];
              b2_padded = [0;b2];
              bi = zeros(numberofNodes,1);
              bi = b1_padded + b2_padded ;
              
        end
        
