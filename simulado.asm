# CI243 - UFPR - PROVA 1 - Nota:   (wz)
# Aluno: 
# matricula: 
# Dado o programa C abaixo (em comentarios #) gerar o programa 
#   assemby equivalente do MIPS conforme padroes 
#   de geracao de codigo estudados.
# Gerar apenas a parte relativa ao codigo (parte de dados e
# funcoes de biblioteca ja' foram inseridas abaixo

# IMPORTANTE:
# cada linha do programa foi precedida de comentarios
# assim, DEVEMOS GERAR o programa p1.s (assembly) escrevendo:
#    a) para linha programa em C inserir o 
#        codigo MIPS gerado adequadamente PARA CADA linha
#       ATENCAO: vc deve inserir codigo assembly DEPOIS da linha fonte,
#                em ORDEM, em SEQUENCIA, como no gabarito, caso nao seja seguido
#                pode nao ser possivel seguir seu codigo,
#                sera' descontado ate' 20 pts em caso nao siga essa diretiva.
#    b) MANTER o original em comentarios
#    c) escreva em assembly SEMPRE alinhando na MARGEM ESQUERDA
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

                       ## int main ( )                   // linha 1
                       .text
                          main:
                       ## {                              // linha 2
                       .data
                       ##        static int n, l, c;     // linha 3
                                 n: .space 4
                                 l: .space 4
                                 c: .space 4
                       ##            
                       .text                         
                       ##   n = readInt();   // le numero     // linha 4
                       	    jal readInt
                            sw $v0, n
                       ##                  
                       ##   l = 0;                     // linha 11
                            li $t0, 0
                            sw $t0, l
                       ##   while( l < n ) {           // linha 12
                       	    while1:
                       	          lw $t0, l
                       		  lw $t1, n
                       		  slt $t0, $t0, $t1
                       		  beq $t0, $0, fimWhile1 #compara com falso
                       ##                  
                       ##     c = 0;                   // linha 13
                       	      li $t0, 0
                       	      sw $t0, c
                       ##     while( c < n ) {         // linha 14
                       	      while2:
                       	      	    lw $t0, c
                       		    lw $t1, n
                      		    slt $t0, $t0, $t1
                       		    beq $t0, $0, fimWhile2
                       ##        if( c == (n-1) )         // linha 15 ***
                                 if1:
                                    lw $t0, c
                                    lw $t1, n
                      		    subi $t1, $t1, 1
                       		    seq $t0, $t0, $t1
                       		    beq $t0, $0, else1
                       ##             imprimeInt( 8 );    // linha 16 ***
                        	      li $a0, 8
                       		      jal imprimeInt
                       		      j fimIf1
                       ##        else                     // linha 17 ***
                       		 else1:
                       ##             imprimeInt( meuValor(l,c) );    // linha 18  ***
                       		      lw $a0, l
                       		      lw $a1, c
                       		      jal meuValor
                       		      move $a0, $v0 # passa o retorno de meuValor para o argumento de imprimeInt
                       		      jal imprimeInt                  		      
                       		
                       		 fimIf1:
                       ##        imprimeChar( 32 );                   // linha 19
                       		 li $a0, ' '
                       		 jal imprimeChar
                       ##        c = c + 1;                           // linha 20
                       		 lw $t0, c
                       		 addi $t0, $t0, 1
                       		 sw $t0, c
                       ##     }                        // linha 21
                       		j while2
                       	      fimWhile2:
                       ##                  
                       ##     imprimeChar( 10 );       // linha 22
                       	      li $a0, '\n'
                       	      jal imprimeChar
                       ##     l = l + 1;               // linha 23
                       	      lw $t0, l
                       	      addi $t0, $t0, 1
                       	      sw $t0, l
                       ##   }                          // linha 24
                              j while1
                       	    fimWhile1:
                       ##                     
                       ##        exit (0);             // linha 25                  
                       		 li $a0, 0
                       		 j exit
                       ## }                            // linha 26
                          
     

                       ## funcao  A SER CODIFICADA por voce
                       ## int meuValor( int l, int c )   // linha 27 
                       meuValor:
                       ## {                              // linha 28  
                       .data
                       ##    static int val;      // linha 29  
                       val: .space 4
                       ##
                       .text
                       ##    if( l <= c )         // linha 30 
                             if2:
                       		sle $t0, $a0, $a1
                       		beq $t0, $0, else2
                       ##        val = 1;         // linha 31        
                       		 li $t0, 1
                       		 sw $t0, val
                       		 j fimIf2
                       ##    else                 // linha 32 
                             else2:
                       ##        val = 0;         // linha 33  
                       	         li $t0, 0
                       		 sw $t0, val
                             fimIf2:
                       ##                  
                       ##    return( val );       // linha 34 
                       	     lw $t0, val
                       	     move $v0, $t0
                       	     jr $ra
                       ## }                       // linha 35
  
#########  rotina para ler numero inteiro e colocar o valor em $v0
      .text 
readInt:
         li $v0, 5             # numero da funcao readInt
         syscall               # chamar funcao do SO
         jr   $ra              # return

#########  rotina para imprimir numero inteiro que estah em $a0
imprimeInt: li   $v0, 1           # especifica em $V0 a funcao a ser executada
                                  ## nesse caso a funcao Print Integer 
            syscall               # chama funcao do Sistema Operacional
            jr   $ra              # return
	
#########  rotina para imprimir um caracter que estah em $a0
      .text    
imprimeChar: li   $v0, 11         # especifica em $V0 a funcao a ser executada
                                  ## nesse caso a funcao Print Integer 
            syscall               # chama funcao do Sistema Operacional
            jr   $ra              # return

#########  rotina exit que termina programa com valor passado em  $a0
      .text 
exit:   li   $v0, 10          # system call for exit (especifica termino de programa)
        syscall               # we are out of here.  (chama SO para terminar)   
        #veja que nao tem return visto que o programa termina



