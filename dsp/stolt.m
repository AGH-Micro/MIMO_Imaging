%Mx = length(kx)
%My = length(ky)
%L = number of time samples
%kz3D = sqrt(4*Kt3D.^2 - kx3D.^2 - ky3d.^2) 
% as said in the w-k video by A V Muppala

% trunc (x or y) range - we only take the reflections which are strong enough 
%

% kz1D_uni - uniform sampling of kz3D

% s_B - signal after FFT in 2 dimensions 

% for clarity, i use s_B, rather than 'data', can change later

% !!!! IF DOESNT WORK, MAYBE THIS COULD BE THE PROBLEM !!!
%
kz_min = min(real(kz(:)));
kz_max = max(real(kz(:)));
kz1D_uni = linspace(kz_min, kz_max, L);
%

s_B2 = zeros(Mx,My,L);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% figure;
% scatter3(-Mx/2:Mx/2,-Myn/2:Myn/2, squeeze(kz3D(indX,indY,:)));
% figure;
% scatter3(-Mx/2:Mx/2,-Myn/2:Myn/2, kz1D_uni);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for indX = 1:Mx
    for indY = 1:My
        % squeeze(kz3D(indX,indY,:)) - points in which we know the value

        % squeeze(s_B(truncX_range(indX),truncY_range(indY),:))
        % = the values

        % kz1D_uni - points in which we want to know the value

        % s_B2() - new, computed, extrapolated values

        % version with strong reflections
        % s_B2(indX,indY,:) = interp1(squeeze(kz(indX,indY,:)),squeeze(s_B(truncX_range(indX),truncY_range(indY),:)),kz1D_uni);
        
        
        %version with no cutting off
        s_B2(indX,indY,:) = interp1(squeeze(kz(indX,indY,:)),squeeze(s_B(indX,indY,:)),kz1D_uni);
        
    end
end

s_B2(isnan(s_B2))=0; % Truncating extrapolated values lying outside the grid to zero.

