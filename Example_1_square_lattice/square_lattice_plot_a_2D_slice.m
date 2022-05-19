function square_lattice_plot_a_2D_slice
W=sqrt(2); X=-W*pi:2*pi*W/100:W*pi; 
f=zeros(1,101); g=zeros(1,101);
 x=X*cos(pi/4);
 y=X*sin(pi/4);
        for j=1:101
            f(j)=square_lattice_solve_phonon_band_structure(x(j),y(j),1);
            g(j)=square_lattice_solve_phonon_band_structure(x(j),y(j),2);
        end
figure
k=1;
plot(X,f)
hold on
k=2;
plot(X,g)