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
echo "I'm helping you for setting playlists' and generate SQL scripts."
echo "So that you can get the correct scripts easily."
echo "For now, this program only can set US playlists' order."
echo "Please make sure us_playlist.txt is exist in same directory!"
filename=defaultname
read -p "What's the name of generated SQL script file you want to be?" filename
read -p "Press any key to continue..."
echo "Checking the number of US playlists in txt file..."
plrow=`cat us_playlist.txt | wc -l`
echo "The number of US playlists is ${plrow}."

i=1
for((i;i<=$plrow;i++))
do
plname=`cat us_playlist.txt | head -n ${i} | tail -n 1`
read -p "What's the order of playlist \"`echo $plname`\"?(Please input number... Or to hide playlist please input XX.)" order
if [ "$order" = "XX" ] || [ "$order" = "xx" ]; then
echo "Hide playlist \"`echo $plname`\" by changing country to \"XX\"."
echo "UPDATE recording_categories SET country = XX WHERE name = '`echo $plname`';" >> `echo $filename`.txt
elif [[ "$order" =~ ^[0-9]+$ ]]; then
echo "The sequence of \"`echo $plname`\" is `echo $order`."
echo "UPDATE recording_categories SET ordering = `echo $order` WHERE name = '`echo $plname`';" >> `echo $filename`.txt
else
echo "UPDATE recording_categories SET ordering = `echo $order` WHERE name = '`echo $plname`';" >> `echo $filename`.txt
echo "Your input has some error, plaese try again carefully..."
rm `echo $filename`.txt
exit
fi
done
echo "All of playlists' sequence have been set!"
cat `echo $filename`.txt
echo "The SQL script file ${filename}.txt has been created!"
echo "You can paste and run SQL scripts on SQLpro to change ordering!"
echo "All job done..."
exit
