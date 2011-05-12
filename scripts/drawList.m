function drawList(screenPointer,height,width,hMargin,wMargin,numRows,color,radius,shape,position,numHide,numShow)

    %color: vector of characters, 'r','g','b','y',or 'w'
    %radius: vector of integers
    %shape: vector of characters, 't','q','c','s'
    %position: vector of numbers based on the agreed positionin
    numShapes = length(color);
    
    numCols = ceil(numShapes/numRows);
    numCols2 = ceil(2 * numShapes/numRows)/2;
        
    colWidth1 = (width - 2 * wMargin)/(numCols2+1);
    rowHeight1 = colWidth1 * sqrt(3)/2;
    
    rowHeight2 = (height - 2 * hMargin)/(numRows+1);
    colWidth2 = rowHeight2 / (sqrt(3)/2);
    
    colWidth = min(colWidth1,colWidth2);
    rowHeight = min(rowHeight1,rowHeight2);
    
    Screen('FrameRect',screenPointer,[100 100 100],[wMargin,hMargin,width - wMargin,height - hMargin]);
    
    coverRadius = max(radius) * 1.3;
    
    for i = 1:length(position)
        f = rem(position(i)-1,numRows)+1;
        c = floor((position(i)-1)/numRows)+1;

        x = width/2 - colWidth * (numCols2 + 1)/2;
        
        if rem(f,2) == 1
            x = x + colWidth * c + colWidth/4;
        else
            x = x + colWidth * c - colWidth/4;
        end

        y = height/2 - (numRows + 1) * rowHeight/2 + f * rowHeight;
        
        switch lower(color(i))
            case 'r'
                sCol = [255 0 0];
            case 'g'
                sCol = [0 140 0];
            case 'b'
                sCol = [0 0 255];
            case 'y'
                sCol = [255 255 0];
            case 'w'
                sCol = [255 255 255];
            otherwise
                sCol = [0 0 0];        
        end

        if i<=numHide || i > numShow
            sCol = [128 128 128];
        end

        if i <= numHide
            Screen('FillPoly',screenPointer,sCol,drawReg(coverRadius,x,y,6));
        else
            if i <= numShow
                switch lower(shape(i))
                    case 't'
                        Screen('FillPoly',screenPointer,sCol,drawReg(radius(i),x,y,3));
                    case 'q'
                        %Squares are made bigger so that they have roughly
                        %the same area as circles
                        %Original:
                        %Screen('FillPoly',screenPointer,sCol,drawReg(radiu
                        %s(i),x,y,4));
                        Screen('FillRect',screenPointer,sCol,[(x-(radius(i)*sqrt(pi)*0.5)) (y-(radius(i)*sqrt(pi)*0.5)) (x+(radius(i)*sqrt(pi)*0.5)) (y+(radius(i)*sqrt(pi)*0.5))]);
                    case 'c'
                        Screen('FillOval',screenPointer,sCol,[(x-radius(i)) (y-radius(i)) (x+radius(i)) (y+radius(i))]);
                    case 's'
                        Screen('FillPoly',screenPointer,sCol,drawStar(radius(i),x,y,10));
                end
            else
                Screen('FramePoly',screenPointer,sCol,drawReg(coverRadius,x,y,6));
            end
        end
    end                     
    
end

