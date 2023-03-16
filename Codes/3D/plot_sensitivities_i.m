function plot_sensitivities_i(ELIST,NLIST,beso,Variable,densities)


ELIST_simp = ELIST(1:beso.nelem,7:10);
NLIST_simp = NLIST(1:beso.nnodes,2:3);

plot_aux_densities = ones(length(ELIST_simp),1);
plot_aux_densities(1:length(beso.densities)) = densities; 

plot_aux_densities2(1:length(beso.densities)) = ~densities; 
colormap jet

patch('Faces',ELIST_simp(find(plot_aux_densities),:),'Vertices',NLIST_simp,'FaceVertexCData',sign(Variable(find(plot_aux_densities))).*sqrt(abs(Variable(find(plot_aux_densities)))),'FaceColor','flat','Linestyle','none' )

patch('Faces',ELIST_simp(find(plot_aux_densities2),:),'Vertices',NLIST_simp,'FaceColor','#8B8878','Linestyle','none');


axis equal
axis off


end
