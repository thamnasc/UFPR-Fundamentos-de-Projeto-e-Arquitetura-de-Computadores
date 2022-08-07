# ATENÇAO: o programa abaixo foi mudado para fazer o somatorio
# A funcao somatorio calcula a soma de todos os numeros no intervalo fechado [n1,n2]
# (anteriormente estava "while( i < n2 )" e NAO fazia até o n2)
# agora foi mudado para "while( i <= n2 )" fazendo corretamente até o n2


#Nome do aluno:
#User ID:
#email:

# lab2a.asm
# ------------------------------- CI243 ------------------
# 
# INSTRUCOES:
# Nesse exercicio voce deve gerar codigo de funcoes e
# depois chama-las no programa principal
#
# Essa sera' primeira vez que codificamos para funcoes
# portanto vamos explicar o que deve ser feito:
#
# para DEFINIR uma funcao:
# ------------------------
#
# a) para gerar uma funcao basta colocar o 
#     label com o nome da mesma e depois o seu codigo
#
#  b) O retorno da funcao deve ser feito com a instrucao abaixo
#     jr $ra     
#
#  c) pela convencao do processador MIPS
#     SE uma funcao  RETORNA um VALOR esse deve ser colocado em $v0
#     ANTES de se fazer o jr $ra
#
#  d) exemplo, suponha xx uma variavel em memoria,
#     para o comando return( xx ) devemos gerar o codigo a seguir:
#
#     lw $v0, xx         # carrega xx em $v0
#     jr $ra             # retorna
#
# para usar os PARAMETROS dentro das funcoes:
# -------------------------------------------
#
#     Os parametros passados para a funcao estao nos registradores $a0 ate' $a3
#     (entao a funcao pode RECEBER ate' 4 parametros de maneira simples)
#     voce pode usar os valores em $a0 ate' $a3 diretamente dentro 
#     da sua funcao,  assim suponha a funcao:
#
#     int soma( int x, int y ) {
#        x = x + y;
#        return( x );
#     }
#
#     pergunta: dentro da funcao soma onde estah a variavel x ?
#     resposta: no registrador $a0
#
#     pergunta: dentro da funcao soma onde estah a variavel y ?
#     resposta: no registrador $a1
#     
#     pergunta: qual e' o codigo a ser gerado para x = x + y acima ?
#     resposta:
#                add $a0, $a0, $a1    # apenas isso!
#
#     porque? porque as variaveis JA' estao nos registradores $a.
#             NESSE caso, nao e' necessario buscar esses valores da memoria
#             e nem alterar valor em memoria
#
#     pergunta: quem coloca os valores nos registradores $a ?
#     resposta: o codigo que CHAMOU a funcao e' responsavel por colocar
#               os valores corretos nos registradores $a 
#               ( na ordem correta dos parametros $a0 ate' $a4 )
#
#     pergunta: nesse caso qual o codigo para return( x )  ?
#     resposta: como x esta' no registrador $a0, e a funcao deve retorna-lo em $v0
#               devemos gerar:
#                           move $v0, $a0        # move x para $v0
#                           jr $ra               # retorna
#
#
#  para CHAMAR uma funcao:
#  -----------------------
#
#  - passar parametros da funcao nos registradores $a0 ate' $a4
#    (entao podemos PASSAR ate' 4 parametros de maneira simples)
#
#  assim, para chamar a funcao ff( xx, yy, zz ) devemos gerar:
#  lw $a0, xx      # busca xx na memoria e passa para $a0  (PRIMEIRO parametro)
#  lw $a1, yy      # busca yy na memoria e passa para $a1  (SEGUNDO parametro)
#  lw $a2, zz      # busca zz na memoria e passa para $a2  (TERCEIRO parametro)
#  jal ff          # CHAMA a funcao ff
#
# ----------------------------------------------------------------------------------
# AGORA faca as funcoes abaixo e o programa main
#  
#   
#
#    int main( void )
.text
     main:
#    {
.data
#       static int a;
	a: .space 4
#       static int b;
	b: .space 4
#       static int menor;
	menor: .space 4
#       static int maior;
	maior: .space 4
#       static int s;
	s: .space 4
#    
#    
.text
#       a = readInt();
	jal readInt
	sw $v0, a
#       b = readIt();
	jal readInt
	sw $v0, b
#    
#       maior = max( a, b );
	lw $a0, a
	lw $a1, b
	jal max
	sw $v0, maior
#       menor = min( a, b );
	lw $a0, a
	lw $a1, b
	jal min
	sw $v0, menor
#    
#       imprimeInt( menor );
	lw $a0, menor
	jal imprimeInt
#       imprimeChar( '<' );
	li $a0, '<'
	jal imprimeChar
#       imprimeInt( maior );
	lw $a0, maior
	jal imprimeInt
#       imprimechar( '\n' );
	li $a0, '\n'
	jal imprimeChar
#    
#       s = somatorio( menor, maior );
	lw $a0, menor
	lw $a1, maior
	jal somatorio
	sw $v0, s
#       imprimeInt( s );
	lw $a0, s
	jal imprimeInt
#       imprimechar( '\n' ); 
	li $a0, '\n'
	jal imprimeChar
#       
#       exit( 0 );
	li $a0, 0
	jal exit
#    }
#    int min( int a, int b )
.text
     min:
#    {
.data
#       static int m;
	m: .space 4
.text
#        if( a < b )
	 if1:
	     slt $t0, $a0, $a1
	     beq $t0, $0, else1
#          m = a;
	   sw $a0, m
#        else
	 j fimIf1
	 else1:
#          m = b;
	   sw $a1, m
#    
	 fimIf1:
#        return( m );
	 lw $v0, m
	 jr $ra
#    }
#    
#    int max( int a, int b )
.text
     max:
#    {
.data
#       static int mm;
	mm: .space 4
#    
.text
#        if( a > b )
	 if2:
	     sgt $t0, $a0, $a1
	     beq $t0, $0, else2
#          mm = a;
	   sw $a0, mm
#        else
	 j fimIf2
	 else2:
#          mm = b;
	   sw $a1, mm
#    
	 fimIf2:
#        return( mm );
	 lw $v0, mm
	 jr $ra
#    }
#    

# ATENÇAO: 
# A funcao somatorio calcula a soma de todos os numeros no intervalo fechado [n1,n2]
# (anteriormente estava "while( i < n2 )" e NAO fazia até o n2)
# agora foi mudado para "while( i <= n2 )" fazendo corretamente até o n2

#    int somatorio( int n1, int n2 )
.text
     somatorio:
#    {
.data
#       static int ss, i;
	ss: .space 4
	i: .space 4
#    
.text
#        i = n1;
	 sw $a0, i
#        while( i <= n2 ) {
	 while1:
	 	lw $t0, i
	 	sle $t0, $t0, $a1
	 	beq $t0, $0, fimWhile1
#           ss = ss + i;
	    lw $t0, ss
	    lw $t1, i
	    add $t0, $t0, $t1 
	    sw $t0, ss
#           i = i + 1;
	    lw $t0, i
	    add $t0, $t0, 1
	    sw $t0, i
	    j while1
#        }
	 fimWhile1:
#    
#        return( ss );
	 lw $v0, ss
	 jr $ra
#    }
#    
#****************************************************************************#
######### Daqui para baixo temos nossa:                            ###########
#########    biblioteca de FUNCOES de I/O que chamam o SO do MIPS  ###########
######### seus programas DEVEM chamar essas funcoes para fazer I/O ########### 
#****************************************************************************#

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
   