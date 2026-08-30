;***********************MBR程序，负责加载内核加载器，然后跳转到内核加载器
section mbr vstart=0x7c00
    mov ax, cs
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov fs, ax
    mov sp, 0x7c00

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

;;;;;;;;;;;;;;;;;;;获取光标位置
; 获取光标位置，然后在光标位置出打印字符
    mov ah, 0x03                ; 输入：3号子功能是获取光标位置
    mov bh, 0x00                ; bh存放待获取光标的页号
    int 0x10                    ; 调用中断，获取光标位置，结果ch=光标开始行，cl=光标结束行
                                ;                           dh=光标所在行号，dl=光标所在列号

;;;;;;;;;;;;;;;;;;;  打印字符串
; 使用0x10 BIOS中断的13号子功能打印字符串
    mov ax, message
    mov bp, ax                  ; es:bp为字符串首地址

    ; 光标位置要用到dx寄存器中的数据，cx中的光标位置可以忽略
    mov cx, 25
    mov ax, 0x1301              ; ah存放子功能号，al设置鞋子福方式，0x01显示字符串，光标跟随移动
    mov bx, 0x2                 ; bh存放待获取光标的页号，bl存放待获取光标的属性字
    int 0x10





;;;;;;;;;;;;;;;;;;  打印字符串结束
    jmp $

    message db "hello, this is hsl's MBR."


    times 510-($-$$) db 0
    db 0x55, 0xAA
