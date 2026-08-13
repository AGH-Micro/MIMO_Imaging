



function x =SFCW( t_shift)

%% default input values
parameters;
if nargin <1 
  t_shift=0;
end


%% creating chirps frequency domain
dt=1/fs;
t=dt:dt:T_chirp*chirp_num;
t=t+t_shift;
freq=((0:step_num-1)'*fstep*(ones(1,round(T_chirp/dt/step_num))))';
freq=freq(:);
freq=freq*ones(1,chirp_num);
k_delay=round(fs*t_shift);
freq=[zeros(k_delay,1);freq(1:end-k_delay)];
%% line 27 rounding error handling
freq=freq(1 : min(length(t),length(freq) ));
t=t(1:length(freq));

%% signal time domain
phase=zeros(1,length(t));

for i=2:length(t)
    phase(i)=dt*freq(i)+phase(i-1);
end
x=sin(2*pi*fmin.*t+ 2*pi*phase)';
for i=1:k_delay
    x(i)=0;
end
%x=bandpass(x,[fmin*0.9, 1.1*( fmin+step_num*fstep)],fs);

end