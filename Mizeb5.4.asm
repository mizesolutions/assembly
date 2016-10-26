# Brian Mize
# CSCD260
# hmwk5
# 05/17/16

# Task Switching

      .data

tcb0:    .space      116
tcb1:    .space      116
tid:     .space      4
str0:    .asciiz     "task 0 running..."
str1:    .asciiz     "task 1 running..."
nl:      .asciiz     "\n"
exit:    .asciiz     "<<-- EXIT -->>"
str2:    .asciiz     " "

      .text
      .globl main

main:

      la    $a0, task0         # load address of task0 into reg a0
      la    $a1, task1         # load address of task1 into reg a1
      la    $t0, tcb0          # load address of tcb0 into reg t0
      la    $t1, tcb1          # load address of tcb1 into reg t1
      
      sw    $a0, 92($t0)       # store reg a0 to 92($t0), tcb0[24] = task0
      sw    $a1, 92($t1)       # store reg a1 to 92($t1), tcb1[24] = task1
      
      la    $a1, tid           # load addresss of tid into reg a1
      sw    $0, 0($a1)         # store 0 into tid
      
      j     task0              # jump to task0 label
      
                               # Prints new line to add space to displayed output
      la    $a0, nl            # load addresss of nl into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0 
      syscall                  # execute instructions to print string
      
                               # Prints EXIT to output
      la    $a0, exit          # load addresss of nl into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0 
      syscall                  # execute instructions to print string
      
      addi  $v0, $0, 10        # load exit instructions to reg v0
      syscall                  # execute instructions to exit
            
