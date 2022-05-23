function square_lattice_plot_both_bands_2D_heatmap

% plotting variables

 N=50;  % number of grid points
 W=1;   % width of the axis

% calculate the band structure at every point on the grid

[X,Y]=meshgrid(-W*pi:pi/N:W*pi);
band1=zeros(2*W*N+1);
band2=zeros(2*W*N+1);

    for i=1:2*W*N+1

        for j=1:2*W*N+1

            eigenValues=square_lattice_solve_phonon_band_structure(X(i,j),Y(i,j)); 
            band1(i,j) = eigenValues(1);
            band2(i,j) = eigenValues(2); 

        end
    end

% normalise the results

maxValueInBand2 = max(band2, [], 'all');

band1 = band1 / maxValueInBand2;
band2 = band2 /maxValueInBand2;

bands = {band1,band2}; % put the bands into a list

% plot a 2 dimensional heat map

figure

ax = gca;
ax.FontSize = 14;

for k=1:2

    subplot(1,2,k);

    surf(X,Y,bands{k},'EdgeColor','None');
    view(2);      % can choose view 2 or 3
    colormap jet;
    colorbar('southoutside');
    set(gcf, 'color', [1 1 1]);

    xlabel('$\mathbf{k_x}$','Interpreter','latex')
    ylabel('$\mathbf{k_y}$','Interpreter','latex')

    set(gca,'XTick',-pi:pi/2:pi)
    set(gca,'XTickLabel',{'$-\pi$','$-\frac{\pi}{2}$','0','$\frac{\pi}{2}$','$\pi$'},'TickLabelInterpreter','latex')
    set(gca,'YTick',-pi:pi/2:pi)
    set(gca,'YTickLabel',{'$-\pi$','$-\frac{\pi}{2}$','0','$\frac{\pi}{2}$','$\pi$'},'TickLabelInterpreter','latex')
    
    end

sgtitle('$\omega_\sigma$ (arbitrary units)','Interpreter','latex')


