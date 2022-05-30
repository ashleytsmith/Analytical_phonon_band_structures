function plot_2D_heatmap(latticeType,h,varargin)

% plotting variables

 N=50;  % number of grid points
 W=1;   % width of the axis
 scaleColorbars = false;

% check user input and determine problem to solve

isField=check_number_of_arguments_from_user(nargin);
[problemToSolve, Nbands] = determine_problem_to_solve(latticeType, isField);

% set up before solving

[X,Y]=meshgrid(-W*pi:pi/N:W*pi);

bands = {};     % empty cell array

for k=1:Nbands  

    emptyBand = zeros(2*W*N+1);   
    bands{k} = emptyBand;                
    bandsWithField{k} = emptyBand;   % cell array of empty bands

end

% calculate the band structure at every point on the grid

for i=1:2*W*N+1

    for j=1:2*W*N+1

        if ~isField     % case without a field

            eigenValues=problemToSolve(X(i,j),Y(i,j));

            for k=1:Nbands
                    
                bands{k}(i,j) = eigenValues(k);
            
            end
                
        end

        if isField         % case with a field    

            eigenValues=problemToSolve(X(i,j),Y(i,j),0); 
                
            for k=1:Nbands
                    
                bands{k}(i,j) = eigenValues(k);
            
            end                                                               

            eigenValuesWithField=problemToSolve(X(i,j),Y(i,j),h);

             for k=1:Nbands
                    
                bandsWithField{k}(i,j) = eigenValuesWithField(k);
            
            end

        end    
    
    end

end

% normalise the results

[bands, maxValueOfTopBand] = normalise_the_band_structure(bands, bandsWithField, Nbands, isField);

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

for k=1:Nbands

    %subplot(1,2,k);
    nexttile
    
    surf(X,Y,bands{k},'EdgeColor','None');      % setting edge color to none removes the grid lines
    view(2);      % can choose view 2 or 3, 2 rotates to a brids eye view, 3 is a surface

    if scaleColorbars

        set(gca,'clim',[cold hot]);    % ensure both colormaps have same colorbarScale

    else 
    
        colorbar('southoutside');

    end
    
    xlabel('$\mathbf{k_x}$','Interpreter','latex')
    ylabel('$\mathbf{k_y}$','Interpreter','latex')

    set(gca,'XTick',-pi:pi/2:pi)
    set(gca,'XTickLabel',{'$-\pi$','$-\frac{\pi}{2}$','0','$\frac{\pi}{2}$','$\pi$'},'TickLabelInterpreter','latex')
    set(gca,'YTick',-pi:pi/2:pi)
    set(gca,'YTickLabel',{'$-\pi$','$-\frac{\pi}{2}$','0','$\frac{\pi}{2}$','$\pi$'},'TickLabelInterpreter','latex')
    
    end

sgtitle('$\omega_\sigma$ (arbitrary units)','Interpreter','latex')

if scaleColorbars

    colorbar('Position',[0.9 0.25 0.05 0.5]);

end 

if isField

    text = [newline 'h = ' num2str(h)];
    xTextbox = 0.8;
    yTextbox = 0.925;
    widthTextbox = 0.1;
    heightTextbox = 0.1;
    annotation('textbox', [xTextbox, yTextbox, widthTextbox, heightTextbox], 'EdgeColor', 'none','FontSize', 14, 'String', text)

end
