function beso = alpha_history(beso,obj_sensitivities_previous,loop)
 
beso.objective_sensitivities = (beso.objective_sensitivities+obj_sensitivities_previous(:,loop-1))/2;

end
