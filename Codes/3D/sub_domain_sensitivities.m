function new_sensitivities = sub_domain_sensitivities(Variable,sub_domain_elements)
    
    [m n] = size(sub_domain_elements);
    sub_domain_sensitivities = zeros(length(Variable),1);
    for i=1:n
        reference = sum(Variable(sub_domain_elements(:,i)));
        sub_domain_sensitivities(sub_domain_elements(:,i)) = reference;
    end
    new_sensitivities = sub_domain_sensitivities;
end