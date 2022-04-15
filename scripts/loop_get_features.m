clc
clear all;

d = dotenv('../.env');
  
lake = d.env.DATALAKE_PATH;
root = d.env.ROOT_PATH;
  
t = readtable(root + '/docs/RECORDS.csv');
s = size(t);
  
for i = 1:s(1)
    file = strrep(t{i,:},'edf','mat');
    
    try
        get_features_v2(file);
    catch ME
        continue
    end
end