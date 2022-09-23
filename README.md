# Analytical Phonon Band Structures
## Overview

This project explores phonon band structures using semi-classical physics. It is repeat of some of the calculations from my Master's thesis where I modelled the Phonon Hall Effect. Remarkably Hall effect problems can be modelled by 

* Assuming fictitious spring forces between the atoms.
* Solving eigenvalue problems.
* Computing topological constants and phases.

## How to run

* Request a license for MATLAB which is free for academics or offers a trial for individuals.

* You can either test MATLAB online in the browser or follow the graphical install process. It is also possible to use MATLAB  together with a Jupeyter notebook. Only the standard libraries are needed for this project.

* Save the required functions in the browser or on your local machine and execute a function by typing its name into the command prompt. For example, make_a_gif_for_varying_field( 'square_lattice', @plot_2D_slice) executes make_a_gif_for_varying_field.m passing in the string 'square_lattice' and the function handle @plot_2D_slice.  All functions a given function calls need to be in the same folders or you need to tell MATLAB how to find them with addpath.

## Very brief summary of the problem

**The standard lattice vibrations problem from solid state physics:**

<p align="center">
<img src="https://github.com/ashleytsmith/Phonon_band_structures_in_seconds_with_MATLAB/blob/main/Images/quick_problem_summary.png" width="400" alt="see tex file if image doesn't show"> 
</p>


## Example 1: Square Lattice

**Illustration of the Square Lattice;**

<p align="center">
<img src="https://github.com/ashleytsmith/Phonon_band_structures_in_seconds_with_MATLAB/blob/main/Images/square_lattice.png" width="400" alt="diagram of the square lattice"> 
</p>

<p align="center">
<img src="https://github.com/ashleytsmith/Phonon_band_structures_in_seconds_with_MATLAB/blob/main/Images/square_lattice_potential.png" width="400" alt="potential for the square lattice"> 
</p>

**How to solve;**

To solve for the phonon band structure all we need to do is construct the dynamical matrix which is shown in the first code snippet and then solve the eigenvalue equation which can be done rather easily in MATLAB using the second code snippet. 

Construct the dynamical matrix:

```
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

Choices made:

To keep things simple I chose k=1 and normalised the solution so that the max value of the top band is 1. This is a nice choice because later if we choose to do something like add a field the size of the effect observed can easily compared to how stiff our springs are. I used a rough rule of thumb which comes from experimental observations that the longitudinal spring constant is 4 times larger than transverse, as the problem is very symmetric here the couplings cancel out in such a way that this assumption doesn't matter. Lastly, I didn't scale how the couplings fall off with distance and in this case I found that simply dividing by the inverse of the distance did not significantly impact the result.

<p align="center">
<img src="https://github.com/ashleytsmith/Phonon_band_structures_in_seconds_with_MATLAB/blob/main/Images/square_lattice_heat_map.svg" width="400" alt="heat map of 2 bands for square lattice"> 
</p>

<p align="center">
<img src="https://github.com/ashleytsmith/Phonon_band_structures_in_seconds_with_MATLAB/blob/main/Images/square_lattice_2D_slice.svg" width="400" alt="slice across both bands"> 
</p>

Comments:

Firstly, we can see both eigenvalues are zero at k=(0,0). This is because at k=(0,0) the dynamical matrix becomes a constant multiplied by the identity matrix so the eigenvalue has to be zero. We can also expect that at the edges of the Brillouin zone the solutions on either side must match up due to Born-von Karmen boundary conditions. Lastly we can see the first band is more square and the second more spherical which means nearest neighbour contributions are likely dominating for this band.

## Adding a field

<p align="center">
<img src="https://github.com/ashleytsmith/Phonon_band_structures_in_seconds_with_MATLAB/blob/main/Images/adding_a_field_problem_update.png" width="400" alt="latex for the case with a field"> 
</p>

Its possible to prove the result above by computing Hamilton’s equations and using Bloch's theorem.	 We end up with a non-Hermitian eigenvalue problem where the system to solve is twice the size but with the extra solutions being degenerate.


## Example 2: Square Lattice with a magnetic field

Solving the eigenvalue problem in the presence of a field is still very straightforward and uses the eig() function again.

```
function eigenValues=square_lattice_with_constant_field_solve_phonon_band_structure(kx,ky,h)

