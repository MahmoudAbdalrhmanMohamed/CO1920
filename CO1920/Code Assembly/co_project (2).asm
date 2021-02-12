.data 
	  array: .space 2000000# size of array
	  buffer:.space 2000000
	prompt1: .asciiz "Enter -1 to exit otherwise but int execution will be done: "
	prompt2: .asciiz "Enter The Size Of the Array: \n"
	prompt3: .asciiz "Enter the array type \n 1 to int \n 2 to char: \n"
	prompt4: .asciiz "Enter the array one by one \n"
	prompt5: .asciiz "the first element in array is: \n"
	prompt6: .asciiz "Successful Array Values\n"
	prompt7: .asciiz "Enter The operation you want do\n 1 to selection sort\n 2 to bubble sort\n"
	prompt8: .asciiz "Array before selection sort \n"
	prompt9: .asciiz "\nIf You Want To Search With Binary Search \nPress 1\n"
	prompt10: .asciiz "Enter The Value Of The Element That You Want To Search For\n"
	prompt11: .asciiz "\n------Endded------\n"
	prompt12: .asciiz "Found In Index \n"
	prompt13: .asciiz "Not Found Element\n"
	prompt14: .asciiz "Array after selection sort \n"
	prompt15: .asciiz "Enter the Array all together \n"
	prompt16: .asciiz "Array Before bubble Sort\n"
	prompt17: .asciiz "Array after bubble sort\n"
	newline: .asciiz "\n"
	printTap:.asciiz "\t"
	massege:.asciiz "done"
.text
	
main:
	add $t3, $zero, 0 # i = 0
	li $v0, 4 # to prompt to user 
	la $a0, prompt1
	syscall
	
	li $v0, 5 #to recive from user an integer 
	syscall
	move $t0, $v0 # $t0 is flage
	
	beq $t0 , -1, exit2 #$t0 is the flage
	li $v0, 4
	la $a0, prompt2 # enter size of array
	syscall
	li $v0, 5# to recive from user an integer 
	syscall
	move $t1, $v0# $t1 is size of arrary
	li $v0, 4
	la $a0, prompt3 # enter type of array
	syscall
	li $v0, 5 # to recive from user an integer  
	syscall
	move $t2, $v0 #$t2 is type of array
	addi $s0, $zero, 0#index of the array
	beq $t2, 1, integer # if (type == 1)
		   #end1
	j Char
	
integer:
	beq $t3, $t1, continue # if(i == size of array)
	li $v0, 4 # to print string 
	la $a0, prompt4 # print ("Enter the array one by one \n")
	syscall
	li $v0 , 5 # scan array elements 
	syscall
	move $s1, $v0  # s1=array[i]
	sw $s1, array($s0) # array[s0]=s1
	addi $s0, $s0, 4   # s0 +=4
	addi $t3, $t3, 1   # t3++ (i++)
	j integer
	
continue:
	
	li $v0, 4 # print string
	la $a0, prompt6 # print "Successful Array Values\n"
	syscall
	li $v0, 4 # print string 
	la $a0, prompt7# print"Enter The operation you want do\n 1 to selection sort\n 2 to bubble sort\n" 
	syscall
	li $v0 , 5 # scan integer (op)
	syscall
	move $t4, $v0 # t4=v0
	beq $t4, 1, selection_sort #if (op==1) goto selection_sort
	beq $t4,2,bubble_sort
	j exit
	
selection_sort:
	li $v0, 4       # print string
	la $a0, prompt8 # print "Array before selection sort \n" 
	syscall
	jal print_array 
  	# before function
	jal before_function # to save regeister
	#setting argument
	la   $s0,array
	move $s1,$t1 #s1=size
	jal  Selection_Sort_decimal
	jal  after_function # to retrive registers' values
	
  	li  $v0, 4        # print string
	la  $a0, prompt14 # print "Array after selection sort \n" 
	syscall
	li $v0, 4
	la $a0,newline
	syscall
	
	jal print_array 
	j   search
	
