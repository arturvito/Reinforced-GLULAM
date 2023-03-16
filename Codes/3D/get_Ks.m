function [K1,K2] = get_Ks(odir_ansys,sub_domain_elements)
[m n] = size(sub_domain_elements);

K1 = cell(m,1);
K2 = cell(m,1);


for i=1:m
    filename =  [odir_ansys '/Ks/Kmatrix1_' num2str(i) '.dat'];
    matk1 = readmatrix(filename);
    K1{i} = create_matrix(matk1);

    filename =  [odir_ansys '/Ks/Kmatrix2_' num2str(i) '.dat'];
    matk2 = readmatrix(filename);
    K2{i} = create_matrix(matk2);    
end

end


