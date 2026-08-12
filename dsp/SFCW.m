function x =SFCW( t_shift,freq_samp,freq_start,freq_step,step_num,chirp_time,chirp_num)

%% default input values
if nargin<7
   chirp_num=1;
   if nargin<6
        chirp_time=0.0001;
        if nargin<5
            step_num=10000;
            if nargin<4
                freq_step=10000;
                if nargin<3
                    freq_start=10000000000;   
                    if nargin <2 
                        freq_samp=100000000000;
                        if nargin <2 
                            t_shift=0;
                        end
                    end
                end
            end
        end
   end
end


%% creating chirps frequency domain
dt=1/freq_samp;
t=dt:dt:chirp_time*chirp_num;
t=t+t_shift;
freq=((0:step_num-1)'*freq_step*(ones(1,round(chirp_time/dt/step_num))))';
freq=freq(:);
freq=freq*ones(1,chirp_num);
k_delay=round(freq_samp*t_shift);
freq=[zeros(k_delay,1);freq(1:end-k_delay)];
%% line 27 rounding error handling
freq=freq(1 : min(length(t),length(freq) ));
t=t(1:length(freq));

%% signal time domain
phase=zeros(1,length(t));

for i=2:length(t)
    phase(i)=dt*freq(i)+phase(i-1);
end
x=sin(2*pi*freq_start.*t+ 2*pi*phase)';
for i=1:k_delay
    x(i)=0;
end
%x=bandpass(x,[freq_start*0.9, 1.1*( freq_start+step_num*freq_step)],freq_samp);

end