function Dk=square_lattice_construct_dynamical_matrix(kx,ky)

% define input variables

k=1;   % spring constant
decay_factor = 1;   % give further away neighbours a different weight when desired
Kx=[k,0;0,k/4];   % spring constant matrix, longitudinal spring constant is 4 times larger than transverse

% nearest neighbour terms

D1=-Kx;
D2=rotate_2D_matrix(D1,pi/2);
D3=rotate_2D_matrix(D1,pi);
D4=rotate_2D_matrix(D1,3*pi/2);

% next nearest neighbour terms

D5=decay_factor*rotate_2D_matrix(D1,pi/4); 
D6=decay_factor*rotate_2D_matrix(D1,3*pi/4); 
D7=decay_factor*rotate_2D_matrix(D1,5*pi/4);
D8=decay_factor*rotate_2D_matrix(D1,7*pi/4);

% on site term

D0 = D1 + D2 + D3 + D4 + D5 + D6 + D7 + D8;        % comes from contributions from the (u(R_0))^2 terms
D0 = - D0;
D0 = diag(diag(D0));  % Only take diagonal elements

%sum up terms to form Dk

Dk = D0 + ...
D1*exp(-i*kx) + ...
D2*exp(-i*ky) + ...
D3*exp(i*kx) + ...
D4*exp(i*ky) + ...
D5*exp(-i*(kx+ky)) + ...
D6*exp(-i*(-kx+ky)) + ...
D7*exp(-i*(-kx-ky)) + ...
D8*exp(-i*(kx-ky));

