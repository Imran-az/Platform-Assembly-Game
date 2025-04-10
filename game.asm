#####################################################################
#
# CSCB58 Winter 2025 Assembly Final Project
# University of Toronto, Scarborough
#
# Student: IMRAN AZIZ, 1010287501, azizimr2, i.aziz@mail.utoronto.ca
# # Bitmap Display
#Configuration:
# - Unit width in pixels: 4 (update this as needed)
# - Unit height in pixels: 4 (update this as needed)
# - Display width in pixels: 256 (update this as needed)
# - Display height in pixels: 256 (update this as needed)
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestoneshave been reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 1/2/3/4 (choose the one the applies)
# - Milestone 1 - Reached (Draw the level, Draw the plaer character, draw at least 2 additional objects)
# - Milestone 2 - Reached (Player can move, Platform collision and gravity, Vertical movement, Allowing restart/quit)
# - Milestone 3 - Reached (Score, Fail Condition, Win Condition)
# - Milestone 4 - Reached (Double Jump, character shoots lasers, enemy moves)
# Which approved features have been implemented for milestone 3?
# (See the assignment handout for the list of additional features)
# 1. Double Jump - 1 mark
# 2. Moving Objects - (Pink enemy moves back and forth on platform patroling) - 2 marks
# 3. shoot Enemies - (Character can shoot the Pink enemy, along with shoot lasers to pick up coins) - 2 marks
# # Link to video demonstration for final
#submission:
# - (insert YouTube / MyMedia / other URL here). Make sure we can view it!
# # Are you OK with us sharing the video with people outside course
#staff? # - yes, and please share this project github link as
#well!
# # Any additional information that the TA needs to
#know:
##Controls:
# - (W key) - jump up (if u double click W key u can double jump
# - (A key) - move character to the left
# - (D key) - move character to the right
# - (Spacebar key) - Shoot lasers
# - (R key) - reset game
# - (Q key) - Quit game

# - When the character dies or wins the game ends. Other than that at any point of the game the user can restart or quit the game
# - Users can use lasers to shoot coins and collect them. They can also run into coins to collect them.
# - lasers are meant to be shot when a character is stationary on a platform
# - If user collects all coins they win the game
# - If user falls into the lava or touches the enemy the lose the game
#
#####################################################################

.eqv BASE_ADDRESS 0x10008000
.eqv MAX_ADDRESS 0x1000c000
.eqv Red 0xff0000
.eqv Green 0x00ff00
.eqv Blue 0x0000ff
.eqv Orange 0xffffa500
.eqv Black 00000000
.eqv White 0xffffff
.eqv Purple 0x8A2BE2
.eqv Pink 0xFF69B4
.eqv Yellow 0xFFFF00
.eqv shoot_start 6588
.eqv shoot_end 6528
.eqv Maroon 0x800000



.data
platform1: 
.word 
14080, 14084, 14088, 14092, 14096, 14100, 14104, 14108,
14336, 14340, 14344, 14348, 14352, 14356, 14360, 14364,
14592, 14596, 14600, 14604, 14608, 14612, 14616, 14620

platform2:
.word 
10812, 10816, 10820, 10824, 10828, 10832, 10836, 10840, 10844, 10848, 10852, 10856, 10860, 10864, 10868, 10872, 10876, 10880, 10884, 10888, 10892,

11068, 11072, 11076, 11080, 11084, 11088, 11092, 11096, 11100, 11104, 11108, 11112, 11116, 11120, 11124, 11128, 11132, 11136, 11140, 11144, 11148,

11324, 11328, 11332, 11336, 11340, 11344, 11348, 11352, 11356, 11360, 11364, 11368, 11372, 11376, 11380, 11384, 11388, 11392, 11396, 11400, 11404


platform3:
.word 
3500, 3504, 3508, 3512, 3516, 3520, 3524, 3528, 3532, 3536, 3540, 3544, 3548, 3552, 3556, 3560, 3564, 3568, 3572, 3576, 3580,

3756, 3760, 3764, 3768, 3772, 3776, 3780, 3784, 3788, 3792, 3796, 3800, 3804, 3808, 3812, 3816, 3820, 3824, 3828, 3832, 3836,

4012, 4016, 4020, 4024, 4028, 4032, 4036, 4040, 4044, 4048, 4052, 4056, 4060, 4064, 4068, 4072, 4076, 4080, 4084, 4088, 4092

