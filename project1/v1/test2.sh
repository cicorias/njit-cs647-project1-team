#!/usr/bin/expect -f

set timeout -1
spawn ./caesar
expect "Please enter the plaintext: "
send -- "HERE COME BUFFER OVERFLOWS\r"
expect "Please enter the shift value: "
send -- "23\r"
expect "EBOB ZLJB YRCCBO LSBOCILTP\n"
expect eof