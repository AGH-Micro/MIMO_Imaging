%% data cells (2 cells of 2x2 matrices )
Tx_data=cell(2);
Rx_data=cell(2);


% radar parameters
radar.fs=50*1e6;   % sampling frequency
radar.fmin=[]    ;   % starting frequency
radar.fstep=[]   ;   % SFCW step size
radar.step_num=[] ;  % SFCW number of steps
radar.T_step=[] ;   %duration of step
radar.T=[];  %duration of whole signal
radar.B=[];  % bandwidth
radar.D_x=0.05; % antennas separation x axis [m]
radar.D_y=0.05;  % antennas separation y axis [m]
radar.beam_w=[];  % Antenna beamwidth [rad]


%generating SFCW signal (need phased array toolbox)
sfcw_wave=phased.SteppedFMWaveform;
sfcw_wave.SampleRate=radar.fs;
sfcw_wave.FrequencyStep=4e3;
sfcw_wave.FrequencyOffset=96e6; % center frequency is 100MHz with 8MHz bandwidth
sfcw_wave.NumPulses=100;


c=299792458 ; % speed of light





