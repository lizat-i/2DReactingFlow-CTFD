function [c_p_noise,T_vec,c_p] = Create_measurements(lower,upper,nMeasurements,noiseLevel)
%%Create_measurements gibt fuer einen gegeben Temperaturbereich Messdaten fuer c_p
%   aus, deren Messfehler gaußverteilt ist.
%
% XSteam wird benötigt!

% Druck
p = 1;

% Initialisierung
T_vec = linspace(lower,upper,nMeasurements)';
c_p = zeros(size(T_vec));

for ii=1:length(T_vec)
  T_C = T_vec(ii) - 273.15;
  c_p(ii) = XSteam('Cp_pT',p,T_C);
end

%% Weisses Gauss'sches Rauschen überlagern (guter Wert für noiseLevel=35)
c_p_noise = awgn(c_p,noiseLevel);

end