#! /bin/csh

set subjs = (001 002 003 004 005 006 007 009 010 011 012 101 102 103 104 105 106 107 108 109 110 111 112 501)


cd ~/DATA/ESCMUL


foreach subj ($subjs)

cd ~/DATA/ESCMUL/ESCM${subj}/siena/

zip -r ESCM${subj}.V1_V3.zip V1_V3


end
