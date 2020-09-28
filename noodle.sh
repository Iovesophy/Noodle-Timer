#!/bin/zsh
clear
trap 'date' 2
sh -c "/bin/echo -n \"How many minutes? 🍜 : \""
read Sec
echo =================================
echo "Set ${Sec} minutes."
view=$((Sec*60))

echo =================================
afplay /System/Library/Sounds/Hero.aiff
sh -c "/bin/echo -n \"start time -> \""
date "+%Y-%m-%d %H:%M:%S"
echo =================================

icon=("ー" "＼" "｜" "／" "ー" "＼" "｜" "／")
count=0
for i in `seq $view`
do 
    sleep 1
    ESC=$(printf '\033')
    echo "${ESC}[m ${ESC}[35m${icon[$count]}${ESC}[m ${ESC}[36m$((view-i)) seconds left...${ESC}[m ${ESC}[35m${icon[$count]}${ESC}[m" |
    while read line; do
        printf '\r%*s\r' ${lenLine:-${#line}}
        printf "%s" "$line"
        lenLine=${#line}
    done
    if [ $count = 7 ]; then
	count=0
    else
	count=$((count + 1))
    fi
done
echo ""
echo =================================
sh -c "/bin/echo -n \"complete time -> \""
date "+%Y-%m-%d %H:%M:%S"
echo =================================
osascript -e "display notification \"$Sec min.\" with title \"🍜 complete.\""
for i in `seq 6`
do
afplay /System/Library/Sounds/Purr.aiff
done
