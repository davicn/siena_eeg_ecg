#!/bin/bash

for filename in /media/davi/6A81-05CF/DATALAKES/siena/raw/signals/PN17*.parquet; do
    matlab  -nodisplay -nosplash -nodesktop -r "sep_eeg_ecg('$filename');exit;"
done