platform4:
.word 
7564, 7568, 7572, 7576, 7580, 7584, 7588, 7592, 7596, 7600, 7604, 7608, 7612

7820, 7824, 7828, 7832, 7836, 7840, 7844, 7848, 7852, 7856, 7860, 7864, 7868

8076, 8080, 8084, 8088, 8092, 8096, 8100, 8104, 8108, 8112, 8116, 8120, 8124

lava_layer1:
.word
15616, 15620, 15624, 15628, 15632, 15636, 15640, 15644, 15648, 15652, 15656, 15660, 15664, 15668, 15672, 15676, 15680, 15684, 15688, 15692, 
15696, 15700, 15704, 15708, 15712, 15716, 15720, 15724, 15728, 15732, 15736, 15740, 15744, 15748, 15752, 15756, 15760, 15764, 15768, 15772,
15776, 15780, 15784, 15788, 15792, 15796, 15800, 15804, 15808, 15812, 15816, 15820, 15824, 15828, 15832, 15836, 15840, 15844, 15848, 15852,
15856, 15860, 15864, 15868

lava_layer2Red:
.word
15872, 15880, 15888, 15896, 15904, 15912, 15920, 15928, 15936, 15944, 
15952, 15960, 15968, 15976, 15984, 15992, 16000, 16008, 16016, 16024, 
16032, 16040, 16048, 16056, 16064, 16072, 16080, 16088, 16096, 16104, 
16112, 16120

lava_layer2Maroon:
.word
15876, 15884, 15892, 15900, 15908, 15916, 15924, 15932, 15940, 15948, 
15956, 15964, 15972, 15980, 15988, 15996, 16004, 16012, 16020, 16028, 
16036, 16044, 16052, 16060, 16068, 16076, 16084, 16092, 16100, 16108, 
16116, 16124

lava_layer3Red:
.word
16132, 16140, 16148, 16156, 16164, 16172, 16180, 16188, 16196, 16204, 
16212, 16220, 16228, 16236, 16244, 16252, 16260, 16268, 16276, 16284, 
16292, 16300, 16308, 16316, 16324, 16332, 16340, 16348, 16356, 16364, 
16372, 16380

lava_layer3Maroon:
.word
16128, 16136, 16144, 16152, 16160, 16168, 16176, 16184, 16192, 16200, 
16208, 16216, 16224, 16232, 16240, 16248, 16256, 16264, 16272, 16280, 
16288, 16296, 16304, 16312, 16320, 16328, 16336, 16344, 16352, 16360, 
16368, 16376

zero:
.word
524, 528, 532, 788, 1044, 1040, 1036, 780

one:
.word
524, 528, 784, 1040, 1036, 1044

slash:
.word
1056, 1308, 1560
 
twoIncrement:
.word
272, 276, 532, 784, 1040, 1044

 twoTotal:
 .word
1572, 1576, 1832, 2084, 2340, 2344

token1:
.word
10592, 10332, 10340, 10080, 

token1Radius:
.word
10592, 10588, 10596, 10332, 10076, 10340, 10080, 10336, 10084, 10088, 10092, 10096, 10352, 10348, 10344

token2Radius:
.word
3268, 3272, 3276, 2760, 3012, 3020, 3016, 2756, 2760, 2764, 2768, 2772, 2776

token2:
.word
3272, 2760, 3012, 3020

enemy:
.word
7356, 7352, 7348, 7092, 7096, 7100, 6844, 6836, 6580, 6584, 6588, 6840

enemyRadius:
.word
7356, 7352, 7348, 7092, 7096, 7100, 6844, 6836, 6580, 6584, 6588, 6332, 6324, 6848, 6852

enemyLocation:
.word
6580

enemyShot:
.word
0

enemy_spray:
.word
6804, 6808

key_pressed_flag: 
.word 
0

coinsCollected:
.word
0

coinsLost:
.word
0

token1LaserDetect:
.word
0

token2LaserDetect:
.word
0

toggleCounter: 
.word 
0     
toggleState:   
.word 
0 

enemyCounter:
.word
0

winScreen:
.word
# Y - 18 
6992, 6996, 7248, 7252, 7504, 7508, 7768, 7772, 8024, 8028, 8280, 8284, 7008, 7012, 7264, 7268, 7520, 7524

