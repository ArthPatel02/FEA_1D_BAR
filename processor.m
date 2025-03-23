% Prompt material details 
E = input("Enter Eastic Modulus of bar in N/mm: ");
disp('Elastic Modulus');
disp(E);

A = input("Enter Area of bar in m^2: ");
disp('Area');
disp(A);

L = input("Enter length of bar: ");
disp('Length');
disp(L);


% Nodes coordinates
X = input("Enter coordinates of Nodes : ");
disp('Coordinates of Nodes');
disp(X);

% Element details
n = numel(X)-1;
disp('Number of element: ');
disp(n);


Le = X(2)-X(1);  % assuming element of same length   
disp('Length of element');
disp(Le);

% Load details
q = input("Enter uniform distributed load in N: ");
disp('unifrom distrubted load');
disp(q);

nR = input("Enter the nodes at which concentrated load is acting in N:");
disp(' nodes at which concentrated load is acting');
disp(nR);

for i = 1:numel(nR)
R(i) = input(sprintf("Enter the concentrated load at Node (%d) in N: ",(nR(i))));
end
disp('concentrated load');
disp(R);

Fixed_DOF = input("Enter the numbers of nodes which has fixity:");
disp('fixity');
disp(Fixed_DOF);



Ke = elementStiffnessMatrix(E,A,Le);
disp('element stiffness matrix');
disp(Ke);

K = globalStiffnessMatrix(n,E,A,Le); 
disp('global stiffness matrix')
disp(K);

[N1,N2,D1,D2] = shapeFunction(X);
disp('Shape functions are');
disp(N1);
disp(N2);

[fe,F] = forceFunction(q,n,X,nR,R);
disp('total force');
disp(fe);
disp(F);

[U] = solution(F,K,Fixed_DOF,n);
disp('displacements');
disp(U);

[e,S] = strain_stress(U,E,X,n);
disp('strain in elements:')
disp(e);

disp('stress in elements:')
disp(S);

hold on
for i = 1:n
plot([X(i) X(i+1)],[S(i) S(i)],'b','LineWidth',2);
end
hold off

% function of element stiffness matrix

function Ke = elementStiffnessMatrix(E,A,Le)
  Ke =  ((A*E)/Le)*[[1 -1];[-1 1]];
  end

% function for global stiffness matrix

function K = globalStiffnessMatrix(n,E,A,Le)
  K = zeros(n+1,n+1);
  Ke = elementStiffnessMatrix(E,A,Le);
   for i= 1:n
       K(i:i+1,i:i+1) = K(i:i+1,i:i+1) + Ke;
   end
end

% function for shape function

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


% function for calculating total force

function [fe,F] = forceFunction(q,n,X,nR,R)
  [N1,N2] = shapeFunction(X);
 
  numberofNodes = n+1;
  syms U1 U2 x
          U = N1*U1 + N2*U2;
          fe1 = sym(zeros(numberofNodes-1,1));
          fe2 = sym(zeros(numberofNodes-1,1));
          f = sym(zeros(numberofNodes,1));
  
  
        for j = 1:numberofNodes-1
             
              g1(x) = N1(j)*q;
              g2(x) = N2(j)*q;
            
              fe1(j) = int(g1,x,X(j),X(j+1)) ;
              fe2(j) = int(g2,x,X(j),X(j+1)) ;
                   
        end
        fe1_padded = [fe1;0];
        fe2_padded = [0;fe2];
        fe = zeros(numberofNodes,1);
        fe = fe1_padded + fe2_padded ;
        for i = 1: numel(nR)
            fe(nR(i)) = fe(nR(i)) + R(i);
        end
       
            F = f + fe;  
        
  end

  % function for solving F = KX 
          
function [U] = solution(F,K,Fixed_DOF,n)
  U = zeros(n+1,1);
  active_DOF = setdiff((1:n+1)' , Fixed_DOF);
  
    U(active_DOF) = K(active_DOF,active_DOF)\F(active_DOF);
    
  end

  % function for calculating strain and stress in each elements

  function [e,S] = strain_stress(U,E,X,n)
    e = zeros(n,1);
    S = zeros(n,1);
    for i = 1:n
    e(i) = (U(i+1) - U(i))/(X(i+1)-X(i));
    S(i) = E*e(i);
    
    end

  end
  