ts:
                               # Moving address of tcb0 to the stack
      addi  $sp, $sp, -4       # move stack pointer 4 bytes, prep for writing
      sw    $t0, 0($sp)        # store address in reg a1 to the stack 0($sp)
      
      la    $t0, tid           # load address of tid to reg t0
      lw    $t0, 0($t0)        # load value of t0 into t0
      
      beq   $t0, $0 zerorun    # if t0 == 0 jump to label zerorun
      
                               # Saving task1
      la    $t0, tcb1          # load address of tcb1 into reg t0
      
      sw    $v0,   0($t0)      # store value in reg v0 to   0($t0), tcb1[0]
      sw    $v1,   4($t0)      # store value in reg v1 to   4($t0), tcb1[1]
      sw    $a0,   8($t0)      # store value in reg a0 to   8($t0), tcb1[2]
      sw    $a1,  12($t0)      # store value in reg a1 to  12($t0), tcb1[3]
      sw    $a2,  16($t0)      # store value in reg a2 to  16($t0), tcb1[4]
      sw    $a3,  20($t0)      # store value in reg a3 to  20($t0), tcb1[5]
      sw    $t1,  24($t0)      # store value in reg t1 to  24($t0), tcb1[6]
      sw    $t2,  28($t0)      # store value in reg t2 to  28($t0), tcb1[7]
      sw    $t3,  32($t0)      # store value in reg t3 to  32($t0), tcb1[8]
      sw    $t4,  36($t0)      # store value in reg t4 to  36($t0), tcb1[9]
      sw    $t5,  40($t0)      # store value in reg t5 to  40($t0), tcb1[10]
      sw    $t6,  44($t0)      # store value in reg t6 to  44($t0), tcb1[11]
      sw    $t7,  48($t0)      # store value in reg t7 to  48($t0), tcb1[12]
      sw    $s0,  52($t0)      # store value in reg s0 to  52($t0), tcb1[13]
      sw    $s1,  56($t0)      # store value in reg s1 to  56($t0), tcb1[14]
      sw    $s2,  60($t0)      # store value in reg s2 to  60($t0), tcb1[15]
      sw    $s3,  64($t0)      # store value in reg s3 to  64($t0), tcb1[16]
      sw    $s4,  68($t0)      # store value in reg s4 to  68($t0), tcb1[17]
      sw    $s5,  72($t0)      # store value in reg s5 to  72($t0), tcb1[18]
      sw    $s6,  76($t0)      # store value in reg s6 to  76($t0), tcb1[19]
      sw    $s7,  80($t0)      # store value in reg s7 to  80($t0), tcb1[20]
      sw    $t8,  84($t0)      # store value in reg t8 to  84($t0), tcb1[21]
      sw    $t9,  88($t0)      # store value in reg t9 to  88($t0), tcb1[22]
      sw    $ra,  92($t0)      # store value in reg ra to  92($t0), tcb1[23]
      
                               # Saving t0
      lw    $v0, 0($sp)        # load value of t0 stored in sp to reg v0      
      sw    $v0, 96($t0)       # store value in reg v0 to 96($t0), tcb1[24]
      addi  $sp, $sp, 4        # move stack pointer 4 bytes, prevent memory leak   
      
      la    $t0, tid           # load address of tid to reg t0
      addi  $t1, $0, 0         # add 0 to reg t1
      sw    $t1, 0($t0)        # store value of t1 into t0, switches tid to 0
                              
                               # Restore task0 
      la    $t0, tcb0          # load address of tcb0 into reg t0
      
      lw    $v0,   0($t0)      # load value into reg v0 from   0($t0), tcb0[0]
      lw    $v1,   4($t0)      # load value into reg v1 from   4($t0), tcb0[1]
      lw    $a0,   8($t0)      # load value into reg a0 from   8($t0), tcb0[2]
      lw    $a1,  12($t0)      # load value into reg a1 from  12($t0), tcb0[3]
      lw    $a2,  16($t0)      # load value into reg a2 from  16($t0), tcb0[4]
      lw    $a3,  20($t0)      # load value into reg a3 from  20($t0), tcb0[5]
      lw    $t1,  24($t0)      # load value into reg t1 from  24($t0), tcb0[6]
      lw    $t2,  28($t0)      # load value into reg t2 from  28($t0), tcb0[7]
      lw    $t3,  32($t0)      # load value into reg t3 from  32($t0), tcb0[8]
      lw    $t4,  36($t0)      # load value into reg t4 from  36($t0), tcb0[9]
      lw    $t5,  40($t0)      # load value into reg t5 from  40($t0), tcb0[10]
      lw    $t6,  44($t0)      # load value into reg t6 from  44($t0), tcb0[11]
      lw    $t7,  48($t0)      # load value into reg t7 from  48($t0), tcb0[12]
      lw    $s0,  52($t0)      # load value into reg s0 from  52($t0), tcb0[13]
      lw    $s1,  56($t0)      # load value into reg s1 from  56($t0), tcb0[14]
      lw    $s2,  60($t0)      # load value into reg s2 from  60($t0), tcb0[15]
      lw    $s3,  64($t0)      # load value into reg s3 from  64($t0), tcb0[16]
      lw    $s4,  68($t0)      # load value into reg s4 from  68($t0), tcb0[17]
      lw    $s5,  72($t0)      # load value into reg s5 from  72($t0), tcb0[18]
      lw    $s6,  76($t0)      # load value into reg s6 from  76($t0), tcb0[19]
      lw    $s7,  80($t0)      # load value into reg s7 from  80($t0), tcb0[20]
      lw    $t8,  84($t0)      # load value into reg t8 from  84($t0), tcb0[21]
      lw    $t9,  88($t0)      # load value into reg t9 from  88($t0), tcb0[22]
      lw    $ra,  92($t0)      # load value into reg ra from  92($t0), tcb0[23]
      
                               # Storing value in v0 to stack
      addi  $sp, $sp, -4       # move stack pointer 4 bytes, prep for writing
      sw    $v0, 0($sp)        # store address in reg a1 to the stack 0($sp)
      
      lw    $v0, 96($t0)       # load value in reg v0 to 96($t0), tcb0[24]
      la    $t0, 0($v0)        # load address in v0 to reg t0
      lw    $v0, 0($sp)        # restore v0 from the stack
      
      addi  $sp, $sp, 4        # move stack pointer 4 bytes, prevent memory leak

      jr    $ra                # jump to address in reg ra
      
      
