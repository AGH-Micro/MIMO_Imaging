
% signal parameters
fs=[]     ;   % sampling frequency
fmin=[]    ;   % starting frequency
fstep=[]   ;   % SFCW step size
step_num=[] ;  % SFCW number of steps
T_step=[] ;   %duration of step
T=[];  %duration of whole signal
B=[];  % bandwidth
c=299792458 ; % speed of light
Mt=[]; % matrix length in time domain 

% radar physical parameters
Mx=4;  % number of antenas in x axis (?transmiters?)
My=4;  % number of antenas in y axis  (?receivers?)
D_x=0.05; % antennas separation x axis [m]
D_y=0.05;  % antennas separation y axis [m]
beam_w=[];  % Antenna beamwidth [rad]


