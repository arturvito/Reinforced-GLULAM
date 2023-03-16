function new_sensitivities = bar_sensitivities(Variable,bar_positions)
    
    [m n] = size(bar_positions);
    bar_sensitivities = zeros(length(Variable),1);
    for i=1:n
        reference = sum(Variable(bar_positions(:,i)));
        bar_sensitivities(bar_positions(:,i)) = reference;
    end
    new_sensitivities = bar_sensitivities;
end