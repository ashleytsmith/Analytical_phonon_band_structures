function f=square_lattice_solve_phonon_band_structure(kx,ky,l)
k=0.144;
D1=-k*[1,0;0,0]; D2=-k*[0,0;0,1]; 
D3=-k*[1,0;0,0]; D4=-k*[0,0;0,1];
D5=rotations(D1,pi/4); D6=rotations(D1,3*pi/4); 
D7=rotations(D1,5*pi/4); D8=rotations(D1,7*pi/4);
Dk = D1*(exp(-i*kx)-1)+D2*(exp(-i*ky)-1)+D3*(exp(i*kx)-1)+ ...
D4*(exp(i*ky)-1)+D5*(exp(-i*(kx+ky))-1)+D6*(exp(-i*(-kx+ky))-1)+ ...
D7*(exp(-i*(-kx-ky))-1)+D8*(exp(-i*(kx-ky))-1);
e=eig(Dk);
es=sort(e);
f=abs(es(l));