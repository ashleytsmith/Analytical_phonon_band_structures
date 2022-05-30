function make_a_gif_for_varying_field(latticeType, plottingScript)

% setup parameters

numberOfFramesInOneSequence = 50; 
terminalDelay = 10;   % delay at the start and end of the gif
maxFieldValue = 2;  
scaleColorbars = false;

% make output file based of name of plotting script

plottingScriptName = func2str(plottingScript);
outputFile  = [latticeType   '_'  replace(plottingScriptName,'plot','changing_field')  '.gif']; 
outputLocation = ['../../'  outputFile];

% prepare enviroment 

if isfile(outputLocation)  % delete previous export

      delete(sprintf(outputLocation))                

end

set(0,'DefaultFigureVisible','off');      % supress figure visibility 

% fetch data to make the gif

plottingScript(latticeType, maxFieldValue);   % get the figure from the max field case

if contains(plottingScriptName,'slice') 

      axLimitsForMaximumField = get(gca,'ylim');
      axTicksForMaximumField = get(gca,'YTick');
                  
end

if contains(plottingScriptName,'heat') && scaleColorbars
      
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
      
                  plottingScript(latticeType,h);

                  if contains(plottingScriptName,'slice') 
                  
                        set(gca,'ylim',axLimitsForMaximumField);
                        set(gca,'YTick',axTicksForMaximumField);

                  end

                  if contains(plottingScriptName,'heat') && scaleColorbars
                  
                        Axes = findall(gcf, 'type', 'axes');      % make sure all axes have the same color map
                        set(Axes,'clim',colorbarScale);

                  end

                  exportgraphics(gcf,outputLocation,'Append',true);

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