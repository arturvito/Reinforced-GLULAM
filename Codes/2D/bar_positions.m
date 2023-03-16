function bar_pos = bar_positions(centroids,x_bar_divisions,y_bar_len,beso,x,y,esize)
    unit = esize;
    cent = centroids((1:beso.nelem),:);
    cent(:,1) = cent(:,1);
    x_bar_elements = x/x_bar_divisions/esize;
    y_bar_elements = y_bar_len/esize;
    number_of_elements_per_bar = round(x_bar_elements*y_bar_elements);
    total_bars = round(beso.nelem/(x_bar_elements*y_bar_elements));
    bar_pos = zeros(number_of_elements_per_bar,total_bars);
    
    aux = 1;
    for j=1:(total_bars/x_bar_divisions)
        for i=1:x_bar_divisions
            idx = find(cent(:,1)>=(x/x_bar_divisions)*(i-1)+unit/4 & cent(:,1)<=(x/x_bar_divisions)*(i)+unit/4 &...
                       cent(:,2)>= -(y_bar_len)+y/4*(j-1)+unit/4 & cent(:,2)<=(y_bar_len)+y/4*(j-1)+unit/4);           
            bar_pos(:,aux) = idx;
            aux = aux+1;
        end
    end
end