# O - 25
7024, 7028, 7032, 7036, 7040, 7280, 7284, 7288, 7292, 7296, 7536, 7792, 8048, 8304, 8308, 8312, 8316, 8320, 8064, 8060, 8056, 8052, 8064, 7808, 7552

# U - 28
7052, 7056, 7308, 7312, 7564, 7568, 7820, 7824, 8076, 8080, 8332, 8336, 8340, 8084, 8088, 8344, 8348, 8092, 7836, 7580, 7324, 7068, 7072, 7328, 
7584, 7840, 8096, 8352

# W
9552, 9556, 9808, 9812, 10064, 10068, 10320, 10324, 10576, 10580, 10328, 10076, 10336, 10340, 10596, 10600, 10344, 10088, 10084, 9828, 9832,
9576, 9572

# I
9588, 9592, 9844, 9848, 10100, 10104, 10356, 10360, 10612, 10616

# N
9604, 9608, 9860, 9864, 10116, 10120, 10372, 10376, 10628, 10632, 9612, 9872, 10132, 10392, 10648, 10652, 10396, 10140, 10136, 9880, 9884, 9624, 9628

loseScreen:
.word
# Y - 18 
6992, 6996, 7248, 7252, 7504, 7508, 7768, 7772, 8024, 8028, 8280, 8284, 7008, 7012, 7264, 7268, 7520, 7524

# O - 25
7024, 7028, 7032, 7036, 7040, 7280, 7284, 7288, 7292, 7296, 7536, 7792, 8048, 8304, 8308, 8312, 8316, 8320, 8064, 8060, 8056, 8052, 8064, 7808, 7552

# U - 28
7052, 7056, 7308, 7312, 7564, 7568, 7820, 7824, 8076, 8080, 8332, 8336, 8340, 8084, 8088, 8344, 8348, 8092, 7836, 7580, 7324, 7068, 7072, 7328, 
7584, 7840, 8096, 8352

# L - 18
9296, 9300, 9552, 9556, 9808, 9812, 10064, 10068, 10320, 10324, 10576, 10580, 10584, 10328, 10588, 10332, 10592, 10336

# O - 25
9324, 9328, 9332, 9336, 9340, 9580, 9584, 9588, 9592, 9596, 9836, 10092, 10348, 10604, 10608, 10612, 10616, 10620, 10364, 10360, 10356, 10352, 10364, 10108, 9852


# S -
9352, 9356, 9360, 9364, 9620, 9616, 9612, 9608, 9612, 9868, 9864, 10120, 10124, 10128, 10132, 10388, 10644, 10900, 10896, 10892, 10888, 10632, 10636, 10640

# E
9376, 9380, 9384, 9388, 9644, 9640, 9636, 9632, 9888, 10144, 10148, 10152, 10156, 10400, 10656, 10912, 10916, 10920, 10924, 10668, 10664, 10660


.globl main
.text 

# ********************************* DRAW PLATFORMS *************************************************
drawPlatform1:    
    li $t0, BASE_ADDRESS
    li $t4, Orange           
    la $a0, platform1        
    li $a1, 24 
    j draw_loop       

draw_loop:
    beqz $a1, draw_done

    lw $t5, 0($a0)
    add $t6, $t0, $t5
    sw $t4, 0($t6)

    addi $a0, $a0, 4
    addi $a1, $a1, -1
    j draw_loop

draw_done:
    jr $ra
    
drawPlatform2:
    li $t0, BASE_ADDRESS
    li $t4, Orange
    la $a0, platform2
    li $a1, 63
    j draw_loop

drawPlatform3:
    li $t0, BASE_ADDRESS
    li $t4, Orange
    la $a0, platform3
    li $a1, 63
    j draw_loop 

drawPlatform4:
    li $t0, BASE_ADDRESS
    li $t4, Orange
    la $a0, platform4
    li $a1, 39
    j draw_loop

drawPlatform4Black:
    li $t0, BASE_ADDRESS
    li $t4, Black
    la $a0, platform4
    li $a1, 39
    j draw_loop

drawEnemy:
    li $t0, BASE_ADDRESS
    li $t4, Pink
    la $a0, enemy
    li $a1, 12
    j draw_loop 


