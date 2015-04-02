#############################################
#
# Programmer:         peachGeek21
#
#############################################

#############################################
#
# Pseudo-code:
# ---------------
#  int Num, Nibble_num, Nibble.
#  int extract, mask, bit_pos.
#  maskbits = 0x000F;
#  cout << "Enter Number: "; cin >> Num;
#  cout << "Enter Desired Nibble [0-7]: "; cin >> Nibble_num;
#
#  cout << "Number = " << Num << endl;
#  cout << "Desired Nibble = " << Nibble_num << endl;
#
# //-| Prepare mask and move to nibble position.
#  nibblemask = 0x00000000 ori 0x000F;
#  bit_pos = 4 * Nibble_num;
#  mask = shift mask left by bit_pos bits
#
#  //-| Apply mask to expose nibble, zero all other bits.
#  extract = num AND mask
#
#  //-| move nibble to low order position:
#  Nibble = shift extract right by bit_pos bits
#  cout << "NIBBLE " << Nibble_num << " = " << Nibble << endl;
#
#
#
##############################################

##############################################
#
# Function:              main
# Function label:       main
#
# Variable-Register Assignments
# -----------------------------
# Variable                 Register
# -----------           ---------
#  Num                       $s0
#  Nibble_num              $s1
#  Nibble                     $s2
#  extract                   $s3
#  mask                      $s4
#  bit_pos                   $s5
#  
#  Value                    Register
# ------------         ----------  
#    4                         $s6      
###############################################

.data

Num:                 .word 0x0000000F
Nibble:               .word 0
Nibble_num:        .word 0
extract:             .word 0
mask:                .word 0x0000000F
bit_pos:             .word 0
Num_Prompt:      .asciiz  "Enter Number: "
Nibble_Prompt:    .asciiz  "Enter Desired Nibble [0-7]: "
Num_Label:         .asciiz  "Number = "
Nibble_Label:       .asciiz  "Desired Nibble = "
NIBBLE:             .asciiz  "NIBBLE "
Equal:                .asciiz " = "
endline:             .asciiz  "\n"
copyright:          .asciiz " (c)  peachGeek21 "

.text
main:

#-----------------------------------
#--| Assign values to registers
#-----------------------------------

              #lw $s0, Num                #$s0<==Num = 0
              #lw $s1, Nibble_num       #$s1<==Nibble_num = 0
              #lw $s2, Nibble              #$s2<==Nibble = 0
              #lw $s3, extract            #$s3<==extract = 0
              lw $s4, mask                 #$s4<==mask = 0x0000000F
              #li $s4, 0x000F
              li $s6, 4

#----------------------------------------------------------------------------------------
#--| Prompt user for Num, Nibble_num==> Read in to registers==> Print Num, Nibble_num
#----------------------------------------------------------------------------------------
 
              li $v0, 4
              la $a0, Num_Prompt
              syscall                       #cout<< "Enter Number: " 

              li $v0, 5
              syscall                       #cin>> Num
              move $s0, $v0             

              li $v0, 4
              la $a0, endline
              syscall                       #cout>> endl;

              li $v0, 4
              la $a0, Nibble_Prompt
              syscall                       #cout<< "Enter Desired Nibble [0-7]: "
              
              li $v0, 5
              syscall
              move $s1, $v0             #cin>> Nibble_num

              li $v0, 4
              la $a0, endline
              syscall                       #cout<< endl;

              li $v0, 4
              la $a0, Num_Label
              syscall                       #cout<< "Number = "
              
              li $v0, 1
              move $a0, $s0             
              syscall                      #cout>> Num

              li $v0, 4
              la $a0, endline
              syscall                       #cout<< endl;
              
              li $v0, 4
              la $a0, endline
              syscall                       #cout>> endl;

              li $v0, 4
              la $a0, Nibble_Label
              syscall                       #cout<< "Desired Nibble = "
              
              li $v0, 1
              move $a0, $s1             
              syscall                       #cout>> Nibble_num

              li $v0, 4
              la $a0, endline
              syscall                       #cout>> endl;
 
               li $v0, 4
               la $a0, endline
               syscall                       #cout<< endl;

#-------------------------------------------------
#--| Prepare mask and move to nibble position
#-------------------------------------------------
                           
              mult $s6, $s1             #Lo = 4*Nibble_num 
              mflo $s5                    #bit_pos <== Lo = 4*Nibble_num
              
              sllv $s4, $s4, $s5        #mask = mask shifted left by bit_pos bits                     

#---------------------------------------------------
#--| Apply mask to expose nibble, zero all other bits
#---------------------------------------------------              

              and $s3, $s0, $s4         #extract = Num and mask

#---------------------------------------------------
#--| Move nibble to low order position
#---------------------------------------------------              
  
               srlv $s2, $s3, $s5         #Nibble= extract shifted right by bit_pos bits     


#---------------------------------------------------
#--| Print Nibble
#---------------------------------------------------       

               li $v0, 4
               la $a0, NIBBLE
               syscall                      #cout<< "NIBBLE "
              
               li $v0, 1
               move $a0, $s1
               syscall                      #cout<< Nibble_num
            
               li $v0, 4
               la $a0, Equal
               syscall                      #cout<< " = "

               li $v0, 1
               move $a0, $s2
               syscall                      #cout<< Nibble

#-----------------------------------------------
#--| Terminate program with copyright notice
#-----------------------------------------------
     
               li $v0, 4
               la $a0, endline
               syscall                       #cout<< endl;

               li $v0, 4
               la $a0, endline
               syscall                       #cout<< endl;

               li $v0, 4
               la $a0, copyright         #cout << " (c)  peachGeek21 "
               syscall