zerorun:
                               # Saving task0
      la    $t0, tcb0          # load address of tcb0 into reg t0  
      
      sw    $v0,   0($t0)      # store value in reg v0 to   0($t0), tcb0[0]
      sw    $v1,   4($t0)      # store value in reg v1 to   4($t0), tcb0[1]
      sw    $a0,   8($t0)      # store value in reg a0 to   8($t0), tcb0[2]
      sw    $a1,  12($t0)      # store value in reg a1 to  12($t0), tcb0[3]
      sw    $a2,  16($t0)      # store value in reg a2 to  16($t0), tcb0[4]
      sw    $a3,  20($t0)      # store value in reg a3 to  20($t0), tcb0[5]
      sw    $t1,  24($t0)      # store value in reg t1 to  24($t0), tcb0[6]
      sw    $t2,  28($t0)      # store value in reg t2 to  28($t0), tcb0[7]
      sw    $t3,  32($t0)      # store value in reg t3 to  32($t0), tcb0[8]
      sw    $t4,  36($t0)      # store value in reg t4 to  36($t0), tcb0[9]
      sw    $t5,  40($t0)      # store value in reg t5 to  40($t0), tcb0[10]
      sw    $t6,  44($t0)      # store value in reg t6 to  44($t0), tcb0[11]
      sw    $t7,  48($t0)      # store value in reg t7 to  48($t0), tcb0[12]
      sw    $s0,  52($t0)      # store value in reg s0 to  52($t0), tcb0[13]
      sw    $s1,  56($t0)      # store value in reg s1 to  56($t0), tcb0[14]
      sw    $s2,  60($t0)      # store value in reg s2 to  60($t0), tcb0[15]
      sw    $s3,  64($t0)      # store value in reg s3 to  64($t0), tcb0[16]
      sw    $s4,  68($t0)      # store value in reg s4 to  68($t0), tcb0[17]
      sw    $s5,  72($t0)      # store value in reg s5 to  72($t0), tcb0[18]
      sw    $s6,  76($t0)      # store value in reg s6 to  76($t0), tcb0[19]
      sw    $s7,  80($t0)      # store value in reg s7 to  80($t0), tcb0[20]
      sw    $t8,  84($t0)      # store value in reg t8 to  84($t0), tcb0[21]
      sw    $t9,  88($t0)      # store value in reg t9 to  88($t0), tcb0[22]
      sw    $ra,  92($t0)      # store value in reg ra to  92($t0), tcb0[23]
      
                               # Saving t0
      lw    $v0, 0($sp)        # load value of t0 stored in sp to reg v0      
      sw    $v0, 96($t0)       # store value in reg v0 to 96($t0), tcb0[24]
      addi  $sp, $sp, 4        # move stack pointer 4 bytes, prevent memory leak  
      
      la    $t0, tid           # load address of tid to reg t0
      addi  $t1, $0, 1         # add 1 to reg t1
      sw    $t1, 0($t0)        # store value of t1 into t0, switches tid to 1
                              
                               # Restore task1 
      la    $t0, tcb1          # load address of tcb1 into reg t0
      
      lw    $v0,   0($t0)      # load value into reg v0 from   0($t0), tcb1[0]
      lw    $v1,   4($t0)      # load value into reg v1 from   4($t0), tcb1[1]
      lw    $a0,   8($t0)      # load value into reg a0 from   8($t0), tcb1[2]
      lw    $a1,  12($t0)      # load value into reg a1 from  12($t0), tcb1[3]
      lw    $a2,  16($t0)      # load value into reg a2 from  16($t0), tcb1[4]
      lw    $a3,  20($t0)      # load value into reg a3 from  20($t0), tcb1[5]
      lw    $t1,  24($t0)      # load value into reg t1 from  24($t0), tcb1[6]
      lw    $t2,  28($t0)      # load value into reg t2 from  28($t0), tcb1[7]
      lw    $t3,  32($t0)      # load value into reg t3 from  32($t0), tcb1[8]
      lw    $t4,  36($t0)      # load value into reg t4 from  36($t0), tcb1[9]
      lw    $t5,  40($t0)      # load value into reg t5 from  40($t0), tcb1[10]
      lw    $t6,  44($t0)      # load value into reg t6 from  44($t0), tcb1[11]
      lw    $t7,  48($t0)      # load value into reg t7 from  48($t0), tcb1[12]
      lw    $s0,  52($t0)      # load value into reg s0 from  52($t0), tcb1[13]
      lw    $s1,  56($t0)      # load value into reg s1 from  56($t0), tcb1[14]
      lw    $s2,  60($t0)      # load value into reg s2 from  60($t0), tcb1[15]
      lw    $s3,  64($t0)      # load value into reg s3 from  64($t0), tcb1[16]
      lw    $s4,  68($t0)      # load value into reg s4 from  68($t0), tcb1[17]
      lw    $s5,  72($t0)      # load value into reg s5 from  72($t0), tcb1[18]
      lw    $s6,  76($t0)      # load value into reg s6 from  76($t0), tcb1[19]
      lw    $s7,  80($t0)      # load value into reg s7 from  80($t0), tcb1[20]
      lw    $t8,  84($t0)      # load value into reg t8 from  84($t0), tcb1[21]
      lw    $t9,  88($t0)      # load value into reg t9 from  88($t0), tcb1[22]
      lw    $ra,  92($t0)      # load value into reg ra from  92($t0), tcb1[23]
      
                               # Storing value in v0 to stack
      addi  $sp, $sp, -4       # move stack pointer 4 bytes, prep for writing
      sw    $v0, 0($sp)        # store address in reg v0 to the stack 0($sp)
      
      lw    $v0, 96($t0)       # load value in reg v0 to 96($t0), tcb1[24]
      la    $t0, 0($v0)        # load address in v0 to reg t0
      lw    $v0, 0($sp)        # restore v0 from the stack
      
      addi  $sp, $sp, 4        # move stack pointer 4 bytes, prevent memory leak 

      jr    $ra                # jump to address in reg ra

