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
build_ansys_ex1(mat1,mat2,dim,sub_dim,sub_div,bar_d)
build_ansys_get_K()
run_ANSYS(odir_ansys,'first','Z_db');
run_ANSYS(odir_ansys,'update','Z_db');
toc

% Getting information 
[nelem,nnodes,ELIST,NLIST,element_vol,centroids,nelem_bar,nnodes_bar] = getvalues(odir_ansys);

% loop 0
% Prepare BESO
beso = BESO(bar_quantity,nelem_bar,nnodes_bar,element_vol,ARmax,ER,x_min,p);

% bar coordinates and number of elements
sub_domain_elements = sub_domain_elements_list(centroids,beso,dim,sub_div);
[K1,K2] = get_Ks(odir_ansys,sub_domain_elements);

nelem_per_bar= size(sub_domain_elements);
beso.nelem_per_bar = nelem_per_bar(1);

%Initial guess
beso.densities(find(ELIST(:,2)==2)) = 1;
beso.densities(find(ELIST(:,2)==1)) = 0;

% Initialize densities
void_elements = find(beso.densities == 0);    
solid_elements = find(beso.densities == 1); 

% build H matrix
tic
% H = BuildFilterMatrix_3D(beso,radius,centroids(1:beso.nelem,:));
load('h.mat')
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
plot_fun(loop,beso.history(:,1),[0 120],beso,'Objective Function')
exportgraphics(fig_his,[odir '/plots/history_design_domain.eps'],'Resolution',300)
exportgraphics(fig_his,[odir '/plots/history_design_domain.png'],'Resolution',300)
save([odir '/workspace.mat'])

rmdir([odir '/ansys'],'s')