search:
	li $v0, 4       # print string
	la $a0, prompt9 #print "\nIf You Want To Search With Binary Search \nPress 1\n"
	syscall
	li $v0 , 5 #scan integer (flag11)
	syscall
	move $t4, $v0 # t4=v0
	#li $t7,1
	beq $t4, 1, BinarySearch #if flag11==1 go to binary search
	
	j exit
	
BinarySearch:
	# print Enter The Value Of The Element That You Want To Search For\n
	li $v0,4
	la $a0,prompt10
	syscall
	#scan integer (element)
	li $v0 , 5 
	syscall
	# setting argument
	move $s2,$v0 # s2=element
	la   $s0,array
	move $s1,$t1 #s1=size
	jal binary_search_decimal
	
	move $t0,$v0
	bne  $t0,-1,FoundIndex
	j NotFoundIndex
	FoundIndex:
	# print found index in  
	li $v0,4
	la $a0,prompt12
	syscall 
	# print index
	li $v0,1
	move $a0,$t0
	syscall
	j exit 
	
	NotFoundIndex:
	# print notfound
	li $v0,4
	la $a0, prompt13
	syscall 
	j exit

bubble_sort:
	# print "Array Before bubble Sort\n"
	li $v0, 4
	la $a0, prompt16
	syscall
	jal print_array
	jal before_function
	#setting argument
	la $s0,array
	move $s1,$t1 #s1=size
	jal bubble_sort_deciaml	
	jal after_function
	# print "Array after bubble Sort\n"
	li $v0, 4
	la $a0, prompt17
	syscall
	jal print_array
	# print "if you want binary search press 1"
	li $v0, 4
	la $a0, prompt9
	syscall
	#scan integer (flag11)
	li $v0 , 5 
	syscall
	move $t4, $v0 # t4=v0 ,t4=(flag11)
	beq $t4, 1, BinarySearch #if (flag11==1) go to binary search
	
	j exit
	
Char: # array #size =t1
	# print "Enter the array one by one \n"
	li $v0, 4
	la $a0, prompt4
	syscall
	# scan string
	li $v0, 8 
	la $a0,buffer # "save string in buffer"
	move $a1,$t1 # send  string size
	syscall
	# print "Successful Array Values\n"
	li $v0, 4
	la $a0, prompt6
	syscall
	# print "Enter The operation you want do \n 1 to selection sort\n 2 to bubble sort\n "
	li $v0, 4
	la $a0, prompt7
	syscall
	#scan integer (op)
	li $v0 , 5 
	syscall
	move $t2, $v0 # t2=op
	
	beq $t2,1,SelectionChar
	beq $t2,2,BubbleChar
	j exit
	
	SelectionChar:
	# print Array before selection sort\n
	li $v0, 4
	la $a0, prompt8
	syscall
	
	jal print_array_char
	jal before_function
	# setting argument
	#s0=array s1=size s2=ele 
	la   $s0,buffer	#s0=buffer
	move $s1,$t1	#s1=size
	jal Selection_Sort_char
	jal after_function
	# print Array after selection sort
	li $v0, 4
	la $a0, prompt14
	syscall 
	li  $v0,4
	li  $s6,1
	la  $a0,buffer($s6)
	syscall
	li  $v0,4
	la  $a0,newline
	syscall
	#If You Want To Search With Binary Search \nPress 1
	li $v0, 4
	la $a0, prompt9
	syscall
	#scan integer (flag)
	li $v0 , 5 
	syscall
	move $t2,$v0 #t2=flag
	beq $t2,1,BinaryChar
	j exit
	
	
	BubbleChar:
	# print Array Before bubble Sort\n
	li $v0,4
	la $a0,prompt16
	syscall
	li $v0,4
	la $a0,buffer
	syscall
	li $v0,4
	la $a0,newline
	syscall
	jal before_function
	# setting agument
	la   $s0,buffer	#s0=buffer
	move $s1,$t1	#s1=size
	jal bubble_sort_char
	jal after_function
	
	#print "Array after bubble sort\n"
	li $v0,4
	la $a0,prompt17
	syscall
	li  $v0,4
	li  $s6,1
	la  $a0,buffer($s6)
	syscall
	li $v0,4
	la $a0,newline
	syscall
	#If You Want To Search With Binary Search \nPress 1
	li $v0,4
	la $a0,prompt9
	syscall
	#scan integer (flag11)
	li $v0,5
	syscall
	move $t7,$v0
	beq $t7,1,BinaryChar
	j exit
	
	BinaryChar:
	# print Enter The Value Of The Element That You Want To Search For
	li $v0, 4
	la $a0, prompt10 
	syscall
	#getchar
	li $v0,12 
	syscall 
	move $s2,$v0 # bi
	jal before_function
	#setting argument
				#s2=bi
	move $s1,$t1
	subi $s1,$s1,1		#s1=size
	li $s6,1	  		
	la $s0,buffer($s6)	#s0=array
	jal binary_search_char
	jal after_function
	
	move $t2,$v0 #g=t2
	beq $t2,-1,printNotFound
	j printFound
	
	printNotFound:
	# print Not Found Element
	li $v0, 4
	la $a0, prompt13 
	syscall
	j exit
	
	printFound:
	# print Found 
	li $v0, 4
	la $a0, prompt12
	syscall
	li $v0, 1
	move $a0, $t2
	syscall
	j exit
	
	
	
