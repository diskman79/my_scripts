#!/bin/sh
#######################################################################################################
#
#     Copyright (C) Intel Mobile Communications (Beijing)
#
#     Author:      Li Xinsheng <xinsheng.li@intel.com>
#     Description: Collect modem and bootloader source code from a workspace which has been built
#     Platform:    XMM7560 (for icc dep file)
#     History:
#                  2016-11-15   Li Xinsheng  Initial version v1.0
#
#######################################################################################################

# Bash variables  Level3 = ../../../   Level2 = ../../    FL= File List
OUT_DIR=source_code
TEMP_DIR=temp_dir
ORG_FL=$TEMP_DIR/org_list
LEVEL3_FL=$TEMP_DIR/level3_list
LEVEL2_FL=$TEMP_DIR/level2_list
FINAL_FL=$TEMP_DIR/final_list
LOCAL_FL=$TEMP_DIR/local_list

# Check script path
if [ ! -d modem ] || [ ! -d bootsystem ]; then
	echo Please goto correct path to run this script. Such as output/M2_7360/M2_7360_XMM7360_REV_2.1_NAND
	exit 1
fi


# Delete files for last time
rm -fr $TEMP_DIR $OUT_DIR $OUT_DIR.7z

# Make folders
mkdir -p $TEMP_DIR
mkdir -p $OUT_DIR



# Find all dep files from 'modem' folder
find modem  -type f -name "*.d" | xargs cat | uniq | sed '/:\ \\/d' | sed 's/\\$//' |sed 's/^\ //'| sed 's/\ \.\.\/\.\.\/\.\.\//\n\.\.\/\.\.\/\.\.\//'|sort | uniq > $ORG_FL

# Find all dep files from 'bootsystem' folder
find bootsystem -type f -name "*.d" | xargs cat | uniq | sed '/:\ \\/d' | sed 's/\\$//' |sed 's/^\ //'| sed 's/\ \.\.\/\.\.\/\.\.\//\n\.\.\/\.\.\/\.\.\//'|sort | uniq >>$ORG_FL

# Collect all files with relative path
cat $ORG_FL | grep -e '^\.\.\/\.\.\/\.\.\/' > $LEVEL3_FL 
cat $ORG_FL | grep -e '^\.\.\/\.\.\/[^\.]' > $LEVEL2_FL 
# Convert Level2 to Level3 , and add to Level3 file list
cat $LEVEL2_FL | sed 's/^\ \.\.\/\.\.\//\ \.\.\/\.\.\/\.\.\/modem\//' >> $LEVEL3_FL 
# Remove same items
cat $LEVEL3_FL | sort | uniq > $FINAL_FL 
# Copy files to current folder '$OUT_DIR'

for item in `cat $FINAL_FL`; do
	# Remove relative path to generate new path in $OUT_DIR
	fullname=`echo $item|sed 's/\.\.\/\.\.\/\.\.\///'` 
	path=`dirname $fullname`

	if [ -f $OUT_DIR/$fullname ];then
		echo File exsit : $fullname
		continue;
	fi 

	if [ ! -d $OUT_DIR/$path ];then
		mkdir -p $OUT_DIR/$path	
	fi

	echo Copy file: $fullname
	cp $item $OUT_DIR/$path
done



# Collect all files with absolute path

cat $ORG_FL | grep -e '^\/local\/' > $LOCAL_FL 

# Copy files to current folder '$OUT_DIR'
for item in `cat $LOCAL_FL`; do
	#Remove the starting path till 'output'
	fullname=`echo $item | sed 's/\/[^\/]*\/[^\/]*\/[^\/]*\///'`
	path=`dirname $fullname`
	if [ -f $OUT_DIR/$fullname ];then
		echo File exsit : $fullname
		continue;
	fi 

	if [ ! -d $OUT_DIR/$path ];then
		mkdir -p $OUT_DIR/$path	
	fi

	echo Copy file: $fullname
	cp $item $OUT_DIR/$path
done


# Zip the source code (7-zip)
7za a $OUT_DIR.7z $OUT_DIR
echo Please check $OUT_DIR.7z

# Delete tempory files
rm -fr $TEMP_DIR $OUT_DIR 

