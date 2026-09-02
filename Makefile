########################启动bochs########################
bochs:
	@echo "启动bochs"
	sh StartBochs.sh


compileMBR:
	nasm -f bin mbr.S -o mbr.bin



.PHONY: clean
clean:
	@echo "清理"
	rm -f bochs.out
	@echo "清理完成"