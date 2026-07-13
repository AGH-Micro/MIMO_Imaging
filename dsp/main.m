


%% constant values

% signal parameters
fs=      ;   % sampling frequency
fmin=    ;   % starting frequency
fstep=   ;   % SFCW step size
step_num= ;  % SFCW number of steps
T_step=  ;   %duration of step
T=T_step*step_num;  %duration of whole signal
B=step_num*fstep;  % bandwidth
c = 299 792 458 ; % speed of light
Mt= T*fs; % matrix length in time domain 

% radar physical parameters
Mx=4;  % number of antenas in x axis (?transmiters?)
My=4;  % number of antenas in y axis  (?receivers?)
D_x=0.05; % antennas separation x axis [m]
D_y=0.05;  % antennas separation y axis [m]
beam_w=;  % Antenna beamwidth [rad]


%% main code


% step 1 : load data , create matrix


% step 2 : fourier x-azis , y-axis 


% step 3: create phase factor matrix (?matched filter?) and multiply data by it

% step 4: Slotz interpolation 

% step 5: 3D inverse fourier 

% step 6: visualising data