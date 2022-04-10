clc;
clear all;

file = '/media/davi/6A81-05CF/physionet.org/files/siena-scalp-eeg/1.0.0/PN00/PN00-1.edf';

infos = get(edfinfo(file));

signals = edfread(file);

name_parquet= strrep(infos.Filename,'edf','parquet');

chs = signals.Properties.VariableNames;

for n = 1:length(infos.SignalLabels)
    M(:,n) = cell2mat(signals{:,chs{n}});
end

T = array2table(M, "VariableNames", chs); %table('Size',size(M),'VariableNames',chs



% T = timetable2table(signals);

parquetwrite(name_parquet, T);