Dk=square_lattice_construct_dynamical_matrix(kx,ky); % construct dynamical matrix just like the non-field case 

B=[0,h;-h,0];   % magnetic field term 
I= eye(2);      % identity matrix

H=i*[-B,-Dk; I,-B];    % hamiltonian with a field

eigenValues=eig(H); 
eigenValues=abs(eigenValues); % convert to real absolute values
eigenValues=sort(eigenValues);
eigenValues = eigenValues([2,4 :end]); % remove degenerate solutions
```

Choices made:


Everything is normalized relative to the no field case so from the height of the bands it’s easy to see how big the effect of the field is in comparison. 

<p align="center">
<img src="https://github.com/ashleytsmith/Phonon_band_structures_in_seconds_with_MATLAB/blob/main/Images/square_lattice_changing_field_2D_slice.gif" width="400" alt="slice across both bands with varying field"> 
</p>

Comments:

Turning on the field causes the bands to separate with the top band increasing in energy and the bottom band flattening. 
The field is said to break the symettry and ‘lift’ the degeneracies which occur at the origin and at the edges of the Brillouin zone.



## Example 3: The Kagome lattice with a magnetic field

**Illustration of the Kagome Lattice:**

<p align="center">
<img src="https://github.com/ashleytsmith/Phonon_band_structures_in_seconds_with_MATLAB/blob/main/Images/kagome_lattice.png" width="400" alt="diagram of the kagome lattice"> 
</p>

<p align="center">
<img src="https://github.com/ashleytsmith/Phonon_band_structures_in_seconds_with_MATLAB/blob/main/Images/kagome_lattice_potential.png" width="400" alt="potential for the kagome lattice"> 
</p>


**Solution for the Kagome lattice;**

<p align="center">
<img src="https://github.com/ashleytsmith/Phonon_band_structures_in_seconds_with_MATLAB/blob/main/Images/kagome_lattice_changing_field_2D_slice.gif" width="400" alt="slice across the bands for the kagome lattice"> 
</p>

<p align="center">
<img src="https://github.com/ashleytsmith/Phonon_band_structures_in_seconds_with_MATLAB/blob/main/Images/kagome_lattice_changing_field_2D_heatmap.gif" width="400" alt="heat map of the bands for kagome lattice"> 
</p>

Comments:

There many cases where the bands either touch or cross with changing magnetic field, for example, one of easiest crossing events to see is at the origin when the field turns on. 3-fold and 6-fold symmetric structures appear and disappear as the field moves up and down, particularly for the middle four bands. 

Many macroscopic physical effects can be captured by crossing of the bands in the band structure related to that particular problem. Its commonly reported that the Square lattice does not exhibit large Phonon Hall currents whereas the Kagome lattice does. This is likely correlated with the Kagome lattice possessing many clear band crossings when compared with the Square lattice.



# Extension ideas

A nice way to extend this project would be to do the calculation for another lattice, something like graphene which is known for having novel physical and chemical properties would be a great choice. The scripts for the solver and the dynamical matrix would need to be written and minor edits would need to be made to the plotting scripts.  Working out the force constant matrices would likely be the most difficult part because as it’s really easy to make a silly slip when you do it the first few times, luckily however this will often reflect itself in the solution indicating something needs to be changed.

A more advanced extension would be to explore some topological properties e.g. Berry curvatures, Berry phases and Chern numbers and to work out the Phonon Hall current. Another movie but this time with the Berry curvature changing with magnetic field could look really good. 

