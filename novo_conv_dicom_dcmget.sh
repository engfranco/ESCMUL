#!/bin/bash

###################################################
### SOMENTE EDITAR ESTA PARTE PARA CADA SUJEITO ###
###################################################

study=ESCM
subj=512
visit=visit4

#####################################
# ALTERE AQUI SOMENTE SE NECESSÁRIO #
#####################################

# get out of script folder
cd ..

# go inside subject folder
cd ${study}${subj}/${visit}/RM

#go inside dicom folder
#check if dicom directory exist inside subject folder
if [ ! -d "dicom" ]; then
	printf "\n#########################################################\n"
	printf "# Não foi encontrado diretório dicom em ${study}${subj}/${visit}. #\n"
	printf "#########################################################\n\n"
	exit 1
else
	cd dicom
	dicom_dir=`pwd` #IMPORTANTE
fi

cd ..

#############################################################
########### ALTERE AQUI DE ACORDO COM O PROJETO!  ###########
#####                                                   #####
##### É NECESSÁRIO QUE UM ELEMENTO CORRESPONDA AO OUTRO #####
##### E OBRIGATORIAMENTE POSSUAM A MESMA QUANTIDADE DE  #####
##### ELEMENTOS.                                        #####
##### EX: pastas=("ANAT" "RST" ...)                     #####
#####     series=("AXI3DFSPGRBRAVO" "FMRI" ...)         #####
##### O vetor 'series' vai depender de como for a saída #####
##### do dmcget. VERIFIQUE ISSO ANTES DE EXECUTAR! UMA  #####
##### VEZ CORRETO, NÃO É MAIS NECESSÁRIO MEXER AQUI.    #####
#####                                                   #####
##### O SCRIPT AVISARÁ SE EXISTEM EXAMES FALTANDO OU SE #####
##### HÁ EXAMES REPETIDOS E PEGARÁ SEMPRE O MAIS RECEN- #####
##### TE ENTRE ELES.                                    #####
#####                                                   #####
########### ALTERE AQUI DE ACORDO COM O PROJETO! ############
#############################################################


pastas=("ANAT" "RST" "DTI" "FLAIR" "DIFFC" "T1CMgT" "T1SMgT" "T1CC" "T1SC" "T2CC" "ANAT.C1.C3")
series=("AXI3DFSPGRBRAVO" "FMRIRST" "DTIGE2.4B750" "SFlairCube" "ADWIDSE+C" "A3DSPGRCOMMgT" "A3DSPGRSEMMgT" "A3DFSPGRFS+C" "A3DFSPGRFS" "AT2FSE+C" "AXI3DC1/C3")


#########################################################
########### NÃO MEXA EM NADA A PARTIR DAQUI! ############
#########################################################

if [ "${#pastas[@]}" -ne "${#series[@]}" ]; then
    echo "###########################################"
    echo "# Os vetores 'pastas' e 'series' precisam #"
    echo "# conter a mesma quantidade de elementos. #"
    echo "#              Verifique!                 #"
    echo "###########################################"
    exit 1
fi

for (( i = 0 ; i < ${#series[@]} ; i++ ))
do
	cd ${dicom_dir}
	if [[ $(ls -d "${series[$i]}_"* 2>/dev/null | wc -l) > 1 ]]; then
		printf "\n	EXISTEM EXAMES REPETIDOS:\n"
                for folder in $(ls -d "${series[$i]}_"* 2>/dev/null)
                do
                        printf "	%s\n" "${folder}"
                done
        	printf "\n#########################################\n"
		printf "# Será usado:				#\n"
		printf "# $(ls -d "${series[$i]}_"* 2>/dev/null | tail -1).		#\n"
		printf "#########################################\n"
        fi
	cd ..
done

function check_series_dir() {
	series_dir=("$@")
	for (( i = 0 ; i < ${#series_dir[@]} ; i++ ))
	do
		if [[ $(ls -ld "${dicom_dir}/${series_dir[$i]}_"* 2>/dev/null | tail -1 | cut -c1) == 'd' ]]; then
			printf "\n##################################\n"
			printf "## CRIANDO DIRETÓRIO ${pastas[$i]}	##\n"
			printf "## E CONVERTENDO PARA NIFTI	##\n"
			printf "##################################\n"
			mkdir -v ${pastas[$i]}
			cd ${pastas[$i]}
			dcm2nii -c -g -o . $(ls -d "${dicom_dir}/${series_dir[$i]}_"* 2>/dev/null | tail -1)/*
			mv -v 2*nii* ${study}${subj}.${pastas[$i]}.nii.gz
			cd ..
		else
			printf "\n#################################################\n"
			printf "##  Não foi encontrado o diretório ${series_dir[$i]}	#\n"
			printf "#################################################\n"
		fi
	done

	# Removing junk files
	rm -v *ANAT*/co* 2>/dev/null
	rm -v *ANAT*/o* 2>/dev/null
	rm -v *FLAIR*/o* 2>/dev/null
	rm -v *T1CC*/o* 2>/dev/null
	rm -v *T1CC*/co* 2>/dev/null
	rm -v *T1SC*/o* 2>/dev/null
	rm -v *T1SC*/co* 2>/dev/null
	# Renaming DTI bval and bvec
	mv -v *DTI*/2*bval DTI/${study}${subj}.DTI.bval 2>/dev/null
	mv -v *DTI*/2*bvec DTI/${study}${subj}.DTI.bvec 2>/dev/null
	# Renaming DIFFC bval and bvec
	mv -v *DIFFC*/2*bval DIFFC/${study}${subj}.DIFFC.bval 2>/dev/null
	mv -v *DIFFC*/2*bvec DIFFC/${study}${subj}.DIFFC.bvec 2>/dev/null
	# Criando pasta MgT e copiando arquivos T1CMgT e T1SMgT
	cd ~/DATA/ESCMUL/${study}${subj}/${visit}/RM
	mkdir MgT
	cd T1CMgT
	cp ${study}${subj}.T1CMgT.nii.gz ../MgT
	cd ../T1SMgT
	cp ${study}${subj}.T1SMgT.nii.gz ../MgT
	cd ..
	rm -rf T1SMgT T1CMgT
	# Now we can compact the dicom folder
	echo "####################################"
	echo "# Compactando o diretório dicom... #"
	echo "####################################"
	echo
	echo Aguarde...
	echo
	tar -zcf dicom.tar.gz dicom
	# Now we can delete the original dicom folder
	echo "##################################"
	echo "# Removendo o diretório dicom... #"
	echo "##################################"
	rm -rf dicom/
	echo
	echo "##############"
	echo "# Concluído. #"
	echo "##############"
}

check_series_dir "${series[@]}"
