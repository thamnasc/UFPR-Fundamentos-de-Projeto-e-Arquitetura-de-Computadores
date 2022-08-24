# Dado o programa C abaixo gerar o programa assemby equivalente
# do MIPS conforme padroes de geracao de codigo estudados

# cada linha do programa foi precedida de comentarios
# assim, devemos gerar o programa array1.s (assembly) escrevendo:
#    para linha do programa em C inserir o codigo MIPS gerado
#    MANTER o original em comentarios

# // gera e imprime matriz identidade
.text
# int main ( )                            // Linha 1
  main:
.data   
# {      int l;                           // Linha 2
         l: .space 4
#        int c;                           // Linha 3    
         c: .space 4
#        int M[10][10];                   // Linha 4
         M: .space 400 # 4 bytes x 10 linhas x 10 colunas
#
.text
#        for (l=0; l<10; l++)             // Linha 5
         sw $0, l #inicializa l em 0
         for1:
             lw $t0, l
             li $t1, 10
             slt $t0, $t0, $t1
             beq $t0, $t0, fimFor1
#            for (c=0; c<10; c++)         // Linha 6
             sw $0, c #inicializa c em 0
             for2:
                  lw $t0, c
                  li $t1, 10
                  seq $t0, $t0, $t1
                  beq $t0, $0, fimFor2
#                 if( l == c )            // Linha 7
                  if1:
                      lw $t0, l
                      lw $t1, c
                      seq $t0, $t0, $t1
                      beq $t0, $0, else1
#                       M[l][c] = 1;      // Linha 8
                        lw $t0, l
                        mul $t0, $t0, 40 # l x 10 colunas x 4 bytes (stride)
                        lw $t1, c
                        mul $t1, $t1, 4 # c x 4
                        add $t0, $t0, $t1 
                        li $t1, 1
                        sw $t1, M($t0)                        
#                  else                   // Linha 9
                   j fimIf1
                   else1:
#                       M[l][c] = 0;      // Linha 10
                        lw $t0, l
                        mul $t0, $t0, 40 # l x 10 x 4 bytes (stride)
                        lw $t1, c
                        mul $t1, $t1, 4 # c x 4
                        add $t0, $t0, $t1
                        sw $0, M($t0)
                   fimIf1:
#
                  #passo c++
                  lw $t0, c
                  addi $t0, $t0, 1
                  sw $t0, c
                  jal for2
             fimFor2:
#            
             #passo l++
             lw $t0, l
             addi $t0, $t0, 1
             sw $t0, l
             jal for1
         fimFor1:
#        for (l=0; l<10; l++) {           // Linha 11
         sw $0, l
         for3:
              lw $t0, l
              li $t1, 10
              slt $t0, $t0, $t1
              beq $t0, $0, fimFor3
#            for (c=0; c<10; c++) {       // Linha 12
             sw $0, c
             for4:
                  lw $t0, c
                  li $t1, 10
                  slt $t0, $t0, $t1
                  beq $t0, $t0, fimFor4
#                 imprimeInt (M[l][c]);   // Linha 13
                  lw $t0, l
                  mul $t0, $t0, 40
                  lw $t1, c
                  mul $t0, $t0, 4
                  add $t0, $t0, $t1
                  lw $a0, M($t0)
                  jal imprimeInt
#                 imprimeChar (' ');      // Linha 14
                  li $a0, ' '
                  jal imprimeChar

                  #passo c++
                  lw $t0, c
                  addi $t0, $t0, 1
                  sw $t0, c
                  jal for4
#             } // final do terceiro for  // Linha 15
              fimFor4:
#             imprimeChar ('\n');         // Linha 16
	          li $a0, '\n'
	          jal imprimeChar

             #passo l++
             lw $t0, l
             addi $t0, $t0, 1
             sw $t0, l
             jal for3
#        } // final do terceiro for       // Linha 17
         fimFor3:
#
#        exit (0);                        // Linha 18
         move $a0, $0
         jal exit
#}                                        // Linha 19

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
