%include "io.mac"

.DATA
char_prompt db  "Please input a character: ", 0
out_msg1    db  "The ASCII code of ", 0
out_msg2    db  "in hex is ", 0xa
query_msg   db  "Do you want to quit (Y/N): ", 0
hex_table   db  "0123456789ABCDEF", 0

.CODE
.STARTUP
readchar:   PutStr char_prompt ; request char input