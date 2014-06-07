#!/bin/bash

#Este script descarga en local el proyecto software, cambia la version de snapshot a release y genera la rama release.
VERSION=$1
DEVELOP=$2
OPTION=$3
RUTA_RPM="/home/pulgoso/NetBeansProjects/MserviceCIdemo/target/rpm/MserviceCIdemo/RPMS/noarch/"
RUTA_REPO="/home/pulgoso/.m2/repository/dpl/uah/service/ci/MserviceCIdemo/"

frenombraRPM (){
#Se le pasa como parámetro la version del RPM

nombreRPM=`ls $RUTA_RPM`
nombreRELEASE=`ls $RUTA_REPO/$1/*rpm | gawk -F/ '{print $13}'`

mv $RUTA_REPO/$1/$nombreRELEASE $RUTA_REPO/$1/$nombreRPM

ls -l $RUTA_REPO/$1/

}

fbuild (){
#se le pasara como parametro la version en la que se quiere trabajar

	if [ -f "compilacion.txt" ]; then
		rm -rf compilacion.txt
	fi
	
	git checkout $1
	git pull origin $1
	mvn clean install > compilacion.txt

	if [ `cat compilacion.txt | grep SUCCESS | cut -d " " -f3 | tail -1` == SUCCESS ]; then
		
		return 1;
	else
		return 0;
	fi
}

fupdateVersionRelease(){
#se le pasara como parametro la version a la que se quiere actualizar

	if [ -f "release.txt" ]; then
		rm -rf release.txt
	fi

#	mvn versions:set -DnewVersion=$1 -DgenerateBackupPoms=false > release.txt

#	if [ `cat release.txt | grep SUCCESS | cut -d " " -f3 | tail -1` == SUCCESS ]; then
		
	#git commit -a -m "[RSE][Updated version to $1]"
	
	COMMIT=`git log | head -1 | cut -d " " -f2`
	
	#Creación del tag
	git tag -a $1/CC $COMMIT -m "Code Complete"

	#Creacion de la rama
	git checkout -b release/$1 $COMMIT
		
	#Comprobacion que la rama se ha creado correctamente.

	RAMA="release/"$1

	if [ `git branch| grep "* " | cut -d " " -f2` == $RAMA ]; then

		mvn versions:set -DnewVersion=$1 -DgenerateBackupPoms=false > release.txt
		#git commit -a -m "[RSE][Updated version to $1]"

	        if [ `cat release.txt | grep SUCCESS | cut -d " " -f3 | tail -1` == SUCCESS ]; then
		
		#RAMA="release/"$1
		#if [ `git branch| grep "* " | cut -d " " -f2` == $RAMA ]; then

			if [ -f "segundaCompilacion.txt" ]; then
        	                rm -rf segundaCompilacion.txt
	                fi

		#	mvn versions:set -DnewVersion=$1 -DgenerateBackupPoms=false > release.txt

			mvn clean install > segundaCompilacion.txt

			if [ `cat segundaCompilacion.txt | grep SUCCESS | cut -d " " -f3 | tail -1` == SUCCESS ]; then

				#Se hace el commit de la version
				git commit -a -m "[RSE][Updated version to $1]"

				#Se renombra el rpm con el build-number
				frenombraRPM $1	

				#Se despliega el sofware generado en nexus
                                mvn deploy

				#se sube la nueva rama a github
				git push origin release/$1
				git push --tags
				
				return 1;
			else
				echo "Fallo en la segunda compilacion, antes de subir la rama release/$1"
				
				return 0;
			fi
		else
			echo "Error al crear la rama, revisar los logs"
			return 0;
		fi
		
	else
		echo "Por favor, revise los pom.xml y el log, ha ocurrido un error: release.txt"
		return 0;
	fi


}

fupdateVersionDevelop() {
#Aumenta la version de snapshot en la rama de develop

if [ -f "snapshot.txt" ]; then
                rm -rf snapshot.txt
        fi

        git checkout develop
	
	mvn versions:set -DnewVersion=$1 -DgenerateBackupPoms=false > snapshot.txt

        if [ `cat snapshot.txt | grep SUCCESS | cut -d " " -f3 | tail -1` == SUCCESS ]; then
                git commit -a -m "[RSE][Updated version to $1"

                COMMIT=`git log | head -1 | cut -d " " -f2`

                #Creación del tag
                git tag -a $1/KO $COMMIT -m "Kick Off"
                
		if [ -f "segundaCompilacion.txt" ]; then
                	rm -rf segundaCompilacion.txt
		fi		


                mvn clean install > segundaCompilacion.txt
                if [ `cat segundaCompilacion.txt | grep SUCCESS | cut -d " " -f3 | tail -1` == SUCCESS ]; then

	                #Se despliega el sofware generado en nexus
			mvn clean deploy

			#se sube la nueva rama a github
                        git push origin develop 
                        git push --tags

			return 1;
                else
  	              echo "Fallo en la segunda compilacion, antes de subir la rama develop"
		      return 0;
                fi

        else
                echo "Por favor, revise los pom.xml y el log, ha ocurrido un error: snapshot.txt"
                return 0;
        fi


}

case "$OPTION"
 in
  build)

	fbuild $VERSION

	RESULTADO=$?
  
	if [ $RESULTADO == 1 ]; then
		echo "La compilación ha sido correcta..."
	else
		echo "Revise el fichero compilacion.txt porque ha habido un error en la compilacion..."
	fi;;
  newRelease)
	fupdateVersionRelease $VERSION

	RESULTADOrelease=$?
	
	if [ $RESULTADOrelease == 1 ]; then
		fupdateVersionDevelop $DEVELOP
		
		RESULTADOdevelop=$?

                if [ $RESULTADOdevelop  == 1 ]; then
                	echo "Se ha actualizado correctamente la rama develop y se ha creado la nueva rama de release..."
        	else
                	echo "Revise el fichero snapshot.txt o bien terceraCompilacion.txt ..."
        	fi
		
                
        else
                echo "Revise el fichero segundaCompilacion.txt porque ha habido un error en la compilacion..."
        fi;;
 nombrar)
	frenombraRPM $1
esac

