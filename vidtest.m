% Initialize with unified keynames and normalized colorspace:
PsychDefaultSetup(2);
% Default preload setting:
preloadsecs = [];
maxThreads = [];
shader=[];
pixelFormat = [];
% Playbackrate defaults to 1:
rate=1;
% Use blocking wait for new frames by default:
blocking = 1;
maxrate=3.0;
minrate=0.1;
timeindex=0;
framenum=1;
tiList=[];
frate=30;

% Setup key mapping:
esc=KbName('ESCAPE');
right=KbName('d');
left=KbName('a');
up=KbName('w');
down=KbName('s');

% Open movie file and retrieve basic info about movie:
[ movie, duration, fps, width, height, count, aspectRatio] =...
	Screen('OpenMovie', EXPWIN, [pwd '/' fn], [], preloadsecs, ...
	[], pixelFormat, maxThreads);

frametime=(0:(vidObj.NumberOfFrames/2))*(1/frate);
rating=zeros(length(frametime),1);

disp('waiting to start')
Screen('DrawText', EXPWIN, 'When ready, press spacebar...', 0,20);
Screen('Flip',EXPWIN)
while(1)
	[~,~,keyCode,~] = KbCheck;
	%find(keyCode)
	if( find(keyCode)== 44 ) % press 'space'
		disp('start  movie......')
		break
	end
end

Screen('PlayMovie', movie, rate, 1, 1.0);
while ((1+timeindex)<duration)
	
	[val,idx]=min(abs(timeindex-frametime));
	framenum=idx;
	
	[keyIsDown, ~, keyCode, ~] = KbCheck;
	tex = Screen('GetMovieImage', EXPWIN, movie, blocking);
	
	% Draw the new texture immediately to screen:
	Screen('DrawTexture', EXPWIN, tex, [], [], [], [], [], [], shader);
	drawmouse;
	
	timeindex=Screen('GetMovieTimeIndex', movie);
	tiList(end+1)=timeindex;
	
	Screen('DrawText', EXPWIN, num2str(timeindex), 0,10);
	Screen('DrawText', EXPWIN, ['Rate: x' num2str(rate)], 0,35);
	
	% Update display:
	Screen('Flip', EXPWIN);
	% Release texture:
	Screen('Close', tex);
	
	if(timeindex==0); disp('timeindex==0;'); end
	
	if( rate<=maxrate )
		if keyCode(up)
			% Increase playback rate by 1 unit.
			rate=rate+0.1; %disp(rate)
		end
	end
	
	if(rate>=minrate)
		if keyCode(down)
			% Decrease playback rate by 1 unit.
			rate=rate-0.1; %disp(rate)
		end
	end
	
	% Further keyboard checks...
	if( (timeindex + 1) < (duration-1) )
		if ( keyCode(right))
			% Advance movietime by one second:
			Screen('SetMovieTimeIndex', movie, ...
				Screen('GetMovieTimeIndex', movie) + 1);
			rate=1;
		end
	end
	
	if( (timeindex - 1) > 0 )
		if (keyCode(left))
			% Rewind movietime by one second:
			Screen('SetMovieTimeIndex', movie, ...
				Screen('GetMovieTimeIndex', movie) - 1);
			rate=1;
		end
	end
	
	Screen('PlayMovie', movie, rate, 1, 1.0);
	
	%exit strategy
	if (keyCode(esc))
		break
	end
end

Screen('Flip', EXPWIN);
KbReleaseWait;

% Done. Stop playback:
Screen('PlayMovie', movie, 0);

% Close movie object:
Screen('CloseMovie', movie);
