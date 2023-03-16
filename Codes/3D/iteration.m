% get from ansys
[ux,uy,uz,SENE] = get_RESP(odir_ansys);

delete([odir_ansys '/SENE.dat'])
delete([odir_ansys '/ux.dat'])
delete([odir_ansys '/uy.dat'])
delete([odir_ansys '/uz.dat'])

% objective Sensitivities
beso = objective_sensitivities(beso,ux,uy,uz,K1,K2,ELIST,sub_domain_elements);

% Filtering sensitivities
beso.objective_sensitivities = H*beso.objective_sensitivities;

%Evaluating average of alpha history
if loop > 1
    beso = alpha_history(beso,obj_sensitivities_previous,loop);
end

% Bar positions and sensitivities
beso.objective_sensitivities_bar = sub_domain_sensitivities(beso.objective_sensitivities,sub_domain_elements);

% Objective 
beso = objective_calc(beso,SENE,nelem);


% Bar quantity in it k
beso.bar_quantity_k = nnz(~beso.densities)/beso.nelem_per_bar;

% Storing optimization history
beso.history(loop,1) = beso.objective;
beso.history(loop,2) = beso.bar_quantity_k;
obj_sensitivities_previous(:,loop) = beso.objective_sensitivities;
densities_previous(:,loop) = beso.densities;

if (loop >= 2*N) % Analyzing 2*N consecutive iterations
    error_2 = zeros(N,1);
    error_2 = zeros(N,1);
    for i = 1:N
        error_1(i) = abs(beso.history(loop-i,1))-abs(beso.history(loop-N-i+1,1));
        error_2(i) = abs(beso.history(loop-i,1));
    end

    % Evaluating convergence
    difference = abs(sum(error_1))/sum(error_2);
    % Verifying error tolerance and if constraint is satisfied
    if ((difference <= tau) && (beso.bar_quantity_k == beso.bar_quantity))
        is_converged = 1;
    end
end

t_i(loop)= toc;

% Print results
disp([' It.: ' sprintf('%3i',loop) '  Obj.: ' sprintf('%5.6e',full(beso.objective))...
      '  Nr. of bars.: ' sprintf('%3.3f',beso.bar_quantity_k)...
      ' It. time: ' sprintf('%3.3f',t_i(loop)) ' Difference: ' sprintf('%3.3e',difference)])

if plot_aux == 0  
    close all
    
    fig_sens = figure;
    plot_sensitivities_3d_reinforcement(ELIST,NLIST,beso,beso.objective_sensitivities,x,y,z)
    exportgraphics(fig_sens,[odir '/plots/sens_' num2str(loop) '.png' ],'Resolution',400)
    view([1 0 0])
    exportgraphics(fig_sens,[odir '/plots/view_1_sens_' num2str(loop) '.png' ],'Resolution',400)
    view([0 -1 0])
    exportgraphics(fig_sens,[odir '/plots/view_2_sens_' num2str(loop) '.png' ],'Resolution',400)
    view([0 0 1])
    exportgraphics(fig_sens,[odir '/plots/view_3_sens_' num2str(loop) '.png' ],'Resolution',400)
    
    fig_sens_verify= figure;
    plot_sensitivities_3d_reinforcement_verify(ELIST,NLIST,beso,beso.objective_sensitivities_bar,x,y,z)
    exportgraphics(fig_sens_verify,[odir '/plots/sens_verify' num2str(loop) '.png' ],'Resolution',400)    
 
else
    plot_aux = plot_aux+1;
end
    