#_____________________Selection_Sort_decimal()____________________________________________
#guide  
#s0=arr
#s1=size
#t0= i 
#s3= &i
#s4=&arr2
#s5=program counter to return to main
#t2=arr[m]
#t3=arr2[m]
Selection_Sort_decimal:
	# decalre and initialize i 
  	addi $sp,$sp,-4    # free space for i
  	li   $t7,0       
  	sw   $t7,($sp)  # i=0 
  	la   $s3,($sp)  # s3=&i
  	# declare local array2
  	mul  $t1,$s1,-4    # t1 = Array size* -4 
  	add  $sp,$sp,$t1   # free space for array 2
  	la   $t3,0($sp)    # t3 = &arr2[size]
  	# s4 = &arr2[size]-size*4 
  	add  $s4,$t3,$t1 # s4 = &arr2
  	move $s5,$ra  # s5=return address to main
  	for_1 :
  	  lw   $t0,($s3) #t0=i
  	  slt  $t7,$t0,$s1#(i<size_arr) ? t7=1:t7=0
  	  beqz $t7,exit_for1
  	 
  	   #In Loop
  	  #clear v1 to receive data,you can set it -1 
  	  #and check after calling function it still -1 or not 
  	  #if it equal -1 then it have error  
  	  move $v1,$zero 
  	  jal  min_selection_sort
  	  
  	  # reload i again in t0 because it may be changed in function
  	  lw   $t0,($s3) 
  	  mul  $t7,$t0,4#t7=i*4
  	  # store the return value from min_selection in arr2[i]
  	  add  $t5,$s4,$t7 #t5=&arr2+i*4
  	  sw   $v1,($t5) 
  	  #i++ 
  	  addi $t0,$t0,1 
  	  sw   $t0,($s3)
  	  j    for_1
  	exit_for1:
  	#j exit_for2
  	move $t0,$zero # m=0
  	for_2:
  	  slt  $t7,$t0,$s1 # (m<size)? t7=1:t7=0
  	  beqz $t7,exit_for2
  	  #IN Loop
  	  mul  $t5,$t0,4    # t5 = m*4
  	  add  $t7,$s4,$t5  # t7 = &arr2+m*4
  	  lw   $t3,($t7)    # t3 = arr2[m]
  	  add  $t2,$t5,$s0  # t2 = &arr[m]
  	  sw   $t3,($t2)    #store t3 in &arr[m]>>>>arr[m]=arr2[m]
  	  # m++
  	  addi $t0,$t0,1
  	  j for_2
  	exit_for2:
  	addi $sp,$s3,4
  	move $ra,$s5
  	jr $ra
  	
  	
