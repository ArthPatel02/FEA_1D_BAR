% Prompt user for input of two variables
a = input('Enter the Domain of bar (Left) : ');
b = input('Enter the Domain of bar (Right): ');

% Display the entered values
 fprintf('Domain : (%g,%g)\n', a, b);

% Read the number of input points
totalNode = input('Enter the total number of nodes : ');

% Initialize a row vector for x-coordinates
nodeArray = zeros(1, totalNode);

disp('Enter the node location :');
for i = 1:totalNode
    nodeArray(i) = input(sprintf('Node(%d): ', i));
end


% Display the Node Array
disp('Entered Nodes are :');
disp(nodeArray);

% Define Sectional - Length Array
secLength = zeros(1, totalNode-1);

for i = 1:(totalNode-1)
    secLength(i) = nodeArray(i+1) - nodeArray(i);
end
disp('Section Length are :');
disp(secLength);

% Define Sectional - Elasticity Array
secMaterial = zeros(1, totalNode-1);

for i = 1:(totalNode-1)
    secMaterial(i) = input(sprintf('Enter Modulus of Elasticity E (GPa) for Section (%d): ', i));
end
disp('Elasticity Array :');
disp(secMaterial);

% Define Sectional - Area Array
secArea = zeros(1, totalNode-1);

for i = 1:(totalNode-1)
    secArea(i) = input(sprintf('Enter Cross-Sectional Area (sq. m) for Section (%d): ', i));
end
disp('Area Array :');
disp(secArea);

% Define Displacement BC 

totalBndc = input('Enter the total number of displacement boundary conditions: ');

% Initialize a 2D array for boundary node and displacement value
essBndc = zeros(totalBndc, 2);

for i = 1:totalBndc
    essBndc(i, 1) = input(sprintf('Enter boundary node for condition (%d): ', i));
    essBndc(i, 2) = input(sprintf('Enter displacement value for condition (%d): ', i));
end

% Display the d-BND Array
disp('Displacement Boundary Condition Array:');
disp(essBndc);

% Define force BC 

totalPfbnd = input('Enter the total number of Point Loads: ');

% Initialize a 2D array for boundary node and displacement value
norPF = zeros(totalPfbnd, 2);

for i = 1:totalPfbnd
    norPF(i, 1) = input(sprintf('Enter node for Point load (%d): ', i));
    norPF(i, 2) = input(sprintf('Enter magnitude (kN) for P-Load (%d): ', i));
end

% Display the d-BND Array
disp('Point Load Array :');
disp(norPF);

totalUfbnd = input('Enter the total number of Uniform Loads: ');

% Initialize a 2D array for boundary node and displacement value
norUF = zeros(totalUfbnd, 2);

for i = 1:totalUfbnd
    norUF(i, 1) = input(sprintf('Enter section for Uniform load (%d): ', i));
    norUF(i, 2) = input(sprintf('Enter magnitude (kN/m) for U-Load (%d): ', i));
end

% Display the d-BND Array
disp('Uniform Load Array :');
disp(norUF);