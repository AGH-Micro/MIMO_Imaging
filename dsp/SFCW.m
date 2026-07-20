function x =SFCW( freq_samp,freq_start,freq_step,step_num,chirp_time,chirp_num)

%% default input values
if nargin<6
   chirp_num=1;
   if nargin<5
        chirp_time=0.0001;
        if nargin<4
            step_num=10000;
            if nargin<3
                freq_step=10000;
                if nargin<2
                    freq_start=10000000000;   
                    if nargin <1 
                        freq_samp=100000000000;
                    end
                end
            end
        end
   end
end


%% creating chirps frequency domain
dt=1/freq_samp;
t=dt:dt:chirp_time*chirp_num;
freq=(freq_start+(0:step_num-1)'*freq_step*(ones(1,round(chirp_time/dt/step_num))))';
freq=freq(:);
freq=freq*ones(1,chirp_num);

%% line 27 rounding error handling
freq=freq(1 : min(length(t),length(freq) ));
t=t(1:length(freq));

%% signal time domain
x=sin(2*pi*(freq').*t)';

%x=bandpass(x,[freq_start*0.9, 1.1*( freq_start+step_num*freq_step)],freq_samp);

end