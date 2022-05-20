.MODEL FLAT, C
.CODE                   
Mul_int PROC           
                      ;
                      

 push ebp               ;coloca o endere�o ebp na base
 mov ebp,esp             ;coloca o conte�do do esp em ebp
 
 push esi               ;coloca o endere�o esi na pilha
 push edi               ;coloca o endere�o edi na pilha
 push ebx               ;coloca o endere�o ebx na pilha
                        
 
 mov esi,[ebp+8]        ;origem1, o primeiro par�metro da fun��o
 mov ebx,[ebp+12]       ;origem2, o primeiro par�metro da fun��o
 mov edi,[ebp+16]       ;destino, o terceiro par�metro da fun��o
 mov ecx,[ebp+20]       ;tamanho, o quarto par�metro da fun��o

 shr ecx,2              ;serao processados 4 elementos de cada vez
                         
 
 
 mov edx , 0             ; contador = 0
 
next: cmp edx ,ecx       ;compara os conte�dos de edx com os de ecx      
                        
 je fim                  ;sair do ciclo  caso haja igualidade

 movdqa xmm0,[esi]       ;coloca o conte�do do registro esi no registro xmm0,
                         ;sendo esse registro xmm0 que tem o tamanho 16 bytes = 128 bits

 add esi,16              ;posiciona o ponteiro de esi 16 bytes � frente
 pmulld xmm0,[ebx]       ;multiplica o vector e guarda o resultado no registo xmm0
 add ebx,16              ;posiciona o ponteiro ebx 16 bytes � frente
                         
 movdqa [edi],xmm0       ;Guarda o resultado no ponteiro de destino ([edi])    
                        
 add edi,16              ;posiciona o ponteiro de edi 16 bytes � frente
 inc edx                 ;incrementa o contador
 jmp next                ;salta para proxima instru�ao
 fim:
 pop ebx                ;retirados os 4 bytes  colocados na pilha
 pop edi                
 pop esi                
 pop ebp                ;Restaurar o ebp
 ret                    ;�ltima instru��o na fun��o
 
Mul_int ENDP            ;fim da fun��o
END
