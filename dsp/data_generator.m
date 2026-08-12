%% constant parameters
chirp_num=1;
chirp_time=0.0001;
step_num=10000;
freq_step=60000;
freq_start=10000000000;   
freq_samp=100000000000;

c=299792458 ;
fs=100000000000;

N=1000; %% downsampling value

% position of object
O=3; % number of objects

x=[0.7,1,0.1];
y=[-0.2,0.5,0];
z=[14,7,4];
% position of antennas
T_x= [0,0.05, 0.1, 0.15 ];
R_y= [0.05, 0.1, 0.15, 0.2 ];

%% start of computing
signal=SFCW(0,freq_samp,freq_start,freq_step,step_num,chirp_time,chirp_num);
f=fs/length(signal)*(0:length(signal)-1);

data=zeros(4,4,length(signal)/N);

for m=1:O

    dis_delay_T=  ( (T_x-x(m)).^2+ y(m)^2+ z(m)^2  ).^0.5;
    dis_delay_R=  ( x(m)^2+ (R_y-y(m)).^2+ z(m)^2  ).^0.5;

    dis_delay_T= [dis_delay_T;dis_delay_T;dis_delay_T;dis_delay_T];
    dis_delay_R=[dis_delay_R;dis_delay_R;dis_delay_R;dis_delay_R]';

    dis_delay=dis_delay_T+dis_delay_R;
    t_delay=dis_delay/c;


    for i=1:4
    for j=1:4    

        sig_rec_0=SFCW(t_delay(i,j),freq_samp,freq_start,freq_step,step_num,chirp_time,chirp_num);
        sig_rec_1 = (dis_delay(i,j)^(-4)).*sig_rec_0;
        sig_rec_2=sig_rec_1.*signal;

        % downsampling  
        if(N>1)
        %fs2=fs/N;
            y = lowpass(sig_rec_2,fs/N,fs);
            sig_rec_3=y(1:N:end);
            f2=fs2/length(sig_rec_3)*(0:length(sig_rec_3)-1);
            data(i,j,:)=squeeze(data(i,j,:))+squeeze(sig_rec_3);
        else
            data(i,j,:)= squeeze(data(i,j,:))+squeeze(sig_rec_2);
        end   
    end
    end
end 

% save("data_nr1.mat","data"); % save calculated data, !do not overwrite previous data!

% see results for yourself
%plot(f,abs(fft(sig_rec_2)))
%figure
%plot(f2,abs(fft(squeeze(data(1,1,:))))); pause

% you can calculate range by finding peak frequency
%R = fb*TP*c/2/B;          fb-peak frequency , TP - time of signal , B -bandwidth
% fb*TP = number of samples where peak frequency is

