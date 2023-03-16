function A = create_matrix(matrix)
v = matrix;

n = length(v);
m = round(sqrt(n * 2));

A = zeros(m);

k = 0;
for i = 1:m
    for j = i:m
        k = k + 1;
        if i == j
            A(i,j) = v(k);
        else
            A(i,j) = v(k);
            A(j,i) = v(k);
        end
    end
end

end
