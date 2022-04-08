clc;
clear all;
%% Carregando dados
fname = 'docs/siena_infos.json'; 
fid = fopen(fname); 
raw = fread(fid,inf); 
str = char(raw'); 
fclose(fid); 
val = jsondecode(str);

idx = 5;

file = strrep(getfield(val,{idx},'name'),'edf','parquet');

fs = 512;
s = parquetread(append('data\raw\EKG\',file));

%% Variaveis de intervalos
seizure_start_sec = getfield(val,{idx},'seizure_start_sec');
seizure_end_sec = getfield(val,{idx},'seizure_end_sec');

total = seizure_end_sec - seizure_start_sec;

normal_start = (seizure_start_sec - 120)-total;
normal_end = seizure_start_sec - 120;


signal_com_crise = table2array(s(seizure_start_sec*fs:seizure_end_sec*fs,"EKG_EKG"));

signal_sem_crise = table2array(s(normal_start*fs:normal_end*fs,"EKG_EKG"));


[B_com_crise,P_com_crise,QRS_com_crise,T_com_crise] = ECGsegmentationF(signal_com_crise,fs);
[B_sem_crise,P_sem_crise,QRS_sem_crise,T_sem_crise] = ECGsegmentationF(signal_sem_crise,fs);

save_com_crise = append('data\processed\ecg_segments\com_crise\',strrep(getfield(val,{idx},'name'),'edf','mat'));
save_sem_crise = append('data\processed\ecg_segments\sem_crise\',strrep(getfield(val,{idx},'name'),'edf','mat'));

save(save_com_crise, 'signal_com_crise','B_com_crise', 'P_com_crise', 'QRS_com_crise', 'T_com_crise');
save(save_sem_crise, 'signal_sem_crise','B_sem_crise', 'P_sem_crise', 'QRS_sem_crise', 'T_sem_crise');

