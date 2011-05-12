function writeFile(fileName,experiments)
file = fopen(fileName,'w');
fprintf(file,'TrialName,PreempAllowed,NumRows,NumShapes,[Shape Color Radius Position],TimeSpentOnFrame,UserAnswer1,CorrectAnswer1,IsCorrect1,UserAnswer2,CorrectAnswer2,IsCorrect2,Frame,FrameAnswered,TimeToAnswer1FromBegin,TimeToStart2,TimeToFinish2\n');
for i = 1:length(experiments)
    for j = 1:length(experiments(i).frame)
        fprintf(file,'%s,',experiments(i).name);
        if(experiments(i).Preemp == '1')
            fprintf(file,'%s','yes,');
        else
            fprintf(file,'%s','no,');
        end
        fprintf(file,'%d,',experiments(i).numRows);
        fprintf(file,'%d,',length(experiments(i).frame(j).shape));
        for k = experiments(i).frame(j).shape
            fprintf(file,'[%s %s %f %d] ',k.shape,k.color,k.radius,k.position);
        end
        fprintf(file,',%6.4f,',experiments(i).frame(j).timeSpent);
        if strcmpi(experiments(i).userAnswer,experiments(i).correctAnswer1)
            correct = 'correct';
        else
            correct = 'incorrect';
        end
        
        if strcmpi(experiments(i).userAnswer2,experiments(i).correctAnswer2)
            correct2 = 'correct';
        elseif ~strcmp(experiments(i).correctAnswer2,'')
            correct2 = 'incorrect';
        else
            correct2 = '';
        end
        
        if ~isfield(experiments(i),'timeToAnswer2Part1')
            experiments(i).timeToAnswer2Part1 = '';
        end
        
        if ~isfield(experiments(i),'timeToAnswer2Part2')
            experiments(i).timeToAnswer2Part2 = '';
        end
        
        fprintf(file,'%s,%s,%s,%s,%s,%s,%d,%d,%6.4f,%6.4f,%6.4f',experiments(i).userAnswer,experiments(i).correctAnswer1,correct,experiments(i).userAnswer2,experiments(i).correctAnswer2,correct2,j,experiments(i).whenAnswer,experiments(i).totalTime,experiments(i).timeToAnswer2Part1,experiments(i).timeToAnswer2Part2);
        fprintf(file,'\n');
    end
end
fclose(file);

end