# --------------------------------------------------------------------------------


task0:
                               # Prints new line to add space to displayed output
      la    $a0, nl            # load addresss of nl into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0 
      syscall                  # execute instructions to print string
      
                               # Print running task ID
      la    $a0, str0          # load address of str0 into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0
      syscall                  # execute instructions to print string
      
                               # Prints new line to add space to displayed output
      la    $a0, nl            # load addresss of nl into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0 
      syscall                  # execute instructions to print string
      
# --------------------------------------------------------------------------------
# Test Block 0.1
#     Placing numbers into registers before the jump to ts
#     Excluding registers: v0, v1, a0, k0, k1, gp, fp, sp, and ra
# --------------------------------------------------------------------------------

      add   $a1, $0,  4        # add  4 to a1
      add   $a2, $0,  5        # add  5 to a2
      add   $a3, $0,  6        # add  6 to a3
      add   $t1, $0,  7        # add  7 to t1
      add   $t2, $0,  8        # add  8 to t2
      add   $t3, $0,  9        # add  9 to t3
      add   $t4, $0, 10        # add 10 to t4
      add   $t5, $0, 11        # add 11 to t5
      add   $t6, $0, 12        # add 12 to t6
      add   $t7, $0, 13        # add 13 to t7
      add   $s0, $0, 14        # add 14 to s0
      add   $s1, $0, 15        # add 15 to s1
      add   $s2, $0, 16        # add 16 to s2
      add   $s3, $0, 17        # add 17 to s3
      add   $s4, $0, 18        # add 18 to s4
      add   $s5, $0, 19        # add 19 to s5
      add   $s6, $0, 20        # add 20 to s6
      add   $s7, $0, 21        # add 21 to s7
      add   $t8, $0, 22        # add 22 to t8
      add   $t9, $0, 23        # add 23 to t9
      add   $t0, $0, 28        # add 28 to t0
      
                               # Print a1
      add   $a0, $0, $a1       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print a2
      add   $a0, $0, $a2       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print a3
      add   $a0, $0, $a3       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t1
      add   $a0, $0, $t1       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t2
      add   $a0, $0, $t2       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t3
      add   $a0, $0, $t3       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t4
      add   $a0, $0, $t4       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t5
      add   $a0, $0, $t5       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t6
      add   $a0, $0, $t6       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t7
      add   $a0, $0, $t7       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s0
      add   $a0, $0, $s0       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s1
      add   $a0, $0, $s1       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s2
      add   $a0, $0, $s2       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s3
      add   $a0, $0, $s3       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s4
      add   $a0, $0, $s4       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s5
      add   $a0, $0, $s5       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s6
      add   $a0, $0, $s6       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s7
      add   $a0, $0, $s7       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t8
      add   $a0, $0, $t8       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t9
      add   $a0, $0, $t9       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t0
      add   $a0, $0, $t0       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Prints new line to add space to displayed output
      la    $a0, nl            # load addresss of nl into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0 
      syscall                  # execute instructions to print string

      
# --------------------------------------------------------------------------------  
    
      jal   ts                 # jump to ts
      
                               # Prints new line to add space to displayed output
      la    $a0, nl            # load addresss of nl into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0 
      syscall                  # execute instructions to print string
      
                               # Print task ID
      la    $a0, str0          # load address of str0 into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0
      syscall                  # execute instructions to print string
      
                               # Prints new line to add space to displayed output
      la    $a0, nl            # load addresss of nl into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0 
      syscall                  # execute instructions to print string
      
