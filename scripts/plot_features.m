clc
clear all

d = dotenv('../.env');
path = d.env.ROOT_PATH;

t = parquetread(path + '/features/features.parquet');

t


scatter3(t, 'var','skew','kur')