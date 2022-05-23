function eigenValues=square_lattice_solve_phonon_band_structure(kx,ky)

Dk=square_lattice_construct_dynamical_matrix(kx,ky);

eigenValues=eig(Dk);
eigenValues=sort(eigenValues); 
eigenValues=abs(eigenValues); % make sure only real part is returned




