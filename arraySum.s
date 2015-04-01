######################################################
#
# Programmer:          	peachGeek21
# File name:           	arraySum.s
# Date:             	Thursday, November 4 2010
#
######################################################

######################################################
#
#  main program pseudo-code:
#
#    1. Compute sum of Array1
#    2. Print array1 label + array1 size + array1 sum
#    3. Compute sum of Array2
#    4. Print array2 label + array2 size + array2 sum
#    5. Compute sum of Array3
#    6. Print array3 label + array3 size + array3 sum
#   
#
######################################################

######################################################
#
# Function:          main
# Function label:    main
#
# Variable-Register Assignments
# -----------------------------
# Variable         Register
# -----------      ----------
#  Sum             $s1
#  size            #s2
#    
######################################################

.data

Sum:           .word -99
size1:         .word 8
Array1:        .word 7,6,5,4,3,2,1,0
size2:         .word 0
Array2:        .word 0
size3:         .word 1
Array3:        .word 1234
Label1:        .asciiz "Array #1: "
Label2:        .asciiz "Array #2: "
Label3:        .asciiz "Array #3: "
SizeLabel:     .asciiz " SIZE = "
SumLabel:      .asciiz "  SUM OF VALUES = "
Space:         .asciiz " "
Endline:       .asciiz "\n"
Copyright:     .asciiz "\n\n (c) peachGeek21 \n\n"
SizePrompt:    .asciiz "\nEnter Array Size: "
ValuePrompt:   .asciiz "\nEnter Value: "

               .text


main:
            #------------------------------------------------------------
            #-| prepCall1: Move variable values to argument registers 
            #-|            expected by arraySum.
            #------------------------------------------------------------

 PrepCall1: la $a1, Array1            # $Val[]<== @ Array1[]
            la $a2, size1             # $a2<== @ size1
                  

            #---------------------------------------------------------------
            #-| callSum: integer value returned by arraySum. 
            #---------------------------------------------------------------
 
 callSum1: jal arraySum            
           move $s1, $a3              # sum <=== return sum from subroutine  
                       
            #---------------------------------------------------------------
            #-| Print: Print array label + array size + array sum
            #---------------------------------------------------------------
 
   Print1:  li $v0, 4
            la $a0, Label1
            syscall                   #"Array #1: "

            li $v0, 4
            la $a0, SizeLabel
            syscall                   #" SIZE = "
            
            li $v0, 1
            move $a0, $a2
            syscall                   #cout<< size
 
            li $v0, 4
            la $a0, SumLabel
            syscall                   #" SUM OF VALUES = "
        
            li $v0, 1
            move $a0, $s1
            syscall                   #cout<< sum

            li $v0, 4
            la $a0, Endline
            syscall                   #cout<< endl;

            #------------------------------------------------------------
            #-| prepCall1: Move variable values to argument registers 
            #-|            expected by arraySum.
            #------------------------------------------------------------

 PrepCall2: la $a1, Array2            # $Val[]<== @ Array1[]
            la $a2, size2             # $a2<== @ size1
                  

            #---------------------------------------------------------------
            #-| callSum: integer value returned by arraySum. 
            #---------------------------------------------------------------
 
  callSum2: jal arraySum            
            move $s1, $a3              # sum <=== return sum from subroutine  
                       
            #---------------------------------------------------------------
            #-| Print
            #---------------------------------------------------------------
 
   Print2:  li $v0, 4
            la $a0, Label2
            syscall                   #"Array #2: "

            li $v0, 4
            la $a0, SizeLabel
            syscall                   #" SIZE = "
            
            li $v0, 1
            move $a0, $a2
            syscall                   #cout<< size
 
            li $v0, 4
            la $a0, SumLabel
            syscall                   #" SUM OF VALUES = "
        
            li $v0, 1
            move $a0, $s1
            syscall                   #cout<< sum
            
            li $v0, 4
            la $a0, Endline
            syscall                   #cout<< endl;

            #------------------------------------------------------------
            #-| prepCall1: Move variable values to argument registers 
            #-|            expected by arraySum.
            #------------------------------------------------------------

 PrepCall3: la $a1, Array3            # $Val[]<== @ Array3[]
            la $a2, size3             # $a2<== @ size3
                  

            #---------------------------------------------------------------
            #-| callSum: integer value returned by arraySum. 
            #---------------------------------------------------------------
 
  callSum3: jal arraySum            
            move $s1, $a3              # sum <=== return sum from subroutine  
            #---------------------------------------------------------------
            #-| Print: Print array label + array size + array sum
            #---------------------------------------------------------------
 
   Print3:  li $v0, 4
            la $a0, Label3
            syscall                   #"Array #3: "

            li $v0, 4
            la $a0, SizeLabel
            syscall                   #" SIZE = "
            
            li $v0, 1
            move $a0, $a2
            syscall                   #cout<< size
 
            li $v0, 4
            la $a0, SumLabel
            syscall                   #" SUM OF VALUES = "
        
            li $v0, 1
            move $a0, $s1
            syscall                   #cout<< sum

            li $v0, 4
            la $a0, Endline
            syscall                   #cout<< endl;
             
          
            #--------------------------------------------------------------
            #--| Exit program after printing copyright notice
            #--------------------------------------------------------------
     
            li $v0, 4
            la $a0, Copyright          
            syscall                    

            li $v0, 10                 # ************************
            syscall                    # Exit/terminate program
                                       # ************************


            #--------------------------------------------------------------
            #--| PLACE SUBROUTINE(s) HERE. 
            #--------------------------------------------------------------

            ###############################################################
            # Function: int arraySum(int Val[], int size)
            #
            # Label:    arraySum
            #--------------------------------------------------------------
            #--| Invocation: sum = arraySum(addr, value);
            #--------------------------------------------------------------
            #--| Register Usage:
            #--|          $a1 -- @ Val[k]
            #--|          $a2 -- size
            #--|          $a3 -- sum
            #--|          $v1 -- Loop counter/subscript, k
            #--|          $t1 -- Val[k] 
            #--------------------------------------------------------------

 arraySum:  li $v1, 0                  # k = 0
            li $a3, 0                  # sum = 0 
            lw $a2, 0($a2)             # $a2<== size(value)

      FOR:  bge $v1, $a2, retSum       # if k >= size(value), goto retLoad
   
    BODY:   lw $t1, 0($a1)             # $t1 = Val[k]
            
            add $a3, $a3, $t1          # sum = sum + Val[k];
         
  UPDATE:   addi $v1, $v1, 1           # k++
            addi $a1, $a1, 4           # @ Val[k+4]
              
      
  goBACK:   j FOR   
     

   retSum:  jr $ra                     # Return.