#___________________________min_selection_sort()_____________________________________
  #guide  
  # s0=array ,s1=size  
  # t0=temp
  # t1=index
  # t2=i
  #t3=arr[i]
  #function return temp in v1
  min_selection_sort:
  	move $t1,$zero # index =0
  	move $t0,$s0   # temp =arr
  	move $t2,$zero # i=0
  	
  	for_min:
  	   slt $t7,$t2,$s1 # i<size ? t7=1:t7=0
  	   
  	   beqz $t7,exit_for_min # if t7=0 go to exit_for_min
  	   # IN loop 
  	    mul  $t3,$t2,4   # t3=i*4
  	    add  $t3,$s0,$t3 # t3=&arr[i]
  	    lw   $t3,($t3)   # t3=arr[i]
  	    slt  $t7,$t3,$t0 # (temp>arr[i]) ? t7=1:t7=0
  	    beqz $t7,exit_if_min
  	    # IN IF
  	      move $t0,$t3 #temp=arr[i]
  	      move $t1,$t2 #index=i    
  	    exit_if_min:
  	    addi $t2,$t2,1 # i++
  	    j for_min
  	exit_for_min:
  	li  $t7,2147483647
  	mul $t1,$t1,4  #t1=index*4
  	add $t1,$s0,$t1#t1=&arr[index]
  	sw  $t7,($t1)  #arr[index]=t7
  	move $v1,$t0
  	jr $ra




#_____________________Selection_Sort_char_____________________________________________
#guide  
#s0=arr
#s1=size
#s3= &i
#s4=&arr2
#s5=program counter to return to main
#t0= i 
#t2=arr[m]
#t3=arr2[m]
#s6=sp
Selection_Sort_char:
	move $s6,$sp
	mul $t0,$s1,4
	sub $sp,$sp,$t0
	#inilize i
	move $t0,$zero
	first_loop_char_cond:
	blt  $t0,$s1,first_loop_char
	j exit_first_loop_char
	
	first_loop_char:
	#&arr4[i]=arr4+i
	add $t2,$s0,$t0
	lb  $t2,($t2)#t2=arr4[i]
	#arr[i]=arr+i*4
	mul $t3,$t0,4
	add $t3,$sp,$t3
	sw  $t2,($t3)#arr[i]=(int)arr4[i];
	
	addi $t0,$t0,1
	j first_loop_char_cond
	
	exit_first_loop_char:
	move $s5,$sp#s5=arr
	# free space for arr2
	mul $t0,$s1,4
	sub $sp,$sp,$t0
	#inilize i
	move $s7,$zero #i=0 
	second_loop_char_cond:
	blt  $s7,$s1,second_loop_char
	j exit_second_loop_char
	second_loop_char:
	# i=s7 ,arr4=s0,arr=s5,arr2=sp,$ra=s4
	move $s3,$s0
	move $s4,$ra
	#setting argument
	move $s0,$s5
	jal min_selection_sort
	# restore Register's data
	#move $s0,$s3
	move $ra,$s4
	move $s0,$s3
	#arr2[i]=arr2+i*4
	mul $t7,$s7,4#i*4
	add $t7,$t7,$sp#t7=&arr2[i]
	sw  $v1,($t7)
	addi $s7,$s7,1#i++
	j second_loop_char_cond
	
	exit_second_loop_char:
	# inilize m
	move $t0,$zero #m=0
	third_loop_char_cond:
	blt  $t0,$s1,third_loop_char
	j exit_third_loop_char
	third_loop_char:
	#arr2[m]
	#arr2+m*4
	mul $t4,$t0,4 #t4=m*4
	add $t5,$sp,$t4#t5=&arr2[m]
	lw  $t5,($t5)#t5=arr2[m]
	#arr4[m]
	#arr4+m
	add $t6,$s0,$t0
	sb  $t5,($t6)
	
	addi $t0,$t0,1
	j third_loop_char_cond
	exit_third_loop_char:
	move $sp,$s6
	jr $ra
