function  get_features(path, label)
    df = parquetread(path);
    cols = df.Properties.VariableNames;

    for n = 1:length(cols)-1
        x =  table2array(df(:,cols(n)));
        var_(n) = var(x);
        skew(n) = skewness(x);
        eng(n) = sum(abs(x).^2);
        kur(n) = kurtosis(x);
        log_(n) =  wentropy(x,'log energy');
        med(n) = mean(x);
    end

    mean_log_entropy = [med + log_].';
    var_log_entropy = [var_ + log_].';
    skew_log_entropy = [skew + log_].';
    kur_log_entropy = [kur + log_,].';
    energy_log_entropy = [eng + log_].';
    
    tt = table(mean_log_entropy, ...
               var_log_entropy, ...
               skew_log_entropy, ...
               kur_log_entropy, ...
               energy_log_entropy);
    
    parts = split(path, "/");
    name = parts(1) + "/" + parts(2) + "/ecg_features/" + label + "/" + parts(end);
    
    parquetwrite(name, tt);
end