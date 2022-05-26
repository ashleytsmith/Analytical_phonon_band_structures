function make_a_gif_for_varying_field()

% setup parameters

numberOfFrames = 50; 
terminalDelay = 10;   % delay at the start and end of the gif
maxFieldValue = 1;
outputFile = '../Images/square_lattice_changing_field.gif';

% prepare enviroment 

if isfile(outputFile)  % delete previous export

      delete(sprintf(outputFile))                

end

set(0,'DefaultFigureVisible','off');      % supress figure visibility 

% fetch data to make the gif

square_lattice_plot_a_2D_slice(maxFieldValue);   % get the y axis from the max field case
axLimitsForMaximumField = get(gca,'ylim');
axTicksForMaximumField = get(gca,'YTick');

forwardFrameValues = 0:maxFieldValue/numberOfFrames:maxFieldValue;  % vector of h values to loop through
backwardFrameValues = flip(forwardFrameValues);

startDelayValues = zeros(1,terminalDelay);    % add delay at start and end of gif
endDelayValues = repelem(maxFieldValue,terminalDelay);


% run the plotting script at a range of field values and make a gif

      function loop_through_vector_of_field_values(field_values)        % nested function which loops through the field values
      
            for h = field_values;
            
                  msg = ['h = ' num2str(h)];
                  disp(msg)
      
                  square_lattice_plot_a_2D_slice(h);
                  set(gca,'ylim',axLimitsForMaximumField);
                  set(gca,'YTick',axTicksForMaximumField);
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