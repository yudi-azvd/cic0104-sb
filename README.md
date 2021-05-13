# Software Básico (CIC0104)
Repositório para a disciplina de Software Básico da Universidade de Brasília. 
Segundo o professor, um nome melhor para a disciplina seria Software de 
Sistemas.

<div style="text-align: center;" >
  <img width="460" src="./.github/sb-big-picture.png">
</div>


## Assembly Intel
É necessário ter o [NASM](https://www.nasm.us/) instalado na sua máquina.


```sh
nasm -f elf program.asm -o program.o
ld -m elf_i386 -o program program.o
```

## Makefile teste
[Makefile](./makefile-teste.md) para um projeto C/C++ com testes unitários com 
dicas adicionais para configurar o VSCode como um ambiente de desenvolvimento.
