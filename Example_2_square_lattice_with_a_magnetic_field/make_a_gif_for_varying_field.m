function make_a_gif_for_varying_field(problemToSolve)

% setup parameters

numberOfFramesInOneSequence = 50; 
terminalDelay = 10;   % delay at the start and end of the gif
maxFieldValue = 2;  

% choose output file based on problem solved

if isequal(problemToSolve,@square_lattice_plot_a_2D_slice)

      outputFile = '../Images/square_lattice_changing_field_2D_slice.gif';

end

if isequal(problemToSolve, @square_lattice_plot_both_bands_2D_heatmap)

    outputFile = '../Images/square_lattice_changing_field_heat_map.gif';

end

% prepare enviroment 

if isfile(outputFile)  % delete previous export

      delete(sprintf(outputFile))                

end

set(0,'DefaultFigureVisible','off');      % supress figure visibility 

% fetch data to make the gif

problemToSolve(maxFieldValue);   % get the figure from the max field case

if isequal(problemToSolve,@square_lattice_plot_a_2D_slice)

      axLimitsForMaximumField = get(gca,'ylim');
      axTicksForMaximumField = get(gca,'YTick');
                  
end

if isequal(problemToSolve,@square_lattice_plot_both_bands_2D_heatmap)
      
      colorbarScale = get(gca,'clim');
                  
end


forwardFrameValues = 0:maxFieldValue/numberOfFramesInOneSequence:maxFieldValue;  % vector of h values to loop through
backwardFrameValues = flip(forwardFrameValues);

startDelayValues = zeros(1,terminalDelay);    % add delay at start and end of gif
endDelayValues = repelem(maxFieldValue,terminalDelay);


% run the plotting script at a range of field values and make a gif

      function loop_through_vector_of_field_values(field_values)        % nested function which loops through the field values
      
            for h = field_values;
            
                  msg = ['h = ' num2str(h)];
                  disp(msg)
      
                  problemToSolve(h);

                  if isequal(problemToSolve,@square_lattice_plot_a_2D_slice)
                  
                        set(gca,'ylim',axLimitsForMaximumField);
                        set(gca,'YTick',axTicksForMaximumField);

                  end

                  if isequal(problemToSolve,@square_lattice_plot_both_bands_2D_heatmap)
                  
                        Axes = findall(gcf, 'type', 'axes');      % make sure all axes have the same color map
                        set(Axes,'clim',colorbarScale);

                  end

                  exportgraphics(gcf,outputFile,'Append',true);

            end
      
      end


loop_through_vector_of_field_values(startDelayValues)
loop_through_vector_of_field_values(forwardFrameValues)
loop_through_vector_of_field_values(endDelayValues)
loop_through_vector_of_field_values(backwardFrameValues)
     

% reset enviroment

set(0,'DefaultFigureVisible','on');  % turn figure visibility back on
close all                            % close all currently open figures


end   % closing end statment needed when using nested functions