#__________________________Bubble_sort_deciaml()______________________________________
  # guide 
  #
  # s0= array , s1=size,
  # t0=temp,
  # t1= m,
  # t2= i
  # t3= size-1
  # t4= arr[i]
  # t5= arr[i+1]
  # t6= &arr[i]
  # s2= &arr[i+1]
  # t7 used in >>> if condition >>>
bubble_sort_deciaml:
  	li $t0,0 # temp =0
  	li $t1,0 # m=0
      for:
  	 # m <size ? t7=1 : t7=0 
  	slt  $t7,$t1,$s1  # if m>size exit
  	beqz $t7,exitloop 
  	li   $t2,0       #i=0
  	sub  $t3,$s1,1   # t3 = size-1
     	  for2:
  	    slt  $t7,$t2,$t3  # if i>size-1 exit
  	    beqz $t7,exitloop2
              mul  $t6,$t2,4     # t6= i*4
              add  $t6,$s0,$t6   # t6= &array[i]
              lw   $t4,($t6)     # t4= array[i]
              addi $s2,$t6,4     # s2=& array[i+1]
              lw   $t5,($s2)     #t5=array[i+1]
  	      # conditon
  	      slt  $t7,$t5,$t4
  	      beqz $t7,exitif
  	        # in if
  	        move  $t0,$t4 
  	        move  $t4,$t5
  	        move  $t5,$t0
  	        sw    $t4,($t6)
  	        sw    $t5,($s2)
  	    exitif:
  	# i++
  	addi $t2,$t2,1
  	j for2
  	exitloop2:
  	# m++
  	addi $t1,$t1,1
  	j for
      exitloop:
      li $v0,4
      la $a0,massege
      jr $ra
      syscall 
      




