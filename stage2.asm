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
    MOV R0, #newline //print newline
    STR R0, .WriteString
    MOV R0, #player_x //print the string "Player "
    STR R0, .WriteString
    MOV R0, R1 //print the name of the player
    STR R0, .WriteString
    MOV R0, #there_are //print the string ", there are "
    STR R0, .WriteString
    MOV R0, R2 //print the number of sticks
    STR R0, .WriteUnsignedNum
    MOV R0, #remaining //print the string " matchsticks remaining."
    STR R0, .WriteString
    MOV R0, #player_x //print the string "Player "
    STR R0, .WriteString
    MOV R0, R1 //print the name of the player
    STR R0, .WriteString
    MOV R0, #how_many //print the string ", how many matchsticks do you want to remove (1-7)?"
    STR R0, .WriteString
    LDR R3, .InputNum //input the number of sticks to remove
if3:
    CMP R3, #0 //check if the input is bigger than 0
    BGT if4
    B else
if4:
    CMP R3, #8 //check if the input is smaller than 8
    BLT cont2
    B else
else2:
    MOV R0, #invalid_num //print the string "Please input a valid number"
    STR R0, .WriteString
    LDR R3, .InputNum //input the number of sticks to remove
    B if3
cont2:
    SUB R2, R2, R3 //remove the sticks
    MOV R0, #player_x //print the string "Player "
    STR R0, .WriteString
    MOV R0, R1 //print the name of the player
    STR R0, .WriteString
    MOV R0, #there_are //print the string ", there are "
    STR R0, .WriteString
    MOV R0, R2 //print the number of sticks
    STR R0, .WriteUnsignedNum
    MOV R0, #remaining //print the string " matchsticks remaining."
    STR R0, .WriteString
    CMP R2, #0 //check if the number of sticks is 0
    BEQ game_over
    MOV R0, #player_x //print the string "Player "
    STR R0, .WriteString
    MOV R0, R1 //print the name of the player
    STR R0, .WriteString
    MOV R0, #how_many //print the string ", how many matchsticks do you want to remove (1-7)?"
    STR R0, .WriteString
    LDR R3, .InputNum //input the number of sticks to remove
    B if3
    CMP R2, #0 //check if the number of sticks is 0
    BEQ game_over
    B cont2
game_over:
    MOV R0, #game_over_txt //print the string "Game Over"
    STR R0, .WriteString
    HALT
req_name:           .ASCIZ "Please enter your name\n"
req_matchsticks:    .ASCIZ "How many matchsticks (10-100)?\n"
invalid_num:        .ASCIZ "Please input a valid number\n"
ann_name:           .ASCIZ "Player 1 is "
ann_matchsticks:    .ASCIZ "Matchsticks: "
newline:            .ASCIZ "\n"
my_name:            .BLOCK 128
player_x:           .ASCIZ "Player "
there_are:          .ASCIZ ", there are "
remaining:          .ASCIZ " matchsticks remaining.\n"
how_many:           .ASCIZ ", how many matchsticks do you want to remove (1-7)?\n"
game_over_txt:      .ASCIZ "Game Over\n"