%% --------------------------------------------------------------------- %%
%                          ** Main Program **                             %
%-------------------------------------------------------------------------%
clear,clc,close all

% Create odir
[odir,odir_ansys] = workingdirectory();

% Load Input and save a copy
input_file = "inputs_ex1.m";
run(input_file);
copyfile(input_file,odir);

%run first script
tic
build_ansys_ex1(mat1,mat2,x,y,y_bar_len,esize)
build_ansys_get_K()
run_ANSYS(odir_ansys,'first','Z_db');
run_ANSYS(odir_ansys,'update','Z_db');

% Getting information 
[nelem,nnodes,ELIST,NLIST,element_vol,centroids,K1,K2] = getvalues(odir_ansys);

% loop 0
% Prepare BESO
beso = BESO(bar_quantity,nelem,nnodes,element_vol,ARmax,ER,x_min,p);

%Initial guess
beso.densities(find(ELIST(1:beso.nelem,2)==2)) = 1;
beso.densities(find(ELIST(1:beso.nelem,2)==1)) = 0;

% Initialize densities
void_elements = find(beso.densities == 0);    
solid_elements = find(beso.densities == 1); 

% bar coordinates and number of elements
bar_positions_coord = bar_positions(centroids,x_bar_divisions,y_bar_len,beso,x,y,esize);
nelem_per_bar= size(bar_positions_coord);
beso.nelem_per_bar = nelem_per_bar(1);

% build H matrix
tic
H = BuildFilterMatrix_3D(beso,radius,centroids(1:beso.nelem,:));
th = toc/60;

%run iteration
iteration

while (is_converged == 0)
    tic
    
    % Iteration counter update
    loop = loop + 1;    

    % Solve with BESO design update scheme
    beso = BESODesignUpdate(beso);

    % Initialize densities
    void_elements = find(beso.densities == 0);    
    solid_elements = find(beso.densities == 1); 

    % Run update topology script APDL
    build_update(void_elements)
    run_ANSYS(odir_ansys,'update','Z_db');           

    %run iteration
    iteration  
    
    % safe exit
    if loop == 100
        break
    end
    
end

% % Ploting compliance history
fig_his = figure;
plot_fun(loop,beso.history(:,1),[0 50],beso,'Objective Function')
exportgraphics(fig_his,[odir '/plots/history_design_domain.eps'],'Resolution',300)
exportgraphics(fig_his,[odir '/plots/history_design_domain.png'],'Resolution',300)
save([odir '/workspace.mat'])

rmdir([odir '/ansys'],'s')
