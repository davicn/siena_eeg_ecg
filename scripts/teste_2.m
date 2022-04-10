clc;
clear all;

d = dotenv('./.env');

file = '/media/davi/6A81-05CF/DATALAKES/siena/raw/signals/PN00-1.parquet';

s = split(file, '/');

name_parquet = s{end};

T = parquetread(file);

chs = T.Properties.VariableNames;

%% ECG

ecg_idx = find(contains( chs,'EKG'));

ECG = array2table(T{:, ecg_idx}, "VariableNames", {chs{ecg_idx}});

parquetwrite(d.env.DATALAKE_PATH + '/siena/raw/ecg/' + name_parquet, ECG);

%% EEG

eeg_idx = find(contains( chs,'EEG'));

EEG = array2table(T{:, eeg_idx}, "VariableNames", {chs{eeg_idx}});

parquetwrite(d.env.DATALAKE_PATH + '/siena/raw/eeg/' + name_parquet, EEG);






