#! /bin/csh 


set subjs = ($1)
set visit = ($2)

set template = MNI152_T1_2009c+tlrc

# get out of scripts folder 
cd ..

set topdir = `pwd`

# updates:
#   - perform uniformity correction on anat before skull strip
#   - specify non-linear registration of anat to template --> will not do b/c of skull stripping issues
#   - do anaticor (regress local white matter)
#   - censor outliers
#   - regress average eroded CSF --> will not do because of BOLD signal bleed through into draining veins
# - doing a non linear registration to the HaskinsPeds mask

foreach subj ($subjs)  

	cd ${topdir}
	cd ${subj}
	cd ${visit}/RM


	set sdir = `pwd`

	afni_proc.py -subj_id $subj                                 	    	\
		-out_dir PROC.RST 					\
		-script proc.${subj}.RST.NL.tcsh		 		\
			-dsets $sdir/RST/${subj}.RST.nii.gz                            \
			-copy_anat $sdir/ANAT/${subj}.ANAT_ns.nii.gz                        \
			-blocks despike tshift align tlrc volreg blur mask regress      \
		-tlrc_base ${template} 							\
		-tlrc_NL_warp							\
		-align_opts_aea        		\
			-giant_move				\
			-anat_has_skull no				\
		-tcat_remove_first_trs 3  		                                    \
			 -tshift_opts_ts -tpattern alt+z      			\
			-volreg_align_to first  			           	\
			-volreg_align_e2a                                               \
			-volreg_tlrc_warp                                               \
			-blur_size 6                                                    \
		-regress_anaticor                                                   \
		-regress_anaticor_radius 25                                         \
		-regress_ROI CSFe 							\
		-regress_censor_outliers 0.1                                        \
			-regress_motion_per_run                                         \
			-regress_censor_motion 0.3                                     \
			-regress_bandpass 0.01 0.1                                      \
			-regress_apply_mot_types demean deriv                           \
			-regress_run_clustsim no                                        \
			-regress_est_blur_errts                                         
			#-execute
			
			
			
#		-execute
	
#	rm -v stats.anaticor.*+tlrc*
#	rm -v pb04.*.r01.blur+tlrc*
#	rm -v pb02.*.r01.tshift+orig*
#	rm -v pb01.*.r01.despike+orig*
#	rm -v pb00.*.r01.tcat+orig*
#	rm -v all_runs.*+orig*
	
end

exit

removed 
    # -tlrc_NL_warp                                                     
    # -regress_ROI CSFe                                                 \
