%  Input parameters      only need to be specified when solving with a field                
%  h                     size of the field

function square_lattice_plot_a_2D_slice(h,varargin)

% check user input 

isField=check_number_of_arguments_from_user(nargin);

% plotting variables

N=200;  % number of grid points
W=sqrt(2);     % width of axis

% calculate the band structure at every point along a 2 dimensional slice

X=-W*pi:2*pi*W/N:W*pi;  

x=X*cos(pi/4);     % take a diagonal slice
y=X*sin(pi/4);

band1=zeros(1,N+1); 
band2=zeros(1,N+1);
band1WithField=zeros(1,N+1); 
band2WithField=zeros(1,N+1);

        for j=1:N+1

            if ~isField     % case without a field

                eigenValues=square_lattice_solve_phonon_band_structure(x(j),y(j));    

                band1(j) = eigenValues(1);
                band2(j) = eigenValues(2);   

            end

            if isField         % case with a field    

                eigenValues=square_lattice_with_constant_field_solve_phonon_band_structure(x(j),y(j),0);    

                band1(j) = eigenValues(1);
                band2(j) = eigenValues(2);                                                                  

                eigenValuesWithField=square_lattice_with_constant_field_solve_phonon_band_structure(x(j),y(j),h);
           
                band1WithField(j) = eigenValuesWithField(1);
                band2WithField(j) = eigenValuesWithField(2); 

            end    
        
        end

% normalise the results

maximum_no_field = max(band2);

bands = normalise_the_band_structure(band1,band2,band1WithField,band2WithField,maximum_no_field,isField);

maxValueOfTopBand = max(bands{2});  % max value after normalising

%plot a 2 dimensional slice

figure

for k=1:2

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