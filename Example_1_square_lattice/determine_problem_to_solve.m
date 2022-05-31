function [problemToSolve, Nbands] = determine_problem_to_solve(latticeType, isField)

if ~isField     % case without a field

    if latticeType == 'kagome_lattice'

         msg = 'Only to in field soloution is available. Please specify a field';
        error(msg)

    end

    problemToSolve = [latticeType   '_solve_phonon_band_structure'];
    problemToSolve = str2func(problemToSolve);     % convert string to function handle
    eigenValues=problemToSolve(0,0);               % determine the number of bands at an arbitrary k point
    Nbands = numel(eigenValues);

end

if isField     % case with a field

    problemToSolve = [latticeType   '_with_field'   '_solve_phonon_band_structure'];
    problemToSolve = str2func(problemToSolve);     % convert string to function handle
    eigenValues=problemToSolve(0,0,0);               % determine the number of bands at an arbitrary k point
    Nbands = numel(eigenValues);

end

