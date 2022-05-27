function isField=check_number_of_arguments_from_user(nargin)

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

