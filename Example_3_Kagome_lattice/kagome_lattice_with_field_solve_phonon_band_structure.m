function eigenValues = kagome_lattice_with_field_solve_phonon_band_structure(kx,ky,h)

Dk=kagome_lattice_construct_dynamical_matrix(kx,ky);

b = [0,h;-h,0];
B = blkdiag(b,b,b);   % magnetic field term 
I = eye(6);           % identity matrix

H=i*[-B,-(h*h*I + Dk); I ,-B];  % hamiltonian with a field

eigenValues=eig(H); 
eigenValues=abs(eigenValues); % convert to real absolute values
eigenValues=sort(eigenValues);
eigenValues = eigenValues([2,4,6,8,10,12 :end]); % remove degenerate solutions
