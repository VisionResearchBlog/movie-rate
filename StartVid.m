sca; clear all; clc;
global EXPWIN GREY
tic
fn='example.MP4';
%fn='GP012697.MP4';
%
Screen('Preference', 'SkipSyncTests', 1)

try
	vidObj=VideoReader(fn);
	
	savename=input('Please type Subject ID - then press enter: ','s');
	
	MONITOR=0; %set to zero for running exp
	SKIP_SYNC=0; %Should be set to 0 when running exp, 1 for programming - ie if you have 2 screens on
	Calib = SetCalibParams(MONITOR, SKIP_SYNC);
	RatingSquare=[0	Calib.screen.height-100 Calib.screen.width Calib.screen.height];
catch me
	save('test0.mat','me')
	keyboard
end


try
	Priority(1);
	AssertOpenGL;
	Screen('TextStyle', EXPWIN, 1);
	Screen('TextFont',EXPWIN, 'Arial');
	Screen('TextSize',EXPWIN, 32);
	Screen('TextColor',EXPWIN, [0 0 0]);
	Screen('DrawText', EXPWIN, 'Loading...', 0,20);
	Screen('Flip',EXPWIN)
	rating=[]; KeyStop=0; frame=0;
catch me
	save('test1.mat','me')
	keyboard
	
end


try
	vidtest
catch me
	save('test2.mat','me')
	keyboard
end

plot(rating)

save([savename '.rating.mat'],'rating','Calib','savename',...
	'duration', 'frametime','tiList')
Screen('CloseAll')