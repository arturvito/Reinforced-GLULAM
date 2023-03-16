function build_ansys_ex1(mat1,mat2,x,y,y_bar_len,esize)
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
    
    
    %plane42
    fprintf(file,'ET,1,PLANE42\r\n'); 
    fprintf(file,'KEYOPT,1,2,1\r\n');     
    fprintf(file,"ALLSEL,ALL \r\n");

    % geometria     
    fprintf(file,'x = %f\r\n', x);  
    fprintf(file,'y = %f\r\n', y);
    
    fprintf(file,'y_len = %f\r\n', y_bar_len); 
    
    fprintf(file,'RECTNG,0,x,0,y_len, \r\n');  
    fprintf(file,'RECTNG,0,x,y/4-y_len/2,y/4+y_len/2, \r\n');  
    fprintf(file,'RECTNG,0,x,2*y/4-y_len/2,2*y/4+y_len/2, \r\n');
    fprintf(file,'RECTNG,0,x,3*y/4-y_len/2,3*y/4+y_len/2, \r\n');
    fprintf(file,'RECTNG,0,x,4*y/4,4*y/4-y_len, \r\n'); 
    
    fprintf(file,'RECTNG,0,x,y_len,y/4-y_len/2, \r\n'); 
    
    fprintf(file,'RECTNG,0,x,y/4+y_len/2,2*y/4-y_len/2, \r\n'); 
    
    fprintf(file,'RECTNG,0,x,2*y/4+y_len/2,3*y/4-y_len/2, \r\n'); 
    
    fprintf(file,'RECTNG,0,x,3*y/4+y_len/2,4*y/4-y_len, \r\n'); 
    
    fprintf(file,"ALLSEL,ALL\r\n");
    fprintf(file,'AGLUE,ALL  \r\n'); 
    fprintf(file,"ALLSEL,ALL\r\n");
    
    % malha design variable  
    fprintf(file,'ESIZE,%f\r\n', esize); 
    
    fprintf(file,"ALLSEL,ALL\r\n");
    fprintf(file,"ASEL,S, , ,       1 \r\n");
    fprintf(file,"ASEL,A, , ,       2 \r\n");
    fprintf(file,"ASEL,A, , ,       3 \r\n");
    fprintf(file,"ASEL,A, , ,       4 \r\n");
    fprintf(file,"ASEL,A, , ,       5 \r\n");    
    fprintf(file,"MSHKEY,1\r\n");
    fprintf(file,"AMESH,ALL\r\n");

    fprintf(file,'*get,nelem,ELEM,0,count\r\n');
    fprintf(file,'*get,nnode,NODE,0,count\r\n');
    fprintf(file,'*CFOPEN,malha_stat,dat\r\n');
    fprintf(file,'*VWRITE,nelem,nnode\r\n');
    fprintf(file,'%%.12e, %%.12e\r\n');
    fprintf(file,'*CFCLOS\r\n');  
    
    % malha non design variable 
    fprintf(file,'ESIZE,%f\r\n', 5*esize);
    fprintf(file,"ALLSEL,ALL\r\n"); 
    fprintf(file,"MSHKEY,1\r\n");
    fprintf(file,"AMESH,ALL\r\n");
    
    % engaste
    fprintf(file,'ALLSEL,ALL                        \r\n');
    fprintf(file,'NSEL,R,LOC,X,-0.000001+x-30E-3,0.000001+x    \r\n');
    fprintf(file,'NSEL,R,LOC,Y,-0.000001,0.000001  \r\n');
%     fprintf(file,'D,ALL, ,0, , , ,ALL, , , , ,  	\r\n');
    fprintf(file,'D,ALL, , , , , ,UY, , , , , 	\r\n');

    % simetria
    fprintf(file,'ALLSEL,ALL                        \r\n');
    fprintf(file,'NSEL,R,LOC,X,-0.000001,0.000001    \r\n');
    fprintf(file,'NSEL,R,LOC,Y,-0.000001,0.000001+y  \r\n');
    fprintf(file,'D,ALL, , , , , ,UX, , , , ,	\r\n');   
    
    % forca y real  
    fprintf(file,'ALLSEL,ALL                        \r\n');
    fprintf(file,'NSEL,R,LOC,X,-0.000001,0.000001  \r\n');
    fprintf(file,'NSEL,R,LOC,Y,-0.000001,0.000001  \r\n');
    fprintf(file,'F,ALL,FY,-100 	\r\n');    
    fprintf(file,'ALLSEL,ALL 							\r\n'); 
    
    
    % initial guess
    fprintf(file,'ALLSEL,ALL                        \r\n');
    fprintf(file,'MPCHG,2,ALL\r\n');
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
    
    % SAVE       
    fprintf(file,'SAVE,Z_db,DB,,\r\n');

    fprintf(file,'ALLSEL,ALL                        \r\n');    
    fprintf(file,'FINISH      \n'); 
    
 
    %% SOL    
    fprintf(file,"/SOL \r\n");
    
    %SOLVE
    fprintf(file,"ANTYPE,0     \n") ;
    fprintf(file,"EQSLV,PCG,1E-10    \r\n");
    fprintf(file,"OUTRES,ERASE   \r\n");
    fprintf(file,"OUTRES,ESOL,LAST \r\n");
    fprintf(file,"SOLVE   \r\n");
    fprintf(file,'FINISH      \n'); 

  
   
    %% post
    
    % GET FROM ORIGINAL PROBLEM
    fprintf(file,'/POST1\r\n'); 
    fprintf(file,'SET,FIRST \r\n');     
    
    % Ux e Uy
    fprintf(file,'*DIM,uxmatrix,array,nnode,1,\n') ;
    fprintf(file,'*DIM,uymatrix,array,nnode,1,\n'); 
    fprintf(file,'*DO,i,1,nnode               \n') ;
    fprintf(file,'*get,uxmatrix(i),NODE,i,U,X \n') ;
    fprintf(file,'*get,uymatrix(i),NODE,i,U,Y \n') ;
    fprintf(file,'*enddo                      \n')  ; 

    fprintf(file,'*CFOPEN,ux,dat\r\n');
    fprintf(file,'*VWRITE,uxmatrix(1)\r\n');
    fprintf(file,'%%.15e\r\n');
    fprintf(file,'*CFCLOS\r\n');  
    
    fprintf(file,'*CFOPEN,uy,dat\r\n');
    fprintf(file,'*VWRITE,uymatrix(1)\r\n');
    fprintf(file,'%%.12e\r\n');
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

    % SENE
    fprintf(file,"ALLSEL,ALL \r\n");  
    fprintf(file,'etable, my_sene, sene \r\n'); 
    fprintf(file,'*VGET,strain_energy,ELEM, ,ETAB,my_sene, , ,2\r\n');
    fprintf(file,'*CFOPEN,SENE,dat\r\n');
    fprintf(file,'*VWRITE,strain_energy(1)\r\n');
    fprintf(file,'%%.20f\r\n');
    fprintf(file,'*CFCLOS\r\n');
    
    fprintf(file,'FINISH      \n');   

fclose(file);
 

end