drawlava_layer1:
    li $t0, BASE_ADDRESS
    li $t4, Red
    la $a0, lava_layer1
    li $a1, 64
    j draw_loop

drawlava_layer2Red:
    li $t0, BASE_ADDRESS
    li $t4, Red
    la $a0, lava_layer2Red
    li $a1, 32
    j draw_loop

drawlava_layer2Maroon:
    li $t0, BASE_ADDRESS
    li $t4, Maroon
    la $a0, lava_layer2Maroon
    li $a1, 32
    j draw_loop

drawlava_layer3Red:
    li $t0, BASE_ADDRESS
    li $t4, Red
    la $a0, lava_layer3Red
    li $a1, 32
    j draw_loop

drawlava_layer3Maroon:
    li $t0, BASE_ADDRESS
    li $t4, Maroon
    la $a0, lava_layer3Maroon
    li $a1, 32
    j draw_loop

drawToken1: 
    li $t0, BASE_ADDRESS
    li $t4, Yellow
    la $a0, token1
    li $a1, 4
    j draw_loop

drawToken2: 
    li $t0, BASE_ADDRESS
    li $t4, Yellow
    la $a0, token2
    li $a1, 4
    j draw_loop

drawZero:
    li $t0, BASE_ADDRESS
    li $t4, White
    la $a0, zero
    li $a1, 8
    j draw_loop

drawOne:
    li $t0, BASE_ADDRESS
    li $t4, White
    la $a0, one
    li $a1, 6
    j draw_loop

drawSlash:
    li $t0, BASE_ADDRESS
    li $t4, White
    la $a0, slash
    li $a1, 3
    j draw_loop

drawTwoTotal:
    li $t0, BASE_ADDRESS
    li $t4, White
    la $a0, twoTotal
    li $a1, 6
    j draw_loop

drawTwoIncrement:
    li $t0, BASE_ADDRESS
    li $t4, White
    la $a0, twoIncrement
    li $a1, 6
    j draw_loop

drawWinScreen:
    li $t0, BASE_ADDRESS
    li $t4, White
    la $a0, winScreen
    li $a1, 131
    j draw_loop
    
drawLoseScreen:
    li $t0, BASE_ADDRESS
    li $t4, White
    la $a0, loseScreen
    li $a1, 160
    j draw_loop

reset_loop:
    add $t7, $t0, $t3         
    sw $t2, 0($t7)            
    addi $t3, $t3, 4          
    bne $t3, $t1, reset_loop  
    jr $ra

resetScreen:
    li $t0, BASE_ADDRESS      
    li $t1, 16384             
    li $t2, Black             
    move $t3, $zero      
    j reset_loop              
    
displayLoseScreen:
    jal resetScreen
    jal drawLoseScreen
    li $v0, 10
    syscall
    j main

#***************************** CREATE CHARACTER **********************************
character:
    li $t0, BASE_ADDRESS
    move $t6, $zero
    li $t1, Purple
    li $t2, Green
    li $t3, Black
    li $t4, Orange
    add $t6, $t0, $t5

    sw $t2, 0($t6)
    sw $t1, 4($t6)
    sw $t2, 8($t6)
    sw $t1, 256($t6)
    sw $t2, 260($t6)
    sw $t1, 264($t6)
    sw $t2, 512($t6)
    sw $t1, 516($t6)
    sw $t2, 520($t6)

    #sleep after every redraw
    li $v0, 32
    li $a0, 100 
    syscall

    #checks to see if coin is below
    lw $t7, 772($t6)
    li $t9, Yellow
    beq $t7, $t9, coinBelow
    lw $t7, 772($t6)
    li $t9, Pink
    beq $t7, $t9, displayLoseScreen
    lw $t7, 776($t6)
    beq $t7, $t9, displayLoseScreen
    lw $t7, 768($t6)
    beq $t7, $t9, displayLoseScreen


    #checks to see if the character has fallen in the lava
    lw $t7, 768($t6)
    li $t9, Red
    beq $t7, $t9, displayLoseScreen
    lw $t7, 772($t6)
    beq $t7, $t9, displayLoseScreen
    lw $t7, 776($t6)
    beq $t7, $t9, displayLoseScreen

    #Checking if below the character the colour is black
    lw $t7, 768($t6)
    lw $t8, 776($t6)
    bne $t7, $t3, platform_check
    bne $t8, $t3, platform_check
    j gravity


