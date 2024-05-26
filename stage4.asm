game:
    MOV R0, #req_name //print the string "Please enter your name"
    STR R0, .WriteString
    MOV R1, #my_name //input the name
    STR R1, .ReadString
    MOV R0, #req_matchsticks //print the string "How many matchsticks (10-100)?"
    STR R0, .WriteString
matchsticks_tot:
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
    B matchsticks_tot
cont:
    MOV R0, #ann_name //print the string "Player 1 is "
    STR R0, .WriteString
    MOV R0, R1 //print the name of the player
    STR R0, .WriteString
    MOV R0, #0x0A //print ASCII code for newline
    STRB R0, .WriteChar
    MOV R0, #ann_matchsticks //print the string "Matchsticks: "
    STR R0, .WriteString
    MOV R0, R2 //print the number of sticks
    STR R0, .WriteUnsignedNum
    MOV R0, #0x0A //print ASCII code for newline
    STRB R0, .WriteChar
    MOV R5, #1 //set the player number to 1
    B draw_matchsticks
clear_display:
    MOV R6, #.PixelScreen
    MOV R7, #.white
    MOV R8, #0 //set the starting pixel address to 0
    MOV R10, #4096 //set the total number of pixels to 4096
clear_display_loop:
    ADD R9, R6, R8 //get the address of the pixel
    STR R7, [R9]//set the pixel to white
    ADD R8, R8, #4 //move to the next pixel
    SUB R10, R10, #4 //decrement the number of pixels
    CMP R10, #0 //check if all pixels have been cleared
    BNE clear_display_loop //if not, continue clearing the display
draw_matchsticks:
    MOV R6, #.PixelScreen
    MOV R7, #.red
    MOV R8, #0 //set the starting pixel address to 0
    MOV R10, R2 //set the number of sticks to the number of sticks remaining
draw_loop:
    PUSH {R6, R7, R8, R9, R10}
    CMP R10, #0 //check if the number of sticks is 0
    BEQ finished_drawing
    BL draw_single_stick //draw a single stick
    ADD R8, R8, #32 //move to the next stick
    SUB R10, R10, #1 //decrement the number of sticks
    B draw_loop
    POP {R6, R7, R8, R9, R10}
draw_single_stick:
    ADD R9, R6, R8 //get the address of the pixel
    STR R7, [R9]//set the pixel to red
    ADD R8, R8, #4 //move to the next pixel
    ADD R9, R6, R8 //get the address of the pixel
    STR R7, [R9]//set the pixel to red
    ADD R8, R8, #4 //move to the next pixel
    RET
finished_drawing:
    CMP R2, #1 //check if the number of sticks is 1
    BEQ game_over
    CMP R2, #0 //check if the number of sticks is 0
    BEQ draw
    CMP R5, #1 //check if the player number is 1
    BEQ human_turn
    MOV R0, #computer //print the string "Computer's turn"
    STR R0, .WriteString
    B computer_turn
human_turn:
    MOV R0, #player_x //print the string "Player "
    STR R0, .WriteString
    MOV R0, R1 //print the name of the player
    STR R0, .WriteString
    MOV R0, #there_are //print the string ", there are "
    STR R0, .WriteString
    MOV R0, R2 //print the number of sticks remaining
    STR R0, .WriteUnsignedNum
    MOV R0, #remaining //print the string " matchsticks remaining."
    STR R0, .WriteString
    MOV R0, #player_x //print the string "Player "
    STR R0, .WriteString
    MOV R0, R1 //print the name of the player
    STR R0, .WriteString
    MOV R0, #how_many //print the string ", how many matchsticks do you want to remove (1-7)?"
    STR R0, .WriteString
sticks_num:
    LDR R3, .InputNum //input the number of sticks
if3:
    CMP R3, #0 //check if the input is bigger than 0
    BGT if4
    B else2
if4:
    CMP R3, #8 //check if the input is less than 8
    BLT if5
    B else2
if5:
    CMP R3, R2 //check if the input is less than the number of sticks remaining
    BGT else2
    B cont2
else2:
    MOV R0, #invalid_num //print the string "Please input a valid number"
    STR R0, .WriteString
    B sticks_num
