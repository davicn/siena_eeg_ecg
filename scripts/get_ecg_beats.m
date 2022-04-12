% function get_ecg_beats()
    fs = 512;
    file = 'PN00-1.parquet';
    label = '';
    
    d = dotenv('../.env');
    
    t = parquetread(d.env.DATALAKE_PATH + '/siena/raw/ecg/' + file);
    x = table2array(t);
    start_ = 1392;
    end_ = 1462;
    
%     class(t{:,start_*fs: end_*fs)
class(x)
    

% end

