function beso = objective_sensitivities(beso,ux,uy,uz,K1,K2,ELIST,sub_domain_elements)

% Sensitivities
idx = ELIST(:,7:end);
beso.objective_sensitivities = ones(beso.nelem,1);
[m,n] = size(sub_domain_elements);
for i=1:n
    for j=1:m
        el = sub_domain_elements(j,i);
        node_idx= idx(el,:);
        Un = [ux(node_idx(1)) uy(node_idx(1)) uz(node_idx(1)) ux(node_idx(2)) uy(node_idx(2)) uz(node_idx(2)) ...
              ux(node_idx(3)) uy(node_idx(3)) uz(node_idx(3)) ux(node_idx(4)) uy(node_idx(4)) uz(node_idx(4)) ...
              ux(node_idx(5)) uy(node_idx(5)) uz(node_idx(5)) ux(node_idx(6)) uy(node_idx(6)) uz(node_idx(6)) ...
              ux(node_idx(7)) uy(node_idx(7)) uz(node_idx(7)) ux(node_idx(8)) uy(node_idx(8)) uz(node_idx(8))]';
          
        if beso.densities(el) == 0
            beso.objective_sensitivities(el) = (1/2)*beso.p*(Un'*K1{j}*Un - Un'*K2{j}*Un);
        end
        if beso.densities(el) == 1
            beso.objective_sensitivities(el) = (1/2)*beso.p*beso.xmin^(beso.p-1)*(Un'*K1{j}*Un - Un'*K2{j}*Un);  
        end
        
    end
end




end


