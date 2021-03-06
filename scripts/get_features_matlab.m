clc; 
clear all;

fs = 512;
folder = "data\processed\ecg_segments\com_crise\";
n =1;
% for n = 1:5
file = folder + "PN00-" + n + ".mat";
load([file]);
% end
%     disp(path)
%     df = parquetread(path);
%     cols = df1.Properties.VariableNames;
%     
%     x =  table2array(df(:,cols(n)));

%     var_(n) = var(x);
%     skew(n) = skewness(x);
%     eng(n) = sum(abs(x).^2);
%     kur(n) = kurtosis(x);
%     log_(n) =  wentropy(x,'log energy');
%     med(n) = mean(x);
%     names = {'mean_log_entropy','var_log_entropy','skew_log_entropy','kur_log_entropy', 'energy_log_entropy'};
%     mean_log_entropy = [med + log_].';
%     var_log_entropy = [var_ + log_].';
%     skew_log_entropy = [skew + log_].';
%     kur_log_entropy = [kur + log_,].';
%     energy_log_entropy = [eng + log_].';
%     
%     tt = table(mean_log_entropy,var_log_entropy,skew_log_entropy,kur_log_entropy,energy_log_entropy);
%     disp(size(tt));
%     
% end

%% Carregando dados
%path_1 = 'data/processed/batimentos/sem_crise/PN00-2.parquet'; % label = 1
%path_2 = 'data/processed/batimentos/com_crise/PN00-2.parquet'; % label =0

%fs = 512;

%% Extração de Características
% df1 = parquetread(path_1);
% cols1 = df1.Properties.VariableNames;
% 
% for n = 1:length(cols1)-1
%     x1 =  table2array(df1(:,cols1(n)));
% 
%     var_1(n) = var(x1);
%     skew1(n) = skewness(x1);
%     eng1(n) = sum(abs(x1).^2);
%     kur1(n) = kurtosis(x1);
%     log_1(n) =  wentropy(x1,'log energy');
%     med1(n) = mean(x1);
% end
% 
% df2 = parquetread(path_2);
% cols2 = df2.Properties.VariableNames;
% 
% for n = 1:length(cols2)-1
%     x2 =  table2array(df2(:,cols2(n)));
% 
%     var_2(n) = var(x2);
%     skew2(n) = skewness(x2);
%     eng2(n) = sum(abs(x2).^2);
%     kur2(n) = kurtosis(x2);
%     log_2(n) =  wentropy(x2,'log energy');
%     med2(n) = mean(x2);
% end


%% Mesclando features
% a1 = var_1 + log_1;
% b1 = med1 + log_1;
% c1 = eng1 + log_1;
% 
% a2 = var_2 + log_2;
% b2 = med2 + log_2;
% c2 = eng2 + log_2;
% 
% names = {'mean_log_entropy','var_log_entropy','skew_log_entropy','kur_log_entropy', 'energy_log_entropy'};
% mean_log_entropy = [ med1 + log_1, med2 + log_2].';
% var_log_entropy = [ var_1 + log_1, var_2 + log_2].';
% skew_log_entropy = [ skew1 + log_1, skew2 + log_2].';
% kur_log_entropy = [ kur1 + log_1, kur2 + log_2].';
% energy_log_entropy = [ eng1 + log_1, eng2 + log_2].';
% labels = [ones(length(med1),1);zeros(length(med2),1)];
% tt = table(mean_log_entropy,var_log_entropy,skew_log_entropy,kur_log_entropy,energy_log_entropy,labels);

%% Criando plot
% tiledlayout(2,2)
% 
% % Plot 3d
% ax1 = nexttile;
% plot1 = scatter3(ax1,a1,b1,c1','b');
% plot1.Marker = 'o';
% plot1.MarkerFaceColor = 'b';
% hold on;
% 
% plot2 = scatter3(ax1,a2,b2,c2,'r');
% plot2.Marker = 'o';
% plot2.MarkerFaceColor = 'r';
% hold on;
% xlabel('A');
% ylabel('B');
% zlabel('C');
% legend([plot1,plot2], {'Sem crise', 'Com crise'});
% 
% % Plot 2d
% ax2 = nexttile;
% sc1 = scatter(ax2, a1,c1);
% sc1.MarkerFaceColor ='b';
% hold on;
% sc2 = scatter(ax2, a2,c2);
% sc2.MarkerFaceColor='r';
% hold on;
% xlabel('A');
% ylabel('C');
% legend({'Sem crise', 'Com crise'});
% % 
% 
% 





% x =  table2array(df(:,10));
% 
% e_shannon = wentropy(x, 'shannon');
% e_log = wentropy(x,'log energy');
% 
% 
% disp(e_shannon);
% disp(e_log);


