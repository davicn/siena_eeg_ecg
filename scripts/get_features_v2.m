function get_features_v2(file)
    d = dotenv('../.env');
    lake = d.env.DATALAKE_PATH;
    
    ictal = load(lake + '/siena/processed/ecg_beats/ictal/' + file);
    pre_ictal = load(lake + '/siena/processed/ecg_beats/pre-ictal/' + file);
    pos_ictal = load(lake + '/siena/processed/ecg_beats/pos-ictal/' + file);
    normal = load(lake + '/siena/processed/ecg_beats/normal/' + file);
    recuperacao = load(lake + '/siena/processed/ecg_beats/recuperacao/' + file);

    x1 = ictal.QRS;
    x2 = pre_ictal.QRS;
    x3 = pos_ictal.QRS;
    x4 = normal.QRS;
    x5 = recuperacao.QRS;

    log1 =  wentropy(x1,'log energy');
    log2 =  wentropy(x2,'log energy');
    log3 =  wentropy(x3,'log energy');
    log4 =  wentropy(x4,'log energy');
    log5 =  wentropy(x5,'log energy');


    var_ictal = var(x1)+ log1;
    skew_ictal = skewness(x1) + log1;
    kur_ictal = kurtosis(x1) + log1;

    var_pre_ictal = var(x2)+ log2;
    skew_pre_ictal = skewness(x2) + log2;
    kur_pre_ictal = kurtosis(x2) + log2;

    var_pos_ictal = var(x3)+ log3;
    skew_pos_ictal = skewness(x3) + log3;
    kur_pos_ictal = kurtosis(x3) + log3;

    var_normal = var(x4)+ log4;
    skew_normal = skewness(x4) + log4;
    kur_normal = kurtosis(x4) + log4;

    var_rep = var(x5)+ log5;
    skew_rep = skewness(x5) + log5;
    kur_rep = kurtosis(x5) + log5;
    
    name = lake + '/siena/processed/features/' + file;
    disp(name)

    save(name,'var_ictal','skew_ictal','kur_ictal','var_pre_ictal','skew_pre_ictal','kur_pre_ictal','var_pos_ictal','skew_pos_ictal','kur_pos_ictal','var_normal','skew_normal','kur_normal','var_rep','skew_rep','kur_rep');

end

