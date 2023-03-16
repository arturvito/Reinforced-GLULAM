function beso = objective_calc(beso,SENE,ELIST)



nelem = length(ELIST);
beso.objective =sum(SENE(1:nelem));




end


