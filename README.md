# Phonon_band_structures_in_seconds_with_MATLAB

## Overview

This project explores Phonon band structures using semi-classical physics. It is based upon my Masters thesis where I modelled the Phonon Hall Effect. Remarkably Hall effect problems can be modelled by 

* Assuming fictitious spring forces between the atoms.
* Solving eigenvalue problems.
* Computing topological constants and phases.

## How to run

* Request a license for MATLAB which is free for academics or offers a trial for individuals.

* You can either test MATLAB online in the browser or follow the graphical install process. It is also possible to use MATLAB  together with a Jupeyter notebook. Only the standard libraries are needed for this project.

* Save the required functions in the browser or on your local machine and execute a function by typing its name into the command prompt. As long all functions a given function calls are in the same folder it should work.


## Very brief summary of the problem

**The standard lattice vibrations problem from solid state physics:**

$$M \omega^2\boldsymbol{\epsilon}=D(\mathbf{k})\boldsymbol{\epsilon}$$

$$D(\mathbf{k})=\sum_{\textbf{R}} D(\mathbf{ R})e^{-i\mathbf{k} \cdot \mathbf{R}}$$

$D(\mathbf{k})$ is a $nd\times nd$ matrix. Where $n$ is the number of atoms in a unit cell and $d$ is the spatial dimension.
It repesents th coupling between the atoms. The eigenvectors $\boldsymbol{\epsilon}$ are indexed by $\sigma$ which runs from 1 to $nd$. They are normal modes with frequency $\omega_\sigma$. Being normal modes the motion of the system can always be expressed as a superposition of them and they are orthonormal. The eigenvalue equation above can be solved at each $\mathbf{k}$ point. The band structure ($\omega_\sigma$ as a function of $\mathbf{k}$) is found by doing this for many $\mathbf{k}$ points. M is the mass which will be taken as a constant here but could of course vary for different atoms types.


## Example 1: Square Lattice

We uttilise MATLAB's powerful linear algebra libraries and solve our problem with very few lines of code.

```
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
```

For the square lattice there will be two bands. The x any y axis are the values of k_x and k_y which run between -pi and pi.

<p align="center">
<img src="https://github.com/ashleytsmith/Phonon_band_structures_in_seconds_with_MATLAB/blob/main/Images/square_lattice_heat_map.svg" width="400" alt="heat map of 2 bands for square lattice"> 
</p>

<p align="center">
<img src="https://github.com/ashleytsmith/Phonon_band_structures_in_seconds_with_MATLAB/blob/main/Images/square_lattice_2D_slice.svg" width="400" alt="slice across both bands"> 
</p>
