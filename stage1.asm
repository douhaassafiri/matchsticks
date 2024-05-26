    MOV R0, #req_name //print the string "Please enter your name"
    STR R0, .WriteString
    MOV R1, #my_name //input the name
    STR R1, .ReadString
    MOV R0, #req_matchsticks //print the string "How many matchsticks (10-100)?"
    STR R0, .WriteString
    LDR R2, .InputNum //input the number of sticks
if1:
    CMP R2, #9 //check if the input is bigger than 9
    BGT if2
    B else
if2:
    CMP R2, #101 //check if the input is smaller than 101
    BLT cont
    B else
else:
    MOV R0, #invalid_num //print the string "Please input a valid number"
    STR R0, .WriteString
    LDR R2, .InputNum //input the number of sticks
    B if1
cont:
    MOV R0, #ann_name //print the string "Player 1 is"
    STR R0, .WriteString
    MOV R0, R1 //print the name of the player
    STR R0, .WriteString
    MOV R0, #newline //print newline
    STR R0, .WriteString
    MOV R0, #ann_matchsticks //print the string "Matchsticks:"
    STR R0, .WriteString
    MOV R0, R2 //print the number of sticks
    STR R0, .WriteUnsignedNum
    HALT
req_name:           .ASCIZ "Please enter your name\n"
req_matchsticks:    .ASCIZ "How many matchsticks (10-100)?\n"
invalid_num:        .ASCIZ "Please input a valid number\n"
ann_name:           .ASCIZ "Player 1 is "
ann_matchsticks:    .ASCIZ "Matchsticks: "
newline:            .ASCIZ "\n"
my_name:            .BLOCK 128
