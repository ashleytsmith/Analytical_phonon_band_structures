function eigenValues=square_lattice_with_field_solve_phonon_band_structure(kx,ky,h)

Dk=square_lattice_construct_dynamical_matrix(kx,ky); % construct dynamical matrix just like the non-field case 

B=[0,h;-h,0];   % magnetic field term 
I= eye(2);      % identity matrix

H=i*[-B,-(h*h*I+Dk); I,-B];    % hamiltonian with a field

eigenValues=eig(H); 
eigenValues=abs(eigenValues); % convert to real absolute values
eigenValues=sort(eigenValues);
eigenValues = eigenValues([2,4 :end]); % remove degenerate solutions