function plot_glulam(ELIST,NLIST,beso,x,y)


ELIST_simp = ELIST(1:beso.nelem,7:10);
NLIST_simp = NLIST(1:beso.nnodes,2:3);

plot_aux_densities = ones(length(ELIST_simp),1);
plot_aux_densities(1:length(beso.densities)) = beso.densities; 

plot_aux_densities2(1:length(beso.densities)) = ~beso.densities; 
colormap jet

patch('Faces',[1 2 3 4],'Vertices',[0 0; x 0; x y; 0 y],'FaceColor','#DDB888','Linestyle','none');

patch('Faces',ELIST_simp(find(plot_aux_densities),:),'Vertices',NLIST_simp,'FaceColor','#DDB888','Linestyle','none');

patch('Faces',ELIST_simp(find(plot_aux_densities2),:),'Vertices',NLIST_simp,'FaceColor','#000000','Linestyle','none');


axis equal
axis off


end
