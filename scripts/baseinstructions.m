%%%%% Instructions %%%%%

%%%%% Screen 1 %%%%%

% Fill the background with black
Screen(windowPtr,'FillRect',black);

% Put the message in white
DrawFormattedText(windowPtr, 'Thank you for participating in this experiment.\n\nYour task in this experiment is to verify as RELIABLY and as QUICKLY as you can whether a sentence truthfully describes a picture that you will see on the screen.\n\n\n',width/10,'center',white,lb);

DrawFormattedText(windowPtr, '--- Press any key to continue ---', 'center', height*0.8);

Screen(windowPtr, 'Flip');
KbWait([],2);


%%%%% Screen 2 %%%%%

% Fill the background with black
Screen(windowPtr,'FillRect',black);

% Put the message in white
DrawFormattedText(windowPtr, 'The pictures you will see depict a set of colored figures, which at first will be covered by hexagons. \n\nEach time you press the SPACE BAR, you will uncover the figures under some of the hexagons.\n\n\n',width/10,'center',white,lb);

DrawFormattedText(windowPtr, '--- Press any key to continue ---', 'center', height*0.8);

Screen(windowPtr, 'Flip');
KbWait([],2);


%%%%% Screen 3 %%%%%

% Fill the background with black
Screen(windowPtr,'FillRect',black);

% Put the message in white
DrawFormattedText(windowPtr, 'There are four kinds of figures: circle, triangle, square, and star.\n\n\n',width/10,height*(1/4),white,lb);

x = width/5;
y = height*(2/5);
rad = height*0.04;

Screen('FillOval',windowPtr,[255 255 0],[(x-rad) (y-rad) (x+rad) (y+rad)]);
Screen('FillPoly',windowPtr,[255 255 0],drawReg(rad,x+(rad*5),y,3));
Screen('FillPoly',windowPtr,[255 255 0],drawReg(rad,x+(rad*10),y,4));
Screen('FillPoly',windowPtr,[255 255 0],drawStar(rad,x+(rad*15),y,10));

DrawFormattedText(windowPtr, 'Each picture contains one kind of figure, and two colors out of blue, yellow, red, green, and white.\n\n\n',width/10,height*(1/2),white,lb);

y = height*(13/20);

Screen('FillOval',windowPtr,[0 0 255],[(x-rad) (y-rad) (x+rad) (y+rad)]);
Screen('FillOval',windowPtr,[255 255 0],[(x+(rad*4)) (y-rad) (x+(rad*6)) (y+rad)]);
Screen('FillOval',windowPtr,[255 0 0],[(x+(rad*9)) (y-rad) (x+(rad*11)) (y+rad)]);
Screen('FillOval',windowPtr,[0 255 0],[(x+(rad*14)) (y-rad) (x+(rad*16)) (y+rad)]);
Screen('FillOval',windowPtr,[255 255 255],[(x+(rad*19)) (y-rad) (x+(rad*21)) (y+rad)]);

DrawFormattedText(windowPtr, '--- Press any key to continue ---', 'center', height*0.8);

Screen(windowPtr, 'Flip'); 
KbWait([],2);


%%%%% Screen 4 %%%%%

% Fill the background with black
Screen(windowPtr,'FillRect',black);

% Put the message in white
DrawFormattedText(windowPtr, 'Your task is to judge whether or not the sentence truthfully describes the picture you have seen. \n\n\nYou will ALWAYS have to uncover the figures under at least half of the hexagones in the picture before you can decide if the sentence is true or not. That is, for every picture you must press the SPACE BAR at least 3-4 times.\n\n\nAfter you have seen enough figures to make a decision: if the sentence is TRUE, press J. If it is FALSE, press F. \n\n\n',width/10,'center',white,lb);

DrawFormattedText(windowPtr, '--- Press any key to continue ---', 'center', height*0.8);

Screen(windowPtr, 'Flip'); 
KbWait([],2);


%%%%% Screen 5 %%%%%

% Fill the background with black
Screen(windowPtr,'FillRect',black);

% Put the message in white
DrawFormattedText(windowPtr, 'To make sure that you are comfortable with the task, there are 6 practice trials. \n\n\nAfter the practice trials you may take a break to ask the proctor questions. If you have any questions before the practice trials begin, please ask them now.\n\n\n',width/10,'center',white,lb);

DrawFormattedText(windowPtr, '--- Press any key to proceed to the practice trials ---', 'center', height*0.8);

Screen(windowPtr, 'Flip');
KbWait([],2);