%% --------------------------------------------------------------------- %%
%    >>                                                                   %
%-------------------------------------------------------------------------%

% Materiais
E1 = 210E9;    %E para material em PA
v1 = 0.3;            %Poisson

E2 = [13400E6 670E6 911.2E6];            %E para material em MPA
v2 = [0.292 0.39 0.449];                 %Poisson
g2 = [857.6E6 93.8E6 1045.2E6];

mat1 = [E1;v1];
mat2 = [E2;v2;g2];

% Beso parameters
bar_quantity = 8;    % Final volume fraction
ER = 2; % bars per it
ARmax = 2; % bars per it
radius = 30E-3;
p = 3;
x_min = 1E-5;

% steel bar size
x_bar_divisions = 8;
y_bar_len = 6E-3;
% Convergence identifiers
is_converged = 0;
difference = 1;
loop = 1; 
N = 5;  
tau = 0.001; % Convergence tolerance

% extra parameters
plot_aux = 0;
t_i = zeros(300,1);

% geometry and mesh
x = 1200E-3; 
y = 120E-3;    
esize = 1E-3;
