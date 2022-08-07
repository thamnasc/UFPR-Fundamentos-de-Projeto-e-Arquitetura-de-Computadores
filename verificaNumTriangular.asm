# Enunciado: 
# Um número inteiro positivo é dito triangular se seu valor é o produto de três números naturais consecutivos. 
# Por exemplo, o número 120 é triangular porque 120 = 4 x 5 x 6 . 
# Faça um programa que leia do teclado um número inteiro positivo n e verifique se ele é triangular ou não. 
# Se for, imprima 1 e se não for, imprima 0. 
# Exemplos: 
# Entrada 1: 
# 120 
# Saída Esperada 1: 
# 1 
# Entrada 2: 
# 123 
# Saída Esperada 2: 
# 0 
# Entrada 3: 
# 6 
# Saída Esperada 3: 
# 1 


# int main() 
.text
  main:
# {
.data
# 	static int num;
        num: .space 4
#	
.text
#       num = readInt();
	jal readInt
	sw $v0, num
#
# 	if(verificaNumTriangular(num))
	if1:
	   lw $a0, num
	   jal verificaNumTriangular
	   move $t0, $v0
	   beq $t0, $0, else1
#		imprimeInt(1);
		li $a0, 1
		jal imprimeInt
#	else
	j fimIf1
	else1:
#		imprimeInt(0);
		li $a0, 0
		jal imprimeInt
fimIf1:
#	exit (0);
	li $a0, 0
	jal exit
# } 

# int verificaNumTriangular(num) 
.text
  verificaNumTriangular:
# {
.data
# 	static int n1 = 1, n2 = 2, n3 = 3, tri = 0;
	n1: .word 1
	n2: .word 2
	n3: .word 3
	tri: .word 0
#	
.text
#	while((n1 * n2 * n3) <= num) 
	while1:
	      lw $t0, n1
	      lw $t1, n2
	      lw $t2, n3
	      mul $t0, $t0, $t1
	      mul $t0, $t0, $t2
	      sle $t0, $t0, $a0
	      beq $t0, $0, fimWhile1
#	{
#		if((n1 * n2 * n3) = num) then
		if2:
		   lw $t0, n1
		   lw $t1, n2
		   lw $t2, n3
		   mul $t0, $t0, $t1 # n1 = n1 * n2
		   mul $t0, $t0, $t2 # n1 = n1 * n3
		   seq $t0, $t0, $a0
		   beq $t0, $0, fimIf2
#			return 1;
			li $v0, 1
			jr $ra
		fimIf2:
#		n1 = n1 + 1;
		lw $t0, n1
		addi $t0, $t0, 1
		sw $t0, n1
#		n2 = n2 + 1;
		lw $t0, n2
		addi $t0, $t0, 1
		sw $t0, n2
#		n3 = n3 + 1;
		lw $t0, n3
		addi $t0, $t0, 1
		sw $t0, n3
#	}
	j while1
fimWhile1:
#	
#	return 0;
	li $v0, 0
	jr $ra
#	
# }

#########  rotina para ler numero inteiro e colocar o valor em $v0
      .text 
readInt:
         li $v0, 5             # numero da funcao readInt
         syscall               # chamar funcao do SO
         jr   $ra              # return

#########  rotina para imprimir numero inteiro que estah em $a0
      .text 
imprimeInt: li   $v0, 1           # especifica em $V0 a funcao a ser executada
                                  # nesse caso a funcao Print Integer 
            syscall               # chama funcao do Sistema Operacional
            jr   $ra              # return
	
#########  rotina para imprimir um caracter que estah em $a0
      .text    
imprimeChar: li   $v0, 11         # especifica em $V0 a funcao a ser executada
                                  # nesse caso a funcao Print Integer 
            syscall               # chama funcao do Sistema Operacional
            jr   $ra              # return

#########  rotina exit que termina programa com valor passado em  $a0
      .text 
exit:   li   $v0, 10          # system call for exit (especifica termino de programa)
        syscall               # we are out of here.  (chama SO para terminar)   
        #veja que nao tem return visto que o programa termina