#***************************** PLATFORM CHECK **********************************
#check if they are standing on a platform to then double jump
platform_check:
    li $t7, 0
    sw $t7, key_pressed_flag

    j gravity_check


#***************************** COIN DETECTION **********************************
firstCoin:
    li $t3, Black
    sw $t3, 10592($t0)
    sw $t3, 10332($t0)
    sw $t3, 10340($t0)
    sw $t3, 10080($t0)
    j numCollectedCoins

secondCoin:
    li $t3, Black
    sw  $t3, 3272($t0)
    sw  $t3, 2760($t0)
    sw  $t3, 3012($t0)
    sw  $t3, 3020($t0)
    j numCollectedCoins

numCollectedCoins:
    la $t4, coinsCollected
    lw $t7, 0($t4)
    addi $t7, $t7, 1
    sw $t7, 0($t4)
    li $t8, 1
    beq $t7, $t8, displayOne
    li $t8, 2
    beq $t7, $t8, displayTwo
    j gravity_check

numLostCoins:
    la $t4, coinsLost
    lw   $t7, 0($t4)	
    addi $t7, $t7, 1
    sw $t7, 0($t4)
    li $t9, 2
    beq $t7, $t9, displayLoseScreen
    j gravity_check

coinLocationRight: 
    addi $t7, $t6, 16
    addi $t4, $t0, 10080
    beq $t4, $t7, firstCoin

    addi $t4, $t0, 2760
    beq $t4, $t7, secondCoin
    j gravity_check

coinBelow:
    addi $t7, $t6, 772
    addi $t4, $t0, 10080
    beq $t4, $t7, firstCoin

    addi $t4, $t0, 2760
    beq $t4, $t7, secondCoin
    j gravity_check

coinLocationLeft: 
    addi $t7, $t6, -8
    addi $t4, $t0, 10080
    beq $t4, $t7, firstCoin

    addi $t4, $t0, 2760
    beq $t4, $t7, secondCoin
    j gravity_check

#***************************** SCORE COUNTER **********************************

displayOne:
    li $t1, Black 
    sw $t1, 524($t0)
    sw $t1, 528($t0)
    sw $t1, 532($t0)
    sw $t1, 788($t0)
    sw $t1, 1044($t0)
    sw $t1, 1040($t0)
    sw $t1, 1036($t0)
    sw $t1, 780($t0)
    move $s0, $t5
    jal drawOne
    move $t5, $s0
    j gravity_check

displayTwo:
    li $t1, Black
    sw $t1, 524($t0)
    sw $t1, 528($t0)
    sw $t1, 784($t0)
    sw $t1, 1040($t0)
    sw $t1, 1036($t0)
    sw $t1, 1044($t0)
    move $s0, $t5
    jal drawTwoIncrement
    move $t5, $s0
    jal resetScreen
    jal drawTwoIncrement
    jal drawSlash
    jal drawTwoTotal
    jal drawWinScreen
    
	

    li $v0, 10
    syscall
    j gravity_check

#***************************** MOVE RIGHT **********************************
move_right:
    li $t3, Black
    li $t1, Yellow
    li $t2, Orange
    li $t7, Pink


    lw $t4, 12($t6)
    beq $t4, $t2, character #check if top right corner is hitting orange platform
    lw $t4, 268($t6)
    beq $t4, $t2, character #check if middle right  is hitting orange platform
    lw $t4, 524($t6)
    beq $t4, $t2, character #check if bottom right corner is hitting orange platform

    lw $t4, 12($t6)
    beq $t4, $t7, character #check if top right corner is hitting orange platform
    lw $t4, 268($t6)
    beq $t4, $t7, character #check if middle right  is hitting orange platform
    lw $t4, 524($t6)
    beq $t4, $t7, character #check if bottom right corner is hitting orange platform

    #checks to see if coin is on the right of the character
    lw $t4, 16($t6)
    beq $t4, $t1, coinLocationRight


# check wall Detection ****************************
    addi $t9, $t5, 12
# Compare row numbers before and after move
    srl $t7, $t5, 8      
    srl $t8, $t9, 8       
# *************************************************
    bne $t7, $t8, character

