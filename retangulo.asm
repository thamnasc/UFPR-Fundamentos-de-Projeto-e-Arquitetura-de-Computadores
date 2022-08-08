# CI243 - UFPR - LAB2b - Nota:   (wz)
# Aluno: 
# matricula: 
# Dado o programa C abaixo (em comentarios #) gerar o programa 
#   assemby equivalente do MIPS conforme padroes 
#   de geracao de codigo estudados.
# Gerar apenas a parte relativa ao codigo (parte de dados e
# funcoes de biblioteca ja' foram inseridas abaixo

# IMPORTANTE:
# cada linha do programa foi precedida de comentarios
# assim, DEVEMOS GERAR o programa lab2b-solucao.asm (assembly) escrevendo:
#    a) para linha programa em C inserir o 
#        codigo MIPS gerado adequadamente PARA CADA linha
#       ATENCAO: vc deve inserir codigo assembly DEPOIS da linha fonte,
#                em ORDEM, em SEQUENCIA, como no gabarito, caso nao seja seguido
#                pode nao ser possivel seguir seu codigo,
#                sera' descontado ate' 20 pts em caso nao siga essa diretiva.
#    b) MANTER o original em comentarios
#    c) escreva em assembly SEMPRE alinhando na MARGEM ESQUERDA
#       PORQUE? fica mais legivel, 
#            assembly alinha à esquerda, codigo C fica com alinhamento normal
#    d) NAO MUDE nada nas linhas de comentarios ##, 
#       NAO MUDE o ALINHAMENTO  (-10 pts se fizer isso)

# Entrega: somente ESSE arquivo (apenas um arquivo 
#                        com o codigo de TODAS as questoes)
# - NAO DELETE nada, nem os comentarios
# - alterar esse arquivo INSERINDO CODIGO assembly entre linhas
# - o numero de cada QUESTAO estah `a direita em comentarios
# - o valor de cada questao esta' ao final desse arquivo
# - seu codigo devera' funcionar mostrando resultados 
#     mesmo se nao fizer todas as questoes
 

# obs1: o numero 32 equivale ao espaco ' ' na tabela ASCII
# obs2: o numero 10 equivale ao \n na tabela ASCII

#
#// leia h e larg (lados de um retangulo)
#// imprime um retangulo de asteriscos com os lados acima
#
#
#int main()
.text
main:
#{
.data
#    static int h, larg;
     h: .space 4
     larg: .space 4
#    static int l;
     l: .space 4
#
.text
#    h = readInt();
     jal readInt
     sw $v0, h
#    larg = readInt();
     jal readInt
     sw $v0, larg
#
#    l = 0;
     li $t0, 0
     sw $t0, l
     
     #alternativa:
     ####move $t0, $0
     ####sw $t0, l
#    
#    while( l < h ) {
     while1:
            lw $t0, l
            lw $t1, h
            slt $t0, $t0, $t1 #atribui 1 se l < h para $t0, ou atribui
            		      # 0 em $t0 se l > h 
            beq $t0, $0, fimWhile1 # continua no while se a comparação
            			   # com falso ($0) for falsa 
            			   # ou seja, precisa que $t0 contenha
            			   # 1 para que continue no while
#
#       imprimeBrancos( 15 );
        li $a0, 15
        jal imprimeBrancos
#       if( (l == 0) || (l == (h-1)) )
	if1:
	    # l == 0
	    lw $t0, l
	    seq $t0, $t0, $0
	    # l == (h-1)
	    lw $t1, l
	    lw $t2, h
	    subi $t2, $t2, 1 ### h = h-1
	    seq $t1, $t1, $t2 
	    	### && = AND
	    	### || = OR
	    # ||
	    or $t0, $t0, $t1
	    beq $t0, $0, else1 #pula se a comparação do if for falsa
#           imprimeLinhaBeirada( 15, larg, '-' );
	    li $a0, 15
	    lw $a1, larg
	    li $a2, '-'
	    jal imprimeLinhaBeirada
#       else
	j fimIf1
        else1:
#           imprimeLinhaMeio( 15, larg, '|' );
	    li $a0, 15
	    lw $a1, larg
	    li $a2, '|'
	fimIf1:
#
#       l = l + 1;  
	lw $t0, l
	addi $t0, $t0, 1
	sw $t0, l
#       imprimeChar( '\n' );     
	li $a0, '\n'
	jal imprimeChar
	
	j while1 ## volta para a verificação do while
