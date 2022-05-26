%  Input parameters      only need to be specified when solving with a field                
%  h                     size of the field

function square_lattice_plot_a_2D_slice(h,varargin)

% check input from the user

if nargin == 0

    isField = false;   % specifiying whether we want to solve with or without a field

end

if nargin == 1 

    isField = true;

end

if nargin > 1

    msg = 'Too many parameters specified.';
    error(msg)

end

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

            eigenValues=square_lattice_with_constant_field_solve_phonon_band_structure(x(j),y(j),0);    % case without a field

            band1(j) = eigenValues(1);
            band2(j) = eigenValues(2); 

            if isField                                                                                  % case with a field

                eigenValuesWithField=square_lattice_with_constant_field_solve_phonon_band_structure(x(j),y(j),h);
           
                band1WithField(j) = eigenValuesWithField(1);
                band2WithField(j) = eigenValuesWithField(2); 

            end    
        
        end

% normalise the results

maximum_no_field = max(band2);
maximum_with_field = max(band2WithField);

band1 = band1 / maximum_no_field;
band2 = band2 / maximum_no_field;

if isField     % normalise relative to the no field case

    band1WithField = band1WithField / maximum_no_field;
    band2WithField = band2WithField / maximum_no_field;

    band1 = band1WithField;
    band2 = band2WithField;

end

bands = {band1,band2}; % put the bands into a list

%plot a 2 dimensional slice

figure

for k=1:2

    plot(X,bands{k})
    hold on

    end

set(gca,'XTick',-3*pi/2:pi/2:3*pi/2)
set(gca,'XTickLabel',{'$-\frac{3\pi}{2}$','$-\pi$','$-\frac{\pi}{2}$','0','$\frac{\pi}{2}$','$\pi$','$\frac{3\pi}{2}$'},'TickLabelInterpreter','latex')
set(gca,'YTick',0:max(bands{2}))


ax = gca;
ax.FontSize = 12;
xlabel('$\mathbf{k}$ (along diagonal)','Interpreter','latex')
ylabel('$\omega_\sigma$ (arbitrary units)','Interpreter','latex')
legend({'\sigma = 1','\sigma = 2'},'Location','southwest')

if isField

    t = ['h = ' num2str(h)];
    title(t)

end