#!/bin/bash


PATH_RPM="/home/pulgoso/NetBeansProjects/MserviceCIdemo/target/rpm/MserviceCIdemo/RPMS/noarch/"
HASH=`git log --pretty=format:"%h" -1`
NAMERPM1=`ls -l $PATH_RPM | awk {'print $9'} | cut -d"-" -f1-2`
NAMERPM2=`ls -l $PATH_RPM | awk {'print $9'} | cut -d"-" -f3 | cut -d"." -f3 | tail -1`
FINALNAME=$NAMERPM1"-SNAPSHOT-r"$HASH.$NAMERPM2

echo $NAMERPM1
echo $NAMERPM2
echo $FINALNAME

cd $PATH_RPM

RPM=`ls *.rpm`

echo $RPM

if [ -f $RPM ]; then
                mv $RPM $FINALNAME
		ls -l
else
	echo "ERROR, No existe ningún fichero RPM entre la fase de install y deploy"
fi

