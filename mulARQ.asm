.MODEL FLAT, C
.CODE                   
Mul_int PROC           
                      ;
                      

 push ebp               ;coloca o endereço ebp na base
 mov ebp,esp             ;coloca o conteúdo do esp em ebp
 
 push esi               ;coloca o endereço esi na pilha
 push edi               ;coloca o endereço edi na pilha
 push ebx               ;coloca o endereço ebx na pilha
                        
 
 mov esi,[ebp+8]        ;origem1, o primeiro parâmetro da função
 mov ebx,[ebp+12]       ;origem2, o primeiro parâmetro da função
 mov edi,[ebp+16]       ;destino, o terceiro parâmetro da função
 mov ecx,[ebp+20]       ;tamanho, o quarto parâmetro da função

 shr ecx,2              ;serao processados 4 elementos de cada vez
                         
 
 
 mov edx , 0             ; contador = 0
 
next: cmp edx ,ecx       ;compara os conteúdos de edx com os de ecx      
                        
 je fim                  ;sair do ciclo  caso haja igualidade

 movdqa xmm0,[esi]       ;coloca o conteúdo do registro esi no registro xmm0,
                         ;sendo esse registro xmm0 que tem o tamanho 16 bytes = 128 bits

 add esi,16              ;posiciona o ponteiro de esi 16 bytes à frente
 pmulld xmm0,[ebx]       ;multiplica o vector e guarda o resultado no registo xmm0
 add ebx,16              ;posiciona o ponteiro ebx 16 bytes à frente
                         
 movdqa [edi],xmm0       ;Guarda o resultado no ponteiro de destino ([edi])    
                        
 add edi,16              ;posiciona o ponteiro de edi 16 bytes à frente
 inc edx                 ;incrementa o contador
 jmp next                ;salta para proxima instruçao
 fim:
 pop ebx                ;retirados os 4 bytes  colocados na pilha
 pop edi                
 pop esi                
 pop ebp                ;Restaurar o ebp
 ret                    ;última instrução na função
 
Mul_int ENDP            ;fim da função
END
