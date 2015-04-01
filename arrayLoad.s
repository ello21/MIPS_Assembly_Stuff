######################################################
#
# Programmer:         	peachGeek21
# File name:           	arrayLoad.s
# Date:			Thursday, November 4 2010
#
######################################################

######################################################
#
#  main program pseudo-code:
#
#    1. Load Array1 of size 8.
#    2. Load Array2 of size 1.
#    3. Load Array3 of size 0.
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
# Register         Usage
# -----------      --------------------------------
#  $t1             @ Array1, @ Array2, @ Array3
#  $t2             value (size1, size2, size3)
#    
######################################################

.data

SizePrompt:    .asciiz "\nEnter Array Size: "
ValuePrompt:   .asciiz "\nEnter Value: "
size1:         .word 0
Array1:        .space 80
size2:         .word 0
Array2:        .space 80
size3:         .word 0
Array3:        .space 80 
Space:         .asciiz " "
Endline:       .asciiz "\n"
Copyright:     .asciiz "\n\n (c) peachGeek21"
               .text


main:

            #------------------------------------------------------------
            #-| prepCall1: Move variable values to argument registers 
            #-|            expected by arrayLoad.
            #------------------------------------------------------------

PrepCall1:  la $t1, Array1            # $Val[]<== @ Array1[]
            la $t2, size1             # $t2<== @ size1
            la $a1, SizePrompt        # $a1<== @ SizePrompt
            la $a2, ValuePrompt       # $a2<== @ ValPrompt
            
            

            #---------------------------------------------------------------
            #-| callLoad: No values returned by arrayPrint. 
            #---------------------------------------------------------------
 
 callLoad1: jal arrayLoad             # call arrayLoad
            


            #------------------------------------------------------------
            #-| prepCall2: Move variable values to argument registers 
            #-|            expected by arrayLoad.
            #------------------------------------------------------------

PrepCall2:  la $t1, Array2            # $Val[]<== @ Array2[]
            la $t2, size2             # $t2<== @ size2
            la $a1, SizePrompt        # $a1<== @ SizePrompt
            la $a2, ValuePrompt       # $a2<== @ ValPrompt
            

            #---------------------------------------------------------------
            #-| callLoad: No values returned by arrayPrint. 
            #---------------------------------------------------------------
 
 callLoad2: jal arrayLoad             # call arrayLoad


            #------------------------------------------------------------
            #-| prepCall1: Move variable values to argument registers 
            #-|            expected by arrayLoad.
            #------------------------------------------------------------

PrepCall3:  la $t1, Array3            # $t1<== @ Array3[]
            la $t2, size3             # $t2<== @ size3
            la $a1, SizePrompt        # $a1<== @ SizePrompt
            la $a2, ValuePrompt       # $a2<== @ ValPrompt
            
            

            #---------------------------------------------------------------
            #-| callLoad: No values returned by arrayPrint. 
            #---------------------------------------------------------------
 
 callLoad3: jal arrayLoad             # call arrayLoad

          
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
            # Function: void arrayLoad(string SizePrompt, string ValPrompt, 
            #                           int Val[], int & size)
            #
            # Label:    arrayLoad
            #--------------------------------------------------------------
            #--| Invocation: arrayLoad(addr, addr, addr, addr);
            #--------------------------------------------------------------
            #--| Register Usage:
            #--|          $t1 -- @ Val[k]
            #--|          $t2 -- @ size / size (value)
            #--|          $a1 -- @ SizePrompt 
            #--|          $a2 -- @ ValPrompt 
            #--|          $v1 -- Loop counter k
            #--|          
            #--------------------------------------------------------------
arrayLoad:  li $v1, 0                  # Loop counter k = 0
            
            li $v0, 4
            move $a0, $a1
            syscall                    # cout<<"\nEnter Array Size: "

            li $v0, 5
            syscall
            sw $v0, 0($t2)             # cin >> @ size (address);
            move $t2, $v0              # $t2 = size (value)
           
     FOR:   bge $v1, $t2, retLoad      # if k >= size(value), goto retLoad
   
    BODY:   li $v0, 4
            move $a0, $a2
            syscall                    # cout<<"\nEnter Value: "
             
            li $v0, 5
            syscall
            sw $v0, 0($t1)             # cin >> Val[k];

         
  UPDATE:   addi $v1, $v1, 1           # k++
            addi $t1, $t1, 4           # @ Val[k+4]
              
      
  goBACK:   j FOR   


retLoad:    jr $ra                     # Return.