#_______________________Bubble _sort_char()____________________________________________    
#guide
#s0=arr2
#s1=size
#t0 counter in  loops
#t1 =&arr instack
#t2= arr[counter]
#t3=arr2[counter]
#t4=temp
#t5 = (i) in insted loop 
#t6 = size-1
# $s5 =sp
bubble_sort_char:
	# declare array
	move $s5,$sp
	addi $t1,$sp,1
	sub $sp,$sp,$s1# # free space
	
	# start loop1
	li $t0,0 #i=0
	for_bub_loop1:
	 # if (i<size) go to enter_bub_loop1
	blt  $t0,$s1,enter_bub_loop1
	j exit_bub_loop1
	enter_bub_loop1:
	#prepare arr2[i]
	add $t3,$s0,$t0
	lb  $t3,($t3)
	
	#prepare arr[i]
	add $t2,$sp,$t0
	#assign arr[i]=arr2[i]
	sb   $t3,($t2) 
	addi $t0,$t0,1#i++
	j for_bub_loop1
	exit_bub_loop1:		
		move $t4,$zero # t4=temp=0
		move $t0,$zero # m = 0
		bub_loop2_cond:
		blt  $t0,$s1,enter_bub_loop2# m<size
		j exit_bub_loop2
		enter_bub_loop2:
		move $t5,$zero # i=0
		addi $t6,$s1,-1#t6=size-1
		bub_nest_loop_cond:
		   blt  $t5,$t6,enter_bub_nested_loop # i<size-1	
		   j exit_bub_nested_loop
		   enter_bub_nested_loop:
		   #prepare arr[i+1]
		   add  $t7, $sp,$t5#arr+i
		   addi $t7, $t7,1
		   lb   $t7,($t7) #t7=arr[i+1]
		   #prerpare arr[i]
		   add   $t2, $sp,$t5
		   lb    $t2,($t2)#t2=arr[i]
		   bgt   $t2,$t7,bub_if
		   j exit_bub_if
		   bub_if:
		   move $t4,$t2 #temp=arr[i]
		   #prerpare arr[i]
		   add   $t2, $sp,$t5 #i+arr
		   sb    $t7,($t2)#arr[i]=arr[i+1]
		   #prerpare arr[i+1]
		   addi  $t2, $t2,1
		   sb    $t4,($t2)#arr[i+1]=temp
		   exit_bub_if:
		   addi $t5,$t5,1 #i++
		   j bub_nest_loop_cond
		   exit_bub_nested_loop:
		   addi $t0,$t0,1 # m++
		   j bub_loop2_cond
		  
		  exit_bub_loop2:   
		  move $t0,$zero #j=0
		  bub_loop3_cond:
		  blt $t0,$s1,enter_bub_loop3
		  #move $sp,$t1
		  #addi $sp,$sp,1
		  move $sp,$s5
		  jr $ra
		  enter_bub_loop3:
		  #prepare arr[j]
		   add $t2,$sp,$t0
		   lb  $t2,($t2)
	           #prepare arr2[j]
		  add $t3,$s0,$t0
		  #assign 
		  sb $t2,($t3)	  
		  #test
  		li $v0,1
	move $a0,$t3
	#move $a0,$t2
	syscall
	  li $v0,4
	  la $a0,printTap
	  syscall
		  addi $t0,$t0,1
		  j bub_loop3_cond
		  
		  
		  
		  
		  
		  # convertint char to int
	 	  #if (t3=<57 && t3>=48) t3 will be number else t3 will be char
		  #slti $t7,$t3,58 # (t3<58)? t7=1:t7=0
		  #sgt  $t6,$t3,47 # (47<t3)? t6=1:t6=0
		  #and $t7,$t7,$t6# t7=t7+t6
		  #li  $t6,2 
		   # bne $t7,$t6,exit_if_int #if t7!=2 exit else t3 is number
	 	    #addi $t3,$t3,-48
		  #exit_if_int:
		  #sb   $t3,($t2)  # arr[i]=arr2[i]
		  #addi $t0,$t0,1#i++
		  # print to test 
		 #  li $v0,1
  		  # lb $a0,($t2)
         	   #syscall 
         	   #li $v0,4
  		   #la $a0,printTap
         	   #syscall
		  #j for_bub_loop1
	
		   #in loop
		  
	
	













#binary_search_char:
#ja binary_search_decimal

####################################################################
#                    BinarySearch Decimal
#Guide
#array =s0
#size =s1
#element = s2 
# f = t1
#t2=arr[f]
# t3=i
binary_search_decimal:
	div $t1,$s1,2# f=size/2
	#prepare array[f]
	mul $t2,$t1,4 #4*f
	add $t2,$s0,$t2 # t2=&arra[f]
	lw  $t2,($t2)  # t2=arr[f]
	# if 
	beq $s2,$t2,binary_if #if ele== arr[f]
	# else if 
	bgt $t2,$s2,binary_elif # arr[f]>ele
	# else 
	j binary_else
	
##                 if                 ##	
	binary_if:
	  move $v0,$t1 # return f
	  jr   $ra
	  
	  
