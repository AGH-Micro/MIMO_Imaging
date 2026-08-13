
kx=D_x/Mx*(-Mx/2:Mx/2-1);
ky=D_y/My*(-My/2:My/2-1);

L=T_chirp*chirp_num*fs;

freq=(fmin+(0:step_num-1)'*fstep*(ones(1,round(T_chirp*fs/step_num))))';
freq=freq(:);
k=2*pi/c*freq;

[mesh_kx,mesh_ky,mesh_k] = meshgrid(kx,ky,k);

z0=0.03; % ??? center of scene, dont know if correct  kt0 = 2*pi*(f_start+1/2*f_step*step_num)/c =>    z0=??(c/(f_start+1/2*f_step*step_num))??
%"It is important to note that in ground-based SAR scenario, z0 is considered to be zero."
kz=(mesh_k.^2-mesh_kx.^2-mesh_ky.^2).^0.5;
pf= -exp(j* z0*kz );
data=data.*pf;

