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

% Define Section
secLength = zeros(1, totalNode-1);

for i = 1:(totalNode-1)
    secLength(i) = nodeArray(i+1) - nodeArray(i);
end
disp('Section Length are : :');
disp(secLength);