# --------------------------------------------------------------------------------
# Test Block 0.2
#     Printing numbers placed in the registers in previous test block
#     Adding 1 to all the numbers in the registers
# --------------------------------------------------------------------------------

      add   $a1, $a1,  1       # add  1 to a1
      add   $a2, $a2,  1       # add  1 to a2
      add   $a3, $a3,  1       # add  1 to a3
      add   $t1, $t1,  1       # add  1 to t1
      add   $t2, $t2,  1       # add  1 to t2
      add   $t3, $t3,  1       # add  1 to t3
      add   $t4, $t4,  1       # add  1 to t4
      add   $t5, $t5,  1       # add  1 to t5
      add   $t6, $t6,  1       # add  1 to t6
      add   $t7, $t7,  1       # add  1 to t7
      add   $s0, $s0,  1       # add  1 to s0
      add   $s1, $s1,  1       # add  1 to s1
      add   $s2, $s2,  1       # add  1 to s2
      add   $s3, $s3,  1       # add  1 to s3
      add   $s4, $s4,  1       # add  1 to s4
      add   $s5, $s5,  1       # add  1 to s5
      add   $s6, $s6,  1       # add  1 to s6
      add   $s7, $s7,  1       # add  1 to s7
      add   $t8, $t8,  1       # add  1 to t8
      add   $t9, $t9,  1       # add  1 to t9
      add   $t0, $t0,  1       # add  1 to t0
      
                               # Print a1
      add   $a0, $0, $a1       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print a2
      add   $a0, $0, $a2       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print a3
      add   $a0, $0, $a3       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t1
      add   $a0, $0, $t1       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t2
      add   $a0, $0, $t2       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t3
      add   $a0, $0, $t3       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t4
      add   $a0, $0, $t4       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t5
      add   $a0, $0, $t5       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t6
      add   $a0, $0, $t6       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t7
      add   $a0, $0, $t7       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s0
      add   $a0, $0, $s0       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s1
      add   $a0, $0, $s1       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s2
      add   $a0, $0, $s2       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s3
      add   $a0, $0, $s3       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s4
      add   $a0, $0, $s4       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s5
      add   $a0, $0, $s5       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s6
      add   $a0, $0, $s6       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s7
      add   $a0, $0, $s7       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t8
      add   $a0, $0, $t8       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t9
      add   $a0, $0, $t9       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t0
      add   $a0, $0, $t0       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Prints new line to add space to displayed output
      la    $a0, nl            # load addresss of nl into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0 
      syscall                  # execute instructions to print string
      
# --------------------------------------------------------------------------------       
      
      jal   ts                 # jump to ts
      
                               # Prints new line to add space to displayed output
      la    $a0, nl            # load addresss of nl into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0 
      syscall                  # execute instructions to print string
      
                               # Print task ID
      la    $a0, str0          # load address of str0 into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0
      syscall                  # execute instructions to print string
      
                               # Prints new line to add space to displayed output
      la    $a0, nl            # load addresss of nl into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0 
      syscall                  # execute instructions to print string
      
# --------------------------------------------------------------------------------
# Test Block 0.3
#     Printing numbers placed in the registers in previous test block
#     Adding 1 to all the numbers in the registers
# --------------------------------------------------------------------------------
      
      add   $a1, $a1,  1       # add  1 to a1
      add   $a2, $a2,  1       # add  1 to a2
      add   $a3, $a3,  1       # add  1 to a3
      add   $t1, $t1,  1       # add  1 to t1
      add   $t2, $t2,  1       # add  1 to t2
      add   $t3, $t3,  1       # add  1 to t3
      add   $t4, $t4,  1       # add  1 to t4
      add   $t5, $t5,  1       # add  1 to t5
      add   $t6, $t6,  1       # add  1 to t6
      add   $t7, $t7,  1       # add  1 to t7
      add   $s0, $s0,  1       # add  1 to s0
      add   $s1, $s1,  1       # add  1 to s1
      add   $s2, $s2,  1       # add  1 to s2
      add   $s3, $s3,  1       # add  1 to s3
      add   $s4, $s4,  1       # add  1 to s4
      add   $s5, $s5,  1       # add  1 to s5
      add   $s6, $s6,  1       # add  1 to s6
      add   $s7, $s7,  1       # add  1 to s7
      add   $t8, $t8,  1       # add  1 to t8
      add   $t9, $t9,  1       # add  1 to t9
      add   $t0, $t0,  1       # add  1 to t0
      
                               # Print a1
      add   $a0, $0, $a1       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print a2
      add   $a0, $0, $a2       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print a3
      add   $a0, $0, $a3       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t1
      add   $a0, $0, $t1       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t2
      add   $a0, $0, $t2       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t3
      add   $a0, $0, $t3       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t4
      add   $a0, $0, $t4       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t5
      add   $a0, $0, $t5       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t6
      add   $a0, $0, $t6       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t7
      add   $a0, $0, $t7       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s0
      add   $a0, $0, $s0       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s1
      add   $a0, $0, $s1       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s2
      add   $a0, $0, $s2       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s3
      add   $a0, $0, $s3       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s4
      add   $a0, $0, $s4       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s5
      add   $a0, $0, $s5       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s6
      add   $a0, $0, $s6       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s7
      add   $a0, $0, $s7       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions

                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t8
      add   $a0, $0, $t8       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t9
      add   $a0, $0, $t9       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t0
      add   $a0, $0, $t0       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Prints new line to add space to displayed output
      la    $a0, nl            # load addresss of nl into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0 
      syscall                  # execute instructions to print string
      
