.text

# int main() 
# {
main:

.data

#    	static int a, b, c, d, m;
    	a: .space 4
    	b: .space 4
    	c: .space 4
    	d: .space 4
    	m: .space 4

.text

#    	a = readInt();
    	jal readInt
	sw $v0, a

#    	b = readInt();
    	jal readInt
    	sw $v0, b

#    	c = readInt();
    	jal readInt
	sw $v0, c

#    	d = readInt();
    	jal readInt
    	sw $v0, d

#    	m = max( a, b );
    	lw $a0, a #passagem de parâmetro
    	lw $a1, b #passagem de parâmetro
    	jal max #chamada da função
    	sw $v0, m #atribuição do valor da função a "m"

#    	m = max( m, c );
    	lw $a0, m
    	lw $a1, c
    	jal max
    	sw $v0, m

#    	m = max( m, d );
    	lw $a0, m
    	lw $a1, d
    	jal max
    	sw $v0, m

#    imprimeInt( m );
    	lw $a0, m
    	jal imprimeInt

#      exit( 0 );
	li $a0, 0
	jal exit
# }


# int max( int a, int b )
# {
max:

#   static int maior;
.data
	maior: .space 4
		
.text

if1:
#   	if( a > b ) 
	sgt $t0, $a0, $a1
	beq $t0, $0, else1

#      	maior = a;
	sw $a0, maior
	j fimIf1
#   else
else1:
#      maior = b;
	sw $a1, maior

	
fimIf1:
#   	return( maior );
#	prepara o valor de retorno
	lw $v0, maior
	jr $ra
# }


#########  rotina para ler numero inteiro e colocar o valor em $v0
      .text 
readInt:
         li $v0, 5             # numero da funcao readInt
         syscall               # chamar funcao do SO
         jr   $ra              # return

#########  rotina para imprimir numero inteiro que estah em $a0
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