#Sets left squares black
    sw $t3, 0($t6)
    sw $t3, 256($t6)
    sw $t3, 512($t6)
    addi $t5, $t5, 4
    j character


#***************************** MOVE LEFT **********************************
move_left:
    li $t3, Black
    li $t1, Yellow
    li $t2, Orange

    lw $t4, -4($t6)
    beq $t4, $t2, character
    lw $t4, 252($t6)
    beq $t4, $t2, character
    lw $t4, 508($t6)
    beq $t4, $t2, character


    #checks to see if the coin is to the left of the character
    lw $t4, -8($t6)
    beq $t4, $t1, coinLocationLeft

#check wall Detection ****************************
    srl $t7, $t5, 8    
# Check next position's row
    sll $t7, $t7, 8   
    beq $t7, $t5, character
# *************************************************

#Sets right squares black
    sw $t3, 8($t6)
    sw $t3, 264($t6)
    sw $t3, 520($t6)
    addi $t5, $t5, -4
    j character


delete_enemy:
    li $t1, Black
    sw $t1, 7356($t0)
    sw $t1, 7352($t0)
    sw $t1, 7348($t0)
    sw $t1, 7092($t0)
    sw $t1, 7096($t0)
    sw $t1, 7100($t0)
    sw $t1, 6844($t0)
    sw $t1, 6836($t0)
    sw $t1, 6580($t0)
    sw $t1, 6584($t0)
    sw $t1, 6588($t0)
    sw $t1, 6332($t0)
    sw $t1, 6324($t0)
    sw $t1, 6840($t0)


    sw $t4, 0($t7)
    sw $t4, 4($t7)

    la $t3, enemyShot
    lw $t4, 0($t3)
    li $t6, 1
    sw $t6, enemyShot

    j character

delete_current_enemy:
    li $t3, Black
    li $t4, Pink
    la $t1, enemyLocation
    lw $t2, 0($t1)
    add $t6, $t0, $t2  #top left corner of enemy

    sw $t3, 0($t6)
    sw $t3, 4($t6)
    sw $t3, 8($t6)
    sw $t3, 256($t6)
    sw $t3, 260($t6)
    sw $t3, 264($t6)
    sw $t3, 512($t6)
    sw $t3, 516($t6)
    sw $t3, 520($t6)
    sw $t3, 768($t6)
    sw $t3, 772($t6)
    sw $t3, 776($t6)
    j continue_loop

move_enemy_right:
    li $t3, Black
    li $t4, Pink
    la $t1, enemyLocation
    lw $t2, 0($t1)
    add $t6, $t0, $t2  #top left corner of enemy

    sw $t3, 0($t6)
    sw $t3, 4($t6)
    sw $t3, 8($t6)
    sw $t3, 256($t6)
    sw $t3, 260($t6)
    sw $t3, 264($t6)
    sw $t3, 512($t6)
    sw $t3, 516($t6)
    sw $t3, 520($t6)
    sw $t3, 768($t6)
    sw $t3, 772($t6)
    sw $t3, 776($t6)

    addi $t2, $t2, 4
    add $t6, $t0, $t2

    sw $t4, 0($t6)
    sw $t4, 4($t6)
    sw $t4, 8($t6)
    sw $t4, 256($t6)
    sw $t4, 260($t6)
    sw $t4, 264($t6)
    sw $t4, 512($t6)
    sw $t4, 516($t6)
    sw $t4, 520($t6)
    sw $t4, 768($t6)
    sw $t4, 772($t6)
    sw $t4, 776($t6)

    sw $t2, enemyLocation # save top left location

    la $t1, enemyCounter
    lw $t2, 0($t1)
    addi $t2, $t2, 1
    sw $t2, enemyCounter
    j continue_loop

