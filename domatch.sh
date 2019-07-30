#!/bin/bash

i=1
k=1
for((i;i<=10001;i++))
do
dictID=`cat uid_dict.txt | tail -n ${i} | head -n 1`
for((k;k<=4249;k++))
do
filename=`cat filename.txt | head -n ${k} | tail -n 1`
cat `echo $filename` | jq '. | if .amplitude_id == '$dictID' then . else empty end ' >> ./amp_data/`echo $dictID`.txt
done
echo ${i} is done
done
