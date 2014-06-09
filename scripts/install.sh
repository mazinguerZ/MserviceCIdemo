#!/usr/bin/expect

set RUTA [lindex $argv 0]
set RPM [lindex $argv 1]

spawn ssh pulgoso@localhost
sleep 5

expect "$ " { send "cd $RUTA\r" }
expect "$ " { send "sudo rpm -ivh $RPM\r" }
expect "*asword:*" { send "airis25`\r" }
expect "$ " { send "exit\r" }

interact
