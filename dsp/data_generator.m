
chirp_num=1;
chirp_time=0.0001;
step_num=10000;
freq_step=10000;
freq_start=10000000000;   
freq_samp=100000000000;

c=299792458 ;
fs=100000000000;

N=100; %% downsampling value

% position of object
x=0.7;
y=-0.2;
z=3;
% position of antennas
T_x= [0,0.05, 0.1, 0.15 ];
R_y= [0.05, 0.1, 0.15, 0.2 ];


signal=SFCW(freq_samp,freq_start,freq_step,step_num,chirp_time,chirp_num);
f=fs/length(signal)*(0:length(signal)-1);

dis_delay_T=  ( (T_x-x).^2+ y^2+ z^2  ).^0.5;
dis_delay_R=  ( x^2+ (R_y-y).^2+ z^2  ).^0.5;

dis_delay_T= [dis_delay_T;dis_delay_T;dis_delay_T;dis_delay_T];
dis_delay_R=[dis_delay_R;dis_delay_R;dis_delay_R;dis_delay_R]';

dis_delay=dis_delay_T+dis_delay_R;
t_delay=dis_delay/c;

k_delay=fs*t_delay;
k_delay=round(k_delay);
data=zeros(4,4,length(signal)/N);

for i=1:4;

for j=1:4;    

    
    sig_rec = dis_delay(i,j)^(-4)* [zeros(1,k_delay(i,j)) ,signal(1:end-k_delay(i,j))']';
    sig_rec_2=sig_rec.*signal;

    % downsampling  
    fs2=fs/N;
    y = lowpass(sig_rec_2,fs/N,fs);
    sig_rec_3=y(1:N:end);
    f2=fs2/length(sig_rec_3)*(0:length(sig_rec_3)-1);

    % see results for yourself
    %plot(f,abs(fft(sig_rec_2)))
    %figure
    %plot(f2,abs(fft(sig_rec_3))); pause

    % you can calculate range by finding peak frequency
    %R = fb*TP*c/2/B;          fb-peak frequency , TP - time of signal , B -bandwidth

    data(i,j,:)=sig_rec_3;
end

end

