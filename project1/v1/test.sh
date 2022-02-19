#!/usr/bin/expect -f

set timeout -1
spawn ./caesar
expect "Please enter the plaintext: "
send -- "HELLO WORLD\r"
expect "Please enter the shift value: "
send -- "15\r"
expect "WTAAD LDGAS"
expect eof