
clear all;

d = dotenv('../.env');

fs = 512;

%% Carregando dados
fname = d.env.ROOT_PATH + '/docs/infos.json'; 
fid = fopen(fname); 
raw = fread(fid,inf); 
str = char(raw'); 
fclose(fid); 
val = jsondecode(str);

labels = {'ictal', 'normal', 'pos-ictal', 'pre-ictal', 'recuperacao'};

for i = 1:length(val)
    itens = val(i).collections;
    
    for j = 1:length(itens)
        name = strrep(itens(j).name, 'edf', 'parquet');
        
        for k = 1:length(labels)
            try
                file = d.env.DATALAKE_PATH + '/siena/raw/periods/ecg/' + labels{k} + '/' + name;
                t = parquetread(file);
                x = table2array(t);
                disp(file);
                
                [B,P,QRS,T] = ECGsegmentationF(x, fs);
                
                s = split(file, '/');
                
                name_mat = strrep(s{end}, 'parquet','mat');

                path_file = d.env.DATALAKE_PATH + '/siena/processed/ecg_beats/' + labels{k} + '/' + name_mat;
                disp(path_file);
                save(path_file,'B','P','QRS','T');

            catch ME
                continue 
            end
        end
    end
end