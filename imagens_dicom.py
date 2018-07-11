#! /usr/bin/env python
import sys
import commands
import os

#.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||....
#-| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |
#.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||....

"""
   Programa de otimizacao de processamento do Jorge Luiz Palmeiro Burger,
finalizado em 29/05/2015.
   Este programa tem como funcao realizar um looping de varios pacientes do
mesmo projeto, ou seja, fazer a otimizacao de dados de varios IDs.
	Baseado em um sistema de argumentos, este recebe as informacoes ba
sicas da imagem que deseja-se utilizar, ou seja, recebe nome do projeto, si
gla de estudo, numero da visita e ID dos pacientes.
	Abaixo tem um exemplo de uso por linha de comando:
		python conv_suite.py PROJETO PROJ visitx xxx xxx xxx [...]
"""

#.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||....
#-| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |
#.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||....

"""------------------------------------------------------------------------
---------------------------------------------------------------------------
			Funcoes utilizadas no script
---------------------------------------------------------------------------
------------------------------------------------------------------------"""

#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
"""			     	   Variaveis				"""
tamanho=len(sys.argv)
subject=[]
if (tamanho<5):
	os.system('clear')
	print 'Este arquivo baseia-se em argumentos como na linha abaixo:'
	print '		Python imagens_dicom.py PROJETO PROJ visitx ID\n'
	print ' Lembre-se de usar os argumentos na ordem.'
	print '		Primeiro argumento: nome do projeto'
	print '			EX:ESCMUL'
	print '		Segundo argumento: sigla do projeto'
	print '			EX:ESCM'
	print '		Terceiro argumento: visita'
	print '			EX:visit1'
	print '		ultimos argumentos: ID do paciente'
	print '			EX:001'
	print '			EX:001 002 003 [...]'
	quit()
elif (tamanho==5):
	project=sys.argv[1]
	project=project.upper()
	study=sys.argv[2]
	study=study.upper()
	visit=sys.argv[3]
	visit=visit.lower()
	subject.append(sys.argv[4])
else:
	project=sys.argv[1]
	project=project.upper()
	study=sys.argv[2]
	study=study.upper()
	visit=sys.argv[3]
	visit=visit.lower()
	for x in range(4, tamanho):
		subject.append(sys.argv[x])
#.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||....
#-| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |
#.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||....

"""------------------------------------------------------------------------
---------------------------------------------------------------------------
			      Inicio do programa
---------------------------------------------------------------------------
------------------------------------------------------------------------"""
projeto='/media/DATA/'+project
os.system('clear')
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
"""			     Looping de sujeitos			"""
cont=0
while(cont<len(subject)):
	ID=subject[cont]
	folder=study+ID
	visita=projeto+'/'+folder+'/'+visit
	RM=visita+'/RM'
	if os.path.exists(RM+'/volume1')==False:
		os.chdir(visita)
		os.system('gedit auxiliar.txt &')
		os.chdir(RM)
		os.system('tar -vzxf dicom.tar.gz')
		os.chdir(visita)
		os.system('gedit scanlog.txt')
	else:
		os.chdir(RM)
		os.system('rm -rf volume*')
	cont+=1	
