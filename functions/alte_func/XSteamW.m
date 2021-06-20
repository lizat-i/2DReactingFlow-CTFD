%% XSteamW.m - a vectorizing wrapper for XSteam.m
%
% Syntax:
% 
% result = XSteamW (Var1, Var2);
% result = XSteamW (Var1, Var2, Var3);
% 
% XSteam.m is a function, written by Magnus Holmgren, for
% calculating Steam and Water properties according to the 
% IAPWS IF-97 standard. XSteam is free, see http://www.x-eng.com
% or http://www.mathworks.com/matlabcentral/fileexchange/9817
% Thanx to Magnus!
% 
% Unfortunately XSteam does not support vectors as passed
% arguments. So calling XSteam following vectorized code
% guidelines sometimes results in error messages. Therefore
% writing some kind of loops around XSteam seems to be unavoidable
% in certain cases.
% 
% XSteamW is a "wrapper" for XSteam, doing this "looping" around
% XSteam. Like XSteam, XSteamW supports two or three arguments. The
% argument Var1 denotes the function XSteam calculates. The 2nd
% argument Var2 serves as an input variable to this function:
% 
% result = XSteam (Var1, Var2);
% 
% Example: calculation of saturated vapour heat capacity as a
% function of pressure, expressed in bar:
% 
% vapour_heat_capacity = XSteam ('CpV_p', pressure);
% 
% Functions of two variables need three arguments passed to
% XSteam. The first argument denotes the function XSteam 
% calculates. The 2nd and 3rd argument serve as input variables 
% to this function: 
% 
% result = XSteam (Var1, Var2, Var3);
% 
% Example: calculation of steam enthalpy as a function of
% pressure and temperature, expressed in bar and °C:
% 
% enthalpy = XSteam ('h_pt', pressure, temperature);
% 
% For documentation of XSteam functions passed through Var1
% see the XSteam documentation.
% 
% 
% XSteamW adds support for row or column vectors passed as arguments
% Var2 and/or Var3. Var1 is passed unchanged to XSteam.
% 
% result = XSteamW (Var1, Var2);
% result = XSteamW (Var1, Var2, Var3);
% 
% Results are calculated as an m-by-n matrix. The number m of rows
% equals the length of Var2, the number n of columns equals
% the length of Var3.
% 
% Example: all of these calls
% 
% XSteamW ('h_pt', [100, 150, 200], [500, 510, 520, 530])
% XSteamW ('h_pt', [100; 150; 200], [500, 510, 520, 530])
% XSteamW ('h_pt', [100, 150, 200], [500; 510; 520; 530])
% XSteamW ('h_pt', [100; 150; 200], [500; 510; 520; 530])
% XSteamW ('h_pt', 100:50:200, 500:10:530)
% 
% will result in
% 
% ans =
% 
%    1.0e+03 *
% 
%     3.3751    3.4008    3.4263    3.4517
%     3.3108    3.3395    3.3678    3.3957
%     3.2412    3.2736    3.3052    3.3361
% 
% 
% XSteam ('h_pt', 100, 500)
% 
% will give
% 
% ans =
% 
%     3.3751e+03
% 
% XSteam ('h_pt', 200, 530)
% 
% results
% 
% ans =
% 
%     3.3361e+03
% 
% 
% V. Staben - Flensburg University of Applied Sciences

%% the code, dumb switching...


function [Result] = XSteamW (Func, Input1, varargin)

    SizeOfVarargIn = size (varargin);

    SizeOfInput1 = size (Input1);

    % check Input1 size, abort if not 1-by-n or n-by-1

    if (min (SizeOfInput1) > 1);
        
        error ('sorry, a matrix is not supported by XSteamW.')
        
    end



    switch SizeOfVarargIn (1)

        case 0                  % no 3rd variable was passed to XSteamW

            Result = zeros (1, max (SizeOfInput1));

            for i = 1:max (SizeOfInput1)            % the loop

                Result (i) = XSteam (Func, Input1(i));

            end



        case 1                  % optionasl variable(s) passed to XSteamW

            
            Input2 = cell2mat(varargin(1));
            
            SizeOfInput2 = size (Input2);

            % check Input2 size, abort if not 1-by-n or n-by-1

            if (min (SizeOfInput2) > 1);
                
                error ('sorry,a matrix is not supported by XSteamW.')
                
            end

            Result = zeros (max (SizeOfInput1), max (SizeOfInput2));
            
            for i = 1:max (SizeOfInput1)            % the loop
                
                for j = 1:max (SizeOfInput2)        % arrrrgh...

                    Result (i,j) = XSteam (Func, Input1(i), Input2(j));
                    
                end

            end
            
        otherwise
            
            error ('XSteamW detected unexspected arguments.')

   end

end