#    }
     fimWhile1:
#
#    exit( 0 );
     li $a0, 0
     ###move $a0, $0 (alternativa)
     jal exit
#}
#
#    void imprimeLinhaMeio( int ini, int larg, char ch )
.text
     imprimeLinhaMeio:
#    {
.data
#      static int c, iniAux;
       c: .space 4
       iniAux: .space 4    
#
.text
#       c = ini;
	sw $a0, c
	# iniAux == ini, mas ini == $a0
	# precisamos fazer isso para liberar o $a0 para imprimeChar
	sw $a0, iniAux
	
#       while( c < (ini+larg) ) {
	while2:
	       lw $t0, c
	       lw $t3, iniAux
	       ### ini+larg
	       add $t1, $t3, $a1
	       slt $t0, $t0, $t1
	       beq $t0, $0, fimWhile2
#         if( (c == ini) || (c == (ini+larg-1)) )
	  if2:
	      ### c == ini
	      lw $t0, c
	      lw $t3, iniAux
	      seq $t0, $t0, $t3 
	      ### c == (ini+larg-1)
	      lw $t3, c
	      lw $t4, iniAux
	      	### ini+larg-1
	      add $t1, $t4, $a1
	      subi $t1, $t1, 1 ### ini+larg-1
	      seq $t1, $t3, $t1
	      ### || (or)
	      or $t0, $t0, $t1 ### compara primeiro seq com segundo seq
	      beq $t0, $0, else2
#           imprimeChar( ch );
	    move $a0, $a2
	    jal imprimeChar
#         else
	  j fimIf2
	  else2:
#            imprimeChar( ' ' );
	     li $a0, ' '
	     jal imprimeChar
          fimIf2:
#         c = c + 1;
	  lw $t0, c
	  addi $t0, $t0, 1
	  sw $t0, c
	  
	  j while2
#       }
	fimWhile2:
#    }
#
#    void imprimeLinhaBeirada( int ini, int larg, char ch )
.text
     imprimeLinhaBeirada:
#    {
.data
#      static int cc;
       cc: .space 4
#      static int iniAuxx;
       iniAuxx: .space 4
#
.text
#       cc = ini; ### ini == $a0
	sw $a0, cc
#	iniAuxx = $a0;
	sw $a0, iniAuxx
	
#       while( cc < (ini+larg) ) {
	while3:
	       lw $t0, cc
	       lw $t1, iniAuxx ### iniAuxx == ini == $a0
	       add $t1, $t1, $a1
	       slt $t0, $t0, $t1
	       beq $t0, $0, fimWhile3
#
#           imprimeChar( ch ); ### ch == $a2
	    move $a0, $a2 ### move o conteúdo de $a2 em $a0
	    jal imprimeChar
#           cc = cc + 1;
	    lw $t0, cc
	    addi $t0, $t0, 1
	    sw $t0, cc
	    
	    j while3
#       }
	fimWhile3:
#    }
#
#    void imprimeBrancos( int ini )
.text
    imprimeBrancos:
     
#    {
.data
#      static int ccc;
       ccc: .space 4
       # static int iniAuxxx;
       iniAuxxx: .space 4
#
.text
#       ccc = 0;
	sw $0, ccc
	# iniAuxxx = $a0
	sw $a0, iniAuxxx
	
#       while( ccc < ini ) {
	while4:
	       lw $t0, ccc
	       lw $t1, iniAuxxx
	       slt $t0, $t0, $t1
	       beq $t0, $0, fimWhile4
#
#           imprimeChar( ' ' );
	    li $a0, ' '
	    jal imprimeChar
#           ccc = ccc + 1;
	    lw $t0, ccc
	    addi $t0, $t0, 1
	    sw $t0, ccc
	    
	    j while4
#       }
	fimWhile4:
#    }
#

.text
#########  rotina para ler numero inteiro e colocar o valor em $v0
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
imprimeChar: li   $v0, 11         # especifica em $V0 a funcao a ser executada
                                  # nesse caso a funcao Print Integer 
            syscall               # chama funcao do Sistema Operacional
            jr   $ra              # return
#########  rotina exit que termina programa com valor passado em  $a0
exit:   li   $v0, 10          # system call for exit (especifica termino de programa)
        syscall               # we are out of here.  (chama SO para terminar)   
         jr   $ra              # return
        #veja que nao tem return visto que o programa termina
#