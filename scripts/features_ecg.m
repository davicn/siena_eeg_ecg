function get_features(path, label)
    load([path]);

    x1 = B_sem_crise;
    size(x1)
    log1 =  wentropy(x1,'log energy');
    
    var_log_entropy = var(x1) + log1;
    size(var_log_entropy)
    skew_log_entropy = skewness(x1) + log1;
    kur_log_entropy = kurtosis(x1) + log1;

    tt = table(var_log_entropy, ...
               skew_log_entropy, ...
               kur_log_entropy);
    
    
    parts = split(path, "\");
    name = parts(1) + "\" + parts(2) + "\ecg_features\" + label + "\" + strrep(parts(end),'mat','mat');
    
    save(name, 'tt');
end