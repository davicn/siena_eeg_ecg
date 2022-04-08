clc
clear all
sem_crise = load(['data\processed\ecg_segments\sem_crise\PN00-1.mat']);
com_crise = load(['data\processed\ecg_segments\com_crise\PN00-1.mat']);

size1 = size(sem_crise.B_sem_crise);
size2 = size(com_crise.B_com_crise);

x1 = sem_crise.QRS_sem_crise;
x2 = com_crise.QRS_com_crise;

log1 =  wentropy(x1,'log energy');
log2 =  wentropy(x2,'log energy');

x_1 = var(x1)+ log1;
y_1 = skewness(x1) + log1;
z_1 = kurtosis(x1) + log1;

x_2 = var(x2)+ log2;
y_2 = skewness(x2) + log2;
z_2 = kurtosis(x2) + log2;


% tt1 = table(x_1, y_1, z_1)
% tt2 = table(x_2, y_2, z_2)

plot1 = scatter3(x_1, y_1, z_1 )
hold on
plot2 = scatter3(x_2, y_2, z_2)
hold on 
legend([plot1, plot2], {'Sem Crise', 'Com Crise'})
% hold off
% title('My plot title')
xlabel('Variance + Log Entropy');
ylabel('Skewness + Log Entropy');
zlabel('Kurtosis + Log Entropy')


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