# --------------------------------------------------------------------------------
      
      jal ts                   # jump to ts

                               # Prints new line to add space to displayed output
      la    $a0, nl            # load addresss of nl into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0 
      syscall                  # execute instructions to print string
      
                               # Print task ID
      la    $a0, str0          # load address of str0 into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0
      syscall                  # execute instructions to print string
      
                               # Prints new line to add space to displayed output
      la    $a0, nl            # load addresss of nl into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0 
      syscall                  # execute instructions to print string
      
# --------------------------------------------------------------------------------
# Test Block 0.4
#     Printing numbers placed in the registers in previous test block
#     Adding 1 to all the numbers in the registers
# --------------------------------------------------------------------------------
      
      add   $a1, $a1,  1       # add  1 to a1
      add   $a2, $a2,  1       # add  1 to a2
      add   $a3, $a3,  1       # add  1 to a3
      add   $t1, $t1,  1       # add  1 to t1
      add   $t2, $t2,  1       # add  1 to t2
      add   $t3, $t3,  1       # add  1 to t3
      add   $t4, $t4,  1       # add  1 to t4
      add   $t5, $t5,  1       # add  1 to t5
      add   $t6, $t6,  1       # add  1 to t6
      add   $t7, $t7,  1       # add  1 to t7
      add   $s0, $s0,  1       # add  1 to s0
      add   $s1, $s1,  1       # add  1 to s1
      add   $s2, $s2,  1       # add  1 to s2
      add   $s3, $s3,  1       # add  1 to s3
      add   $s4, $s4,  1       # add  1 to s4
      add   $s5, $s5,  1       # add  1 to s5
      add   $s6, $s6,  1       # add  1 to s6
      add   $s7, $s7,  1       # add  1 to s7
      add   $t8, $t8,  1       # add  1 to t8
      add   $t9, $t9,  1       # add  1 to t9
      add   $t0, $t0,  1       # add  1 to t0
                              
                               # Print a1
      add   $a0, $0, $a1       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print a2
      add   $a0, $0, $a2       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print a3
      add   $a0, $0, $a3       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t1
      add   $a0, $0, $t1       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t2
      add   $a0, $0, $t2       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t3
      add   $a0, $0, $t3       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t4
      add   $a0, $0, $t4       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t5
      add   $a0, $0, $t5       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t6
      add   $a0, $0, $t6       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t7
      add   $a0, $0, $t7       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s0
      add   $a0, $0, $s0       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s1
      add   $a0, $0, $s1       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s2
      add   $a0, $0, $s2       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s3
      add   $a0, $0, $s3       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s4
      add   $a0, $0, $s4       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s5
      add   $a0, $0, $s5       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s6
      add   $a0, $0, $s6       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s7
      add   $a0, $0, $s7       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions

                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t8
      add   $a0, $0, $t8       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t9
      add   $a0, $0, $t9       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t0
      add   $a0, $0, $t0       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Prints new line to add space to displayed output
      la    $a0, nl            # load addresss of nl into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0 
      syscall                  # execute instructions to print string
      
# --------------------------------------------------------------------------------
      
                               # Prints new line to add space to displayed output
      la    $a0, nl            # load addresss of nl into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0 
      syscall                  # execute instructions to print string
      
                               # Prints EXIT to output
      la    $a0, exit          # load addresss of nl into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0 
      syscall                  # execute instructions to print string
      
      addi  $v0, $0, 10        # load exit instructions to reg v0
      syscall                  # execute instructions to exit
   
         
task1:
      
                               # Prints new line to add space to displayed output
      la    $a0, nl            # load addresss of nl into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0 
      syscall                  # execute instructions to print string
      
                               # Print task ID
      la    $a0, str1          # load address of str1 into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0
      syscall                  # execute instructions to print string
      
                               # Prints new line to add space to displayed output
      la    $a0, nl            # load addresss of nl into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0 
      syscall                  # execute instructions to print string
      
