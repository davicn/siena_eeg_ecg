%% Função para extrair jnfos de edf e separar canais de EEG e EKG

function edf_to_parquet_infos(file)
    %% Extraindo e salvando infos
    infos = get(edfinfo(file));

    name_infos = strrep(infos.Filename,'edf','mat');
    
    save('~/Documentos/siena_eeg_ecg/data/raw/infos/' + name_infos, 'infos');
    
    %% Extraindo amostras e salvando 
    signals = edfread(file);
    
    name_parquet= strrep(infos.Filename,'edf','parquet');
    
%     parquetwrite('~/Documentos/siena_eeg_ecg/data/raw/signals/' + name_parquet, signals);
    parquetwrite(name_parquet, signals);

    
    %% Extraindo e salvando
    
%     idx_eeg = find(contains(signals.Properties.VariableNames,'EEG'));
%     
%     idx_ekg = find(contains(signals.Properties.VariableNames,'EKG'));
%     
%     eeg = signals{:, idx_eeg};
%     
%     ekg = signals{:, idx_ekg};
    
%     disp(class(ekg));
    
    
    name_parquet= strrep(infos.Filename,'edf','parquet');
    
%     parquetwrite('~/Documentos/siena_eeg_ecg/data/raw/EEG/' + name_parquet, 'eeg');
%     parquetwrite('~/Documentos/siena_eeg_ecg/data/raw/ECG/' + name_parquet, 'ekg');
    
    %%
    disp('concluído para: ' + infos.Filename);
end

