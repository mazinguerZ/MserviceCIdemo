#!/usr/bin/expect -f

#Modifico un archivo para que cuando se detecte un cambio se ejecute el job de CI en jenkins

#Variables
set RUTA_RPM [lindex $argv 0]
set REMOTO "localhost"
set USUARIO "pulgoso"
set RUTA_DESTINO "/home/pulgoso/instalaciones"
set PASS "airis25"


puts $REMOTO
puts $USUARIO

puts $RUTA_RPM

cd $RUTA_RPM

set RPM [ glob . * ]

puts [lindex $RPM 1]

set PAQUETE [lindex $RPM 1]

puts $PAQUETE

spawn ssh 

scp $PAQUETE  $USUARIO@$REMOTO:$RUTA_DESTINO
match_max 100000
expect "*?assword: "
send -- "airis25\r"
send -- "\r"

send -- "cd $RUTA_DESTINO\r"
expect "*instalaciones]$"
send -- "sudo rpm -ivh --force $PAQUETE --nodeps\r"
match_max 100000
expect "[sudo] password for pulgoso:*"
send -- "airis25\r" 
send -- "\r"
expect "*Preparando*"
expect "*1:MserviceCIdemo*"
#expect "*100%*"
expect "*WARNING*"
#puts "Se ha instalado correctamente el paquete:"
#puts $PAQUETE

#puts "Acceptance Test: Comprobacion de si el servicio esta disponible/usable tras la instalacion....."
#puts "########################################################################....."


#send -- "wget http://localhost:8080/MserviceCIdemo/"
#expect "saved"
#puts "Mostramos lo que ha devuelto el servicio cunado ha sido llamado"
#send -- "cat index.html\r"

expect eof

exit 1



