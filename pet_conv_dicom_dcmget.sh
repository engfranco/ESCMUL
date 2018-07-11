
#!/bin/bash

###################################################
### SOMENTE EDITAR ESTA PARTE PARA CADA SUJEITO ###
###################################################

study=ESCM
subj=507
visit=visit4

#####################################
# ALTERE AQUI SOMENTE SE NECESSÁRIO #
#####################################

# get out of script folder
cd ..

# go inside subject folder
cd ${study}${subj}/${visit}/PET

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


pastas=("CT" "CTAC" "MAC" "NAC" "RX")
series=("CTSCOUTBRAIN" "CTAC3.75Thick" "e+1StaticBrain3DMAC" "e+1StaticBrain3DNAC" "BrainStandard")


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


		printf "\n################################\n"
		printf "## CRIANDO DIRETÓRIO MAC	##\n"
		printf "## E CONVERTENDO PARA NIFTI	##\n"
		printf "##################################\n"
		mkdir -v MAC
		cd dicom 
		cp -a e+1StaticBrain3DMAC* ../MAC
		cd ../MAC
		dcm2nii * 
		cd e+1StaticBrain3DMAC*
		mv 2* ..
		cd ..
		rm -rf e+1StaticBrain3DMAC*
			mv *000.nii.gz ${study}${subj}.MAC0.nii.gz
			mv *000A.nii.gz ${study}${subj}.MACA.nii.gz
			mv *000B.nii.gz ${study}${subj}.MACB.nii.gz
			mv *000C.nii.gz ${study}${subj}.MACC.nii.gz
			mv *000D.nii.gz ${study}${subj}.MACD.nii.gz
			mv *000E.nii.gz ${study}${subj}.MACE.nii.gz
			mv *000F.nii.gz ${study}${subj}.MACF.nii.gz
			mv *000G.nii.gz ${study}${subj}.MACG.nii.gz
			mv *000H.nii.gz ${study}${subj}.MACH.nii.gz
			mv *000I.nii.gz ${study}${subj}.MACI.nii.gz
			mv *000J.nii.gz ${study}${subj}.MACJ.nii.gz
			mv *000K.nii.gz ${study}${subj}.MACK.nii.gz
			mv *000L.nii.gz ${study}${subj}.MACL.nii.gz
			mv *000M.nii.gz ${study}${subj}.MACM.nii.gz
			mv *000N.nii.gz ${study}${subj}.MACN.nii.gz
			mv *000O.nii.gz ${study}${subj}.MACO.nii.gz
			mv *000P.nii.gz ${study}${subj}.MACP.nii.gz
			mv *000Q.nii.gz ${study}${subj}.MACQ.nii.gz
			mv *000R.nii.gz ${study}${subj}.MACR.nii.gz
			mv *000S.nii.gz ${study}${subj}.MACS.nii.gz
			mv *000T.nii.gz ${study}${subj}.MACT.nii.gz
			mv *000U.nii.gz ${study}${subj}.MACU.nii.gz
			mv *000V.nii.gz ${study}${subj}.MACV.nii.gz
			mv *000W.nii.gz ${study}${subj}.MACW.nii.gz
			mv *000X.nii.gz ${study}${subj}.MACX.nii.gz
			mv *000Y.nii.gz ${study}${subj}.MACY.nii.gz
			mv *000Z.nii.gz ${study}${subj}.MACZ.nii.gz
		cd ..

		printf "\n################################\n"
		printf "## CRIANDO DIRETÓRIO NAC	##\n"
		printf "## E CONVERTENDO PARA NIFTI	##\n"
		printf "##################################\n"
		mkdir -v NAC
		cd dicom 
		cp -a e+1StaticBrain3DNAC* ../NAC
		cd ../NAC
		dcm2nii * 
		cd e+1StaticBrain3DNAC*
		mv 2* ..
		cd ..
		rm -rf e+1StaticBrain3DNAC*
			mv *000.nii.gz ${study}${subj}.NAC0.nii.gz
			mv *000A.nii.gz ${study}${subj}.NACA.nii.gz
			mv *000B.nii.gz ${study}${subj}.NACB.nii.gz
			mv *000C.nii.gz ${study}${subj}.NACC.nii.gz
			mv *000D.nii.gz ${study}${subj}.NACD.nii.gz
			mv *000E.nii.gz ${study}${subj}.NACE.nii.gz
			mv *000F.nii.gz ${study}${subj}.NACF.nii.gz
			mv *000G.nii.gz ${study}${subj}.NACG.nii.gz
			mv *000H.nii.gz ${study}${subj}.NACH.nii.gz
			mv *000I.nii.gz ${study}${subj}.NACI.nii.gz
			mv *000J.nii.gz ${study}${subj}.NACJ.nii.gz
			mv *000K.nii.gz ${study}${subj}.NACK.nii.gz
			mv *000L.nii.gz ${study}${subj}.NACL.nii.gz
			mv *000M.nii.gz ${study}${subj}.NACM.nii.gz
			mv *000N.nii.gz ${study}${subj}.NACN.nii.gz
			mv *000O.nii.gz ${study}${subj}.NACO.nii.gz
			mv *000P.nii.gz ${study}${subj}.NACP.nii.gz
			mv *000Q.nii.gz ${study}${subj}.NACQ.nii.gz
			mv *000R.nii.gz ${study}${subj}.NACR.nii.gz
			mv *000S.nii.gz ${study}${subj}.NACS.nii.gz
			mv *000T.nii.gz ${study}${subj}.NACT.nii.gz
			mv *000U.nii.gz ${study}${subj}.NACU.nii.gz
			mv *000V.nii.gz ${study}${subj}.NACV.nii.gz
			mv *000W.nii.gz ${study}${subj}.NACW.nii.gz
			mv *000X.nii.gz ${study}${subj}.NACX.nii.gz
			mv *000Y.nii.gz ${study}${subj}.NACY.nii.gz
			mv *000Z.nii.gz ${study}${subj}.NACZ.nii.gz
		cd ..


		printf "\n################################\n"
		printf "## CRIANDO DIRETÓRIO CT		##\n"
		printf "## E CONVERTENDO PARA NIFTI	##\n"
		printf "##################################\n"
		mkdir -v CT
		cd dicom 
		cp -a BrainStandard* ../CT
		cd ../CT
		dcm2nii * 
		cd BrainStandard*
		mv 2* ..
		cd ..
		rm -rf BrainStandard*
		mv 2* ${study}${subj}.CT.nii.gz
		cd ..


		printf "\n################################\n"
		printf "## CRIANDO DIRETÓRIO CTAC	##\n"
		printf "## E CONVERTENDO PARA NIFTI	##\n"
		printf "##################################\n"
		mkdir -v CTAC
		cd dicom 
		cp -a CTAC3.75Thick* ../CTAC
		cd ../CTAC
		dcm2nii * 
		cd CTAC3.75Thick*
		mv 2* ..
		cd ..
		rm -rf CTAC3.75Thick*
		mv 2* ${study}${subj}.CTAC.nii.gz
		cd ..


		printf "\n################################\n"
		printf "## CRIANDO DIRETÓRIO RX		##\n"
		printf "## E CONVERTENDO PARA NIFTI	##\n"
		printf "##################################\n"
		mkdir -v RX
		cd dicom 
		cp -a CTSCOUTBRAIN* ../RX
		cd ../RX
		dcm2nii * 
		cd CTSCOUTBRAIN*
		mv 2* ..
		cd ..
		rm -rf CTSCOUTBRAIN*
		mv 2* ${study}${subj}.RX.nii.gz
		cd ..


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

