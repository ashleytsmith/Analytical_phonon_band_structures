function square_lattice_plot_both_bands_2D_heatmap(h,varargin)

% check user input 

isField=check_number_of_arguments_from_user(nargin);

% plotting variables

 N=50;  % number of grid points
 W=1;   % width of the axis

% calculate the band structure at every point on the grid

[X,Y]=meshgrid(-W*pi:pi/N:W*pi);

band1=zeros(2*W*N+1);
band2=zeros(2*W*N+1);
band1WithField=zeros(2*W*N+1);
band2WithField=zeros(2*W*N+1);


    for i=1:2*W*N+1

        for j=1:2*W*N+1

            if ~isField     % case without a field

                eigenValues=square_lattice_solve_phonon_band_structure(X(i,j),Y(i,j)); 
                
                band1(i,j) = eigenValues(1);
                band2(i,j) = eigenValues(2); 

            end

            if isField         % case with a field    

                eigenValues=square_lattice_with_constant_field_solve_phonon_band_structure(X(i,j),Y(i,j),0); 
                
                band1(i,j) = eigenValues(1);
                band2(i,j) = eigenValues(2);                                                                

                eigenValuesWithField=square_lattice_with_constant_field_solve_phonon_band_structure(X(i,j),Y(i,j),h);
           
                band1WithField(i,j) = eigenValuesWithField(1);
                band2WithField(i,j) = eigenValuesWithField(2); 

            end    
        end
    end

% normalise the results

maximum_no_field = max(band2, [], 'all');

bands = normalise_the_band_structure(band1,band2,band1WithField,band2WithField,maximum_no_field,isField);

maxValueOfTopBand = max(bands{2}, [], 'all');  % max value after normalising

% plot a 2 dimensional heat map

figure

set(gcf, 'color', [1 1 1]);     % set background color to white
ax = gca;
ax.FontSize = 14;
colormap jet;

cold = 0;                   % manual values supplied to the color map
hot = maxValueOfTopBand;

tiles = tiledlayout(1,2);
tiles.TileSpacing = 'compact';

for k=1:2

    %subplot(1,2,k);
    nexttile
    
    surf(X,Y,bands{k},'EdgeColor','None');      % setting edge color to none removes the grid lines
    view(2);      % can choose view 2 or 3, 2 rotates to a brids eye view, 3 is a surface
          
    set(gca,'clim',[cold hot]);    % ensure both colormaps have same colorbarScale
    
    xlabel('$\mathbf{k_x}$','Interpreter','latex')
    ylabel('$\mathbf{k_y}$','Interpreter','latex')

    set(gca,'XTick',-pi:pi/2:pi)
    set(gca,'XTickLabel',{'$-\pi$','$-\frac{\pi}{2}$','0','$\frac{\pi}{2}$','$\pi$'},'TickLabelInterpreter','latex')
    set(gca,'YTick',-pi:pi/2:pi)
    set(gca,'YTickLabel',{'$-\pi$','$-\frac{\pi}{2}$','0','$\frac{\pi}{2}$','$\pi$'},'TickLabelInterpreter','latex')
    
    end

sgtitle('$\omega_\sigma$ (arbitrary units)','Interpreter','latex')
colorbar('Position',[0.9 0.25 0.05 0.5]);  

if isField

    text = [newline 'h = ' num2str(h)];
    xTextbox = 0.47;
    yTextbox = 0.0;
    widthTextbox = 0.1;
    heightTextbox = 0.1;
    annotation('textbox', [xTextbox, yTextbox, widthTextbox, heightTextbox], 'EdgeColor', 'none','FontSize', 14, 'String', text)

end
