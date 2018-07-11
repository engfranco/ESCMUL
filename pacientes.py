#! /usr/bin/env python
import sys
import commands
import os

#.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.
#-| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----
#.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.

"""-------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
					Funcoes utilizadas no script
----------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------"""

def Ir_para(lugar):# Entrar na pasta 'lugar'.
	os.chdir(lugar)
	
def Existe(caminho):# Testar se existe a pasta.
	return os.path.exists(caminho)
	
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
"""			     	   		Variaveis					 """
tamanho=len(sys.argv)
subject=[]
if (tamanho<5):
	os.system('clear')
	print """
   Programa de otimizacao de organizacao de imagens criado por Jorge Luiz Palmeiro Burger comecado 
no inicio de 2015.
   Este programa tem como funcao realizar um looping de varios pacientes do mesmo projeto e da mesma
visita, ou seja,fazer a otimizacao de dados de varios IDs.
	Baseado em um sistema de argumentos, este recebe as informacoes basicas da imagem que deseja
 utilizar, ou seja, recebe nome do projeto, sigla de estudo, numero da visita e ID dos pacientes.
	Abaixo tem um exemplo de uso por linha de comando:
		pacientes.py PROJETO PROJ visitx xxx xxx xxx [...]
	Primeiro argumento: nome do projeto
		Ex:ESCMUL
	Segundo argumento: sigla do projeto
		Ex:ESCM
	Terceiro argumento: visita
		Ex:visit1
	Ultimos argumentos: ID do paciente
		Ex:001 002 003 ...
"""
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
#.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.
#-| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----
#.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.
backup='/media/DATA/jorge/scripts/backup'
scripts='/media/DATA/'+project+'/SCRIPTS'
# Mudando as permissoes do script
##.##Ir_para(backup)
##.##if Existe(backup+'/pacientes.py')==True:
##.##	os.system('chmod a+w pacientes.py')
"""-------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
			      		Inicio do programa
----------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------"""

#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
"""			     		Looping de sujeitos				 	 """
cont=0
while(cont<len(subject)):
	ID=subject[cont]
	os.system('conv_suite.py '+project+' '+study+' '+visit+' '+ID)
	cont+=1	
	
#.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.
#-| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----
#.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.
"""-------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
					 Fim do programa
----------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------"""
# Fazendo Backup do script
##.##Ir_para(scripts)
##.##os.system('cp pacientes.py '+backup)
# Mudando as permissoes dos scripts
##.##Ir_para(backup)
##.##os.system('chmod a-w pacientes.py')
#.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.
#-| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----| |----
#.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.....||.
