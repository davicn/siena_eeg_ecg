function sep_eeg_ecg(file)
    d = dotenv('../.env');
    
    s = split(file, '/');
    name_parquet = s{end};
    
    disp(name_parquet);
    
    T = parquetread(file);
    
    chs = T.Properties.VariableNames;
    
    %% ECG
    
    ecg_idx = find(contains( chs,'EKG'));
    
    if length(ecg_idx)==0
        
        disp('There is no ECG in the signal');
        
    else
        ECG = array2table(T{:, ecg_idx}, "VariableNames", {chs{ecg_idx}});
    
        parquetwrite(d.env.DATALAKE_PATH + '/siena/raw/ecg/' + name_parquet, ECG);
    
        disp('Save ECG');
    end
    
    %% EEG
    
    eeg_idx = find(contains( chs,'EEG'));
    
    EEG = array2table(T{:, eeg_idx}, "VariableNames", {chs{eeg_idx}});
    
    parquetwrite(d.env.DATALAKE_PATH + '/siena/raw/eeg/' + name_parquet, EEG);
    
    disp('Save EEG');
end

