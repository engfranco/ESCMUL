#!/bin/bash

subjs=( "$@" )
visit=visit4
scriptdir=`pwd`

# get out of scripts folder
cd ..
topdir=`pwd`

for subj in "${subjs[@]}"
do
	echo #####################################################
	echo "Initial Time of ${subj} is `date`"
	echo #####################################################
	cd ${topdir}
	cd ${subj}
	cd ${visit}/RM
	sdir=`pwd`
	mkdir -p PROC.DTI


	#copy orig files
	if true; then
		cp -v DTI/{${subj}.DTI.bval,${subj}.DTI.bvec,${subj}.DTI.nii.gz} PROC.DTI/
		cp -v ANAT/${subj}.ANAT.nii.gz PROC.DTI/
		gunzip -dv PROC.DTI/${subj}.DTI.nii.gz
		gunzip -dv PROC.DTI/${subj}.ANAT.nii.gz
	fi

	cd PROC.DTI

	#create a t2 image from t1
	if true; then
		mkdir -p t2fromt1
		#3dSkullStrip -shrink_fac_bot_lim 0.8 -no_pushout -input ${subj}.ANAT.nii -prefix t2fromt1/${subj}.ss.nii
		3dcopy ../PROC.RST/${subj}.ANAT_ns+orig t2fromt1/${subj}.ss.nii
		#3dcopy ../ANAT/${subj}.ANAT_ns.nii.gz t2fromt1/${subj}.ss.nii
		3dcalc -a t2fromt1/${subj}.ss.nii -expr 'step(a)' -prefix t2fromt1/${subj}.ss.mask.nii
		fat_pre_t2w_from_t1w.tcsh -inset ${subj}.ANAT.nii -outdir t2fromt1 -prefix ${subj} -in_ss t2fromt1/${subj}.ss.mask.nii -do_clean
	fi

	#make tortoise preprocessing
	if true; then
		ImportNIFTI -i ${subj}.DTI.nii -p horizontal -b ${subj}.DTI.bval -v ${subj}.DTI.bvec
		DIFFPREP -i ${subj}.DTI_proc/${subj}.DTI.list -s t2fromt1/${subj}_t2w.nii \
		--do_QC no --reg_settings teste.xml -o ${subj} -c quadratic -e ITKBSP  -b 0 --gibbs_ringing_correction on\
		-d for_reg --is_human_brain 1 --upsampling all --high_b 0 --FoV 200 240 190 --keep_intermediate 0 --res 1.5 1.5 1.5
	fi

	#create tensor reconstructions
	if true; then
		mkdir -p RECON
		1dDW_Grad_o_Mat -in_bmatT_cols ${subj}.DTI_proc/${subj}.DTI.bmtxt -out_grad_cols RECON/GRADS.txt -flip_z
		3dAutomask -prefix RECON/${subj}.mask.nii.gz ${subj}.DTI_proc/${subj}.DTI_proc.nii.gz
		3dDWItoDT -nonlinear -eigs -sep_dsets -mask RECON/${subj}.mask.nii.gz -prefix RECON/DTI/${subj} RECON/GRADS.txt \
		${subj}.DTI_proc/${subj}.DTI_proc.nii.gz
		3dTrackID -mode DET -mask RECON/${subj}.mask.nii.gz -netrois RECON/${subj}.mask.nii.gz -logic OR -prefix RECON/${subj}.o.WB \
		-dti_in RECON/DTI/${subj} -alg_Nseed_X 1 -alg_Nseed_Y 1 -alg_Nseed_Z 1 -overwrite
	fi

	#Aling FA_map with (T1)_MNI152_T1_2009c
	if true; then
		auto_warp.py -base ../PROC.RST/${subj}.ANAT_ns+tlrc -input RECON/DTI/${subj}_FA+orig -skull_strip_input no
		3dbucket -prefix RECON/FA_MNI/${subj}_FA_ns awpy/${subj}_FA.aw.nii*
		mv awpy/anat.un.aff.Xat.1D RECON/FA_MNI
		mv awpy/anat.un.aff.qw_WARP.nii RECON/FA_MNI
	fi

	#Removing trash
	if true; then
		rm -rf awpy
		rm -vf ${subj}.ANAT.nii ${subj}.DTI.bval ${subj}.DTI.bvec ${subj}.DTI.nii
	fi

	#compact everything
	if true; then
		find . -type f -name "*.nii" -o -name "*.BRIK" | xargs gzip -v

	fi

	#send to me
	if false; then
		cd ${topdir}
		rsync -pvah -e "ssh -i /home/jose.osmar/.ssh/id_rsa" --remove-source-files --relative ${subj}/visit1/RM/PROC.DTI \
		--exclude='${subj}.DTI_proc.nii.gz' --exclude='t2fromt1' --exclude='RECON' --exclude='${subj}.DTI.bmtxt' \
		11105167@10.30.151.89:/media/11105167/DATA
	fi

	echo #####################################################
	echo "Final Time of ${subj} is `date`"
	echo #####################################################

done

exit