# --------------------------------------------------------------------------------
# Test Block 1.1
#     Placing numbers into registers before the jump to ts
#     Excluding registers: v0, v1, a0, k0, k1, gp, fp, sp, and ra
# --------------------------------------------------------------------------------

      add   $a1, $0,  1        # add  1 to a1
      add   $a2, $0,  2        # add  2 to a2
      add   $a3, $0,  3        # add  3 to a3
      add   $t1, $0,  4        # add  4 to t1
      add   $t2, $0,  5        # add  5 to t2
      add   $t3, $0,  6        # add  6 to t3
      add   $t4, $0,  7        # add  7 to t4
      add   $t5, $0,  8        # add  8 to t5
      add   $t6, $0,  9        # add  9 to t6
      add   $t7, $0, 10        # add 10 to t7
      add   $s0, $0, 11        # add 11 to s0
      add   $s1, $0, 12        # add 12 to s1
      add   $s2, $0, 13        # add 13 to s2
      add   $s3, $0, 14        # add 14 to s3
      add   $s4, $0, 15        # add 15 to s4
      add   $s5, $0, 16        # add 16 to s5
      add   $s6, $0, 17        # add 17 to s6
      add   $s7, $0, 18        # add 18 to s7
      add   $t8, $0, 19        # add 19 to t8
      add   $t9, $0, 20        # add 20 to t9
      add   $t0, $0, 21        # add 21 to t0
      
                               # Print a1
      add   $a0, $0, $a1       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print a2
      add   $a0, $0, $a2       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print a3
      add   $a0, $0, $a3       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t1
      add   $a0, $0, $t1       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t2
      add   $a0, $0, $t2       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t3
      add   $a0, $0, $t3       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t4
      add   $a0, $0, $t4       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t5
      add   $a0, $0, $t5       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t6
      add   $a0, $0, $t6       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t7
      add   $a0, $0, $t7       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s0
      add   $a0, $0, $s0       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s1
      add   $a0, $0, $s1       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s2
      add   $a0, $0, $s2       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s3
      add   $a0, $0, $s3       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s4
      add   $a0, $0, $s4       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s5
      add   $a0, $0, $s5       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s6
      add   $a0, $0, $s6       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s7
      add   $a0, $0, $s7       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions

                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t8
      add   $a0, $0, $t8       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t9
      add   $a0, $0, $t9       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t0
      add   $a0, $0, $t0       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Prints new line to add space to displayed output
      la    $a0, nl            # load addresss of nl into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0 
      syscall                  # execute instructions to print string

      
# --------------------------------------------------------------------------------
      
      jal   ts                 # jump to ts
      
                               # Prints new line to add space to displayed output
      la    $a0, nl            # load addresss of nl into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0 
      syscall                  # execute instructions to print string
      
                               # Print task ID
      la    $a0, str1          # load address of str1 into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0
      syscall                  # execute instructions to print string
      
                               # Prints new line to add space to displayed output
      la    $a0, nl            # load addresss of nl into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0 
      syscall                  # execute instructions to print string
      
# --------------------------------------------------------------------------------
# Test Block 1.2
#     Printing numbers placed in the registers in previous test block
#     Adding 1 to all the numbers in the registers
# --------------------------------------------------------------------------------
      
      add   $a1, $a1,  1       # add  1 to a1
      add   $a2, $a2,  1       # add  1 to a2
      add   $a3, $a3,  1       # add  1 to a3
      add   $t1, $t1,  1       # add  1 to t1
      add   $t2, $t2,  1       # add  1 to t2
      add   $t3, $t3,  1       # add  1 to t3
      add   $t4, $t4,  1       # add  1 to t4
      add   $t5, $t5,  1       # add  1 to t5
      add   $t6, $t6,  1       # add  1 to t6
      add   $t7, $t7,  1       # add  1 to t7
      add   $s0, $s0,  1       # add  1 to s0
      add   $s1, $s1,  1       # add  1 to s1
      add   $s2, $s2,  1       # add  1 to s2
      add   $s3, $s3,  1       # add  1 to s3
      add   $s4, $s4,  1       # add  1 to s4
      add   $s5, $s5,  1       # add  1 to s5
      add   $s6, $s6,  1       # add  1 to s6
      add   $s7, $s7,  1       # add  1 to s7
      add   $t8, $t8,  1       # add  1 to t8
      add   $t9, $t9,  1       # add  1 to t9
      add   $t0, $t0,  1       # add  1 to t0
      
                               # Print a1
      add   $a0, $0, $a1       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print a2
      add   $a0, $0, $a2       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print a3
      add   $a0, $0, $a3       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t1
      add   $a0, $0, $t1       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t2
      add   $a0, $0, $t2       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t3
      add   $a0, $0, $t3       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t4
      add   $a0, $0, $t4       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t5
      add   $a0, $0, $t5       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t6
      add   $a0, $0, $t6       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t7
      add   $a0, $0, $t7       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s0
      add   $a0, $0, $s0       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s1
      add   $a0, $0, $s1       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s2
      add   $a0, $0, $s2       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s3
      add   $a0, $0, $s3       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s4
      add   $a0, $0, $s4       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s5
      add   $a0, $0, $s5       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s6
      add   $a0, $0, $s6       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s7
      add   $a0, $0, $s7       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions

                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t8
      add   $a0, $0, $t8       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t9
      add   $a0, $0, $t9       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t0
      add   $a0, $0, $t0       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Prints new line to add space to displayed output
      la    $a0, nl            # load addresss of nl into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0 
      syscall                  # execute instructions to print string
      
