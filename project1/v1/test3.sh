#!/usr/bin/expect -f
# rot 954

spawn ./caesar
expect "Please enter the plaintext: "
send -- "DONT FAIL ME NOW THIS IS GOING TO BE A LONG ONE\r"
expect "Please enter the shift value: "
send -- "18\r"
expect "VGFL XSAD EW FGO LZAK AK YGAFY LG TW S DGFY GFW\r"
expect eof