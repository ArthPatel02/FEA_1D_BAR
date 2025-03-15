% Parameters
L = 1.0;                 % Length of the bar (meters)
Nx = 2;                  % Number of elements
E = 1;                   % Young's Modulus (Pa)
A = 1;                    % Cross-sectional Area (m^2)
F = [0;0;10];          % Applied axial force (N)
q = [5;0];               % Applied uniform force (N/m)

% Node coordinates
x = linspace(0, L, Nx + 1);

% Initialize stiffness matrix and force vector
K_global = zeros(Nx + 1, Nx + 1);
F_urial = zeros(Nx + 1, 1);

% Assembly of stiffness matrix and force vector
for i = 1:Nx
    ke = (E * A / L) * [1, -1; -1, 1];
    fe = q(i)/2 * [1; 1];
    
    nodes = [i, i+1];
    K_global(nodes, nodes) = K_global(nodes, nodes) + ke;
    F_urial(nodes) = F_urial(nodes) + fe;
end

F_global = F_urial + F ;

% Apply boundary conditions (fixed ends)
K_global(1, :) = 0;
K_global(:,1) = 0;
K_global(1, 1) = 1;
F_global(1) = 0;

Y = inv(K_global);
U = Y*F_global

