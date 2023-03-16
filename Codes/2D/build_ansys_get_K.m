function build_ansys_get_K()

file = fopen('ansys_update.mac', 'w');

    fprintf(file,'FINISH \r\n');
    fprintf(file,'/CLEAR,NOSTART\r\n');
    fprintf(file,'RESUME,Z_db,DB,,SOLU\r\n');   

    fprintf(file,'/PREP7\r\n');   
    fprintf(file,'ALLSEL,ALL\r\n');    
    fprintf(file,'ESEL,S, , ,       1 \r\n');    
    fprintf(file,'MPCHG,1,ALL\r\n');
    
    fprintf(file,'ALLSEL,ALL\r\n');   
    fprintf(file,'ESEL,S, , ,       2 \r\n');    
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
    
    
    fprintf(file,'*dMAT, MatK1, D, import, emat, Z_db.emat, stiff,1      \r\n');
    fprintf(file,'*export, MatK1, MMF, matkMMF1.txt     \r\n');
    fprintf(file,'*dMAT, MatK2, D, import, emat, Z_db.emat, stiff,2      \r\n');
    fprintf(file,'*export, MatK2, MMF, matkMMF2.txt     \r\n');
    fprintf(file,'FINISH      \r\n');
    
fclose(file);
 

end