# --------------------------------------------------------------------------------
      
      jal   ts                 # jump to ts
      
                               # Prints new line to add space to displayed output
      la    $a0, nl            # load addresss of nl into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0 
      syscall                  # execute instructions to print string
      
                               # Print task ID
      la    $a0, str1          # load address of str1 into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0
      syscall                  # execute instructions to print string
      
                               # Prints new line to add space to displayed output
      la    $a0, nl            # load addresss of nl into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0 
      syscall                  # execute instructions to print string
      
# --------------------------------------------------------------------------------
# Test Block 1.3
#     Printing numbers placed in the registers in previous test block
#     Adding 1 to all the numbers in the registers
# --------------------------------------------------------------------------------
      
      add   $a1, $a1,  1       # add  1 to a1
      add   $a2, $a2,  1       # add  1 to a2
      add   $a3, $a3,  1       # add  1 to a3
      add   $t1, $t1,  1       # add  1 to t1
      add   $t2, $t2,  1       # add  1 to t2
      add   $t3, $t3,  1       # add  1 to t3
      add   $t4, $t4,  1       # add  1 to t4
      add   $t5, $t5,  1       # add  1 to t5
      add   $t6, $t6,  1       # add  1 to t6
      add   $t7, $t7,  1       # add  1 to t7
      add   $s0, $s0,  1       # add  1 to s0
      add   $s1, $s1,  1       # add  1 to s1
      add   $s2, $s2,  1       # add  1 to s2
      add   $s3, $s3,  1       # add  1 to s3
      add   $s4, $s4,  1       # add  1 to s4
      add   $s5, $s5,  1       # add  1 to s5
      add   $s6, $s6,  1       # add  1 to s6
      add   $s7, $s7,  1       # add  1 to s7
      add   $t8, $t8,  1       # add  1 to t8
      add   $t9, $t9,  1       # add  1 to t9
      add   $t0, $t0,  1       # add  1 to t0
      
                               # Print a1
      add   $a0, $0, $a1       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print a2
      add   $a0, $0, $a2       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print a3
      add   $a0, $0, $a3       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t1
      add   $a0, $0, $t1       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t2
      add   $a0, $0, $t2       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t3
      add   $a0, $0, $t3       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t4
      add   $a0, $0, $t4       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t5
      add   $a0, $0, $t5       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t6
      add   $a0, $0, $t6       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t7
      add   $a0, $0, $t7       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s0
      add   $a0, $0, $s0       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s1
      add   $a0, $0, $s1       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s2
      add   $a0, $0, $s2       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s3
      add   $a0, $0, $s3       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s4
      add   $a0, $0, $s4       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s5
      add   $a0, $0, $s5       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s6
      add   $a0, $0, $s6       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print s7
      add   $a0, $0, $s7       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions

                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t8
      add   $a0, $0, $t8       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t9
      add   $a0, $0, $t9       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Print t0
      add   $a0, $0, $t0       # add a1 to a0 for printing
      addi  $v0, $0, 1         # add print int instructions into v0
      syscall                  # execute print int insturctions
      
                               # Print blank space
      la    $a0, str2          # load address of str2 into a0
      addi  $v0, $0, 4         # add print string instructions to v0
      syscall                  # execute print string instructions
      
                               # Prints new line to add space to displayed output
      la    $a0, nl            # load addresss of nl into reg a0
      addi  $v0, $0, 4         # load print string instructions to reg v0 
      syscall                  # execute instructions to print string
      
# --------------------------------------------------------------------------------
      
      jal   ts                 # jump to ts

      

