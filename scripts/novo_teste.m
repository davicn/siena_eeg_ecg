clc
clear all;
d = dotenv('../.env');

lake = d.env.DATALAKE_PATH;

% filename = d.env.ROOT_PATH + '/docs/RECORDS';
% delimiter = {',',' '};
% formatSpec = '%q%[^\n\r]';
% fileID = fopen(filename,'r');
% dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
% fclose(fileID);
% 
% files = dataArray{1};
% 
% for i = 1:length(files)
%     file = split(files{i}, '/');
%     file = strrep(file{end}, 'edf', 'mat');
%     
%     try
%         ictal = load(lake + '/siena/processed/ecg_beats/ictal/' + file + '.mat');
%         pre_ictal = load(lake + '/siena/processed/ecg_beats/pre-ictal/' + file + '.mat');
%         pos_ictal = load(lake + '/siena/processed/ecg_beats/pos-ictal/' + file + '.mat');
%         normal = load(lake + '/siena/processed/ecg_beats/normal/' + file + '.mat');
%         recuperacao = load(lake + '/siena/processed/ecg_beats/recuperacao/' + file + '.mat');
%         
%         x1 = ictal.QRS;
%         x2 = pre_ictal.QRS;
%         x3 = pos_ictal.QRS;
%         x4 = normal.QRS;
%         x5 = recuperacao.QRS;
%         
%         disp(x1)
%         
%         log1 =  wentropy(x1,'log energy');
%         log2 =  wentropy(x2,'log energy');
%         log3 =  wentropy(x3,'log energy');
%         log4 =  wentropy(x4,'log energy');
%         log5 =  wentropy(x5,'log energy');
% 
% 
%         x_1 = var(x1)+ log1;
%         y_1 = skewness(x1) + log1;
%         z_1 = kurtosis(x1) + log1;
% 
%         x_2 = var(x2)+ log2;
%         y_2 = skewness(x2) + log2;
%         z_2 = kurtosis(x2) + log2;
% 
%         x_3 = var(x3)+ log3;
%         y_3 = skewness(x3) + log3;
%         z_3 = kurtosis(x3) + log3;
% 
%         x_4 = var(x4)+ log4;
%         y_4 = skewness(x4) + log4;
%         z_4 = kurtosis(x4) + log4;
% 
%         x_5 = var(x5)+ log5;
%         y_5 = skewness(x5) + log5;
%         z_5 = kurtosis(x5) + log5;
% 
%         tt1 = table(x_1, y_1, z_1);
%         tt2 = table(x_2, y_2, z_2);
%         tt3 = table(x_3, y_3, z_3);
%         tt4 = table(x_4, y_4, z_4);
%         tt5 = table(x_5, y_5, z_5);
%         
%         plot1 = scatter3(x_1, y_1, z_1,70,'filled' )
%         hold on
%         plot2 = scatter3(x_2, y_2, z_2,70,'filled' )
%         hold on 
%         plot3 = scatter3(x_3, y_3, z_3,70,'filled' )
%         hold on
%         plot4 = scatter3(x_4, y_4, z_4,70,'filled' )
%         hold on 
%         plot5 = scatter3(x_5, y_5, z_5,70,'filled' )
% 
%         legend([plot1, plot2, plot3, plot4, plot5], {'ictal', 'pre-ictal','pos-ictal','normal', 'recuperacao'})
%         hold off
%         title('My plot title')
%         xlabel('Variance + Log Entropy');
%         ylabel('Skewness + Log Entropy');
%         zlabel('Kurtosis + Log Entropy')
%         
%         
%     catch ME
%         continue
%     end
% end

file = 'PN00-3';

ictal = load(lake + '/siena/processed/ecg_beats/ictal/' + file + '.mat');
pre_ictal = load(lake + '/siena/processed/ecg_beats/pre-ictal/' + file + '.mat');
pos_ictal = load(lake + '/siena/processed/ecg_beats/pos-ictal/' + file + '.mat');
normal = load(lake + '/siena/processed/ecg_beats/normal/' + file + '.mat');
recuperacao = load(lake + '/siena/processed/ecg_beats/recuperacao/' + file + '.mat');



x1 = ictal.QRS;
x2 = pre_ictal.QRS;
x3 = pos_ictal.QRS;
x4 = normal.QRS;
x5 = recuperacao.QRS;

log1 =  wentropy(x1,'log energy');
log2 =  wentropy(x2,'log energy');
log3 =  wentropy(x3,'log energy');
log4 =  wentropy(x4,'log energy');
log5 =  wentropy(x5,'log energy');


var_ictal = var(x1)+ log1;
skew_ictal = skewness(x1) + log1;
kur_ictal = kurtosis(x1) + log1;


var_pre_ictal = var(x2)+ log2;
skew_pre_ictal = skewness(x2) + log2;
kur_pre_ictal = kurtosis(x2) + log2;

var_pos_ictal = var(x3)+ log3;
skew_pos_ictal = skewness(x3) + log3;
kur_pos_ictal = kurtosis(x3) + log3;

var_normal = var(x4)+ log4;
skew_normal = skewness(x4) + log4;
kur_normal = kurtosis(x4) + log4;

var_rep = var(x5)+ log5;
skew_rep = skewness(x5) + log5;
kur_rep = kurtosis(x5) + log5;

save('tesntando.mat','var_ictal','skew_ictal','kur_ictal','var_pre_ictal','skew_pre_ictal','kur_pre_ictal','var_pos_ictal','skew_pos_ictal','kur_pos_ictal','var_normal','skew_normal','kur_normal','var_rep','skew_rep','kur_rep');
% plot1 = scatter3(x_1, y_1, z_1,70,'filled' )
% hold on
% plot2 = scatter3(x_2, y_2, z_2,70,'filled' )
% hold on 
% plot3 = scatter3(x_3, y_3, z_3,70,'filled' )
% hold on
% plot4 = scatter3(x_4, y_4, z_4,70,'filled' )
% hold on 
% plot5 = scatter3(x_5, y_5, z_5,70,'filled' )
% 
% legend([plot1, plot2, plot3, plot4, plot5], {'ictal', 'pre-ictal','pos-ictal','normal', 'recuperacao'})
% hold off
% title('My plot title')
% xlabel('Variance + Log Entropy');
% ylabel('Skewness + Log Entropy');
% zlabel('Kurtosis + Log Entropy')


% writetable(tt1)
% writetable(tt2)

% parquetwrite('teste1.parquet',tt1);
% parquetwrite('teste1.parquet',tt2);
% csv


% hold off
% title('My plot title')
% xlabel('Temperature')
% ylabel('Wind Speed')
% zlabel('Solar Radiation')

% zlabel('Kurtosis + Log Entropy');


% figure
% subplot(2,3,1)
% boxchart(var(x1)+ log1)
% hold on 
% boxchart(var(x2) + log2)
% 
% subplot(2,3,2)
% boxchart(skewness(x1) + log1)
% hold on 
% boxchart(skewness(x2) + log2)
% 
% subplot(2,3,3)
% boxchart(skewness(x1))
% hold on 
% boxchart(skewness(x2))
% 
% subplot(2,3,4)
% boxchart(kurtosis(x1))
% hold on 
% boxchart(kurtosis(x2))
% 
% 
% subplot(2,3,5)
% boxchart(meanfreq(x1))
% hold on 
% boxchart(meanfreq(x2))



