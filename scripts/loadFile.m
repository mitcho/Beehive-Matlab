function experiment = loadFile(fileName)

file = fopen(fileName);
A = regexp(getLine(file),'\t','split');[hMargin vMargin fontPerc] = A{:};

experiment = struct('batch',[],'hMargin',str2double(hMargin),'vMargin',str2double(vMargin),'font',str2double(fontPerc));

while ~isempty(getLine(file))
    try

        % get the first line of the block
        line = getLine(file);
        % if there is no more input, this will return -1,
        % in which case we break.
        if line == -1
            break;
        end
        
        A = regexp(line,'\t','split');

        all = 0;
        if length(A) ==4
            [tName,bNumber,numRows,numShapes] = A{:};
            %fprintf([tName '\n']);
            all = 0;time = 0;
            
        else
            if length(A) == 5
                [tName,bNumber,numRows,numShapes,all] = A{:};
                if all(length(all)) ~= 's'
                    all = 1;time = 0;
                else
                    time = str2double(all(1:length(all)-2));all = 1;
                end
            end
        end
        
        % B = Before, D = During, A = After
        A = regexp(getLine(file),'\t','split');[QB1 QB2] = A{:};
        A = regexp(getLine(file),'\t','split');[QD1 QD2 Preemp] = A{:};
        A = regexp(getLine(file),'\t','split');[QA1 QA2 Answer1] = A{:};
        A = getLine(file);

        A = regexp(A,'\t','split');
        if (length(A) == 1)
            fprintf([tName ': Missing a tab: ' A{:} '\n']);
        end
        
        [Q2 Answer2] = A{:};

        bNumber = str2num(bNumber);
        numShapes = str2num(numShapes);
        numRows = str2num(numRows);

        if isempty(experiment.batch)        
            experiment.batch = struct('trial',[]);
        else
            if length(experiment.batch) < bNumber
            experiment.batch(bNumber) = struct('trial',[]);
            end
        end

        experiment.batch(bNumber).trial = [experiment.batch(bNumber).trial struct('name',tName,'numRows',numRows,'QB1',QB1,'QB2',QB2,'QD1',QD1,'QD2',QD2,'Preemp',Preemp,'QA1',QA1,'QA2',QA2,'frame',[],'all',all,'time',time,'correctAnswer1',Answer1,'Q2',Q2,'correctAnswer2',Answer2)];
        

        for i = 1:numShapes
            A = regexp(getLine(file),'\t','split');
            
            if all == 0
                if length(A) == 4
                    [shape color radius frame] = A{:};frame = str2num(frame);position = i;
                end            
                if length(A) == 5
                    B = A{5};
                    if B(1) == '('
                        [shape color radius frame position] = A{:};frame = str2num(frame);
                        C = regexp(B,',','split');
                        [c r] = C{:};
                        c = str2num(c(2:length(c)));r = str2num(r(1:length(r)-1));
                        position = r + (c - 1) * numRows;
                    else                    
                        [shape color radius frame position] = A{:};frame = str2num(frame);position = str2num(position);
                    end
                end
            else
                if length(A) == 3
                    [shape color radius] = A{:};frame = 1;position = i;
                end            
                if length(A) == 4
                    B = A{4};
                    if B(1) == '('
                        [shape color radius position] = A{:};frame = 1;
                        C = regexp(B,',','split');
                        [c r] = C{:};
                        c = str2num(c(2:length(c)));r = str2num(r(1:length(r)-1));
                        position = r + (c - 1) * numRows;
                    else                    
                        [shape color radius position] = A{:};frame = 1;position = str2num(position);
                    end
                end           
            end
            
            
            if length(experiment.batch(bNumber).trial(length(experiment.batch(bNumber).trial)).frame) == 0
                experiment.batch(bNumber).trial(length(experiment.batch(bNumber).trial)).frame = struct('shape',[]);
            end
            if length(experiment.batch(bNumber).trial(length(experiment.batch(bNumber).trial)).frame)<frame
                experiment.batch(bNumber).trial(length(experiment.batch(bNumber).trial)).frame(frame) = struct('shape',[]);
            end
            
            experiment.batch(bNumber).trial(length(experiment.batch(bNumber).trial)).frame(frame).shape = [experiment.batch(bNumber).trial(length(experiment.batch(bNumber).trial)).frame(frame).shape struct('shape',shape,'color',color,'radius',str2num(radius),'position',position)];
        end
    catch exception
        %rethrow(exception);
        break;
    end
end
    
fclose(file);
end

