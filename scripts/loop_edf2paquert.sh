#!/bin/bash

for filename in /media/davi/6A81-05CF/physionet.org/files/siena-scalp-eeg/1.0.0/PN01/*.edf; do
    matlab  -nodisplay -nosplash -nodesktop -r "edf_to_parquet_infos('$filename');exit;"
done