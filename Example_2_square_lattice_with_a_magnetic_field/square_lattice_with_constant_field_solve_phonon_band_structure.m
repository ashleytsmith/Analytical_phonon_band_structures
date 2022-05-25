function eigenValues=square_lattice_with_constant_field_solve_phonon_band_structure(kx,ky,h)

Dk=square_lattice_construct_dynamical_matrix(kx,ky); % construct dynamical matrix just like the non-field case 

B=[0,h;-h,0];   % magnetic field term 
I= eye(2);      % identity matrix

H=i*[-B,-Dk; I,-B];    %hamiltonian with a field

e=[0;0;0;0];

eigenValues=eig(H); 
eigenValues=abs(eigenValues); % convert to real absolute values
eigenValues=sort(eigenValues);
eigenValues = eigenValues([2,4 :end]); % remove degenerate solutions