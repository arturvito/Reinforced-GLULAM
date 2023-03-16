function beso = objective_sensitivities(beso,ux,uy,K1,K2,ELIST)

% Sensitivities
idx = ELIST(:,7:end);
beso.objective_sensitivities = ones(beso.nelem,1);
for i=1:beso.nelem    
    nod= idx(i,:);
    Un = [ux(nod(1)) uy(nod(1)) ux(nod(2)) uy(nod(2)) ux(nod(3)) uy(nod(3)) ux(nod(4)) uy(nod(4))]';
    
    if beso.densities(i) == 0
        beso.objective_sensitivities(i) = (1/2)*beso.p*(Un'*K1*Un - Un'*K2*Un);
    end
    if beso.densities(i) == 1
        beso.objective_sensitivities(i) = (1/2)*beso.p*beso.xmin^(beso.p-1)*(Un'*K1*Un - Un'*K2*Un);  
    end    
end

end


