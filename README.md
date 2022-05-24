# Phonon_band_structures_in_seconds_with_MATLAB

## Overview

This project explores phonon band structures using semi-classical physics. It is repeat of some of the calculations from my Master's thesis where I modelled the Phonon Hall Effect. Remarkably Hall effect problems can be modelled by 

* Assuming fictitious spring forces between the atoms.
* Solving eigenvalue problems.
* Computing topological constants and phases.

## How to run

* Request a license for MATLAB which is free for academics or offers a trial for individuals.

* You can either test MATLAB online in the browser or follow the graphical install process. It is also possible to use MATLAB  together with a Jupeyter notebook. Only the standard libraries are needed for this project.

* Save the required functions in the browser or on your local machine and execute a function by typing its name into the command prompt. As long all functions a given function calls are in the same folder it should work.


## Very brief summary of the problem

**The standard lattice vibrations problem from solid state physics:**

<p align="center">
<img src="https://github.com/ashleytsmith/Phonon_band_structures_in_seconds_with_MATLAB/blob/main/Images/quick_problem_summary.png" width="400" alt="see tex file if image doesn't show"> 
</p>


## Example 1: Square Lattice

**Diagram of the Square Lattice;**

<p align="center">
<img src="https://github.com/ashleytsmith/Phonon_band_structures_in_seconds_with_MATLAB/blob/main/Images/square_lattice.png" width="400" alt="diagram of the square lattice"> 
</p>

**How to solve;**

To solve for the phonon band structure all we need to do is construct the dynamical matrix which is shown in the first code snippet and then solve the eigenvalue equation which can be done rather easily in MATLAB using the second code snippet.

Construct the dynamical matrix:

```
function Dk=square_lattice_construct_dynamical_matrix(kx,ky)

% define input variables

k=1;   % spring constant
decay_factor = 1;   % give further away neighbours a different weight when desired
Kx=[k,0;0,k/4];   % spring constant matrix, longditudinal spring constant is 4 times larger than transverse

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

D0 = D1 + D2 + D3 + D4 + D5 + D6 + D7 + D8;
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


```

Solve the eigenvalue problem:

```
function eigenValues=square_lattice_solve_phonon_band_structure(kx,ky)

Dk=square_lattice_construct_dynamical_matrix(kx,ky);

eigenValues=eig(Dk);
eigenValues=sort(eigenValues); 
eigenValues=abs(eigenValues); % make sure only real part is returned
```

**Understanding the solution;**

For the square lattice there will be two bands. The x any y axis are the values of k_x and k_y which run between -pi and pi.

<p align="center">
<img src="https://github.com/ashleytsmith/Phonon_band_structures_in_seconds_with_MATLAB/blob/main/Images/square_lattice_heat_map.svg" width="400" alt="heat map of 2 bands for square lattice"> 
</p>

<p align="center">
<img src="https://github.com/ashleytsmith/Phonon_band_structures_in_seconds_with_MATLAB/blob/main/Images/square_lattice_2D_slice.svg" width="400" alt="slice across both bands"> 
</p>
