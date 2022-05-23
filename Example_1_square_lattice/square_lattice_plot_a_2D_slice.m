function square_lattice_plot_a_2D_slice

% plotting variables

N=50;  % number of grid points
W=sqrt(2);     % width of axis

% calculate the band structure at every point along a 2 dimensional slice

X=-W*pi:2*pi*W/N:W*pi;  

x=X*cos(pi/4);     % take a diagonal slice
y=X*sin(pi/4);

band1=zeros(1,N+1); 
band2=zeros(1,N+1);

        for j=1:N+1

            eigenValues=square_lattice_solve_phonon_band_structure(x(j),y(j));
            band1(j) = eigenValues(1);
            band2(j) = eigenValues(2); 
        
        end

% normalise the results

band1 = band1 / max(band2);
band2 = band2 /max(band2);

bands = {band1,band2}; % put the bands into a list

%plot a 2 dimensional slice

figure

for k=1:2

    plot(X,bands{k})
    hold on

    end

set(gca,'XTick',-3*pi/2:pi/2:3*pi/2)
set(gca,'XTickLabel',{'$-\frac{3\pi}{2}$','$-\pi$','$-\frac{\pi}{2}$','0','$\frac{\pi}{2}$','$\pi$','$\frac{3\pi}{2}$'},'TickLabelInterpreter','latex')
set(gca,'YTick',-3*pi/2:pi/2:3*pi/2)
set(gca,'YTickLabel',{'$-\frac{3\pi}{2}$','$-\pi$','$-\frac{\pi}{2}$','0','$\frac{\pi}{2}$','$\pi$','$\frac{3\pi}{2}$'},'TickLabelInterpreter','latex')

ax = gca;
ax.FontSize = 12;
xlabel('$\mathbf{k}$ (along diagonal)','Interpreter','latex')
ylabel('$\omega_\sigma$ (arbitrary units)','Interpreter','latex')
legend({'\sigma = 1','\sigma = 2'},'Location','southwest')
