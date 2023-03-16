%get summary
teste = './teste/';
if ~exist(teste)
   mkdir(teste);
end

for i=0:7
    ini_sum = ['./output/case' num2str(i) '/plots/summary.png'];
    ini_out = ['./teste/summary_case_' num2str(i) '.png'];

    copyfile(ini_sum,ini_out);

    ini_sum = ['./output/case' num2str(i) '/plots/deformed.png'];
    ini_out = ['./teste/deformed_case_' num2str(i) '.png'];


    copyfile(ini_sum,ini_out);
end