##                 Else if            ##
	
	binary_elif:
	  # inilize i
	  subi $t3,$t1,1 # i = f-1
	  
	  binary_elif_loop_cond:
	    bgez $t3,binary_elif_inside_loop # if (i>=0)
	    j exit_binary_elif_loop #  out for 
	    
	    binary_elif_inside_loop:
	    # prepare array[i]
	       mul $t4,$t3,4 # t4=i*4
	       add $t4,$s0,$t4 # t4=arr+i*4
	       lw  $t4,($t4) # t4 = arr[i]
	    #  array[i]=t4 
	       beq $t4,$s2,binary_elif_loop_if #go to in_for_if 
	       
	       subi $t3,$t3,1 #i-- 
	       j binary_elif_loop_cond  
	       
	       binary_elif_loop_if:
	          move $v0,$t3 #return i
	          jr   $ra
	          
	    exit_binary_elif_loop:
	    j exit_binary_if
	    
##                Else                      ##    	    	    
	   binary_else:
	       # inilize i
	       addi $t3,$t1,1 # i =f+1
	       binary_else_loop_cond:
	       
	       blt $t3,$s1,binary_else_inside_loop
	       j exit_else_loop
	       
	       binary_else_inside_loop:
	       # prepare array[i]
	       mul $t4,$t3,4
	       add $t4,$t4,$s0
	       lw  $t4,($t4)
	       # prepare array[i] is completed
	       beq  $t4,$s2,binary_else_loop_if  # in if 
	       
	       addi $t3,$t3,1 # i++
	       j binary_else_loop_cond
	      
	        binary_else_loop_if:
	         move $v0,$t3
	         jr   $ra
	       
	       exit_else_loop:
	        j exit_binary_if
	    exit_binary_if:     
	      li $v0,-1 # return-1
	      jr $ra
	      
	

####################################################################
#                    BinarySearch Decimal
#Guide
#array =s0
#size =s1
#element = s2 
# f = t1
#t2=arr[f]
# t3=i
binary_search_char:
	div $t1,$s1,2# f=size/2
	#prepare array[f]
	mul $t2,$t1,1 #4*f
	add $t2,$s0,$t2 # t2=&arra[f]
	lb  $t2,($t2)  # t2=arr[f]
	# if 
	beq $s2,$t2,binary_if_char #if ele== arr[f]
	# else if 
	bgt $t2,$s2,binary_elif_char # arr[f]>ele
	# else 
	j binary_else_char
	
##                 if                 ##	
	binary_if_char:
	  move $v0,$t1 # return f
	  jr   $ra
	  
	  
##                 Else if            ##
	
	binary_elif_char:
	  # inilize i
	  subi $t3,$t1,1 # i = f-1
	  
	  binary_elif_loop_cond_char:
	    bgez $t3,binary_elif_inside_loop_char # if (i>=0)
	    j exit_binary_elif_loop_char #  out for 
	    
	    binary_elif_inside_loop_char:
	    # prepare array[i]
	       mul $t4,$t3,1 # t4=i*4
	       add $t4,$s0,$t4 # t4=arr+i*4
	       lb  $t4,($t4) # t4 = arr[i]
	    #  array[i]=t4 
	       beq $t4,$s2,binary_elif_loop_if_char #go to in_for_if 
	       
	       subi $t3,$t3,1 #i-- 
	       j binary_elif_loop_cond_char  
	       
	       binary_elif_loop_if_char:
	          move $v0,$t3 #return i
	          jr   $ra
	          
	    exit_binary_elif_loop_char:
	    j exit_binary_if_char
	    
##                Else                      ##    	    	    
	   binary_else_char:
	       # inilize i
	       addi $t3,$t1,1 # i =f+1
	       binary_else_loop_cond_char:
	       
	       blt $t3,$s1,binary_else_inside_loop_char
	       j exit_else_loop_char
	       
	       binary_else_inside_loop_char:
	       # prepare array[i]
	       mul $t4,$t3,1
	       add $t4,$t4,$s0
	       lb  $t4,($t4)
	       # prepare array[i] is completed
	       beq  $t4,$s2,binary_else_loop_if_char  # in if 
	       
	       addi $t3,$t3,1 # i++
	       j binary_else_loop_cond_char
	      
	        binary_else_loop_if_char:
	         move $v0,$t3
	         jr   $ra
	       
	       exit_else_loop_char:
	        j exit_binary_if_char
	    exit_binary_if_char:     
	      li $v0,-1 # return-1
	      jr $ra
	      
	
	
