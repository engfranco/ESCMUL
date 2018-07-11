#! /bin/csh

set subjs = (001 002 003 101 102 103 105 106 108 109 501 004 005 009 010 104 107)
set visit = visit4

foreach subj ($subjs)

cd ~/DATA/ESCMUL/ESCM${subj}/${visit}/RM/

mkdir ANATeFLAIR

cd ~/DATA/ESCMUL/ESCM${subj}/${visit}/RM/ANAT

cp ESCM* ../ANATeFLAIR

cd ~/DATA/ESCMUL/ESCM${subj}/${visit}/RM/FLAIR

cp ESCM* ../ANATeFLAIR

end

exit
