#! /bin/csh

set subjs=(501 001 502 002 003 101 102 103 104 004 005 105 006 106 007 107 008 108 009 010 109 110 111 011 012 503 112 505 506 507 509 510 511 512 513)
set visit = visit1

foreach subj ($subjs)
 

   cd ~/DATA/ESCMUL/ESCM${subj}/${visit}/RM/DIFFC
   
   if [ ! -d "*bval" ]; then
        printf "${subj}/${visit1} /n"
        exit 1
   fi

end

exit
