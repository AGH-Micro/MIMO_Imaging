


% signal parameters
fs=100000000;   % sampling frequency
fmin=10000000000;   % starting frequency
fstep=60000;   % SFCW step size
step_num=10000;  % SFCW number of steps
chirp_num=1; %number of chirps
T_chirp=0.0001;   %duration of chirp
T_step=T_chirp/step_num; % duration of step
T=T_chirp*chirp_num;  %duration of whole signal
B=fstep*step_num;  % bandwidth
c=299792458 ; % speed of light
%N=1000; %% downsampling value

%Mt=[]; % matrix length in time domain 

% radar physical parameters
Mx=4;  % number of antenas in x axis (?transmiters?)
My=4;  % number of antenas in y axis  (?receivers?)
D_x=0.05; % antennas separation x axis [m]
D_y=0.05;  % antennas separation y axis [m]
beam_w=[];  % Antenna beamwidth [rad]


