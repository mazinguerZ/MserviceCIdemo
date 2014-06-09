#!/usr/bin/expect

#Variables
set PAQUETE [lindex $argv 0]
set REMOTO "localhost"
set USUARIO "pulgoso"
set RUTA_DESTINO "/home/pulgoso/instalaciones"
set PASS "airis25"

spawn ssh pulgoso@localhost
sleep 5

expect "$ " { send "cd $RUTA_DESTINO\r" }
expect "$ " { send "sudo rpm -ivh --force $PAQUETE --nodeps\r" }
expect ": " { send "airis25\r" }
expect "$ " { send "exit\r" }

interact