cont2:
    SUB R2, R2, R3 //remove the sticks
    MOV R0, #player_x //print the string "Player "
    STR R0, .WriteString
    MOV R0, R1 //print the name of the player
    STR R0, .WriteString
    MOV R0, #there_are //print the string ", there are "
    STR R0, .WriteString
    MOV R0, R2 //print the number of sticks remaining
    STR R0, .WriteUnsignedNum
    MOV R0, #remaining //print the string " matchsticks remaining."
    STR R0, .WriteString
    MOV R5, #2 //set the player number to 2
    B clear_display
computer_turn:
    LDR R4, .Random //generate a random number between 1 and 7
    LSR R4, R4, #29 //get the last 3 bits of the random number
    CMP R4, #0 //check if the random number is more than 0
    BEQ computer_turn
    CMP R4, R2 //check if the random number is equal to the number of sticks remaining
    BGT computer_turn
    SUB R2, R2, R4 //remove the sticks
    MOV R0, #computer_rem //print the string "Computer removed "
    STR R0, .WriteString
    MOV R0, R4 //print the number of sticks removed
    STR R0, .WriteUnsignedNum
    MOV R0, #matchsticks //print the string " matchsticks."
    STR R0, .WriteString
    MOV R5, #1 //change the player number
    B clear_display
game_over:
    CMP R5, #1 //check if the player is human
    BEQ lose
    B win
lose:
    MOV R0, #player_x //print the string "Player "
    STR R0, .WriteString
    MOV R0, R1 //print the name of the player
    STR R0, .WriteString
    MOV R0, #loser //print the string ", YOU LOSE!"
    STR R0, .WriteString
    B play_again
win:
    MOV R0, #player_x //print the string "Player "
    STR R0, .WriteString
    MOV R0, R1 //print the name of the player
    STR R0, .WriteString
    MOV R0, #winner //print the string ", YOU WIN!"
    STR R0, .WriteString
    B play_again
draw:
    MOV R0, #its_draw //print the string "It's a draw!"
    STR R0, .WriteString
    B play_again
play_again:
    MOV R0, #play_again_txt //print the string "Play again (y/n)?"
    STR R0, .WriteString
    MOV R3, #ans //store array base address
    STR R3, .ReadString
    MOV R5, #0 //initialise index
to_lower:
    LDRB R2, [R3+R5]//read byte from array
    CMP R2, #65 //check lower value limit
    BLT skip_conversion //if lower than uppercase range, skip conversion
    CMP R2, #90 // check upper value limit
    BGT skip_conversion //if greater than uppercase range, skip conversion
    ADD R2, R2, #32 //convert to lowercase value
    STRB R2, [R3+R5] //write it back to the array
skip_conversion: //branch destination if value was not uppercase
    ADD R5, R5, #1 //increment index
    CMP R2, #0 //check if NULL character
    BNE to_lower //keep looping if not NULL character
    LDRB R3, [R3] //load the first character of the input
    MOV R4, #yes
    LDRB R4, [R4]//load the first character of the string "y"
    CMP R3, R4 //check if the choice is 'y'
    BEQ play
    MOV R4, #no
    LDRB R4, [R4]//load the first character of the string "n"
    CMP R3, R4 //check if the choice is 'n'
    BEQ end
    B play_again
play:
    B game
end:
    HALT
req_name:           .ASCIZ "Please enter your name\n"
req_matchsticks:    .ASCIZ "How many matchsticks (10-100)?\n"
invalid_num:        .ASCIZ "Please input a valid number\n"
ann_name:           .ASCIZ "Player 1 is "
ann_matchsticks:    .ASCIZ "Matchsticks: "
player_x:           .ASCIZ "Player "
there_are:          .ASCIZ ", there are "
remaining:          .ASCIZ " matchsticks remaining.\n"
how_many:           .ASCIZ ", how many matchsticks do you want to remove (1-7)?\n"
computer:           .ASCIZ "Computer Player's turn\n"
computer_rem:       .ASCIZ "Computer removed "
matchsticks:        .ASCIZ " matchsticks.\n"
winner:             .ASCIZ ", YOU WIN!\n"
loser:              .ASCIZ ", YOU LOSE!\n"
its_draw:           .ASCIZ "It's a draw!\n"
play_again_txt:     .ASCIZ "Play again (y/n)?\n"
yes:                .ASCIZ "y\n"
no:                 .ASCIZ "n\n"
.ALIGN 256
my_name:
.BLOCK 128
ans:
.BLOCK 128
