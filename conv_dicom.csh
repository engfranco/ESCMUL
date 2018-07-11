#! /bin/csh 


### In this script we will read the dicom files and convert them to NII. In the process we will also create the 
### subject folders as well as putting th nii files in the correct location. 
### Note, this script assumes that the subject folder exists, and inside it there is a "dicom" folder in it with the 
### dicom files in it
### 
### Author: Alexandre Franco
### Dez 17, 2013

### SOMENTE EDITAR ESTA PARTE PARA CADA SUJEITO@@@@@
set study = SI
set subj = ${1}
#set visit = visit2




###########################@@@@@@@@@@@@@@@@@@@@
 
# get out of script folder
cd ..

# go inside subject folder
cd ${study}${subj}
#cd ${visit}
set subj_loc = `pwd`



##########################################################

# T1 - Anatomical
set image = ANAT
set name = AXI3DFSPGRBRAVO
mkdir ${image}
cd ${image}
set output = `pwd`
dcm2nii -c -g -o ${output} ${subj_loc}/dicom/${name}/*
mv 2*nii* ${study}${subj}.${image}.nii.gz
rm c*nii*
rm o*nii*


 
cd ${subj_loc}
##########################################################
# Resting state
set image = RST
set name = FMRIRST
mkdir ${image}
cd ${image}
set output = `pwd`
dcm2nii -c -g -o ${output} ${subj_loc}/dicom/${name}/*
mv 2*nii* ${study}${subj}.${image}.nii.gz



cd ${subj_loc}
##########################################################
# DTI
set image = DTI
set name = DTIGE2.4B-750
mkdir ${image}
cd ${image}
set output = `pwd`
dcm2nii -c -g -o ${output} ${subj_loc}/dicom/${name}/*
mv 2*nii* ${study}${subj}.${image}.nii.gz
mv 2*bval ${study}${subj}.${image}.bval
mv 2*bvec ${study}${subj}.${image}.bvec


cd ${subj_loc}
##########################################################
# FLAIR
set image = FLAIR
set name = AT2Flair
mkdir ${image}
cd ${image}
set output = `pwd`
dcm2nii -c -g -o ${output} ${subj_loc}/dicom/${name}/*
mv 2*nii* ${study}${subj}.${image}.nii.gz




cd ${subj_loc}
tar -zcvf dicom.tar.gz dicom


# Now we can delete the original dicom folder
rm -rfv dicom/



exit















