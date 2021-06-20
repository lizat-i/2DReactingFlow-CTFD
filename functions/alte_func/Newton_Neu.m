function [x, iStep] = Newton(f, x_0)

% Iteration settings
iStep = 0;   % Initialise iteration step counter
iStepMax = 50;   % Max iteration steps before process stops
tolerance = 1e-7;   % Criterion to check if root of equation has been found
xConvergenceTest = tolerance+1;  % Initialise error value for convergence error on x axis

h = 1e-5;  % Size of step for numerical (forward and backward) difference method
x = x_0;
y = f(x);  % Function value at initial guess

% No need to check if function value of initial guess < tolerance as it is highly unlikely.  
% iStep<iStepMax instead of <= to ensure the last step is actually performed
while (abs(y) > tolerance) && (xConvergenceTest > tolerance) && (iStep < iStepMax)
    dy_dx = (f(x+h) - y) / h;  % Forward difference method. Less accurate than central diff but it reduces computational cost.
    
    xNew = x - y/dy_dx;   % Intersection with x axis
    xConvergenceTest = abs(xNew-x);
    
    x = xNew;
    y = f(x);
              
    iStep = iStep + 1;
end


end