function [bands, maxValueOfTopBand] = normalise_the_band_structure(band1,band2,band1WithField,band2WithField,maximum_no_field,isField)

band1 = band1 / maximum_no_field;
band2 = band2 / maximum_no_field;

if isField     % normalise relative to the no field case

    band1WithField = band1WithField / maximum_no_field;
    band2WithField = band2WithField / maximum_no_field;

    band1 = band1WithField;
    band2 = band2WithField;

end

bands = {band1,band2}; % put the bands into a list




