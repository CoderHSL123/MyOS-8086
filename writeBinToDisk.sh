#!/bin/bash
########################将二进制文件写入硬盘镜像
##if=FILE：read from FILE instead of stdin
##of=FILE：write to FILE instead of stdout
##bs=BLOCK_SIZE：block size in bytes，配置了输入块大小ibs和输出块大小obs，这两个可以进行单独配置
##count=COUNT：write COUNT blocks，拷贝的块数
##seek=blocks：跳过blocks个块，再开始写入
##conv=notrunc：不截断输出文件，只写入实际数据
dd if=mbr.bin of=myhd60M.img bs=512 count=1 conv=notrunc
