
caesar.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <main>:
   0:	55                   	push   %rbp
   1:	48 89 e5             	mov    %rsp,%rbp
   4:	be 15 00 00 00       	mov    $0x15,%esi
   9:	48 8d 3d 00 00 00 00 	lea    0x0(%rip),%rdi        # 10 <main+0x10>
  10:	e8 00 00 00 00       	callq  15 <main+0x15>
  15:	b8 00 00 00 00       	mov    $0x0,%eax
  1a:	e8 00 00 00 00       	callq  1f <main+0x1f>
  1f:	be 0c 00 00 00       	mov    $0xc,%esi
  24:	48 8d 3d 00 00 00 00 	lea    0x0(%rip),%rdi        # 2b <main+0x2b>
  2b:	e8 00 00 00 00       	callq  30 <main+0x30>
  30:	b8 00 00 00 00       	mov    $0x0,%eax
  35:	e8 00 00 00 00       	callq  3a <main+0x3a>
  3a:	b8 00 00 00 00       	mov    $0x0,%eax
  3f:	e8 00 00 00 00       	callq  44 <main+0x44>
  44:	b8 00 00 00 00       	mov    $0x0,%eax
  49:	5d                   	pop    %rbp
  4a:	c3                   	retq   

000000000000004b <cipher>:
  4b:	55                   	push   %rbp
  4c:	48 89 e5             	mov    %rsp,%rbp
  4f:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 55 <cipher+0xa>
  55:	89 45 fc             	mov    %eax,-0x4(%rbp)
  58:	90                   	nop
  59:	5d                   	pop    %rbp
  5a:	c3                   	retq   

000000000000005b <print>:
  5b:	55                   	push   %rbp
  5c:	48 89 e5             	mov    %rsp,%rbp
  5f:	48 83 ec 20          	sub    $0x20,%rsp
  63:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  67:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  6a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  6d:	48 63 d0             	movslq %eax,%rdx
  70:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  74:	48 89 c6             	mov    %rax,%rsi
  77:	bf 01 00 00 00       	mov    $0x1,%edi
  7c:	e8 00 00 00 00       	callq  81 <print+0x26>
  81:	89 45 fc             	mov    %eax,-0x4(%rbp)
  84:	90                   	nop
  85:	c9                   	leaveq 
  86:	c3                   	retq   

0000000000000087 <readString>:
  87:	55                   	push   %rbp
  88:	48 89 e5             	mov    %rsp,%rbp
  8b:	48 83 ec 10          	sub    $0x10,%rsp
  8f:	ba 32 00 00 00       	mov    $0x32,%edx
  94:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # 9b <readString+0x14>
  9b:	bf 00 00 00 00       	mov    $0x0,%edi
  a0:	e8 00 00 00 00       	callq  a5 <readString+0x1e>
  a5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  a9:	be 0e 00 00 00       	mov    $0xe,%esi
  ae:	48 8d 3d 00 00 00 00 	lea    0x0(%rip),%rdi        # b5 <readString+0x2e>
  b5:	e8 00 00 00 00       	callq  ba <readString+0x33>
  ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  be:	89 c6                	mov    %eax,%esi
  c0:	48 8d 3d 00 00 00 00 	lea    0x0(%rip),%rdi        # c7 <readString+0x40>
  c7:	e8 00 00 00 00       	callq  cc <readString+0x45>
  cc:	be 01 00 00 00       	mov    $0x1,%esi
  d1:	48 8d 3d 00 00 00 00 	lea    0x0(%rip),%rdi        # d8 <readString+0x51>
  d8:	e8 00 00 00 00       	callq  dd <readString+0x56>
  dd:	90                   	nop
  de:	c9                   	leaveq 
  df:	c3                   	retq   

00000000000000e0 <readRot>:
  e0:	55                   	push   %rbp
  e1:	48 89 e5             	mov    %rsp,%rbp
  e4:	48 83 ec 20          	sub    $0x20,%rsp
  e8:	ba 32 00 00 00       	mov    $0x32,%edx
  ed:	48 8d 35 00 00 00 00 	lea    0x0(%rip),%rsi        # f4 <readRot+0x14>
  f4:	bf 00 00 00 00       	mov    $0x0,%edi
  f9:	e8 00 00 00 00       	callq  fe <readRot+0x1e>
  fe:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 102:	be 0e 00 00 00       	mov    $0xe,%esi
 107:	48 8d 3d 00 00 00 00 	lea    0x0(%rip),%rdi        # 10e <readRot+0x2e>
 10e:	e8 00 00 00 00       	callq  113 <readRot+0x33>
 113:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 117:	89 c6                	mov    %eax,%esi
 119:	48 8d 3d 00 00 00 00 	lea    0x0(%rip),%rdi        # 120 <readRot+0x40>
 120:	e8 00 00 00 00       	callq  125 <readRot+0x45>
 125:	be 01 00 00 00       	mov    $0x1,%esi
 12a:	48 8d 3d 00 00 00 00 	lea    0x0(%rip),%rdi        # 131 <readRot+0x51>
 131:	e8 00 00 00 00       	callq  136 <readRot+0x56>
 136:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
 13d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
 144:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
 14b:	eb 34                	jmp    181 <readRot+0xa1>
 14d:	8b 45 ec             	mov    -0x14(%rbp),%eax
 150:	48 63 d0             	movslq %eax,%rdx
 153:	48 8d 05 00 00 00 00 	lea    0x0(%rip),%rax        # 15a <readRot+0x7a>
 15a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
 15e:	0f be c0             	movsbl %al,%eax
 161:	83 e8 30             	sub    $0x30,%eax
 164:	89 45 f4             	mov    %eax,-0xc(%rbp)
 167:	8b 55 f0             	mov    -0x10(%rbp),%edx
 16a:	89 d0                	mov    %edx,%eax
 16c:	c1 e0 02             	shl    $0x2,%eax
 16f:	01 d0                	add    %edx,%eax
 171:	01 c0                	add    %eax,%eax
 173:	89 c2                	mov    %eax,%edx
 175:	8b 45 f4             	mov    -0xc(%rbp),%eax
 178:	01 d0                	add    %edx,%eax
 17a:	89 45 f0             	mov    %eax,-0x10(%rbp)
 17d:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
 181:	8b 45 ec             	mov    -0x14(%rbp),%eax
 184:	48 98                	cltq   
 186:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
 18a:	48 83 ea 01          	sub    $0x1,%rdx
 18e:	48 39 d0             	cmp    %rdx,%rax
 191:	7c ba                	jl     14d <readRot+0x6d>
 193:	8b 45 f0             	mov    -0x10(%rbp),%eax
 196:	89 05 00 00 00 00    	mov    %eax,0x0(%rip)        # 19c <readRot+0xbc>
 19c:	90                   	nop
 19d:	c9                   	leaveq 
 19e:	c3                   	retq   
