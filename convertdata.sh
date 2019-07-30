#!/bin/bash
echo :::::::::::::/+ossyyyyyyysso+/::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo :::::::::/osyso+/:::::::::/+osyso/::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::::::/oyyo/:::::::::::::::::::/osyo/:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::::/oys/::::::::+ossssso+/:::::::/syo/:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo :::+ys/::::::::oys+//::/+syo::::::::/sy+:::::::::::::::osssssssso+:::::::::::::::::/ooso+/::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::oyo:::::::::sy+:::::::::/yy:::::::::oyo:::::::::::::::shhysssyhhs::::::::::::::/yhhyyyhhs/::::::::::::::::::::::::::syy+::::::::::::::::::::::::::::
echo :oyo::/++/:::+ho:::::::::::+h+::/+++/::+yo::::::::::::::shhs:::/yhho:::::::::::::yhho/:/yhy+::::::::::::::::::::::::::yhh+::::::::::::::::::::::::::::
echo /ys::syoosy/:+h+:::::::::::+ho:+ysooys::sy/:::::::::::::shhs::::shhs:::/oooo+/:::hhh+:::+o/:::/++oo++oo/:::/+ooo+/:::/yhhso+:+ooo:::/oo+:::+oooo+:::::
echo sh/:+ho::/ho:+h+:::::::::::+ho:sh/::oh/:/ys:::::::::::::shhs:::/yhho:/shhysyhyo::hhh+::::::::/yhhysyhhh+::oyhyyyhyo:+syhhys+:ohhy:::shhs:+yhyyyyhs::::
echo yy::+ho::/ho:+h+:::::::::::+ho:sh/::oh/::yy::::::::::::oyhhysssyhys::ohhy:::shh+:hhh+::::::::shhs:::yhh+:+hhy/:/yy+:::yhh+:::ohhy:::shhs:yhho::os/::::
echo yy::+ho::+hs/oh+::::::::::/oho/sh/::oh/::sy:::::::::::::shhyssyhy+:::ohhs://yhh+:hhh+::::::::yhho:::yhh+:+hhy::://::::yhh+:::ohhy:::shhs:ohhyo+/::::::
echo yy::+ho::osssyh+::::::::::/osssss:::oh/::yy:::::::::::::shhs::/yhy/::ohhyyyyys+::hhh+::::::::yhh+:::yhh+:+hhy:::::::::yhh+:::ohhy:::shhs::+syyhyyo::::
echo +h+:/ho::::::+h+::::::::::::::::::::sh/:+ho:::::::::::::shhs:::ohhs::ohhy+///::::hhh+:::::/+:yhh+:::yhh+:+hhy:::::::::yhh+:::ohhy:::shhs:::://+shhs:::
echo :yy/:osssssssyh+::::::::::+sssssssssyo:/yy::::::::::::::shhs::::yhy/:ohhy::::/+/:yhho:::/oys:yhhs::/yhho:+hhy/:::/++::yhh+:::ohhy/:/yhhs:://:::+hhy:::
echo :/yy/:://////oh+:::::::::::+ho//////::/sy/::::::::::::::shhs::::ohhs:/shhyyyyys::+yhyyyyyhy/:ohhhysyyhhy+:shhyyyyys/::oyhs++//yhhyyyhyhy+:syyyyyhy+:::
echo ::/sy+:::::::+h+:::::::::::+ho:::::::/yy/:::::::::::::::+oo+:::::+oo/::/ooso+/::::/osssso+::::+osoo+/+o+:::/oosso/:::::/+oo/::/ooooo//oo/::+osoo+:::::
echo ::::oys/:::::+h+:::::::::::+ho:::::/syo:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo :::::/oys+:::+h+:::::::::::+ho:::+syo/::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::::::::+sys+oh+:::::::::::+ho+oys+:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo :::::::::::+osy+:::::::::::+yso+::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::By AlexHu:::
echo "I'm helping you for getting data from Amplitude."
echo "And coverting their json data format into csv."
echo "So that you can import them to our DEV_DB."
read -p "Press any ket to continue..."
echo "IMPORTANT NOTE: If you wish to export a whole day, then it would be from T00 to T23. The maximum time range you can query at once is 365 days."
read -p "Please input the start time you want to download.(First hour included in data series, formatted YYYYMMDDTHH (e.g. 20150201T05).)" starttime
read -p "Please input the end time you want to download.(Last hour included in data series, formatted YYYYMMDDTHH (e.g. 20150203T20).)" endtime
echo "The data time interval you want to get is: $starttime to $endtime."
read -p "Please check time interval is correct. Is it correct?(y/N)" check

if [ "$check" = "y" ]
then
	read -p "What's the file name you gonna download want to be?" yourfilename 
	echo "Variables are: $starttime, $endtime and $yourfilename."
	varurl="https://amplitude.com/api/2/export?start="$starttime"&end="$endtime""
	echo $varurl
curl -u '<Key:Key>' `echo $varurl` >> `echo $yourfilename`.zip
	echo "Downloading finished." 
else
	echo "Please redo again."
	exit
fi

echo "I'm going to help you coverting data."
read -p "Press any key to continue..."
unzip `echo $yourfilename`.zip
echo "Your data file unzipped successfully."
echo "Now I'm going to help you to converting json data to csv."
read -p "Press any key to continue..."
read -p "Do you want to keep all json file after converting process? (y/N)" keepjson
gzip -d ./192473/*.json.gz
today=$(date +"%Y-%m-%d")
cat ./192473/*.json | jq '. |{server_received_time:'.server_received_time',app:'.app',device_carrier:'.device_carrier',city:'.city',user_id:'.user_id',uuid:'.uuid',event_time:'.event_time',platform:'.platform',os_version:'.os_version',amplitude_id:'.amplitude_id',processed_time:'.processed_time',user_creation_time:'.user_creation_time',version_name:'.version_name',ip_address:'.ip_address',paying:'.paying',dma:'.dma',client_upload_time:'.client_upload_time',event_type:'.event_type',library:'.library',device_type:'.device_type',device_manufacturer:'.device_manufacturer',start_version:'.start_version',location_lng:'.location_lng',server_upload_time:'.server_upload_time',event_id:'.event_id',location_lat:'.location_lat',os_name:'.os_name',amplitude_event_type:'.amplitude_event_type',device_brand:'.device_brand',device_id:'.device_id',language:'.language',device_model:'.device_model',country:'.country',region:'.region',is_attribution_event:'.is_attribution_event',adid:'.adid',session_id:'.session_id',device_family:'.device_family',sample_rate:'.sample_rate',idfa:'.idfa',client_event_time':'.client_event_time'} | json2csv >> ./`echo ${today}`data.csv

if [ "$keepjson" = "y" ]
then
	echo "All json data file are keeped."
	echo "All jobs have been done!"
else
	rm -r ./192473
	echo "All json data file are deleted."
fi

echo "Your converted csv data file is `echo ${today}`data.csv."
echo "All jobs have been done!"
exit
