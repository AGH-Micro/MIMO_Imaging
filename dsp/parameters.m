function S=parameters()



% signal parameters
S.fs=[]     ;   % sampling frequency
S.fmin=[]    ;   % starting frequency
S.fstep=[]   ;   % SFCW step size
S.step_num=[] ;  % SFCW number of steps
S.T_step=[] ;   %duration of step
S.T=[];  %duration of whole signal
S.B=[];  % bandwidth
S.c=299792458 ; % speed of light
S.Mt=[]; % matrix length in time domain 

% radar physical parameters
S.Mx=4;  % number of antenas in x axis (?transmiters?)
S.My=4;  % number of antenas in y axis  (?receivers?)
S.D_x=0.05; % antennas separation x axis [m]
S.D_y=0.05;  % antennas separation y axis [m]
S.beam_w=[];  % Antenna beamwidth [rad]


end