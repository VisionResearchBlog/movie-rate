# movie-rate

A matlab program to playback movies & rate frame-by-frame from 0 to 1.
The program requires the psychtoolbox (http://psychtoolbox.org/)

StartVid.m is the main file to run and edit to assign the movie filename you want
to load. The program loads the video, asks for a filename for the viewer's
rating file (.mat file) and then allows the viewer to watch the film.

The film is played back in fullscreen at normal speed, in the top left corner the seconds
elapsed and current film speed are displayed. The A & D key allow stepping backward or
forward in time, respectively, by 1s.  The W & S keys speed up and slow down the video
play back increments of 0.1x (bound with a minumum of 0.1x speed up to 2x).

Using the horizontal component of the mouse alters a bar on the bottom screen to be
bright green (fasr left) or bright red (far right).  This is used by the viewer
to rate the video on a scale from -0.5 to 0.5. In our studies, this is used
as a measure of confidence in performing a task filmed while wearing a 1st person camera.
This can be used for other measures as need.  After the films duration has elapsed,
the rating.mat file is saved and a graph appears showing the viewer's rating over time.
