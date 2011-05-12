% RunExperimentWithInstructionsAndPractice
% Parameters:
%  - instructions: the name of a matlab script file (without the .m)
%  - practiceIn: filename of the practice input file
%  - practiceOut: filename of the practice output file
%  - targetIn: filename of the target (experiment) input file
%  - targetOut: filename of the target (experiment) output file
%  - breakInterval: number of trials after which breaks are offered
%  - debug: true if debug (enable escape-ing)
function RunExperimentWithInstructionsAndPractice(instructions,practiceIn,practiceOut,targetIn,targetOut,breakInterval,debug)
%%% seed the random generator!

RandStream.setDefaultStream(RandStream('mt19937ar','seed',GetSecs())); 

%%% Make Windows and Mac key codes the same
KbName('UnifyKeyNames');

%%%%%% Subject No Check %%%%%%

    % If subjNo does not exist, put 108
    if ~exist('subjNo','var')
       subjNo = 108;
    end
    
    % Warn if duplicate subjNo
    if exist(targetOut, 'file')
        resp = input(['The file ' targetOut ' already exists. Do you want to overwrite it? [Y/N]'], 's');
    
       % Abort if No
       if ~strcmpi(resp,'Y')
            disp('Experiment aborted. Try again.')
            return
       end
    end


try 

    %%% BEGIN SETUP WINDOW
    % Ignore keyboard input in the command line
    ListenChar(2);
    AssertOpenGL;
    HideCursor;
    
    Screen('Preference', 'VisualDebugLevel', 3);
    Screen('Preference', 'SuppressAllWarnings', 1);
    
    windowPtr = Screen('OpenWindow',0, 0, [], 32, 2);
    

    %%% END SETUP WINDOW
    
    Priority(2);
    ifi = Screen('GetFlipInterval',windowPtr,200);
    Priority(0);
    
    Priority(2);
    vbl = Screen('Flip',windowPtr);
    
    lb = 65;
    
    % Get white and black
    white = WhiteIndex(windowPtr);
    black = BlackIndex(windowPtr);

    % Get width and height
    [width, height]=Screen('WindowSize', windowPtr);

    % Set the font size and color
    Screen('TextFont', windowPtr, 'Helvetica');
    Screen('TextSize', windowPtr, 56);
    Screen('TextColor', windowPtr, [255 255 255]);

    
    %%%%% Instructions %%%%%
    
    run(instructions);    
    
    
    %%%%% Practice Trials %%%%%
    
    RunExperiment(practiceIn,practiceOut,windowPtr,breakInterval,debug);
    
    %%%%% Screen 5 %%%%%

    DrawFormattedText(windowPtr, 'If you have any questions, please ask them now.','center','center',white,lb);

    %DrawFormattedText(windowPtr, '', 'center', height*0.3);
    
    DrawFormattedText(windowPtr, '--- Press any key to proceed to the experiment ---', 'center', height*0.8);
    
    Screen(windowPtr, 'Flip'); 
    KbWait([],2);

    
    
    %%%%% Proceed to RunExperiment.m %%%%%

    RunExperiment(targetIn,targetOut,windowPtr,breakInterval,debug);

    %%%%%% End of RunExperiment.m
    
    DrawFormattedText(windowPtr, 'All done!!\n\nPlease let the proctor know that you are done.', 'center', height*0.4);
    Screen(windowPtr, 'Flip');
    KbWait([],2);

    
    %%%%% Finish up %%%%%

    Screen('CloseAll');
    Priority(0);
    ShowCursor();
    ListenChar(0);

    
%%%%% When there is an error... %%%%%
catch
    Screen('CloseAll');
    Priority(0);
    ShowCursor();
    ListenChar(0);
    psychrethrow(psychlasterror);
end
end