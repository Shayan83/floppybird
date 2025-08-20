serial_init:
    ; اگه نخواستی از DOS دستور MODE بدی، این رو کال کن:
    ; AH=00h init, DX=0 (COM1), AL=پارامتر 2400,8N1
    mov dx,0              ; COM1
    mov ax,0x00E3         ; 2400bps, 8N1  (E3h = 1110_0011b)
    int 14h
    ret

serial_send:              ; AL = byte
    mov dx,0              ; COM1
    mov ah,1
    int 14h               ; AH bit7=0 یعنی OK
    ret

serial_recv_try:          ; خروجی: CF=1 یعنی چیزی نیست، CF=0 و AL=بایت
    mov dx,0
    mov ah,2
    int 14h               ; اگه چیزی نباشه AH bit7=1
    test ah,80h
    jnz .empty
    clc                   ; success
    ret
.empty:
    stc
    ret
