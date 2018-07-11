#! /bin/bash

subjs=(501 001 002 003 101 102 103 104 004 005 105 006 106 007 107 108 009 010 109 110 111 011 012 112 505)
visit=(visit3)

#foreach subj ($subjs)
for subj in ${subjs[*]} ; do
 

   cd ~/DATA/ESCMUL/ESCM$subj/$visit/RM/DIFFC
   
   if [ ! -d "*bval" ]; then
        printf "$subj/$visit1 /n"
        exit 1
   fi

end