#################################################################
before_function:# array size in t3 
	# save value (s0,s1,s2,s3,s4,s5,t0,t1,t2,t3,t4)in stack
	addi $sp,$sp,-4   # free space for s0
	sw   $s0,0($sp)    # sp=s0
  	addi $sp,$sp,-4   # free space for s1      
  	sw   $s1,0($sp)    # sp=s1
  	addi $sp,$sp,-4   # free space for s2      
  	sw   $s2,0($sp)    # sp=s2
  	addi $sp,$sp,-4   # free space for s3
	sw   $s3,0($sp)    # sp=s3
  	addi $sp,$sp,-4   # free space for s4      
  	sw   $s4,0($sp)    # sp=s4
  	addi $sp,$sp,-4   # free space for s5
	sw   $s5,0($sp)    # sp=s5
  	addi $sp,$sp,-4   # free space for t0      
  	sw   $t0,0($sp)    # sp=t0
	addi $sp,$sp,-4   # free space for t1     
  	sw   $t1,0($sp)    # sp=t1
	addi $sp,$sp,-4   # free space for t2      
  	sw   $t2,0($sp)    # sp=t2
  	addi $sp,$sp,-4   # free space for t3      
  	sw   $t3,0($sp)    # sp=t3
  	addi $sp,$sp,-4   # free space for t4     
  	sw   $t4,0($sp)    # sp=t4
  	jr $ra
 
after_function:
	# retrive value (s0,s1,s2,s3,s4,s5,t0,t1,t2,t3,t4)from stack
	lw   $t4,($sp)  #t4
	addi $sp,$sp,4 
	lw   $t3,($sp)  #t3  
  	addi $sp,$sp,4  
	lw   $t2,($sp)  #t2   
  	addi $sp,$sp,4   
	lw   $t1,($sp)  #t1 
  	addi $sp,$sp,4       
  	lw   $t0,($sp)  #t0
  	addi $sp,$sp,4  
	lw   $s5,($sp)  #s5 
  	addi $sp,$sp,4    
  	lw   $s4,($sp)  #s4
	addi $sp,$sp,4   
  	lw   $s3,($sp)  #s3
  	addi $sp,$sp,4
  	lw   $s2,($sp)  #s2
	addi $sp,$sp,4    
  	lw   $s1,($sp)  #s1
  	addi $sp,$sp,4  
  	lw   $s0,($sp)  #s0
  	jr $ra
  	
  	#######################################
   	#######################################
  	#######################################
  	# Guide array size in t1 #
print_array:
	# p (counter) # array_size # array
	# t4 = p,t1 = array_size ,array=array
	move $t4,$zero # p = 0
	move $s0,$zero # to increase address 
	print_Array_loop:
		bge $t4,$t1,exit_print_Array_#if p>array_size exit
		  li $v0, 1 # print integer
		  lw $a0, array($s0) #  print "array[p]" 
		  syscall
		  li $v0, 4 # print string
		  la $a0,printTap
		  syscall
		  addi $s0,$s0,4 # s0 = next word
		  addi $t4,$t4,1 # p++
		j print_Array_loop
	exit_print_Array_:
	li $v0, 4 # print string
	la $a0, newline # print new line 
	syscall
	jr $ra

print_array_char:
	li $v0, 4 # print string
	la $a0, buffer # print new line 
	syscall
	li $v0, 4 # print string
	la $a0, newline # print new line 
	syscall
	jr $ra
	

exit:
	li $v0, 4
	la $a0, prompt11
	syscall
	j main
exit2:
	li $v0, 4
	la $a0, prompt11
	syscall
	li $v0,10
	syscall
