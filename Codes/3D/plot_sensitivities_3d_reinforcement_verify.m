function plot_sensitivities_3d_reinforcement_verify(ELIST,NLIST,beso,Variable,x,y,z)
x=x;
y=y;
z=-z;
ELIST_simp = ELIST(1:beso.nelem,7:14);
NLIST_simp = NLIST(1:beso.nnodes,2:4);

NLIST_simp_x1 = NLIST_simp;

pot = 1/4;

plot_aux_densities = ones(length(ELIST_simp),1);
% plot_aux_densities(1:length(beso.densities)) = ones(length(beso.densities),1); 

colormap(jet)


hold on
patch('Faces',ELIST_simp(find(plot_aux_densities),[1:4]),'Vertices',NLIST_simp(:,[1,3,2]),'FaceVertexCData',sign(Variable(find(plot_aux_densities))).*(abs(Variable(find(plot_aux_densities)).^pot)),'FaceColor','flat','Linestyle','none')
patch('Faces',ELIST_simp(find(plot_aux_densities),[5:8]),'Vertices',NLIST_simp(:,[1,3,2]),'FaceVertexCData',sign(Variable(find(plot_aux_densities))).*(abs(Variable(find(plot_aux_densities)).^pot)),'FaceColor','flat','Linestyle','none')
patch('Faces',ELIST_simp(find(plot_aux_densities),[1,2,6,5]),'Vertices',NLIST_simp(:,[1,3,2]),'FaceVertexCData',sign(Variable(find(plot_aux_densities))).*(abs(Variable(find(plot_aux_densities)).^pot)),'FaceColor','flat','Linestyle','none')
patch('Faces',ELIST_simp(find(plot_aux_densities),[3,4,8,7]),'Vertices',NLIST_simp(:,[1,3,2]),'FaceVertexCData',sign(Variable(find(plot_aux_densities))).*(abs(Variable(find(plot_aux_densities)).^pot)),'FaceColor','flat','Linestyle','none')
patch('Faces',ELIST_simp(find(plot_aux_densities),[1,4,8,5]),'Vertices',NLIST_simp(:,[1,3,2]),'FaceVertexCData',sign(Variable(find(plot_aux_densities))).*(abs(Variable(find(plot_aux_densities)).^pot)),'FaceColor','flat','Linestyle','none')
patch('Faces',ELIST_simp(find(plot_aux_densities),[2,3,7,6]),'Vertices',NLIST_simp(:,[1,3,2]),'FaceVertexCData',sign(Variable(find(plot_aux_densities))).*(abs(Variable(find(plot_aux_densities)).^pot)),'FaceColor','flat','Linestyle','none')



view(35,30)
view([1 -1 1])
axis equal
axis off


end
