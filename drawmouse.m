x=GetMouse(MONITOR)/Calib.screen.width;

if(x>0.5)
	rating(framenum)=x-0.5;
	Screen('FillRect', EXPWIN, [0 2*rating(framenum)*255 ...
		0], RatingSquare  );
else
	rating(framenum)=-(1-x)+0.5;
	Screen('FillRect', EXPWIN, [ -2*rating(framenum)*255 0 ...
		0], RatingSquare  );
end
