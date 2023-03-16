function build_update(void_elements)

file = fopen('ansys_update.mac', 'w');

    fprintf(file,'FINISH \r\n');
    fprintf(file,'/CLEAR,NOSTART\r\n');
    fprintf(file,'RESUME,Z_db,DB,,SOLU\r\n');   

    fprintf(file,'/PREP7\r\n');   
    fprintf(file,'ALLSEL,ALL\r\n');
    fprintf(file,'MPCHG,2,ALL\r\n');

    fprintf(file,'ALLSEL,ALL\r\n');   
    name1 = ['FLST,5,' num2str(length(void_elements)) ',2,ORDE,' num2str(length(void_elements)) '\r\n'];
    fprintf(file,name1);
    
    void_elements = num2cell(void_elements);
    void_elements =cellfun(@num2str,void_elements,'un',0);
    fprintf(file,'FITEM,5, %s\n',void_elements{:});
    fprintf(file,"ESEL,S, , ,P51X \r\n");     
    fprintf(file,'MPCHG,1,ALL\r\n');
    fprintf(file,'ALLSEL,ALL\r\n');
   
   
    % SOL
    fprintf(file,"ALLSEL,ALL\r\n");
    fprintf(file,"/SOL \r\n");
    
    %SOLVE
    fprintf(file,"ANTYPE,0     \n") ;
    fprintf(file,"EQSLV,PCG,1E-10    \r\n");
    fprintf(file,"OUTRES,ERASE   \r\n");
    fprintf(file,"OUTRES,ESOL,LAST \r\n");
    fprintf(file,"SOLVE   \r\n");
    fprintf(file,'FINISH      \n');
    
    % SAVE   
    fprintf(file,'/POST1\r\n');
    fprintf(file,'SAVE,Z_db,DB,,SOLU\r\n');
    
    % GET FROM ORIGINAL PROBLEM
    fprintf(file,'/POST1\r\n'); 
    fprintf(file,'SET,last \r\n');            

    
    % SENE
    fprintf(file,"ALLSEL,ALL \r\n");  
    fprintf(file,'etable, my_sene, sene \r\n'); 
    fprintf(file,'*VGET,strain_energy,ELEM, ,ETAB,my_sene, , ,2\r\n');
    fprintf(file,'*CFOPEN,SENE,dat\r\n');
    fprintf(file,'*VWRITE,strain_energy(1)\r\n');
    fprintf(file,'%%.12e\r\n');
    fprintf(file,'*CFCLOS\r\n'); 

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
    
    fprintf(file,'FINISH      \n');
fclose(file);



    
    
end
