function Dk = kagome_lattice_construct_dynamical_matrix(kx,ky)

% define input variables

k=1;              % spring constant
Kx=[k,0;0,k/4];   % spring constant matrix, longitudinal spring constant is 4 times larger than transverse

% coupling terms 

D01=-Kx; 
D02=rotate_2D_matrix(D01,pi/3);
D03=rotate_2D_matrix(D01,-pi/3);

% nearest neighbour terms

O = zeros(2);

D1=[ O,O,O;         % corresponds to a term DO1*(u_2(R_0)- u_1 (R_1))^2 where only the cross term survives
    D01,O,O;
     O,O,O];

D2=[O,O,O;
    O,O,O;
    D02,O,O];

D3=[O,O,O;
    O,O,O;
    O,D03,O];

D4=[O,D01,O;
    O,O,O;
    O,O,O];

D5=[O,O,D02;
    O,O,O;
    O,O,O];

D6=[O,O,O;
    O,O,D03;
    O,O,O];

% on site term

D0 = D1 + D2 + D3 + D4 + D5 + D6 - ...
   2*[D01+D02,O,O;
      O,D01+D03,O;
      O,O,D02+D03];


%sum up terms to form Dk

Dk = D0 + ...
D1*exp(i*kx) + ... 
D2*exp(i/2*(kx+sqrt(3)*ky)) + ...
D3*exp(i/2*(-kx+sqrt(3)*ky)) + ... 
D4*exp(-i*kx) + ...
D5*exp(-i/2*(kx+sqrt(3)*ky)) + ...
D6*exp(i/2*(kx-sqrt(3)*ky));



