function plot_sensitivities_deformed(ELIST,NLIST,beso,Variable,u)


ELIST_simp = ELIST(1:beso.nelem,7:10);
NLIST_simp = NLIST(1:beso.nnodes,2:3);

NLIST_simp_def = NLIST_simp + u*1e6;



plot_aux_densities = ones(length(ELIST_simp),1);
plot_aux_densities(1:length(beso.densities)) = beso.densities; 

plot_aux_densities2(1:length(beso.densities)) = ~beso.densities; 
colormap jet




patch('Faces',ELIST_simp(find(plot_aux_densities),:),'Vertices',NLIST_simp_def,'FaceVertexCData',sign(Variable(find(plot_aux_densities))).*sqrt(abs(Variable(find(plot_aux_densities)))),'FaceColor','flat','Linestyle','none' )
patch('Faces',ELIST_simp(find(plot_aux_densities2),:),'Vertices',NLIST_simp_def,'FaceColor','#8B8878','Linestyle','none');


axis equal
axis off


end
