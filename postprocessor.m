% // Graph of nodal displacement along  with  coordinates
% // Co = coordinates , ND = nodal displacement
% ND = [1,2,3,4,5,6,7,8,9,10]
% Co = [1.5,2.5,3.5,4,5.5,6.6,7,8,9,9.5]
% plot(Co,ND,"-Ro")

K = [1 0 0 ; 0 2 -1 ; 0 -1 1] 
F = [0 ; 2.5 ; 10]

y = inv(K)
U = y*F