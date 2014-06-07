#!/bin/bash

RUTA_RPM="/home/pulgoso/NetBeansProjects/MserviceCIdemo/target/rpm/MserviceCIdemo/RPMS/noarch/"
RUTA_REPO="/home/pulgoso/.m2/repository/dpl/uah/service/ci/MserviceCIdemo/"

#Se le pasa como parámetro la version del RPM

nombreRPM=`ls $RUTA_RPM`
#nombreRELASE=`ls 

mv $RUTA_REPO/1.0/*.rpm $nombreRPM

