#############################################
#
# Programmer:          peachGeek21
#############################################

#############################################
#
# Pseudo-code:
# ---------------
#  int toBase=8;  // Conversion base 8 (octal).
#  int Num;         // Decimal number; reduced to zero when conversion complete.
#  int Digit;         // An isolated octal digit.
#  int Weight=1;  // Weight of octal digit, based on its position.
#  int Check=0;   // Number reconstructed from its digits.
#
#  cout << "Enter Number to be Converted: "; cin >> Num;
#  cout << "Number = " << Num << endl;
#
#
#  while (Num > 0)
# {
#     Digit = Num % toBase;
#     Num = Num / toBase;
#     cout << "Digit: " << Digit << endl;
#     Check = Digit * Weight + Check;
#     Weight = toBase * Weight;
#  }
#  cout << "Check = " << Check << endl;
#  
#
##############################################

##############################################
#
# Function:             main
# Function label:      main
#
# Variable-Register Assignments
# -----------------------------
# Variable           Value
# -----------      -------
#  Num               $s0
#  Check            $s1             
#  toBase           $s2
#  Digit              $t0
#  Weight           $t1
#  Digit*Weight   $t2
###############################################

.data

toBase:           .word 8
Num:              .word 0
Digit:              .word 0
Weight:           .word 1
Check:            .word 0
endline:           .asciiz  "\n"
Num_Prompt:    .asciiz   "Enter Number to be Converted: "
Num_Label:      .asciiz  "Number = "
Digit_Label:      .asciiz  "Digit: "
Check_Label:    .asciiz  "Check = "
copyright:        .asciiz " (c)  peachGeek21 "

.text
main:


#----------------------------------------------------------------------------------------
#--| Assign Values to Registers
#----------------------------------------------------------------------------------------

              lw $s0, Num               #$s0<==Num = 0
              lw $s1, Check             #$s1<==Check = 0
              lw $s2, toBase            #$s2<==toBase = 8
              lw $t0, Digit                #$t0<==Digit = 0
              lw $t1, Weight            #$t1<==Weight = 1
              addi $s3, $zero, 1        #$s3 = 1
              
#----------------------------------------------------------------------------------------
#--| Prompt user for Num ==> Store Num ==> Print Num
#----------------------------------------------------------------------------------------
 
              li $v0, 4
              la $a0, Num_Prompt
              syscall                       #cout<< "Enter Number to be Converted: ";

              li $v0, 5
              syscall                       #cin>> $s0
              move $s0, $v0

              sw $s0, Num               #Num<== $s0           

              li $v0, 4
              la $a0, endline
              syscall                       #cout>> endl;

              li $v0, 4
              la $a0, Num_Label
              syscall                       #cout<< "Number = "
              
              li $v0, 1
              move $a0, $s0
              syscall                       #cout<< Num

              li $v0, 4
              la $a0, endline
              syscall                       #cout<< endl;
    
#-----------------------------------------------------------------------------------------
#--| Loop: If Num > 0  => Print octal digits ==> Update Check ==> Update Weight 
#-----------------------------------------------------------------------------------------
                           
     Loop:  ble $s0, $zero, EndLoop   #if Num <=0, goto EndLoop
              
              div $s0, $s2                   #Lo = Num / toBase     Hi = Num % toBase
              
              mfhi $t0                       #$t0<== Hi = Num % toBase
              sw $t0, Digit                 #Digit<== $t0 = Num % toBase

              mflo $s0                       #$s0<== Lo = Num / toBase
            #sw $s0, Num                 #Num<== $s0 = Num / toBase      <====Caused issues when running the program multiple times
              
              li $v0, 4                     
              la $a0, Digit_Label
              syscall                         #cout<< "Digit: "

              li $v0, 1                     
              move $a0, $t0
              syscall                        #cout<< Digit
             
              li $v0, 4
              la $a0, endline
              syscall                        #cout<< endl;

              mult $t0, $t1              #Lo = Digit*Weight
              mflo $t2                    #$t2 <== Lo = Digit*Weight
              add $s1, $t2, $s1        #$s1 = Digit*Weight + Check
             #sw $s1, Check           #Check = Digit*Weight + Check      <====Caused issues when running the program multiple times

              mult $s2, $t1              #Hi = toBase*Weight
              mflo $t1                     #$s2 <== Lo = toBase*Weight
             #sw $t1, Weight           #Weight = toBase*Weight            <====Caused issues when running the program multiple times
              
              j Loop                        #branch to Loop

#-----------------------------------------------------------------------------------------
#--| EndLoop: Num <= 0 ==> Print Check
#-----------------------------------------------------------------------------------------
 EndLoop:li $v0, 4
              la $a0, Check_Label
              syscall                      #cout<< "Check = "
              
              li $v0, 1                     
              move $a0, $s1
              syscall                      #cout<< Check
     
#------------------------------------------------------------------------------------------
#--| Terminate program with copyright notice
#------------------------------------------------------------------------------------------
     
            li $v0, 4
            la $a0, endline
            syscall                       #cout<< endl;

            li $v0, 4
            la $a0, endline
            syscall                       #cout<< endl;

            li $v0, 4
            la $a0, copyright         # cout << " (c)  peachGeek21 "
            syscall

            li $v0, 4
            la $a0, endline
            syscall                       #cout<< endl;
