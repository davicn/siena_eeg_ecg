
%% UNIVERSIDADE FEDERAL DO MARANHÃO
%% MESTRADO DE ENGENHARIA DE ELETRICIDADE
%% JONATHAN ARAUJO QUEIROZ

%%        CÓDIGO : classificador PP
clear all
%close all
clc
%%%%%%%%%%%%%%%%%%%%%% Pacientes saudaveis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%\\\\\\\\\\\\\\\ Normal\\\\\\\\\\\\\\\\\\\\\\\ 
ECGn=[]; % Matriz de entrada (Colunas=ECG e Linhas=pacentes)
Fsn=128; % Frequência de amostragem 
%%%%%%%%%%%%%%%%%%%%%% parametros %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%\\\\\\\\\\\\\\ Arrtmial \\\\\\\\\\\\\\\\\\\
ECGa=[];
Fsa=360;

%\\\\\\\\\\\\\\ Af \\\\\\\\\\\\\\\\\\\
ECGaf=[];
Fsaf=256;

%%%%%%%%%%%%%%%%%%%%%% ECG %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Normal
 for i= 19000:19900;%i= 16000:17100; %20000
     arquivo = [num2str(i),'.mat']; % Leitura de todos os arquivos
     if exist(arquivo)
     load(arquivo);             % Carregado "vetor" total
     ECGn=[ECGn;val(1,:)'];           
     end        
        
 end
 
% break
% Arritmias
for i= 100:205; %i= 100:118;%250;%
     arquivo = [num2str(i),'.mat']; % Leitura de todos os arquivos
     if exist(arquivo)
     load(arquivo);             % Carregado "vetor" total
     ECGa=[ECGa;val(1,:)'];           
     end        
          
end

% AF
ECGaf=[];
Fsaf=256;
for i= 6000:8400; %i= 100:118;%250;%
     arquivo = [num2str(i),'.mat']; % Leitura de todos os arquivos
     if exist(arquivo)
     load(arquivo);             % Carregado "vetor" total
     ECGaf=[ECGaf;val(1,:)'];           
     end        
          
end


ECGa = downsample(ECGa,round(Fsa/Fsn)); % mesma frequencia de amostragem 

%%%%%%%%%%%%%%%%%%%%%%% Pre-processamento %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Normal
ECGn=ECGn(5001:end-10); % limitar o sinais (amostragem errada no começo de alguns sinais)
ECGn=ECGn-mean(ECGn); % retirar média
%ECGn=sgolayfilt(ECGn,2,5); %Filtragem (suavização) 
ECGn=ECGn ./(max(ECGn)); % Normalizar
[ECGn, qrs_amplitude,qrs_index,delay] = detection_peaksR(ECGn, [0 60],  Fsn, 0); % detecção de picos 
% Arritmias
ECGa=ECGa(5001:end-10); % limitar o sinais (amostragem errada no começo de alguns sinais)
ECGa=ECGa-mean(ECGa); % retirar média
%ECGa=sgolayfilt(ECGa,2,5); %Filtragem (suavização) 
ECGa=ECGa ./(max(ECGa)); % Normalizar
[ECGa, qrs_amplitudea,qrs_indexa,delaya] = detection_peaksR(ECGa, [0 60],  Fsa, 0); % detecção de picos 
% AF
ECGaf=ECGaf(5001:end-10); % limitar o sinais (amostragem errada no começo de alguns sinais)
ECGaf=ECGaf-mean(ECGaf); % retirar média
%ECGa=sgolayfilt(ECGa,2,5); %Filtragem (suavização) 
ECGaf=ECGaf ./(max(ECGaf)); % Normalizar
[ECGaf, qrs_amplitudeaf,qrs_indexaf,delayaf] = detection_peaksR(ECGaf, [0 60],  Fsaf, 0); % detecção de picos 

%%%%%%%%%%%%%%%%%%%%%%% segmenta sinal %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Normal
if(qrs_index(1)<31) %Exclui picos para garantir o intervalo;
    qrs_index(1)=[];
    qrs_amplitude(1)=[];
end

if(qrs_index(end)>length(ECGn)-60) %Exclui picos para garantir o intervalo;
    qrs_index(end)=[];
    qrs_amplitude(end)=[];
end

% % % % % % % % Só lembrando que o primeiro if, é para os 
% % % % % % % % pontos antes do pico e o segundo para os pontos depois


btn = zeros(length(qrs_amplitude),81);
for i = 1:length(qrs_amplitude)
    btn(i,:) = ECGn(qrs_index(i)-30:qrs_index(i)+50);   
end 
btn=btn';

% Arritmias
if(qrs_indexa(1)<31)
    qrs_indexa(1)=[];
    qrs_amplitudea(1)=[];
end

if(qrs_indexa(end)>length(ECGa)-60) 
    qrs_indexa(end)=[];
    qrs_amplitudea(end)=[];
end

bta = zeros(length(qrs_amplitudea),81);
for i = 1:length(qrs_amplitudea)
    bta(i,:) = ECGa(qrs_indexa(i)-40:qrs_indexa(i)+40);   
end 
bta=bta';


% AF
if(qrs_indexaf(1)<31)
    qrs_indexaf(1)=[];
    qrs_amplitudeaf(1)=[];
end

if(qrs_indexaf(end)>length(ECGaf)-60) 
    qrs_indexaf(end)=[];
    qrs_amplitudeaf(end)=[];
end

btaf = zeros(length(qrs_amplitudeaf),81);
for i = 1:length(qrs_amplitudeaf)
    btaf(i,:) = ECGaf(qrs_indexaf(i)-40:qrs_indexaf(i)+40);   
end 
btaf=btaf';
%%%%%%%%%%%%%%%%%%%%%%%% Extra��o de caracteristicas 
%%%%%%%%%%%% Normal
meann=mean(btn);
stdn=std(btn);
varn=var(btn);
skewnessn=skewness(btn);
kurtosisn=kurtosis(btn);

%%%%%%%%%%%% Arritmias
meana=mean(bta);
stda=std(bta);
vara=var(bta);
skewnessa=skewness(bta);
kurtosisa=kurtosis(bta);

%%%%%%%%%%%% AF
meanaf=mean(btaf);
stdaf=std(btaf);
varaf=var(btaf);
skewnessaf=skewness(btaf);
kurtosisaf=kurtosis(btaf);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
%subplot(1,3,1)
plot3(varn(:,1:10000),skewnessn(:,1:10000),kurtosisn(:,1:10000), 'b*', 'linewidth',2)
hold on 
plot3(vara(:,1:10000),skewnessa(:,1:10000),kurtosisa(:,1:10000), 'r*', 'linewidth',2)
xlabel({'Variance','b) Beats (25000)'}) ;
ylabel('Skewness') ;
zlabel('kurtosis') ;
legend('Healthy','Arrhythmia')
%title('Beats (25000)') ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
%subplot(1,3,1)
plot3(varn(:,1:10000),skewnessn(:,1:10000),kurtosisn(:,1:10000), 'b*', 'linewidth',2)
hold on 
plot3(varaf(:,1:10000),skewnessaf(:,1:10000),kurtosisaf(:,1:10000), 'r*', 'linewidth',2)
xlabel({'Variance','b) Beats (25000)'}) ;
ylabel('Skewness') ;
zlabel('kurtosis') ;
legend('Healthy','Arrhythmia')
%title('Beats (25000)') ;


% figure
% plot3(varn,skewnessn,kurtosisn, 'b*', 'linewidth',2)
% hold on 
% plot3(vara,skewnessa,kurtosisa, 'r*', 'linewidth',2)
% xlabel({'MSK'}) ;
% ylabel('SKM') ;
% zlabel('KMS') ;
% legend('Healthy','Arrhythmia','Apneia')

figure
plot3(varn,skewnessn,kurtosisn, 'b*', 'linewidth',2)
hold on 
plot3(varaf,skewnessaf,kurtosisaf, 'r*', 'linewidth',2)
xlabel({'MSK'}) ;
ylabel('SKM') ;
zlabel('KMS') ;
legend('Healthy','Arrhythmia','Apneia')