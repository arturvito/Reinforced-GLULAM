function build_ansys_ex1(mat1,mat2,dim,sub_dim,sub_div,bar_d)
%% --------------------------------------------------------------------- %%
%    >>                                                                   %
%-------------------------------------------------------------------------%

file = fopen("ansys_in.mac", "w");   

    fprintf(file,"FINISH\r\n");
    fprintf(file,"/CLEAR,NOSTART\r\n");
    fprintf(file,"ALLSEL,ALL\r\n"); 

    fprintf(file,"/PREP7 \r\n"); 

    fprintf(file,'MP,EX,1,%5.6f\r\n', mat1(1,1));   
    fprintf(file,'MP,PRXY,1,%5.6f\r\n', mat1(2,1));
    
    fprintf(file,'MP,EX,2,%5.6f\r\n', mat2(1,1));   
    fprintf(file,'MP,EY,2,%5.6f\r\n', mat2(1,2));  
    fprintf(file,'MP,EZ,2,%5.6f\r\n', mat2(1,3));  
    fprintf(file,'MP,PRXY,2,%5.6f\r\n', mat2(2,1));
    fprintf(file,'MP,PRYZ,2,%5.6f\r\n', mat2(2,2)); 
    fprintf(file,'MP,PRXZ,2,%5.6f\r\n', mat2(2,3));
    fprintf(file,"MP,GXY,2,%.10e\r\n", mat2(3,1)); 
    fprintf(file,"MP,GYZ,2,%.10e\r\n", mat2(3,2)); 
    fprintf(file,"MP,GXZ,2,%.10e\r\n", mat2(3,3));  
    
    %solid 185
    fprintf(file,'ET,1,SOLID185\r\n'); 
    fprintf(file,'KEYOPT,1,2,2\r\n');        
    fprintf(file,"ALLSEL,ALL \r\n");

    % geometria 
    fprintf(file,'x=   %5.6f \r\n',dim(1));   
    fprintf(file,'y=   %5.6f \r\n',dim(2)); 
    fprintf(file,'z=   %5.6f \r\n',dim(3)); 
    
    fprintf(file,'dx=   %5.6f \r\n',sub_dim(1));   
    fprintf(file,'dy=   %5.6f \r\n',sub_dim(2)); 
    fprintf(file,'dz=   %5.6f \r\n',sub_dim(3)); 
    fprintf(file,'ndx=  %5.6f \r\n',sub_div(1)); 
    fprintf(file,'ndy=  %5.6f \r\n',sub_div(2)); 
    fprintf(file,'ndz=  %5.6f \r\n',sub_div(3)); 
    
    fprintf(file,'bar_d =  %5.6f \r\n',bar_d); 

    fprintf(file,'RECTNG,-dx/2,dx/2,-dy/2,dy/2\r\n'); 
    fprintf(file,'PCIRC,bar_d/2,,0,360          \r\n'); 
    fprintf(file,'AOVLAP,ALL                  \r\n'); 

    fprintf(file,'L,1,3 \r\n'); 
    fprintf(file,'L,2,4 \r\n'); 

    fprintf(file,'K,100,-dx,0       \r\n'); 
    fprintf(file,'K,101,dx,0        \r\n'); 
    fprintf(file,'K,102,0,dx        \r\n'); 
    fprintf(file,'K,103,0,-dx       \r\n'); 
    fprintf(file,'L,100,101         \r\n'); 
    fprintf(file,'L,102,103         \r\n'); 
    fprintf(file,'ASBL,ALL,ALL      \r\n'); 
    fprintf(file,'VEXT,ALL,,,0,0,-dz\r\n'); 
    fprintf(file,'VGLUE,ALL         \r\n');    
    
    
    fprintf(file,'VGEN,ndx,ALL,,,dx                           \r\n'); 
    fprintf(file,'VGEN,ndy,ALL,,,,dy                          \r\n'); 
    fprintf(file,'VGEN,ndz,ALL,,,,,-dz                         \r\n'); 
    fprintf(file,'VGLUE,ALL                                   \r\n'); 
    
    fprintf(file,'VGEN, ,ALL, , ,dx/2,dy/2 , , , ,1          \r\n'); 
    
    
    fprintf(file,'VSEL,S,LOC,x,dx/2-(bar_d/4)-1E-3,(bar_d/4)+1E-3 +dx/2       \r\n'); 
    fprintf(file,'*do,i,2,ndx                                 \r\n'); 
    fprintf(file,'    VSEL,A,LOC,x,(i-1)*dx+dx/2+(-(bar_d/4)-1E-3),(i-1)*dx+dx/2+((bar_d/4)+1E-3)		\r\n'); 
    fprintf(file,'*enddo      								  \r\n'); 

    fprintf(file,'AESIZE,ALL,5E-3            				  \r\n'); 
    fprintf(file,'MSHAPE,0,3d\r\n');
    fprintf(file,'MSHKEY,1   \r\n');
    fprintf(file,'VMESH,ALL  \r\n');
    
    fprintf(file,'ALLSEL,ALL\r\n');  
    fprintf(file,'MPCHG,2,ALL\r\n');
    fprintf(file,'ALLSEL,ALL\r\n');  
    
    fprintf(file,'*get,nelem_bar,ELEM,0,count\r\n');
    fprintf(file,'*get,nnode_bar,NODE,0,count\r\n');
    fprintf(file,'*CFOPEN,malha_stat_bar,dat\r\n');
    fprintf(file,'*VWRITE,nelem_bar,nnode_bar\r\n');
    fprintf(file,'%%.12e, %%.12e\r\n');
    fprintf(file,'*CFCLOS\r\n');  

    fprintf(file,"ALLSEL,ALL \r\n");  
    fprintf(file,"VMESH,ALL\r\n");   
        
    fprintf(file,'*get,nelem,ELEM,0,count\r\n');
    fprintf(file,'*get,nnode,NODE,0,count\r\n');
    fprintf(file,'*CFOPEN,malha_stat,dat\r\n');
    fprintf(file,'*VWRITE,nelem,nnode\r\n');
    fprintf(file,'%%.12e, %%.12e\r\n');
    fprintf(file,'*CFCLOS\r\n');     
 
    % engaste
    fprintf(file,"ALLSEL,ALL\r\n");
    fprintf(file,'NSEL,R,LOC,X,-0.000001,+0.000001+x   \r\n');
    fprintf(file,'NSEL,R,LOC,Y,-0.000001,+0.000001   \r\n');
    fprintf(file,'NSEL,R,LOC,Z,-0.000001-z,+0.000001-z+50E-3  \r\n');
    fprintf(file,'D,ALL, ,0, , , ,ALL, , , , ,  	\r\n');
    
    % simetria
    fprintf(file,'ALLSEL,ALL                        \r\n');
    fprintf(file,'NSEL,R,LOC,X,-0.000001,+0.000001+x  \r\n');
    fprintf(file,'NSEL,R,LOC,Y,-0.000001,+0.000001+y   \r\n');
    fprintf(file,'NSEL,R,LOC,Z,-0.000001,+0.000001  \r\n');
    fprintf(file,'D,ALL, , , , , ,UZ, , , , ,	\r\n');    
    
    % Initial guess
    fprintf(file,'ALLSEL,ALL\r\n');  
    fprintf(file,'MPCHG,2,ALL\r\n');
    fprintf(file,'ALLSEL,ALL\r\n'); 
    

    fprintf(file,'ALLSEL,ALL\r\n'); 
    fprintf(file,'VSEL,S,LOC,x,dx/2-(bar_d/4)-1E-3+x/4,(bar_d/4)+dx/2+1E-3+x/4 \r\n'); 
    fprintf(file,'VSEL,R,LOC,Y,2*y/4,3*y/4 \r\n'); 
    fprintf(file,'ESLV,S     \r\n');      
    fprintf(file,'MPCHG,1,ALL\r\n');  
    fprintf(file,'ALLSEL,ALL\r\n'); 
    
    fprintf(file,'ALLSEL,ALL\r\n'); 
    fprintf(file,'VSEL,S,LOC,x,dx/2-(bar_d/4)-1E-3+2*x/4,(bar_d/4)+dx/2+1E-3+2*x/4 \r\n'); 
    fprintf(file,'VSEL,R,LOC,Y,2*y/4,3*y/4 \r\n'); 
    fprintf(file,'ESLV,S     \r\n');      
    fprintf(file,'MPCHG,1,ALL\r\n');  
    fprintf(file,'ALLSEL,ALL\r\n'); 

    fprintf(file,'ALLSEL,ALL\r\n'); 
    fprintf(file,'VSEL,S,LOC,x,dx/2-(bar_d/4)-1E-3+x/4,(bar_d/4)+dx/2+1E-3+x/4 \r\n'); 
    fprintf(file,'VSEL,R,LOC,Y,y/4,2*y/4 \r\n'); 
    fprintf(file,'ESLV,S     \r\n');      
    fprintf(file,'MPCHG,1,ALL\r\n');  
    fprintf(file,'ALLSEL,ALL\r\n'); 
    
    fprintf(file,'ALLSEL,ALL\r\n'); 
    fprintf(file,'VSEL,S,LOC,x,dx/2-(bar_d/4)-1E-3+2*x/4,(bar_d/4)+dx/2+1E-3+2*x/4 \r\n'); 
    fprintf(file,'VSEL,R,LOC,Y,y/4,2*y/4 \r\n'); 
    fprintf(file,'ESLV,S     \r\n');      
    fprintf(file,'MPCHG,1,ALL\r\n');  
    fprintf(file,'ALLSEL,ALL\r\n'); 
    
    
    % NLIST
    fprintf(file,"ALLSEL,ALL \r\n");  
    fprintf(file,"/PAGE, 1E9,, 1E9,,\r\n"); 
    fprintf(file,"/FORMAT, , ,14,5, ,\r\n");     
    fprintf(file,"/HEADER, off, off, off, off, on, off  \r\n");    
    fprintf(file,"/OUTPUT,NLIST,dat \r\n");      
    fprintf(file,"NLIST,ALL, , , ,NODE,NODE,NODE  \r\n");     
    fprintf(file,"/OUTPUT \r\n");  

    % ELIST
    fprintf(file,"ALLSEL,ALL \r\n");  
    fprintf(file,"/PAGE, 1E9,, 1E9,,\r\n"); 
    fprintf(file,"/FORMAT, , ,14,5, ,\r\n");     
    fprintf(file,"/HEADER, off, off, off, off, on, off  \r\n");    
    fprintf(file,"/OUTPUT,ELIST,dat \r\n");      
    fprintf(file,"ELIST,ALL, , , ,NODE,NODE,NODE  \r\n");     
    fprintf(file,"/OUTPUT \r\n");  
    fprintf(file,'FINISH      \n');    
  
    %% Real Load
    % SOL    
    fprintf(file,"/SOL \r\n");
    
    % forca Y real
    fprintf(file,'ALLSEL,ALL                        \r\n');
    fprintf(file,'NSEL,R,LOC,X,-0.000001,+0.000001+x  \r\n');
    fprintf(file,'NSEL,R,LOC,Y,-0.000001+y,+0.000001+y  \r\n');
    fprintf(file,'NSEL,R,LOC,Z,-0.000001-z/4,+0.000001-z/4  \r\n');
    fprintf(file,"*get,forcenodes,node,,count  \r\n");  
    fprintf(file,'x_i = x/(forcenodes-1)     								\r\n');
    fprintf(file,'pi = 3.141592653589793238				                    \r\n');
    fprintf(file,'                                                          \r\n');
    fprintf(file,'*do,i,1,forcenodes                                        \r\n');
    fprintf(file,'	ALLSEL,ALL                                              \r\n');
    fprintf(file,'	NSEL,R,LOC,X,-0.000001+(x_i*(i-1)),+0.000001+(x_i*(i-1))\r\n');
    fprintf(file,'	NSEL,R,LOC,Y,-0.000001+y,+0.000001+y                    \r\n');
    fprintf(file,'	NSEL,R,LOC,Z,-0.000001-z/4,+0.000001-z/4  				\r\n');			
    fprintf(file,'    F,ALL,FY,sin((pi/16)*(i-1))*1000                      \r\n');
    fprintf(file,'*enddo                                                    \r\n'); 
    fprintf(file,'ALLSEL,ALL 							\r\n');    
   
    %SOLVE
    fprintf(file,"ANTYPE,0     \n") ;
    fprintf(file,"EQSLV,PCG,1E-10    \r\n");
    fprintf(file,"SOLVE   \r\n");
    fprintf(file,'FINISH      \n');
    
        
    % SAVE       
    fprintf(file,'/POST1\r\n');
    fprintf(file,'SAVE,Z_db,DB,,SOLU\r\n');
    
    %% post
    
    % GET FROM ORIGINAL PROBLEM
    fprintf(file,'/POST1\r\n'); 
    fprintf(file,'SET,FIRST \r\n');  
    
    % Ux e Uy e Uz
    fprintf(file,'*DIM,uxmatrix,array,nnode,1,\n') ;
    fprintf(file,'*DIM,uymatrix,array,nnode,1,\n'); 
    fprintf(file,'*DIM,uzmatrix,array,nnode,1,\n'); 
    fprintf(file,'*DO,i,1,nnode               \n') ;
    fprintf(file,'*get,uxmatrix(i),NODE,i,U,X \n') ;
    fprintf(file,'*get,uymatrix(i),NODE,i,U,Y \n') ;
    fprintf(file,'*get,uzmatrix(i),NODE,i,U,Z \n') ;
    fprintf(file,'*enddo                      \n')  ;     

    fprintf(file,'*CFOPEN,ux,dat\r\n');
    fprintf(file,'*VWRITE,uxmatrix(1)\r\n');
    fprintf(file,'%%.15e\r\n');
    fprintf(file,'*CFCLOS\r\n');  
    
    fprintf(file,'*CFOPEN,uy,dat\r\n');
    fprintf(file,'*VWRITE,uymatrix(1)\r\n');
    fprintf(file,'%%.12e\r\n');
    fprintf(file,'*CFCLOS\r\n'); 

    fprintf(file,'*CFOPEN,uz,dat\r\n');
    fprintf(file,'*VWRITE,uzmatrix(1)\r\n');
    fprintf(file,'%%.12e\r\n');
    fprintf(file,'*CFCLOS\r\n'); 
    
    % SENE
    fprintf(file,"ALLSEL,ALL \r\n");  
    fprintf(file,'etable, my_sene, sene \r\n'); 
    fprintf(file,'*VGET,strain_energy,ELEM, ,ETAB,my_sene, , ,2\r\n');
    fprintf(file,'*CFOPEN,SENE,dat\r\n');
    fprintf(file,'*VWRITE,strain_energy(1)\r\n');
    fprintf(file,'%%.20f\r\n');
    fprintf(file,'*CFCLOS\r\n'); 
    
    % Volume
    fprintf(file,'etable, my_vol, volu \r\n'); 
    fprintf(file,'*VGET,element_volume,ELEM, ,ETAB,my_vol, , ,2\r\n');
    fprintf(file,'*CFOPEN,ElementVolume,dat\r\n');
    fprintf(file,'*VWRITE,element_volume(1)\r\n');
    fprintf(file,'%%.20e\r\n');
    fprintf(file,'*CFCLOS\r\n');

    % Centroid X
    
    fprintf(file,'ETABLE,cent_x,CENT,X  \r\n'); 
    fprintf(file,'*VGET,my_cent_x,ELEM, ,ETAB,cent_x, , ,2 \r\n'); 
    fprintf(file,'*CFOPEN,Centroid_x,dat \r\n'); 
    fprintf(file,'*VWRITE,my_cent_x(1) \r\n'); 
    fprintf(file,'%%.20e\r\n');
    fprintf(file,'*CFCLOS \r\n'); 
    
    % Centroid Y
    
    fprintf(file,'ETABLE,cent_y,CENT,Y  \r\n'); 
    fprintf(file,'*VGET,my_cent_y,ELEM, ,ETAB,cent_y, , ,2 \r\n'); 
    fprintf(file,'*CFOPEN,Centroid_y,dat \r\n'); 
    fprintf(file,'*VWRITE,my_cent_y(1) \r\n'); 
    fprintf(file,'%%.20e\r\n');
    fprintf(file,'*CFCLOS \r\n');  
    
    % Centroid Z    
    fprintf(file,'ETABLE,cent_z,CENT,Z  \r\n'); 
    fprintf(file,'*VGET,my_cent_z,ELEM, ,ETAB,cent_z, , ,2 \r\n'); 
    fprintf(file,'*CFOPEN,Centroid_z,dat \r\n'); 
    fprintf(file,'*VWRITE,my_cent_z(1) \r\n'); 
    fprintf(file,'%%.20e\r\n');
    fprintf(file,'*CFCLOS \r\n');    
    
    fprintf(file,'FINISH      \n');

fclose(file);
 

end
