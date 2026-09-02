; ***********************MBR程序，负责加载内核加载器，然后跳转到内核加载器
section mbr vstart=0x7c00
    mov ax, cs
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov fs, ax
    mov sp, 0x7c00
    mov ax, 0xB800          ; 显存地址段地址
    mov gs, ax



;;;;;;;;;;;;;清屏;;;;;;;;;;;;;
; 使用0x10 BIOS中断的0x06号子功能清屏
; AH 功能号
; AL 上卷的行数，如果为0则表示清屏
; BH 上卷行属性
; (CL, CH) 窗口左上角的(X, Y)坐标
; (DL, DH) 窗口右下角的(X, Y)坐标

    mov ax, 0x600
    mov bx, 0x700
    mov cx, 0x0000
    mov dx, 0x184F
    int 0x10


;;;;;;;;;;;;;获取光标位置;;;;;;;;;;;;;
; 使用0x10 BIOS中断的0x03号子功能获取光标位置
; 获取光标位置，然后在光标位置出打印字符
    mov ah, 0x03                ; 输入：3号子功能是获取光标位置
    mov bh, 0x00                ; bh存放待获取光标的页号
    int 0x10                    ; 调用中断，获取光标位置，结果ch=光标开始行，cl=光标结束行
                                ;                           dh=光标所在行号，dl=光标所在列号


;;;;;;;;;;;;;;;;;;打印字符串;;;;;;;;;;;;;;;;;;
; 直接使用显存输出字符串
; 输出闪烁背景为绿色，前景为红色的字符串

; 使用循环输出字符串

    mov di, 0x0000
    mov bx, 0           ; 字符串索引
    mov ch, 10101100b
ShowString:
    mov cl, message[bx]
    mov word gs:[di], cx

    add di, 2
    inc bx
    cmp cl, 0x00
    je ShowStringEnd
    jmp ShowString
ShowStringEnd:
    jmp $




;;;;;;;;;;;;;;;;;;  打印字符串结束

    message db "hello, this is hsl's MBR."


    times 510-($-$$) db 0
    db 0x55, 0xAA
