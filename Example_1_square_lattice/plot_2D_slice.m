%  Input parameters      only need to be specified when solving with a field
%  latticeType           a string specifying the lattice to be used
%  h                     size of the field

function plot_2D_slice(latticeType,h,varargin)

% plotting variables

N=50;  % number of grid points
W=sqrt(2);     % width of axis

% check user input and determine the problem to be solved

isField=check_number_of_arguments_from_user(nargin);
[problemToSolve, Nbands] = determine_problem_to_solve(latticeType, isField);

% set up before solving

X=-W*pi:2*pi*W/N:W*pi;  

x=X*cos(pi/4);     % take a diagonal slice
y=X*sin(pi/4);

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

figure

for k=1:Nbands

    plot(X,bands{k})
    hold on

    end

set(gca,'XTick',-3*pi/2:pi/2:3*pi/2)
set(gca,'XTickLabel',{'$-\frac{3\pi}{2}$','$-\pi$','$-\frac{\pi}{2}$','0','$\frac{\pi}{2}$','$\pi$','$\frac{3\pi}{2}$'},'TickLabelInterpreter','latex')
set(gca,'YTick',0:0.5:maxValueOfTopBand)


ax = gca;
ax.FontSize = 12;
xlabel('$\mathbf{k}$ (along diagonal)','Interpreter','latex')
ylabel('$\omega_\sigma$ (arbitrary units)','Interpreter','latex')
legend({'\sigma = 1','\sigma = 2'},'Location','southwest')

if isField

    t = ['h = ' num2str(h)];
    title(t)

end
