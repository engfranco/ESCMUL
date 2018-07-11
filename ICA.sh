#! /bin/bash

study=ESCM
#set subjs=(001 002 003 004 005 006 007 008 009 010 101 102 103 104 105 106 107 108 501 502)
subjs=(001 002 003 004 005 006 007 008 009 010 101 102 103 104 105 106 107 108 501 502)
visits=(visit1)
project_dir=~/DATA/ESCMUL/ICA

echo ${subjs[*]}


for subj in ${subjs[*]}; do
        for visit in ${visits[*]}; do
                cd $project_dir/$study$subj/$visit/RM/PROC.RST
		if [ ! -f errts.anaticor.$study$subj.nii.gz ]; then
                	3dAFNItoNIFTI errts.anaticor.$study$subj+tlrc
			gzip -1v errts.anaticor.$study$subj.nii
		fi

		if [ -z "$list" ]; then
			echo Creating variable
			list=($project_dir/$study$subj/$visit/PROC.RST/errts.anaticor.$study$subj.nii.gz)
		else
			echo Appending variable
			list=( ${list[*]} $project_dir/$study$subj/$visit/PROC.RST/errts.anaticor.$study$subj.nii.gz )
		fi
	done
done
echo ${list[*]}


cd $project_dir

melodic --verbose --approach=concat --Oall -i ${list[*]} -o ICA -m ./ICA/MNI152_T1_3mm_resampled.nii




