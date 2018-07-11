#! /usr/bin/env python
from datetime import *
import sys
import commands
import os
import time
import dicom

#.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.
#-| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----
#.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.

"""-------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
				 	     Variaveis,Constantes e Funcoes
----------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------"""

#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
"""			     	   		Variaveis			    	         """
tamanho=len(sys.argv)
if (tamanho<=3):
	os.system('clear')
	print """
  Programa de otimizacao de organizacao de imagens criado por Jorge Luiz Palmeiro Burger comecado 
no inicio de 2015.
   Este programa tem como funcao escrever o Scanlog do paciente. Recebe de argumentos o nome do pro-
jeto, o tipo de imagem que serao retirados dados para analises e por ultimo o ID do paciente a ser
estudado.
   Abaixo um exemplo de como utilizar este programa e tambem sua sintaxe:
	python erro_scanlog.py PROJETO IDxxx visitx
	Primeiro argumento: nome do projeto
		Ex:ESCMUL
	Segundo argumento: ID do paciente
		Ex:ESCM001
	Terceiro argumento: visita
		Ex:visit1
		
"""
	quit()

elif (tamanho == 4):
	project=sys.argv[1]
	project=project.upper()
	folder=sys.argv[2]
	folder=folder.upper()
	visit=sys.argv[3]
	visit=visit.lower()
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
"""					     	     Constantes			    		 """
projeto='/media/DATA/'+project+'/'+folder+'/'+visit+'/RM'

#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
"""				   		     Funcoes				         """
def Existe(caminho):# Testar se existe a pasta.
	return os.path.exists(caminho)

def Esperar(tempo):# Esperar tantos segundos.
	time.sleep(tempo)

def Copiar_arquivo(arquivo,lugar):# Copiar arquivo para 'lugar'.
	os.system('cp '+arquivo+' '+lugar)

def Remover_arquivo(arquivo):# Remover 'arquivo'
	os.system('rm '+arquivo)

def Ir_para(lugar):# Entrar na pasta 'lugar'.
	os.chdir(lugar)

def Estou_em():# Mostrar o caminho da pasta em que o programa se localiza.
	print os.getcwd()


def Renomear(arquivo,nome):# Renomear arquivo para 'nome'.
	os.system('mv '+arquivo+' '+nome)


#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

#.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.
#-| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----
#.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.
"""-------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
				 		Inicio do programa
----------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------"""

#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#<----------------------------------------------------------------------------COMENTAR E DESCOMENTAR
if Existe(projeto+'/volume1') == False:	os.system('tar -xvzf dicom.tar.gz')
caminho=projeto+'/volume1'
Ir_para(caminho)# Entrando na pasta volume
ls=commands.getoutput('ls')
caminho=caminho+'/'+ls[0 : ls.find('\n')]
Ir_para(caminho)# Entrando na pasta numerica
ls=commands.getoutput('ls')
caminho=caminho+'/'+ls
Ir_para(caminho)# Entrando na pasta do estudo
ls=commands.getoutput('ls')
# Vendo quantas series a pasta tem
cont2=int(ls.count('serie'))+1
ls=ls.replace('serie','').replace('\n',' ')
# Encontrando a primeira serie
first=int(min(ls.split(' ')))
for x in range((first-cont2),(first+cont2)):
	cam=caminho+'/serie'+str(x)
	if Existe(cam)  ==  True:# Entrando nas pastas serie
		Ir_para(cam)
		ls=commands.getoutput('ls')
		# Quantidade de imagens da serie
		qnt=ls.count('.dcm')
		ls=ls.replace('.dcm','').replace('\n',' ')
		# Encontrando a primeira imagem
		I1=int(min(ls.split(' ')))
		for y in range((I1-qnt),(I1+qnt)):
			teste=cam+'/'+str(y)+'.dcm'
			if Existe(teste) == True:
				I1=y
				break
		# Lendo a primeira imagem da serie
		imagem=dicom.read_file(str(I1)+'.dcm')
		# Escrevendo o nome do paciente
		print 'Nome: '
		print imagem.PatientName
		# Escrevendo a idade do paciente
		print '\nIdade: '
		print imagem.PatientAge[1:-1]+' anos'
		# Escrevendo a data de nascimento
		print'\nAniversario: '
		var=imagem.PatientBirthDate[-2:]+'/'+imagem.PatientBirthDate[-4:-2]+'/'
		var=var+imagem.PatientBirthDate[0:-4]
		print var
		# Escrevendo o sexo do paciente
		print'\nSexo: '
		var=imagem.PatientSex
		if var == 'F':
			print 'Feminino\n'
		elif var == 'M':
			print 'Masculino\n'
		# Escrevendo o tipo do paciente
		print 'Tipo: '
		if folder[-3] == '0':
			print 'Paciente em tratamento previo.\n\n'
		elif folder[-3] == '1':
			print 'Paciente virgem de tratamento.\n\n'
		elif folder[-3] == '5':
			print 'Controle.\n\n'
		# Escrevendo a data do exame
		print 'Data de exame: '
		var=imagem.StudyDate[-2:]+'/'+imagem.StudyDate[-4:-2]+'/'
		var=var+imagem.StudyDate[0:-4]
		print var
		quit()
