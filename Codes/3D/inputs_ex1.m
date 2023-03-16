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
bar_quantity = 28;    % Final volume fraction
ER = 4; % bars per it
ARmax = 8; % bars per it
radius = 30E-3;
p = 3;
x_min = 1E-5;

% Convergence identifiers
is_converged = 0;
difference = 1;
loop = 1; 
N = 3;  
tau = 0.01; % Convergence tolerance

% extra parameters
plot_aux = 0;
t_i = zeros(300,1);

% geometry and mesh
x = 120E-3; 
y = 120E-3; 
z = 1400E-3;
bar_d = 6E-3;

dim = [x y z];

sub_dx = 4;
sub_dy = 4;
sub_dz = 7;
sub_div = [sub_dx sub_dy sub_dz];

sub_x = x/sub_dx;
sub_y = y/sub_dy;
sub_z = z/sub_dz;
sub_dim = [sub_x sub_y sub_z];