move_enemy_left:
    li $t3, Black
    la $t1, enemyLocation
    lw $t2, 0($t1)
    add $t6, $t0, $t2  #top left corner of enemy

    sw $t3, 0($t6)
    sw $t3, 4($t6)
    sw $t3, 8($t6)
    sw $t3, 256($t6)
    sw $t3, 260($t6)
    sw $t3, 264($t6)
    sw $t3, 512($t6)
    sw $t3, 516($t6)
    sw $t3, 520($t6)
    sw $t3, 768($t6)
    sw $t3, 772($t6)
    sw $t3, 776($t6)

    addi $t2, $t2, -4
    add $t6, $t0, $t2

    li $t4, Pink

    sw $t4, 0($t6)
    sw $t4, 4($t6)
    sw $t4, 8($t6)
    sw $t4, 256($t6)
    lw $t7, 252($t6)
    li $t8, Green,
    beq $t7, $t8, displayLoseScreen


    sw $t4, 260($t6)
    sw $t4, 264($t6)
    sw $t4, 512($t6)
    sw $t4, 516($t6)
    sw $t4, 520($t6)
    sw $t4, 768($t6)
    sw $t4, 772($t6)
    sw $t4, 776($t6)

    li $t3, Green
    beq $t4, $t3, displayLoseScreen

    sw $t2, enemyLocation #save new location top left

    la $t1, enemyCounter
    lw $t2, 0($t1)
    addi $t2, $t2, 1
    sw $t2, enemyCounter
    j continue_loop
#***************************** LASER DELETES COIN **********************************
deleteCoin1_laser:
    la $s7, token1LaserDetect
    lw $s6, 0($s7)
    li $s5, 1
    beq $s6, $s5, check_coin2_laser
    
    addi $s6, $s6, 1
    sw $s6, 0($s7)
    
    li $t3, Black
    sw $t3, 10592($t0)
    sw $t3, 10332($t0)
    sw $t3, 10340($t0)
    sw $t3, 10080($t0)
    
    sw $t3, 0($t7)
    sw $t3, 4($t7)
    j numCollectedCoins

deleteCoin2_laser:
    li $t3, Black
    sw  $t3, 3272($t0)
    sw  $t3, 2760($t0)
    sw  $t3, 3012($t0)
    sw  $t3, 3020($t0)
    
    sw $t4, 0($t7)
    sw $t4, 4($t7)
    j numCollectedCoins


#***************************** LASER **********************************
firstCoin_laser:
    li $t3, Black
    sw $t3, 10592($t0)
    sw $t3, 10332($t0)
    sw $t3, 10340($t0)
    sw $t3, 10080($t0)
    sw $t4, 0($t7)
    sw $t4, 4($t7)
    j numLostCoins

shoot:
    li $t1, Red         
    li $t4, Black       
    li $t2, 0           
    li $t3, 5          
    move $t8, $t5	
    addi $t8, $t8, 16
    add $t7, $t0, $t8	
    sw $t1, 0($t7)
    sw $t1, 4($t7)
    
shoot_loop:
    move $t6, $t7	#storing current laser position into a temp
 
    li $v0, 32
    li $a0, 100
    syscall

    sw $t4, 0($t6)
    sw $t4, 4($t6)
 
    #moving lasers to next location
    addi $t8, $t8, 16	
    add $t7, $t0, $t8

    sw $t1, 0($t7)
    sw $t1, 4($t7)

    la $t9, token1Radius
    li $s1, 12

#check to see if laser hit token1
check_coin1_laser:
    beqz $s1, check_coin2_laser

    lw $s2, 0($t9)
    add $s3, $t0, $s2
    lw $s4, 0($s3) 
    beq $s4, $t1, deleteCoin1_laser


    addi $t9, $t9, 4      # Move to next enemy offset
    addi $s1, $s1, -1
    j check_coin1_laser

#check to see if laser hit token2
check_coin2_laser:

    la $t9, token2Radius
    li $s1, 13
    
check_coin2_laser_loop:
    beqz $s1, continue
    
    lw $s2, 0($t9)
    add $s3, $t0, $s2
    lw $s4, 0($s3) 
    beq $s4, $t1, deleteCoin2_laser

    addi $t9, $t9, 4      # Move to next enemy offset
    addi $s1, $s1, -1
    j check_coin2_laser_loop
    
#Now check if enemy has been hit
continue:
    # Load enemy address and count
    la $t9, enemyRadius        
    li $s1, 15            

check_enemy_loop:
    beqz $s1, skip_check  # Exit loop if all checked

    lw $s2, 0($t9)        
    add $s3, $t0, $s2     
    lw $s4, 0($s3)       

    beq $s4, $t1, delete_enemy  # If color is Red laser hit

    addi $t9, $t9, 4      # Move to next enemy offset
    addi $s1, $s1, -1
    j check_enemy_loop

