#!/bin/bash

user=$1
host=$2
activity_path=$3
xo_path=$4
xo_path_temp="/tmp/$RANDOM/"

ssh $user@$host <<END
if [ -d $xo_path ]
then
echo "Activity directory [on XO] already exists. Deleting it now."
rm -rf $xo_path
fi
END

# We first have to copy the files to a temporary path so as to avoid the "MalformedActivity" error.

scp -r $activity_path $user@$host:$xo_path_temp

ssh $user@$host <<END
mv $xo_path_temp $xo_path
rm -rf $xo_path_temp

chown -R olpc:olpc $xo_path
chmod -R 775 $xo_path
END
