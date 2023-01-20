#!/bin/bash

err="0"
errstr=" "
printbad() {
  for filename in $1/*.go
  do
    if [ -f $filename ]
    then
      if grep -Eq "Code generated by .* DO NOT EDIT" $filename; then     	
 	continue
      fi
      strfound=1
      if grep -Eq "Copyright \(c\) 202[0-9]-present (unTill Pro|Sigma-Soft|Heeus), Ltd." $filename
      then
        strfound=0
      fi
      if grep -Eq "Copyright \(c\) 202[0-9]-present (unTill Pro|Sigma-Soft|Heeus), Ltd., (unTill Pro|Sigma-Soft|Heeus), Ltd." $filename
      then
        strfound=0	
      fi
      if [ $strfound -eq 1 ]
      then
        err="1"
        errstr="$errstr  $filename" 
      fi	
    fi
  done

  for dirname in $1/* 
  do 
     dir=$dirname
     if [ -d "$dirname" ]
     then
       printbad $dir $cname
     fi
  done
}  

printbad "./."

if [ $err -eq "1" ]
then
    echo "::error::Some files:${errstr} - has no correct Copyright line"
    exit 1
fi
