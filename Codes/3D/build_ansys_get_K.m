function build_ansys_get_K()

file = fopen('ansys_update.mac', 'w');

    fprintf(file,'FINISH \r\n');
    fprintf(file,'/CLEAR,NOSTART\r\n');
    fprintf(file,'RESUME,Z_db,DB,,SOLU\r\n');   
    
    fprintf(file,'/PREP7\r\n'); 
    fprintf(file,'VSEL,S,LOC,x,dx/2-(bar_d/4)-1E-3,(bar_d/4)+dx/2+1E-3       \r\n'); 
    fprintf(file,'VSEL,R,LOC,Y,0,dy        \r\n'); 
    fprintf(file,'VSEL,R,LOC,Z,0,-dz        \r\n');
    fprintf(file,'ESLV,S       \r\n');      
    fprintf(file,'MPCHG,1,ALL\r\n');

    fprintf(file,'*get,nelem_sub_design,ELEM,0,count\r\n');
    
    fprintf(file,'ALLSEL,ALL\r\n');
    
    fprintf(file,'VSEL,S,LOC,x,dx/2-(bar_d/4)-1E-3+dx,(bar_d/4)+dx/2+1E-3+dx       \r\n'); 
    fprintf(file,'VSEL,R,LOC,Y,0,dy        \r\n'); 
    fprintf(file,'VSEL,R,LOC,Z,0,-dz        \r\n');
    fprintf(file,'ESLV,S       \r\n');      
    fprintf(file,'MPCHG,2,ALL\r\n');
    fprintf(file,'ALLSEL,ALL\r\n');  
    
    % SOL
    fprintf(file,"ALLSEL,ALL\r\n");
    fprintf(file,"/SOL \r\n");
    
    %SOLVE
    fprintf(file,"eqslv, sparse    \r\n");
    fprintf(file,"EMATWRITE,1  \r\n");
    fprintf(file,"SOLVE   \r\n");
    fprintf(file,"FINISH      \n");
    
    fprintf(file,"/aux2   \n");
    fprintf(file,'combine, emat     \r\n');
    fprintf(file,'FINISH      \r\n');
    
    fprintf(file,'*do,i,1,nelem_sub_design                                 \r\n'); 
    fprintf(file,'*dMAT, MatK1, D, import, emat, Z_db.emat, stiff,i      \r\n');
    fprintf(file,'*dMAT, MatK2, D, import, emat, Z_db.emat, stiff,(nelem_sub_design+i)      \r\n');
    fprintf(file,"str0 = strcat('./Ks/Kmatrix1_',chrval(i))      \r\n");
    fprintf(file,"str1 = strcat(str0,'.dat')      \r\n");
    
    fprintf(file,"str2 = strcat('./Ks/Kmatrix2_',chrval(i))      \r\n");
    fprintf(file,"str3 = strcat(str2,'.dat')      \r\n");
    
    fprintf(file,'*export, MatK1, MMF, str1    \r\n');
    fprintf(file,'*export, MatK2, MMF, str3    \r\n');
    fprintf(file,'*enddo      								  \r\n'); 
    
    fprintf(file,'FINISH      \r\n');
    
fclose(file);
 

end
