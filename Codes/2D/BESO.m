%% --------------------------------------------------------------------- %%
%                           ** BESO class **                              %
%-------------------------------------------------------------------------%

classdef BESO
    
    %% Properties
    properties
        % BESO parameters
        ER
        ARmax
        inth
        xmin
        p
        
        % Densities {0,1}
        densities
        
        % Objective and sensitivities
        objective
        objective_sensitivities   
        objective_sensitivities_bar 
        
        % bar quantity
        bar_quantity_k
        bar_quantity
        
        % Optimization history
        % [ objective, constraint ,removed elements, inserted elements]
        history

        % Elemento volumes
        element_vol
        
        % Initial Volume
        initial_volume    
        
        %number of elements and nodes in desing variable
        nelem
        nnodes
        nelem_per_bar
        
    end
    
    %% Methods
    methods        
        %% Constructor
        
        function beso = BESO(bar_quantity,number_of_variables,nnodes...
                             ,element_vol,ARmax,ER,x_min,p)
            
            disp([' '])
            disp(['         Preparing BESO.'])
            

                        
            %objective sensitivities
            beso.objective_sensitivities = ones(number_of_variables,1);
            
            % Volume constraint
            beso.bar_quantity = bar_quantity;
                     
            % Initial design variables
            beso.densities = ones(number_of_variables,1);
            
            % Divisões nos eixos
            beso.element_vol = element_vol;
            
            %ER
            beso.ER = ER;
            
            %ARmax
            beso.ARmax = ARmax;
            
            %x_min
            beso.xmin = x_min;
            
            % penalty
            beso.p = p;
            
            %nelem
            beso.nelem = number_of_variables;
            
            %nnodes
            beso.nnodes = nnodes;            
            
        end % end Constructor
       

       %% Function to update structural design with BESO

    function [beso] = BESODesignUpdate(beso)

    % BESO sensitivity now being called alpha (negative sign for minimization)
    alpha = beso.objective_sensitivities_bar;

    % Sorting objective sensitivities (alpha) in descend order
    [alpha,In] = sort(alpha,1,'descend');

    % Next iteration target volume
    % If current volume is higher than final volume
    if (beso.bar_quantity_k > beso.bar_quantity)
        target_bars  = beso.bar_quantity_k-beso.ER;

    % Elseif current volume is lower than final volume
    elseif (beso.bar_quantity_k <= beso.bar_quantity)
        target_bars  = beso.bar_quantity;
    end

    % Adjusting for even number of removed elements
    nath = beso.nelem_per_bar*target_bars;

    % Sensitivity thresholds
    ath = alpha(nath);
    ath_add = ath;
    ath_del = ath;

    % Number of changed elements
    nadd = length(nonzeros(beso.densities(In(1:nath))));

    % Computing current ratio of admission
    ARi = nadd/length(alpha);

    % If admission ratio is feasible
    if (ARi <= beso.ARmax)

        % Loop for addition/removal of elements
        for i = 1:length(alpha)
            if alpha(i) < ath_del
                beso.densities(In(i)) = 1;
            elseif alpha(i) >= ath_add
                beso.densities(In(i)) = 0;
            end
        end

    % If admission ratio is not feasible
    else
        disp('ARmax Triggered')
        % Design variables sorted acordding to sensitivities
        In_mat = beso.densities(In);

        % Number of elements to be added
        nadd_ath = round(beso.ARmax*length(alpha));
        % Adjusting for even number of added elements
        nadd_ath = round(nadd_ath/4)*4;

        % Finding index i where In_mat corresponds to ath_add
        % Counting number of 1's in In_mat until it reaches nadd_nath
        aux_In_mat = 0;
        for i = 1:length(In_mat)
            if In_mat(i) == 1
                aux_In_mat = aux_In_mat+1;
                if aux_In_mat == (nadd_ath)
                    In_add = i;
                    break
                end
            end
        end

        % New ath_add
        ath_add = alpha(In_add);

        % Finding index i where In_mat corresponds to ath_del
        % Counting number of 0's in In_mat until it reaches nret_nath
        aux_In_mat = 0;
        for i = length(In_mat):(-1):1
            if In_mat(i) == 0
                aux_In_mat = aux_In_mat+1;
                if aux_In_mat == nadd_ath
                    In_ret = i;
                    break
                end
            end
        end

        % New ath_del
        ath_del = alpha(In_ret);

        % Loop for addition/removal of elements
        for i = 1:length(alpha)
            if alpha(i) <= ath_del
                beso.densities(In(i)) = 1;
            elseif alpha(i) >= ath_add
                beso.densities(In(i)) = 0;
            end
        end

    end

end % end BESODesignUpdate

    end 
        
end

        
        