function [bands, maxValueOfTopBand] = normalise_the_band_structure(bands, bandsWithField, Nbands, isField)

    function maxValueOfTopBand = calculateMaxValueOfTopBand(bands)  % nested function which calulates the max value of the top band

        input = bands{Nbands};

        if isvector(input)

            maxValueOfTopBand = max(input); 

        end 

        if ismatrix(input)

            maxValueOfTopBand = max(input, [], 'all');
             
        end 

    end

maximum_no_field = calculateMaxValueOfTopBand(bands);

if ~isField     % normalise relative to highest value of the top band

    for k=1:Nbands

        bands{k} = bands{k} / maximum_no_field;
                
    end

    maxValueOfTopBand = 1;

end


if isField     % normalise relative to the no field case

    for k=1:Nbands

        bandsWithField{k} = bandsWithField{k} / maximum_no_field;
                  
    end

    bands = bandsWithField;
    maxValueOfTopBand = calculateMaxValueOfTopBand(bands);  % max value after normalising

end

end % closing end statment needed when using nested functions

