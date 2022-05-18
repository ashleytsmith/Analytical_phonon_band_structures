function square_lattice_plot_both_bands_2D_heatmap
figure
for k=1:2
   subplot(1,2,k);
   N=50; W=1; % N changes the density of point and W changes the width of the region over which one plots
   [X,Y]=meshgrid(-W*pi:pi/N:W*pi); f=zeros(2*W*N+1);
    for i=1:2*W*N+1
        for j=1:2*W*N+1
            f(i,j)=square_lattice_solve_phonon_band_structure(X(i,j),Y(i,j),k);
        end
    end
surf(X,Y,f,'EdgeColor','None');
view(2);
colormap jet;
colorbar('southoutside');
set(gcf, 'color', [1 1 1]);
end
