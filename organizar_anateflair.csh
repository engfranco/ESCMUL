#! /bin/csh

set subjs = (001 002 003 101 102 103 105 106 108 109 501 004 005 009 010 104 107)
set visit = visit4

cd ~/DATA/ESCMUL
mkdir ANATeFLAIR_V4

foreach subj ($subjs)

cd ~/DATA/ESCMUL/ESCM${subj}/${visit}/RM

mv ANATeFLAIR ANATeFLAIR${subj}

mv ANATeFLAIR${subj} ~/DATA/ESCMUL/ANATeFLAIR_V4


end
