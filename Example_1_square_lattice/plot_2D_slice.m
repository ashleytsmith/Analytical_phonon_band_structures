%  Input parameters      only need to be specified when solving with a field
%  latticeType           a string specifying the lattice to be used
%  h                     size of the field

function plot_2D_slice(latticeType,h,varargin)

% plotting variables

N=100;  % number of grid points

if latticeType == 'square_lattice'

    W=sqrt(2);   % width of the axis
    sliceAlong = pi/4;  % direction to slice along
    XTicks = -3*pi/2:pi/2:3*pi/2;
    XTickLabels = {'$-\frac{3\pi}{2}$','$-\pi$','$-\frac{\pi}{2}$','0','$\frac{\pi}{2}$','$\pi$','$\frac{3\pi}{2}$'};
    Xlabel = '$\mathbf{k}$ (along diagonal)';
 
end

if latticeType == 'kagome_lattice'

    W = 2;   % width of the axis
    sliceAlong = 0;  % direction to slice along
    XTicks = -2*pi:pi:2*pi;
    XTickLabels = {'$-2\pi$','$-\pi$','0','$\pi$', '$-2\pi$'};
    Xlabel = '$\mathbf{k}$ (along $\mathbf{k_{y}=0}$)';
  
end

% check user input and determine the problem to be solved

isField=check_number_of_arguments_from_user(nargin);
[problemToSolve, Nbands] = determine_problem_to_solve(latticeType, isField);

% set up before solving

X=-W*pi:2*pi*W/N:W*pi;  

x=X*cos(sliceAlong);     % take a slice at the given angle
y=X*sin(sliceAlong);

bands = {};     % empty cell array

for k=1:Nbands  

    emptyBand = zeros(1,N+1);   
    bands{k} = emptyBand;                
    bandsWithField{k} = emptyBand;   % cell array of empty bands

end

% calculate the band structure at every point along a 2-dimensional slice

for j=1:N+1

    if ~isField     % case without a field

        eigenValues=problemToSolve(x(j),y(j));    

        for k=1:Nbands
                    
            bands{k}(j) = eigenValues(k);
                
        end
                

    end

    if isField         % case with a field    

        eigenValues=problemToSolve(x(j),y(j),0);    

        for k=1:Nbands
                    
            bands{k}(j) = eigenValues(k);
                
        end                                                                  

        eigenValuesWithField=problemToSolve(x(j),y(j),h);
           
        for k=1:Nbands
                    
            bandsWithField{k}(j) = eigenValuesWithField(k);
                
        end

    end    
        
end

% normalise the results

[bands, maxValueOfTopBand] = normalise_the_band_structure(bands, bandsWithField, Nbands, isField);

%plot a 2 dimensional slice

labels = {};    

figure

for k=1:Nbands

    plot(X,bands{k})
    hold on

    text = ['\sigma = ' num2str(k)];
    labels{k} = text;

    end

set(gca,'XTick',XTicks)
set(gca,'XTickLabel',XTickLabels,'TickLabelInterpreter','latex')
set(gca,'YTick',0:0.5:maxValueOfTopBand)


ax = gca;
ax.FontSize = 12;
xlabel(Xlabel,'Interpreter','latex')
ylabel('$\omega_\sigma$ (arbitrary units)','Interpreter','latex')


legend(labels,'Location','southwest')

if isField

    t = ['h = ' num2str(h)];
    title(t)

end
