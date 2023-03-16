function sub_domain_elements = sub_domain_elements_list(centroids,beso,dim,sub_div)

    cent = centroids((1:beso.nelem),:);
    cent(:,3)=-cent(:,3);
    
    number_of_sub_domains = sub_div(1)*sub_div(2)*sub_div(3);
    sub_domain_elements = zeros(beso.nelem/number_of_sub_domains,number_of_sub_domains);
    
    [m n]=size(sub_domain_elements);
        
    aux = 1;
    for k=1:sub_div(3)
        for j=1:sub_div(2)
            for i=1:sub_div(1)
                idx = find(cent(:,1)>=(dim(1)/sub_div(1))*(i-1)+1E-5 & cent(:,1)<=(dim(1)/sub_div(1))*(i)+1E-5 &...
                           cent(:,2)>=(dim(2)/sub_div(2))*(j-1)+1E-5 & cent(:,2)<=(dim(2)/sub_div(2))*(j)+1E-5 &...
                           cent(:,3)>=(dim(3)/sub_div(3))*(k-1)+1E-5 & cent(:,3)<=(dim(3)/sub_div(3))*(k)+1E-5 );
                sub_domain_elements(:,aux) = idx;
                aux = aux+1;
            end
        end
    end

end