function RunExperiment(fileIn,fileOut,windowPtr,breakInterval,debug)
try    
    
    [width, height]=Screen('WindowSize', windowPtr);
    
    experiment = loadFile(fileIn);
    experiments = shuffleGroups(experiment);
    
    Priority(2);
    vbl = Screen('Flip',windowPtr);
    
    white = WhiteIndex(windowPtr);
    black = BlackIndex(windowPtr);
    
    lb = 65;
    
    currTrial = 1;
    currFrame = 0;
    
    Screen('TextFont', windowPtr, 'Helvetica');
    Screen('TextSize', windowPtr, experiment.font);
    Screen('TextColor', windowPtr, [255 255 255]);
        
    quit = 0;
    while quit == 0        
        A = [experiments(currTrial).frame.shape];
        
        if currFrame <= length(experiments(currTrial).frame)
            numShow = length([experiments(currTrial).frame(1:currFrame).shape]);
            numHide = length([experiments(currTrial).frame(1:(currFrame-1)).shape]);
        else
            numShow = length([experiments(currTrial).frame.shape]);
            numHide = length([experiments(currTrial).frame.shape]);
        end            


        drawList(windowPtr,...
            height,width,...
            experiment.vMargin * height,experiment.hMargin * width,...
            experiments(currTrial).numRows,...
            [A.color],height * [A.radius],[A.shape],[A.position],...
            numHide,numShow);
    
        if currFrame == 0
            DrawFormattedText(windowPtr, experiments(currTrial).QB1, 'center', experiment.vMargin * height / 2);
            DrawFormattedText(windowPtr, experiments(currTrial).QB2, 'center', (1 - experiment.vMargin/2) * height);
        else
            % Next line changed to display the third text at the
            % last frame rather than after the last frame
            % Original:
            %   if currFrame > length(experiments(currTrial).frame)
            if currFrame >= length(experiments(currTrial).frame)
                DrawFormattedText(windowPtr, experiments(currTrial).QA1, 'center', experiment.vMargin * height / 2);
                DrawFormattedText(windowPtr, experiments(currTrial).QA2, 'center', (1 - experiment.vMargin/2) * height);
            else
                DrawFormattedText(windowPtr, experiments(currTrial).QD1, 'center', experiment.vMargin * height / 2);
                DrawFormattedText(windowPtr, experiments(currTrial).QD2, 'center', (1 - experiment.vMargin/2) * height);
            end
        end
        
        showTime = Screen('Flip',windowPtr, [], [0]); %%% the , [], [0] is added.
        
        if currFrame == 1
            questionTime = showTime;
        end
        
        while 1    
            if experiments(currTrial).time > 0 && currFrame == 1
                time = getSecs();
                if (time - showTime)*1000 > experiments(currTrial).time
                    experiments(currTrial).frame(currFrame).timeSpent = time - showTime;
                    currFrame = currFrame + 1;
                    break;
                end
            else
                [seconds, keyCode, deltaSec] = KbWait([],2);
                if ~strcmp(class(KbName(keyCode)),'cell')
                    % Next line changed to nullifly SPACE on the final
                    % frame
                    % Original:
                    %   if strcmp(upper(KbName(keyCode)),'SPACE') &
                    %   currFrame <= length(experiments(currTrial).frame)
                    if strcmpi(KbName(keyCode),'SPACE') && currFrame < length(experiments(currTrial).frame)
                        if(currFrame > 0)
                            experiments(currTrial).frame(currFrame).timeSpent = seconds - showTime;
                        end
                        currFrame = currFrame+1;
                        break;
                    end
                   
                    if debug && strcmpi(KbName(keyCode),'ESCAPE')
                        quit=1;
                        break;
                    end
                    
                    if (strcmpi(KbName(keyCode),'J') || (strcmpi(KbName(keyCode),'F')))
                        if currFrame >= length(experiments(currTrial).frame) ||...
                            (currFrame > 0 && currFrame <= length(experiments(currTrial).frame) && experiments(currTrial).Preemp == '1')
                            if strcmpi(KbName(keyCode),'J')
                                experiments(currTrial).userAnswer = 'yes';
                            else
                                experiments(currTrial).userAnswer = 'no';
                            end
                            experiments(currTrial).whenAnswer = currFrame;

                            if(currFrame <= length(experiments(currTrial).frame))
                                experiments(currTrial).frame(currFrame).timeSpent = seconds - showTime;
                                for i=currFrame+1:length(experiments(currTrial).frame)
                                    experiments(currTrial).frame(i).timeSpent = 0;
                                end
                            end

                            experiments(currTrial).totalTime = seconds - questionTime;

                            if ~isempty(experiments(currTrial).Q2)
                                [experiments(currTrial).timeToAnswer2Part1 experiments(currTrial).timeToAnswer2Part2 experiments(currTrial).userAnswer2] = askQuestion(experiments(currTrial).Q2,windowPtr,height);
                            else
                                experiments(currTrial).timeToAnswer2 = 0;
                                experiments(currTrial).userAnswer2 = [];
                            end

                            currFrame = 0;

                            % Break after every breakInterval trials
                            if (rem(currTrial, breakInterval) == 0)
                               DrawFormattedText(windowPtr, 'You may take a break now','center','center',white,lb);
                               DrawFormattedText(windowPtr, '--- Press RETURN to go back to the experiment ---', 'center', height*0.8);
                               Screen(windowPtr, 'Flip');
                               while 1
                               [seconds, kyCd, dSec] = KbWait([],2);
                                   if strcmp(KbName(kyCd),'Return')
                                       break;
                                   end
                               end   
                            end
                            
                            
                            currTrial = currTrial+1;
                            if(currTrial > length(experiments))
                                writeFile(fileOut,experiments);
                                quit=1;
                                break;
                            end

                            break;
                        end
                    end
                end
            end
        end
    end
    
catch exception
    Screen('CloseAll');
    Priority(0);
    ShowCursor;
    ListenChar(0);
    rethrow(exception);
end;


end
