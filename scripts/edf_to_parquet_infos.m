%% Função para extrair jnfos de edf e separar canais de EEG e EKG

function edf_to_parquet_infos(file)

    d = dotenv('../.env');
    
    %% Extraindo e salvando infos
    infos = get(edfinfo(file));

    name_infos = strrep(infos.Filename,'edf','mat');
    
    save(d.env.DATALAKE_PATH + '/siena/raw/infos/' + name_infos, 'infos');
    
    %% Extraindo amostras e salvando 
    signals = edfread(file);
    
    name_parquet= strrep(infos.Filename,'edf','parquet');
    
    chs = signals.Properties.VariableNames;
    
    for n = 1:length(infos.SignalLabels)
        M(:,n) = cell2mat(signals{:,chs{n}});
    end

    T = array2table(M, "VariableNames", chs);
    
    
    parquetwrite(d.env.DATALAKE_PATH + '/siena/raw/signals/' + name_parquet, T);

    
    %% Extraindo e salvando
    
%     idx_eeg = find(contains(signals.Properties.VariableNames,'EEG'));
%     
%     idx_ekg = find(contains(signals.Properties.VariableNames,'EKG'));
%     
%     eeg = signals{:, idx_eeg};
%     
%     ekg = signals{:, idx_ekg};
    
%     disp(class(ekg));
    
    
%    name_parquet= strrep(infos.Filename,'edf','parquet');
    
%     parquetwrite('~/Documentos/siena_eeg_ecg/data/raw/EEG/' + name_parquet, 'eeg');
%     parquetwrite('~/Documentos/siena_eeg_ecg/data/raw/ECG/' + name_parquet, 'ekg');
    
    %%
    disp('concluído para: ' + infos.Filename);
end