#if none of our checks went through continue drawing the laser
skip_check:
    addi $t2, $t2, 1
    bne $t2, $t3, shoot_loop
 
    sw $t4, 0($t7)
    sw $t4, 4($t7)
    j character

#***************************** MOVE UP **********************************
move_up:
    li $t1, Black
    li $t3, Orange
    

    # Check if the w key has already been pressed
    lw $t2, key_pressed_flag
    beq $t2, 2, character  # If jump is already in progress, skip further jumps

    # Set the flag to prevent further jumps
    addi $t2, $t2, 1
    sw $t2, key_pressed_flag
    
    # Set the previous position to black erase the character
    sw $t1, 0($t6)
    sw $t1, 4($t6)
    sw $t1, 8($t6)
    sw $t1, 256($t6)
    sw $t1, 260($t6)
    sw $t1, 264($t6)
    sw $t1, 512($t6)
    sw $t1, 516($t6)
    sw $t1, 520($t6)

    # Move the character up by 4096 units 
    addi $t5, $t5, -4096

    # Redraw the character at the new position
    j character
    

#***************************** KEYPRESSED **********************************
keypress_happend:
    lw $t3, 4($t9)
    beq $t3, 0x61, move_left # a key
    beq $t3, 100, move_right # d key
    beq $t3, 0x77, move_up   # w key
    beq $t3, 0x72, main   #r key
    beq $t3, 0x20, shoot   #spacebar key
    beq $t3, 0x71, exit_program   #q key
    jal character
    j main_loop


exit_program:
    li $v0, 10
    syscall

#***************************** GRAVITY **********************************
gravity:
    li $t1, Black
    #setting current location of the character to black
    sw $t1, 0($t6)
    sw $t1, 4($t6)
    sw $t1, 8($t6)
    sw $t1, 256($t6)
    sw $t1, 260($t6)
    sw $t1, 264($t6)
    sw $t1, 512($t6)
    sw $t1, 516($t6)
    sw $t1, 520($t6)
    addi $t5, $t5, 256
    j gravity_check

resetEnemyCounter:
    la $t1, enemyCounter
    lw $t2, 0($t1)
    li $t3, 0
    sw $t3, enemyCounter
    j continue_loop

resetEnemy:
    # Reset enemy Location
    li $t1, 6580
    la $t2, enemyLocation
    sw $t1, enemyLocation
    jal drawEnemy
    
    # Reset enemyShot flag to 0
    li   $t2, 0
    la   $t3, enemyShot
    sw   $t2, 0($t3)
    
    # Reset enemyCounter to 0
    li   $t4, 0
    la   $t5, enemyCounter
    sw   $t4, 0($t5)
    j continue_main
    
main:
    jal resetScreen
    la $t1, enemyCounter
    la $t4, coinsCollected
    li $t7, 0
    sw $t7, 0($t4)
    jal drawZero
    jal drawSlash
    jal drawTwoTotal
    jal drawPlatform1    
    jal drawPlatform2 
    jal drawPlatform3
    jal drawPlatform4
    jal drawlava_layer1
    jal drawlava_layer2Red
    jal drawlava_layer2Maroon
    jal drawlava_layer3Red
    jal drawlava_layer3Maroon
    jal resetEnemy
    continue_main:
    jal drawToken1
    jal drawToken2
    li $t5, 13328         # Initial character X offset
    li $t4, 1000000
    
    la $t1, enemyCounter
    lw $t2, 0($t1)
    li $t3, 0
    sw $t3, enemyCounter
    la $t2, enemyShot
    lw $t4, 0($t2)
    li $t3, 0
    lw $t3, enemyShot
    la $t1, enemyCounter
    lw $t2, 0($t1)
    j main_loop 

 main_loop:
    la $t2, enemyShot
    lw $t4, 0($t2)
    li $t3, 1
    beq $t4, $t3, delete_current_enemy
    lw $t2, enemyCounter
    li $t3, 4 
    ble $t2, $t3, move_enemy_left
    li $t3, 9
    ble $t2, $t3, move_enemy_right
    li $t3, 10
    beq $t2, $t3, resetEnemyCounter
    
    continue_loop:
    jal character
    gravity_check:
    li $t9, 0xffff0000 
    lw $t8, 0($t9)
    beq $t8, 1, keypress_happend

    j main_loop
