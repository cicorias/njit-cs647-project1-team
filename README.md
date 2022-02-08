# Caesar Cipher in C as a prolog to the Assember version

## Requirements

### Mandatory criteria:
- Your program MUST use a function to perform the Caesar Cipher on the plaintext.
- Your program MUST pass arguments to its functions via the stack.
- Your program MUST read user input through stdin.
    - Prompt the user for each input
    - Ex. "Please enter the plaintext: "
    - Ex. "Please enter the shift value: "
- Your program MUST write ciphertext through stdout.

### Assumptions:
- When prompted for plaintext, the input is assumed to be an UPPERCASE character from the Latin alphabet, or the space character. (This means you do not need to worry about error handling the plaintext)
- When prompted for the shift value, the input is assumed to be a positive integer, or zero. (No need to worry about handling decimals or shifting backwards)
- Length of the plaintext is string **to be encoded** is no more than 50 characters
- You can assume the shift value will be at most 3 digits, i.e. 0 <= *shiftValue* < 1000
Some things to consider:
- When you read through stdin, the input is read as a string. In C, you use library functions to convert that string to an integer.
- Functions are nice, especially when you must read/write multiple times.
- You will NOT have to encrypt a space character; however, you will have to handle it
when you come across one. (Just ignore it and leave it as is)
Your Deliverable

### Subission
You will submit one file, called caesar.s, to Canvas by the deadline.

### Grading Criteria
Your project will be graded in multiple parts based on some of the following criteria:
- Did the program perform the Caesar Cipher correctly on the input?
- Was the space character preserved?
- Did the program use functions?
    - Did the functions get their arguments from the stack?
- Did the program get the correct input from the user via stdin?
- Did the program print the correct output to the user via stdout?
- Did the program convert the shift value correctly?
- Was the program commented well enough?
- Did the program assemble and link successfully?