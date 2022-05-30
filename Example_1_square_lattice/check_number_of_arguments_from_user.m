function isField=check_number_of_arguments_from_user(nargin)

if nargin == 0 

    msg = 'Please provide a lattice type';
    error(msg)

end

if nargin == 1

    isField = false;   % specifiying whether we want to solve with or without a field

end

if nargin == 2 

    isField = true;

end

if nargin > 2

    msg = 'Too many parameters specified.';
    error(msg)

end

