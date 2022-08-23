
# OBS: Esse exercício é apenas para praticar
#      Não vale nota

# CI243 - UFPR - CopiaVetorReverso - Nota:   (wz)
# Aluno: 
# matricula: 
#
# Dado o programa C abaixo (em comentarios #) gerar o programa 
#   assemby equivalente do MIPS conforme padroes 
#   de geracao de codigo estudados.
# Gerar apenas a parte relativa ao codigo (parte de dados e
# funcoes de biblioteca ja' foram inseridas abaixo

# IMPORTANTE:
# cada linha do programa foi precedida de comentarios
# assim, DEVEMOS GERAR o programa copiaVetorReverso.asm (assembly) escrevendo:
#    a) para linha programa em C inserir o 
#        codigo MIPS gerado adequadamente PARA CADA linha
#    b) MANTER o original em comentarios
#    c) escreva em assembly SEMPRE alinhando na MARGEM ESQUERDA
#    d) NAO MUDE nada nas linhas de comentarios #, 
#       NAO MUDE o ALINHAMENTO  (-5 pts se fizer isso)

# - NAO DELETE nada, nem os comentarios
# - alterar esse arquivo INSERINDO CODIGO assembly entre linhas
# - o numero de cada QUESTAO estah `a direita em comentarios
# - o valor de cada questao esta' ao final desse arquivo
# - seu codigo devera' funcionar mostrando resultados 
#     se voce nao fizer todas as questoes 

# obs1: o numero 32 equivale ao espaco ' ' na tabela ASCII
# obs2: o numero 10 equivale ao \n na tabela ASCII

#       int main ( ) 
.text
        main:
#       {
.data
#          static int A[5];
           A: .space 20 # 5x4 = 20
#          static int Rev[5];
           Rev: .space 20
#          
#          static int i;
           i: .space 4
#          
.text
#          // “Digite o vetor A: “
           sw $0, i #inicializa variável
#          for( i=0; i < 5; i++ ) // leitura do Vetor A
           for1:
                lw $t0, i
                li $t1, 5
                slt $t0, $t0, $t1
                beq $t0, $0, fimFor1
#             A[i] = readInt();
              jal readInt
              lw $t0, i
              mul $t0, $t0, 4
              sw $v0, A($t0)

              #passo
              lw $t0, i
              addi $t0, $t0, 1
              sw $t0, i
              jal for1
            fimFor1:
#             
           sw $0, i
#          // copia A em Rev em ordem reversa (ver SLIDES)
#          for( i=0; i < 5; i++ )
           for2:
                lw $t0, i
                li $t1, 5
                slt $t0, $t0, $t1
                beq $t0, $0, fimFor2
#             Rev[i] = A[5-i-1];   // copia em ordem reversa
              lw $t0, i
              li $t1, 5
              sub $t0, $t1, $t0
              subi $t0, $t0, 1
              mul $t0, $t0, 4
              lw $t0, A($t0)

              lw $t1, i
              mul $t1, $t1, 4
              sw $t0, Rev($t1)

              #passo
              lw $t0, i
              addi $t0, $t0, 1
              sw $t0, i
              
              jal for2
            fimFor2:
#             
           sw $0, i
#          for( i=0; i < 5; i++ ) { // imprime o vetor Rev
           for3:
                lw $t0, i
                li $t1, 5
                slt $t0, $t0, $t1
                beq $t0, $0, fimFor3

#             imprimeInt( Rev[i] );
              lw $t0, i
              mul $t0, $t0, 4
              lw $a0, Rev($t0)
              jal imprimeInt

#             imprimeChar( ' ' );
              li $a0, ' '
              jal imprimeChar

              #passo
              lw $t0, i
              addi $t0, $t0, 1
              sw $t0, i

              jal for3
#          }   
           fimFor3:
#       
#          return 0;
           li $a0, 0
           jal exit
#       } // fim do programa
       
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