
echo "Please pass in the repo name as parameter"

#myrep=$1
#git clone $myrep

cd hello-world 
git branch --remote --merged origin/master | grep -v 'master' |   grep -v 'develop' >> /tmp/mergedBranch




cat /tmp/mergedBranch | while read line

do

for k in ` git branch -r | grep $line  | perl -pe 's/^..(.*?)( ->.*)?$/\1/'`; do echo -e `git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k -- | head -n 1`\\t$k; done | sort -r

for k in ` git branch -r | grep $line  | perl -pe 's/^..(.*?)( ->.*)?$/\1/'`; do echo -e `git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k -- | head -n 1`\\t$k; done | sort -r | awk '{print $4}'> /tmp/hoursUpdated
hoursUpdated=`cat /tmp/hoursUpdated`


for k in ` git branch -r | grep $line  | perl -pe 's/^..(.*?)( ->.*)?$/\1/'`; do echo -e `git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k -- | head -n 1`\\t$k; done | sort -r | awk '{print $5}'> /tmp/timUnit
timeUnit=`cat /tmp/timUnit`
#echo "Time unit for $line is $timeUnit"
if [ $timeUnit = "hours" ]
then

  if [ $hoursUpdated -lt 336 ] 
   then
     echo "Seems to be updated less than 15 days"
   else
   echo "Last updated 15 days before, going to delete now"
    branchtobedel="$( cut -d '/' -f 2 <<< "$line" )"; echo "$branchtobedel"  
   ##This command will actually delete the branch 
   git push origin :$branchtobedel 
  fi

else
echo "Time unit is not hours, not taking any action"
fi


done

#Clening up temp files created

rm -rf /tmp/mergedBranch
rm -rf /tmp/hoursUpdated
