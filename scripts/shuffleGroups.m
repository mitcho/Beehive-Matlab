function experiments = shuffleGroups(experiment)
   
% IF there are multiple batches...
if(length(experiment.batch) > 1)
    % the experiment should have at least two batches.
    % right now batch 2 contains the fillers and batch 1 is the real stuff
    
    r1 = randperm(length(experiment.batch(1).trial)); % random permutation of the numbers 1..N, where batch 1 has N trials
    r2 = randperm(length(experiment.batch(2).trial)); % same deal

    targets = experiment.batch(1).trial(r1); % randomized targets
    fillers = experiment.batch(2).trial(r2); % randomized fillers

    experiments = []; % init experiments

    %%% FIRST PASS %%%
    % interleave targets and fillers, as many pairs as possible.
    % "pairs" is the number of these we will do.
    pairs = min(length(targets), length(fillers));
    
    for i=1:pairs
        experiments = [experiments fillers(i) targets(i)]; % ensure that the first item is always a filler
    end

    
    %%% SECOND PASS %%%
    % if there are more fillers than targets, add in fillers
    % if there are more targets than fillers, add in targets
    
    if length(targets) > length(fillers) % if more targets than fillers...
        for i = length(fillers)+1:length(targets)
            pos = floor((length(experiments)+1) * rand());
            experiments = [experiments(1:pos) targets(i) experiments(pos+1:length(experiments))];
        end
    else % else, if more fillers than targets...
        for i = length(targets)+1:length(fillers)
            pos = floor((length(experiments)+1) * rand());
            experiments = [experiments(1:pos) fillers(i) experiments(pos+1:length(experiments))];
        end
    end

% ELSE if there's only one batch...
else
    % just randomize that one batch and return it.
    r1 = randperm(length(experiment.batch(1).trial));
    experiments = experiment.batch(1).trial(r1);
end

end

