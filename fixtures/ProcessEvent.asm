00000000029efdc0 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent>:
 29efdc0:	48 8b 0d e9 41 a0 01 	mov    rcx,QWORD PTR [rip+0x1a041e9]        # 43f3fb0 <runtime.tlsg@@Base+0x43f3fb0>
 29efdc7:	64 48 8b 09          	mov    rcx,QWORD PTR fs:[rcx]
 29efdcb:	48 8d 84 24 a8 fd ff 	lea    rax,[rsp-0x258]
 29efdd2:	ff 
 29efdd3:	48 3b 41 10          	cmp    rax,QWORD PTR [rcx+0x10]
 29efdd7:	0f 86 d1 15 00 00    	jbe    29f13ae <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x15ee>
 29efddd:	48 81 ec d8 02 00 00 	sub    rsp,0x2d8
 29efde4:	48 89 ac 24 d0 02 00 	mov    QWORD PTR [rsp+0x2d0],rbp
 29efdeb:	00 
 29efdec:	48 8d ac 24 d0 02 00 	lea    rbp,[rsp+0x2d0]
 29efdf3:	00 
 29efdf4:	0f 57 c0             	xorps  xmm0,xmm0
 29efdf7:	48 8d bc 24 90 01 00 	lea    rdi,[rsp+0x190]
 29efdfe:	00 
 29efdff:	48 89 6c 24 f0       	mov    QWORD PTR [rsp-0x10],rbp
 29efe04:	48 8d 6c 24 f0       	lea    rbp,[rsp-0x10]
 29efe09:	e8 73 50 c5 fe       	call   1644e81 <runtime.duffzero+0xd1>
 29efe0e:	48 8b 6d 00          	mov    rbp,QWORD PTR [rbp+0x0]
 29efe12:	0f 57 c0             	xorps  xmm0,xmm0
 29efe15:	0f 11 84 24 60 03 00 	movups XMMWORD PTR [rsp+0x360],xmm0
 29efe1c:	00 
 29efe1d:	48 8b 84 24 e0 02 00 	mov    rax,QWORD PTR [rsp+0x2e0]
 29efe24:	00 
 29efe25:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29efe29:	48 8b 8c 24 e8 02 00 	mov    rcx,QWORD PTR [rsp+0x2e8]
 29efe30:	00 
 29efe31:	48 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],rcx
 29efe36:	48 8b 94 24 f0 02 00 	mov    rdx,QWORD PTR [rsp+0x2f0]
 29efe3d:	00 
 29efe3e:	48 89 54 24 10       	mov    QWORD PTR [rsp+0x10],rdx
 29efe43:	e8 e8 8d fb ff       	call   29a8c30 <github.com/docker/docker/daemon.(*Daemon).GetContainer>
 29efe48:	48 8b 44 24 18       	mov    rax,QWORD PTR [rsp+0x18]
 29efe4d:	48 8b 4c 24 20       	mov    rcx,QWORD PTR [rsp+0x20]
 29efe52:	48 85 c0             	test   rax,rax
 29efe55:	74 09                	je     29efe60 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xa0>
 29efe57:	48 85 c9             	test   rcx,rcx
 29efe5a:	0f 84 ca 00 00 00    	je     29eff2a <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x16a>
 29efe60:	48 8b 84 24 e8 02 00 	mov    rax,QWORD PTR [rsp+0x2e8]
 29efe67:	00 
 29efe68:	48 89 84 24 28 01 00 	mov    QWORD PTR [rsp+0x128],rax
 29efe6f:	00 
 29efe70:	48 8b 84 24 f0 02 00 	mov    rax,QWORD PTR [rsp+0x2f0]
 29efe77:	00 
 29efe78:	48 89 84 24 30 01 00 	mov    QWORD PTR [rsp+0x130],rax
 29efe7f:	00 
 29efe80:	0f 57 c0             	xorps  xmm0,xmm0
 29efe83:	0f 11 84 24 38 01 00 	movups XMMWORD PTR [rsp+0x138],xmm0
 29efe8a:	00 
 29efe8b:	48 8d 05 6e 8a a1 00 	lea    rax,[rip+0xa18a6e]        # 3408900 <type.string>
 29efe92:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29efe96:	48 8d 84 24 28 01 00 	lea    rax,[rsp+0x128]
 29efe9d:	00 
 29efe9e:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
 29efea3:	e8 f8 82 c0 fe       	call   15f81a0 <runtime.convT2Estring>
 29efea8:	48 8b 44 24 18       	mov    rax,QWORD PTR [rsp+0x18]
 29efead:	48 8b 4c 24 10       	mov    rcx,QWORD PTR [rsp+0x10]
 29efeb2:	48 89 8c 24 38 01 00 	mov    QWORD PTR [rsp+0x138],rcx
 29efeb9:	00 
 29efeba:	48 89 84 24 40 01 00 	mov    QWORD PTR [rsp+0x140],rax
 29efec1:	00 
 29efec2:	48 8d 05 44 27 21 00 	lea    rax,[rip+0x212744]        # 2c0260d <go.string.*+0x21aad>
 29efec9:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29efecd:	48 c7 44 24 08 15 00 	mov    QWORD PTR [rsp+0x8],0x15
 29efed4:	00 00 
 29efed6:	48 8d 84 24 38 01 00 	lea    rax,[rsp+0x138]
 29efedd:	00 
 29efede:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
 29efee3:	48 c7 44 24 18 01 00 	mov    QWORD PTR [rsp+0x18],0x1
 29efeea:	00 00 
 29efeec:	48 c7 44 24 20 01 00 	mov    QWORD PTR [rsp+0x20],0x1
 29efef3:	00 00 
 29efef5:	e8 a6 6e cd fe       	call   16c6da0 <fmt.Errorf>
 29efefa:	48 8b 44 24 30       	mov    rax,QWORD PTR [rsp+0x30]
 29efeff:	48 8b 4c 24 28       	mov    rcx,QWORD PTR [rsp+0x28]
 29eff04:	48 89 8c 24 60 03 00 	mov    QWORD PTR [rsp+0x360],rcx
 29eff0b:	00 
 29eff0c:	48 89 84 24 68 03 00 	mov    QWORD PTR [rsp+0x368],rax
 29eff13:	00 
 29eff14:	90                   	nop
 29eff15:	e8 76 46 c2 fe       	call   1614590 <runtime.deferreturn>
 29eff1a:	48 8b ac 24 d0 02 00 	mov    rbp,QWORD PTR [rsp+0x2d0]
 29eff21:	00 
 29eff22:	48 81 c4 d8 02 00 00 	add    rsp,0x2d8
 29eff29:	c3                   	ret    
 29eff2a:	48 89 84 24 b8 00 00 	mov    QWORD PTR [rsp+0xb8],rax
 29eff31:	00 
 29eff32:	48 8b 8c 24 00 03 00 	mov    rcx,QWORD PTR [rsp+0x300]
 29eff39:	00 
 29eff3a:	48 83 f9 04          	cmp    rcx,0x4
 29eff3e:	0f 8d 90 0f 00 00    	jge    29f0ed4 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x1114>
 29eff44:	48 83 f9 03          	cmp    rcx,0x3
 29eff48:	0f 85 75 0f 00 00    	jne    29f0ec3 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x1103>
 29eff4e:	48 8b 94 24 f8 02 00 	mov    rdx,QWORD PTR [rsp+0x2f8]
 29eff55:	00 
 29eff56:	0f b7 1a             	movzx  ebx,WORD PTR [rdx]
 29eff59:	66 81 fb 6f 6f       	cmp    bx,0x6f6f
 29eff5e:	0f 85 56 0f 00 00    	jne    29f0eba <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x10fa>
 29eff64:	0f b6 5a 02          	movzx  ebx,BYTE PTR [rdx+0x2]
 29eff68:	80 fb 6d             	cmp    bl,0x6d
 29eff6b:	0f 84 3b 0e 00 00    	je     29f0dac <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xfec>
 29eff71:	48 83 f9 04          	cmp    rcx,0x4
 29eff75:	0f 85 0a 0b 00 00    	jne    29f0a85 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xcc5>
 29eff7b:	8b 0a                	mov    ecx,DWORD PTR [rdx]
 29eff7d:	81 f9 65 78 69 74    	cmp    ecx,0x74697865
 29eff83:	0f 85 fc 0a 00 00    	jne    29f0a85 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xcc5>
 29eff89:	48 8b 48 08          	mov    rcx,QWORD PTR [rax+0x8]
 29eff8d:	8b 94 24 28 03 00 00 	mov    edx,DWORD PTR [rsp+0x328]
 29eff94:	48 8b 59 10          	mov    rbx,QWORD PTR [rcx+0x10]
 29eff98:	48 39 d3             	cmp    rbx,rdx
 29eff9b:	0f 85 a9 07 00 00    	jne    29f074a <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x98a>
 29effa1:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 29effa5:	e8 f6 d0 c5 fe       	call   164d0a0 <sync.(*Mutex).Lock>
 29effaa:	48 8b 84 24 e0 02 00 	mov    rax,QWORD PTR [rsp+0x2e0]
 29effb1:	00 
 29effb2:	48 8b 88 08 01 00 00 	mov    rcx,QWORD PTR [rax+0x108]
 29effb9:	48 8b 90 10 01 00 00 	mov    rdx,QWORD PTR [rax+0x110]
 29effc0:	48 8b 49 38          	mov    rcx,QWORD PTR [rcx+0x38]
 29effc4:	48 8b 9c 24 b8 00 00 	mov    rbx,QWORD PTR [rsp+0xb8]
 29effcb:	00 
 29effcc:	48 8b 73 48          	mov    rsi,QWORD PTR [rbx+0x48]
 29effd0:	48 8b 7b 40          	mov    rdi,QWORD PTR [rbx+0x40]
 29effd4:	4c 8b 05 5d ae a7 01 	mov    r8,QWORD PTR [rip+0x1a7ae5d]        # 446ae38 <context.background>
 29effdb:	48 89 7c 24 18       	mov    QWORD PTR [rsp+0x18],rdi
 29effe0:	48 89 74 24 20       	mov    QWORD PTR [rsp+0x20],rsi
 29effe5:	48 8d 35 f4 2b e8 00 	lea    rsi,[rip+0xe82bf4]        # 3872be0 <go.itab.*context.emptyCtx,context.Context>
 29effec:	48 89 74 24 08       	mov    QWORD PTR [rsp+0x8],rsi
 29efff1:	4c 89 44 24 10       	mov    QWORD PTR [rsp+0x10],r8
 29efff6:	48 89 14 24          	mov    QWORD PTR [rsp],rdx
 29efffa:	ff d1                	call   rcx
 29efffc:	48 8b 44 24 50       	mov    rax,QWORD PTR [rsp+0x50]
 29f0001:	48 8b 4c 24 48       	mov    rcx,QWORD PTR [rsp+0x48]
 29f0006:	48 8b 94 24 b8 00 00 	mov    rdx,QWORD PTR [rsp+0xb8]
 29f000d:	00 
 29f000e:	48 8d 5a 40          	lea    rbx,[rdx+0x40]
 29f0012:	48 85 c9             	test   rcx,rcx
 29f0015:	0f 85 78 06 00 00    	jne    29f0693 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x8d3>
 29f001b:	48 8b 02             	mov    rax,QWORD PTR [rdx]
 29f001e:	84 00                	test   BYTE PTR [rax],al
 29f0020:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f0024:	e8 d7 e3 c5 fe       	call   164e400 <sync.(*WaitGroup).Wait>
 29f0029:	48 8b 84 24 b8 00 00 	mov    rax,QWORD PTR [rsp+0xb8]
 29f0030:	00 
 29f0031:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f0035:	c6 44 24 08 00       	mov    BYTE PTR [rsp+0x8],0x0
 29f003a:	e8 91 e6 67 ff       	call   206e6d0 <github.com/docker/docker/container.(*Container).Reset>
 29f003f:	48 8d 05 1a 5f c3 00 	lea    rax,[rip+0xc35f1a]        # 3625f60 <type.iPh4Qw+B>
 29f0046:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f004a:	e8 21 ab c0 fe       	call   15fab70 <runtime.newobject>
 29f004f:	48 8b 44 24 08       	mov    rax,QWORD PTR [rsp+0x8]
 29f0054:	48 89 84 24 f8 00 00 	mov    QWORD PTR [rsp+0xf8],rax
 29f005b:	00 
 29f005c:	48 c7 84 24 68 01 00 	mov    QWORD PTR [rsp+0x168],0x0
 29f0063:	00 00 00 00 00 
 29f0068:	0f 57 c0             	xorps  xmm0,xmm0
 29f006b:	0f 11 84 24 70 01 00 	movups XMMWORD PTR [rsp+0x170],xmm0
 29f0072:	00 
 29f0073:	0f 11 84 24 80 01 00 	movups XMMWORD PTR [rsp+0x180],xmm0
 29f007a:	00 
 29f007b:	8b 8c 24 2c 03 00 00 	mov    ecx,DWORD PTR [rsp+0x32c]
 29f0082:	48 89 8c 24 68 01 00 	mov    QWORD PTR [rsp+0x168],rcx
 29f0089:	00 
 29f008a:	48 8b 8c 24 40 03 00 	mov    rcx,QWORD PTR [rsp+0x340]
 29f0091:	00 
 29f0092:	48 8b 94 24 38 03 00 	mov    rdx,QWORD PTR [rsp+0x338]
 29f0099:	00 
 29f009a:	48 8b 9c 24 30 03 00 	mov    rbx,QWORD PTR [rsp+0x330]
 29f00a1:	00 
 29f00a2:	48 89 9c 24 78 01 00 	mov    QWORD PTR [rsp+0x178],rbx
 29f00a9:	00 
 29f00aa:	48 89 94 24 80 01 00 	mov    QWORD PTR [rsp+0x180],rdx
 29f00b1:	00 
 29f00b2:	48 89 8c 24 88 01 00 	mov    QWORD PTR [rsp+0x188],rcx
 29f00b9:	00 
 29f00ba:	0f b6 8c 24 48 03 00 	movzx  ecx,BYTE PTR [rsp+0x348]
 29f00c1:	00 
 29f00c2:	88 8c 24 70 01 00 00 	mov    BYTE PTR [rsp+0x170],cl
 29f00c9:	8b 0d 81 47 aa 01    	mov    ecx,DWORD PTR [rip+0x1aa4781]        # 4494850 <runtime.writeBarrier>
 29f00cf:	85 c9                	test   ecx,ecx
 29f00d1:	0f 85 8d 05 00 00    	jne    29f0664 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x8a4>
 29f00d7:	48 8b 8c 24 68 01 00 	mov    rcx,QWORD PTR [rsp+0x168]
 29f00de:	00 
 29f00df:	48 89 08             	mov    QWORD PTR [rax],rcx
 29f00e2:	48 8d 78 08          	lea    rdi,[rax+0x8]
 29f00e6:	48 8d b4 24 70 01 00 	lea    rsi,[rsp+0x170]
 29f00ed:	00 
 29f00ee:	48 89 6c 24 f0       	mov    QWORD PTR [rsp-0x10],rbp
 29f00f3:	48 8d 6c 24 f0       	lea    rbp,[rsp-0x10]
 29f00f8:	e8 57 51 c5 fe       	call   1645254 <runtime.duffcopy+0x364>
 29f00fd:	48 8b 6d 00          	mov    rbp,QWORD PTR [rbp+0x0]
 29f0101:	48 8b 8c 24 b8 00 00 	mov    rcx,QWORD PTR [rsp+0xb8]
 29f0108:	00 
 29f0109:	48 8b 91 98 01 00 00 	mov    rdx,QWORD PTR [rcx+0x198]
 29f0110:	48 85 d2             	test   rdx,rdx
 29f0113:	0f 84 22 04 00 00    	je     29f053b <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x77b>
 29f0119:	48 8b 41 08          	mov    rax,QWORD PTR [rcx+0x8]
 29f011d:	48 8b 50 40          	mov    rdx,QWORD PTR [rax+0x40]
 29f0121:	48 8b 58 38          	mov    rbx,QWORD PTR [rax+0x38]
 29f0125:	48 8b 40 30          	mov    rax,QWORD PTR [rax+0x30]
 29f0129:	48 8b b1 a0 01 00 00 	mov    rsi,QWORD PTR [rcx+0x1a0]
 29f0130:	48 89 b4 24 80 00 00 	mov    QWORD PTR [rsp+0x80],rsi
 29f0137:	00 
 29f0138:	48 8b b9 98 01 00 00 	mov    rdi,QWORD PTR [rcx+0x198]
 29f013f:	48 89 7c 24 78       	mov    QWORD PTR [rsp+0x78],rdi
 29f0144:	4c 8b 84 24 e0 02 00 	mov    r8,QWORD PTR [rsp+0x2e0]
 29f014b:	00 
 29f014c:	45 0f b6 88 d2 00 00 	movzx  r9d,BYTE PTR [r8+0xd2]
 29f0153:	00 
 29f0154:	44 88 4c 24 5e       	mov    BYTE PTR [rsp+0x5e],r9b
 29f0159:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f015d:	48 89 5c 24 08       	mov    QWORD PTR [rsp+0x8],rbx
 29f0162:	48 89 54 24 10       	mov    QWORD PTR [rsp+0x10],rdx
 29f0167:	e8 94 bc cb fe       	call   16abe00 <time.Since>
 29f016c:	48 8b 44 24 78       	mov    rax,QWORD PTR [rsp+0x78]
 29f0171:	48 8b 40 20          	mov    rax,QWORD PTR [rax+0x20]
 29f0175:	48 8b 4c 24 18       	mov    rcx,QWORD PTR [rsp+0x18]
 29f017a:	0f b6 54 24 5e       	movzx  edx,BYTE PTR [rsp+0x5e]
 29f017f:	84 d2                	test   dl,dl
 29f0181:	0f 84 a0 03 00 00    	je     29f0527 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x767>
 29f0187:	ba 01 00 00 00       	mov    edx,0x1
 29f018c:	88 54 24 0c          	mov    BYTE PTR [rsp+0xc],dl
 29f0190:	8b 94 24 2c 03 00 00 	mov    edx,DWORD PTR [rsp+0x32c]
 29f0197:	89 54 24 08          	mov    DWORD PTR [rsp+0x8],edx
 29f019b:	48 89 4c 24 10       	mov    QWORD PTR [rsp+0x10],rcx
 29f01a0:	48 8b 8c 24 80 00 00 	mov    rcx,QWORD PTR [rsp+0x80]
 29f01a7:	00 
 29f01a8:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 29f01ac:	ff d0                	call   rax
 29f01ae:	0f b6 44 24 18       	movzx  eax,BYTE PTR [rsp+0x18]
 29f01b3:	88 44 24 5f          	mov    BYTE PTR [rsp+0x5f],al
 29f01b7:	48 8b 4c 24 20       	mov    rcx,QWORD PTR [rsp+0x20]
 29f01bc:	48 89 8c 24 88 00 00 	mov    QWORD PTR [rsp+0x88],rcx
 29f01c3:	00 
 29f01c4:	48 8b 54 24 28       	mov    rdx,QWORD PTR [rsp+0x28]
 29f01c9:	48 89 94 24 98 00 00 	mov    QWORD PTR [rsp+0x98],rdx
 29f01d0:	00 
 29f01d1:	48 85 d2             	test   rdx,rdx
 29f01d4:	0f 84 17 03 00 00    	je     29f04f1 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x731>
 29f01da:	48 8b 9c 24 50 03 00 	mov    rbx,QWORD PTR [rsp+0x350]
 29f01e1:	00 
 29f01e2:	48 85 db             	test   rbx,rbx
 29f01e5:	0f 85 d2 02 00 00    	jne    29f04bd <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x6fd>
 29f01eb:	48 8b 84 24 b8 00 00 	mov    rax,QWORD PTR [rsp+0xb8]
 29f01f2:	00 
 29f01f3:	48 8b 48 08          	mov    rcx,QWORD PTR [rax+0x8]
 29f01f7:	48 8b 94 24 f8 00 00 	mov    rdx,QWORD PTR [rsp+0xf8]
 29f01fe:	00 
 29f01ff:	48 89 54 24 08       	mov    QWORD PTR [rsp+0x8],rdx
 29f0204:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 29f0208:	e8 13 fc 67 ff       	call   206fe20 <github.com/docker/docker/container.(*State).SetStopped>
 29f020d:	48 8b 84 24 e0 02 00 	mov    rax,QWORD PTR [rsp+0x2e0]
 29f0214:	00 
 29f0215:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
 29f021a:	48 8b 8c 24 b8 00 00 	mov    rcx,QWORD PTR [rsp+0xb8]
 29f0221:	00 
 29f0222:	48 89 4c 24 18       	mov    QWORD PTR [rsp+0x18],rcx
 29f0227:	c7 04 24 10 00 00 00 	mov    DWORD PTR [rsp],0x10
 29f022e:	48 8d 15 eb 71 e4 00 	lea    rdx,[rip+0xe471eb]        # 3837420 <github.com/docker/docker/daemon.(*Daemon).autoRemove·f>
 29f0235:	48 89 54 24 08       	mov    QWORD PTR [rsp+0x8],rdx
 29f023a:	e8 41 3a c2 fe       	call   1613c80 <runtime.deferproc>
 29f023f:	85 c0                	test   eax,eax
 29f0241:	0f 85 60 02 00 00    	jne    29f04a7 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x6e7>
 29f0247:	48 8b 84 24 b8 00 00 	mov    rax,QWORD PTR [rsp+0xb8]
 29f024e:	00 
 29f024f:	48 8b 48 08          	mov    rcx,QWORD PTR [rax+0x8]
 29f0253:	84 01                	test   BYTE PTR [rcx],al
 29f0255:	48 89 4c 24 10       	mov    QWORD PTR [rsp+0x10],rcx
 29f025a:	c7 04 24 08 00 00 00 	mov    DWORD PTR [rsp],0x8
 29f0261:	48 8d 0d e0 d4 e4 00 	lea    rcx,[rip+0xe4d4e0]        # 383d748 <sync.(*Mutex).Unlock·f>
 29f0268:	48 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],rcx
 29f026d:	e8 0e 3a c2 fe       	call   1613c80 <runtime.deferproc>
 29f0272:	85 c0                	test   eax,eax
 29f0274:	0f 85 17 02 00 00    	jne    29f0491 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x6d1>
 29f027a:	48 8b 84 24 e0 02 00 	mov    rax,QWORD PTR [rsp+0x2e0]
 29f0281:	00 
 29f0282:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f0286:	48 8b 8c 24 b8 00 00 	mov    rcx,QWORD PTR [rsp+0xb8]
 29f028d:	00 
 29f028e:	48 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],rcx
 29f0293:	e8 c8 f9 fe ff       	call   29dfc60 <github.com/docker/docker/daemon.(*Daemon).stopHealthchecks>
 29f0298:	8b 84 24 2c 03 00 00 	mov    eax,DWORD PTR [rsp+0x32c]
 29f029f:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f02a3:	e8 e8 77 c7 fe       	call   1667a90 <strconv.Itoa>
 29f02a8:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
 29f02ad:	48 89 44 24 70       	mov    QWORD PTR [rsp+0x70],rax
 29f02b2:	48 8b 4c 24 08       	mov    rcx,QWORD PTR [rsp+0x8]
 29f02b7:	48 89 8c 24 f0 00 00 	mov    QWORD PTR [rsp+0xf0],rcx
 29f02be:	00 
 29f02bf:	e8 5c 0e c0 fe       	call   15f1120 <runtime.makemap_small>
 29f02c4:	48 8b 04 24          	mov    rax,QWORD PTR [rsp]
 29f02c8:	48 89 84 24 c0 00 00 	mov    QWORD PTR [rsp+0xc0],rax
 29f02cf:	00 
 29f02d0:	48 8d 0d e9 33 af 00 	lea    rcx,[rip+0xaf33e9]        # 34e36c0 <type.wnzCXIht>
 29f02d7:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 29f02db:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
 29f02e0:	48 8d 0d 8d 88 1f 00 	lea    rcx,[rip+0x1f888d]        # 2be8b74 <go.string.*+0x8014>
 29f02e7:	48 89 4c 24 10       	mov    QWORD PTR [rsp+0x10],rcx
 29f02ec:	48 c7 44 24 18 08 00 	mov    QWORD PTR [rsp+0x18],0x8
 29f02f3:	00 00 
 29f02f5:	e8 36 53 c0 fe       	call   15f5630 <runtime.mapassign_faststr>
 29f02fa:	48 8b 7c 24 20       	mov    rdi,QWORD PTR [rsp+0x20]
 29f02ff:	48 8b 44 24 70       	mov    rax,QWORD PTR [rsp+0x70]
 29f0304:	48 89 47 08          	mov    QWORD PTR [rdi+0x8],rax
 29f0308:	8b 05 42 45 aa 01    	mov    eax,DWORD PTR [rip+0x1aa4542]        # 4494850 <runtime.writeBarrier>
 29f030e:	85 c0                	test   eax,eax
 29f0310:	0f 85 69 01 00 00    	jne    29f047f <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x6bf>
 29f0316:	48 8b 84 24 f0 00 00 	mov    rax,QWORD PTR [rsp+0xf0]
 29f031d:	00 
 29f031e:	48 89 07             	mov    QWORD PTR [rdi],rax
 29f0321:	48 8b 84 24 e0 02 00 	mov    rax,QWORD PTR [rsp+0x2e0]
 29f0328:	00 
 29f0329:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f032d:	48 8b 8c 24 b8 00 00 	mov    rcx,QWORD PTR [rsp+0xb8]
 29f0334:	00 
 29f0335:	48 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],rcx
 29f033a:	48 8d 15 57 11 1f 00 	lea    rdx,[rip+0x1f1157]        # 2be1498 <go.string.*+0x938>
 29f0341:	48 89 54 24 10       	mov    QWORD PTR [rsp+0x10],rdx
 29f0346:	48 c7 44 24 18 03 00 	mov    QWORD PTR [rsp+0x18],0x3
 29f034d:	00 00 
 29f034f:	48 8b 94 24 c0 00 00 	mov    rdx,QWORD PTR [rsp+0xc0]
 29f0356:	00 
 29f0357:	48 89 54 24 20       	mov    QWORD PTR [rsp+0x20],rdx
 29f035c:	e8 9f 6e fe ff       	call   29d7200 <github.com/docker/docker/daemon.(*Daemon).LogContainerEventWithAttributes>
 29f0361:	48 8b 84 24 e0 02 00 	mov    rax,QWORD PTR [rsp+0x2e0]
 29f0368:	00 
 29f0369:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f036d:	48 8b 8c 24 b8 00 00 	mov    rcx,QWORD PTR [rsp+0xb8]
 29f0374:	00 
 29f0375:	48 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],rcx
 29f037a:	e8 11 e6 01 00       	call   2a0e990 <github.com/docker/docker/daemon.(*Daemon).Cleanup>
 29f037f:	48 8b 84 24 e0 02 00 	mov    rax,QWORD PTR [rsp+0x2e0]
 29f0386:	00 
 29f0387:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f038b:	48 8b 8c 24 b8 00 00 	mov    rcx,QWORD PTR [rsp+0xb8]
 29f0392:	00 
 29f0393:	48 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],rcx
 29f0398:	e8 d3 f7 ff ff       	call   29efb70 <github.com/docker/docker/daemon.(*Daemon).setStateCounter>
 29f039d:	48 8b 84 24 e0 02 00 	mov    rax,QWORD PTR [rsp+0x2e0]
 29f03a4:	00 
 29f03a5:	48 8b 48 30          	mov    rcx,QWORD PTR [rax+0x30]
 29f03a9:	48 8b 50 38          	mov    rdx,QWORD PTR [rax+0x38]
 29f03ad:	48 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],rcx
 29f03b2:	48 89 54 24 10       	mov    QWORD PTR [rsp+0x10],rdx
 29f03b7:	48 8b 8c 24 b8 00 00 	mov    rcx,QWORD PTR [rsp+0xb8]
 29f03be:	00 
 29f03bf:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 29f03c3:	e8 98 58 67 ff       	call   2065c60 <github.com/docker/docker/container.(*Container).CheckpointTo>
 29f03c8:	48 8b 44 24 18       	mov    rax,QWORD PTR [rsp+0x18]
 29f03cd:	48 8b 4c 24 20       	mov    rcx,QWORD PTR [rsp+0x20]
 29f03d2:	48 8b 94 24 98 00 00 	mov    rdx,QWORD PTR [rsp+0x98]
 29f03d9:	00 
 29f03da:	48 85 d2             	test   rdx,rdx
 29f03dd:	74 26                	je     29f0405 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x645>
 29f03df:	48 89 84 24 60 03 00 	mov    QWORD PTR [rsp+0x360],rax
 29f03e6:	00 
 29f03e7:	48 89 8c 24 68 03 00 	mov    QWORD PTR [rsp+0x368],rcx
 29f03ee:	00 
 29f03ef:	90                   	nop
 29f03f0:	e8 9b 41 c2 fe       	call   1614590 <runtime.deferreturn>
 29f03f5:	48 8b ac 24 d0 02 00 	mov    rbp,QWORD PTR [rsp+0x2d0]
 29f03fc:	00 
 29f03fd:	48 81 c4 d8 02 00 00 	add    rsp,0x2d8
 29f0404:	c3                   	ret    
 29f0405:	0f b6 54 24 5f       	movzx  edx,BYTE PTR [rsp+0x5f]
 29f040a:	84 d2                	test   dl,dl
 29f040c:	74 d1                	je     29f03df <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x61f>
 29f040e:	48 89 84 24 a8 00 00 	mov    QWORD PTR [rsp+0xa8],rax
 29f0415:	00 
 29f0416:	48 89 8c 24 b0 00 00 	mov    QWORD PTR [rsp+0xb0],rcx
 29f041d:	00 
 29f041e:	48 8b 84 24 f8 00 00 	mov    rax,QWORD PTR [rsp+0xf8]
 29f0425:	00 
 29f0426:	48 89 44 24 28       	mov    QWORD PTR [rsp+0x28],rax
 29f042b:	48 8b 84 24 88 00 00 	mov    rax,QWORD PTR [rsp+0x88]
 29f0432:	00 
 29f0433:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
 29f0438:	48 8b 84 24 e0 02 00 	mov    rax,QWORD PTR [rsp+0x2e0]
 29f043f:	00 
 29f0440:	48 89 44 24 18       	mov    QWORD PTR [rsp+0x18],rax
 29f0445:	48 8b 84 24 b8 00 00 	mov    rax,QWORD PTR [rsp+0xb8]
 29f044c:	00 
 29f044d:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
 29f0452:	c7 04 24 20 00 00 00 	mov    DWORD PTR [rsp],0x20
 29f0459:	48 8d 05 98 6f e4 00 	lea    rax,[rip+0xe46f98]        # 38373f8 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent.func1·f>
 29f0460:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
 29f0465:	e8 a6 e2 c2 fe       	call   161e710 <runtime.newproc>
 29f046a:	48 8b 84 24 a8 00 00 	mov    rax,QWORD PTR [rsp+0xa8]
 29f0471:	00 
 29f0472:	48 8b 8c 24 b0 00 00 	mov    rcx,QWORD PTR [rsp+0xb0]
 29f0479:	00 
 29f047a:	e9 60 ff ff ff       	jmp    29f03df <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x61f>
 29f047f:	48 8b 84 24 f0 00 00 	mov    rax,QWORD PTR [rsp+0xf0]
 29f0486:	00 
 29f0487:	e8 24 48 c5 fe       	call   1644cb0 <runtime.gcWriteBarrier>
 29f048c:	e9 90 fe ff ff       	jmp    29f0321 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x561>
 29f0491:	90                   	nop
 29f0492:	e8 f9 40 c2 fe       	call   1614590 <runtime.deferreturn>
 29f0497:	48 8b ac 24 d0 02 00 	mov    rbp,QWORD PTR [rsp+0x2d0]
 29f049e:	00 
 29f049f:	48 81 c4 d8 02 00 00 	add    rsp,0x2d8
 29f04a6:	c3                   	ret    
 29f04a7:	90                   	nop
 29f04a8:	e8 e3 40 c2 fe       	call   1614590 <runtime.deferreturn>
 29f04ad:	48 8b ac 24 d0 02 00 	mov    rbp,QWORD PTR [rsp+0x2d0]
 29f04b4:	00 
 29f04b5:	48 81 c4 d8 02 00 00 	add    rsp,0x2d8
 29f04bc:	c3                   	ret    
 29f04bd:	48 8b 84 24 b8 00 00 	mov    rax,QWORD PTR [rsp+0xb8]
 29f04c4:	00 
 29f04c5:	48 8b 48 08          	mov    rcx,QWORD PTR [rax+0x8]
 29f04c9:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 29f04cd:	48 8b 8c 24 50 03 00 	mov    rcx,QWORD PTR [rsp+0x350]
 29f04d4:	00 
 29f04d5:	48 8b 94 24 58 03 00 	mov    rdx,QWORD PTR [rsp+0x358]
 29f04dc:	00 
 29f04dd:	48 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],rcx
 29f04e2:	48 89 54 24 10       	mov    QWORD PTR [rsp+0x10],rdx
 29f04e7:	e8 c4 fc 67 ff       	call   20701b0 <github.com/docker/docker/container.(*State).SetError>
 29f04ec:	e9 fa fc ff ff       	jmp    29f01eb <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x42b>
 29f04f1:	84 c0                	test   al,al
 29f04f3:	0f 84 e1 fc ff ff    	je     29f01da <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x41a>
 29f04f9:	48 8b 84 24 b8 00 00 	mov    rax,QWORD PTR [rsp+0xb8]
 29f0500:	00 
 29f0501:	48 ff 80 18 01 00 00 	inc    QWORD PTR [rax+0x118]
 29f0508:	48 8b 48 08          	mov    rcx,QWORD PTR [rax+0x8]
 29f050c:	48 8b 94 24 f8 00 00 	mov    rdx,QWORD PTR [rsp+0xf8]
 29f0513:	00 
 29f0514:	48 89 54 24 08       	mov    QWORD PTR [rsp+0x8],rdx
 29f0519:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 29f051d:	e8 2e fb 67 ff       	call   2070050 <github.com/docker/docker/container.(*State).SetRestarting>
 29f0522:	e9 20 fd ff ff       	jmp    29f0247 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x487>
 29f0527:	48 8b 9c 24 b8 00 00 	mov    rbx,QWORD PTR [rsp+0xb8]
 29f052e:	00 
 29f052f:	0f b6 93 21 01 00 00 	movzx  edx,BYTE PTR [rbx+0x121]
 29f0536:	e9 51 fc ff ff       	jmp    29f018c <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x3cc>
 29f053b:	48 8b 81 30 01 00 00 	mov    rax,QWORD PTR [rcx+0x130]
 29f0542:	48 8b 50 58          	mov    rdx,QWORD PTR [rax+0x58]
 29f0546:	48 89 94 24 f0 00 00 	mov    QWORD PTR [rsp+0xf0],rdx
 29f054d:	00 
 29f054e:	48 8b 58 60          	mov    rbx,QWORD PTR [rax+0x60]
 29f0552:	48 89 5c 24 70       	mov    QWORD PTR [rsp+0x70],rbx
 29f0557:	48 8b b1 18 01 00 00 	mov    rsi,QWORD PTR [rcx+0x118]
 29f055e:	48 89 74 24 60       	mov    QWORD PTR [rsp+0x60],rsi
 29f0563:	48 8b 40 68          	mov    rax,QWORD PTR [rax+0x68]
 29f0567:	48 89 44 24 68       	mov    QWORD PTR [rsp+0x68],rax
 29f056c:	48 8d 3d 4d bb a0 00 	lea    rdi,[rip+0xa0bb4d]        # 33fc0c0 <type.PjmncIw1>
 29f0573:	48 89 3c 24          	mov    QWORD PTR [rsp],rdi
 29f0577:	48 c7 44 24 08 00 00 	mov    QWORD PTR [rsp+0x8],0x0
 29f057e:	00 00 
 29f0580:	e8 ab c8 bf fe       	call   15ece30 <runtime.makechan>
 29f0585:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
 29f058a:	48 89 84 24 e8 00 00 	mov    QWORD PTR [rsp+0xe8],rax
 29f0591:	00 
 29f0592:	48 8d 0d 47 9d d3 00 	lea    rcx,[rip+0xd39d47]        # 372a2e0 <type.FQSE7v+F>
 29f0599:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 29f059d:	e8 ce a5 c0 fe       	call   15fab70 <runtime.newobject>
 29f05a2:	48 8b 44 24 08       	mov    rax,QWORD PTR [rsp+0x8]
 29f05a7:	48 8b 4c 24 70       	mov    rcx,QWORD PTR [rsp+0x70]
 29f05ac:	48 89 48 20          	mov    QWORD PTR [rax+0x20],rcx
 29f05b0:	48 8b 4c 24 68       	mov    rcx,QWORD PTR [rsp+0x68]
 29f05b5:	48 89 48 28          	mov    QWORD PTR [rax+0x28],rcx
 29f05b9:	8b 0d 91 42 aa 01    	mov    ecx,DWORD PTR [rip+0x1aa4291]        # 4494850 <runtime.writeBarrier>
 29f05bf:	48 8d 78 18          	lea    rdi,[rax+0x18]
 29f05c3:	85 c9                	test   ecx,ecx
 29f05c5:	0f 85 81 00 00 00    	jne    29f064c <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x88c>
 29f05cb:	48 8b 8c 24 f0 00 00 	mov    rcx,QWORD PTR [rsp+0xf0]
 29f05d2:	00 
 29f05d3:	48 89 48 18          	mov    QWORD PTR [rax+0x18],rcx
 29f05d7:	48 8b 4c 24 60       	mov    rcx,QWORD PTR [rsp+0x60]
 29f05dc:	48 89 48 30          	mov    QWORD PTR [rax+0x30],rcx
 29f05e0:	8b 0d 6a 42 aa 01    	mov    ecx,DWORD PTR [rip+0x1aa426a]        # 4494850 <runtime.writeBarrier>
 29f05e6:	48 8d 78 48          	lea    rdi,[rax+0x48]
 29f05ea:	85 c9                	test   ecx,ecx
 29f05ec:	75 49                	jne    29f0637 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x877>
 29f05ee:	48 8b 8c 24 e8 00 00 	mov    rcx,QWORD PTR [rsp+0xe8]
 29f05f5:	00 
 29f05f6:	48 89 48 48          	mov    QWORD PTR [rax+0x48],rcx
 29f05fa:	48 8d 0d 5f 62 e6 00 	lea    rcx,[rip+0xe6625f]        # 3856860 <go.itab.*github.com/docker/docker/restartmanager.restartManager,github.com/docker/docker/restartmanager.RestartManager>
 29f0601:	48 8b 94 24 b8 00 00 	mov    rdx,QWORD PTR [rsp+0xb8]
 29f0608:	00 
 29f0609:	48 89 8a 98 01 00 00 	mov    QWORD PTR [rdx+0x198],rcx
 29f0610:	8b 0d 3a 42 aa 01    	mov    ecx,DWORD PTR [rip+0x1aa423a]        # 4494850 <runtime.writeBarrier>
 29f0616:	48 8d ba a0 01 00 00 	lea    rdi,[rdx+0x1a0]
 29f061d:	85 c9                	test   ecx,ecx
 29f061f:	75 0f                	jne    29f0630 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x870>
 29f0621:	48 89 82 a0 01 00 00 	mov    QWORD PTR [rdx+0x1a0],rax
 29f0628:	48 89 d1             	mov    rcx,rdx
 29f062b:	e9 e9 fa ff ff       	jmp    29f0119 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x359>
 29f0630:	e8 7b 46 c5 fe       	call   1644cb0 <runtime.gcWriteBarrier>
 29f0635:	eb f1                	jmp    29f0628 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x868>
 29f0637:	48 89 c1             	mov    rcx,rax
 29f063a:	48 8b 84 24 e8 00 00 	mov    rax,QWORD PTR [rsp+0xe8]
 29f0641:	00 
 29f0642:	e8 69 46 c5 fe       	call   1644cb0 <runtime.gcWriteBarrier>
 29f0647:	48 89 c8             	mov    rax,rcx
 29f064a:	eb ae                	jmp    29f05fa <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x83a>
 29f064c:	48 89 c1             	mov    rcx,rax
 29f064f:	48 8b 84 24 f0 00 00 	mov    rax,QWORD PTR [rsp+0xf0]
 29f0656:	00 
 29f0657:	e8 54 46 c5 fe       	call   1644cb0 <runtime.gcWriteBarrier>
 29f065c:	48 89 c8             	mov    rax,rcx
 29f065f:	e9 73 ff ff ff       	jmp    29f05d7 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x817>
 29f0664:	48 8d 0d f5 58 c3 00 	lea    rcx,[rip+0xc358f5]        # 3625f60 <type.iPh4Qw+B>
 29f066b:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 29f066f:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
 29f0674:	48 8d 8c 24 68 01 00 	lea    rcx,[rsp+0x168]
 29f067b:	00 
 29f067c:	48 89 4c 24 10       	mov    QWORD PTR [rsp+0x10],rcx
 29f0681:	e8 fa af c0 fe       	call   15fb680 <runtime.typedmemmove>
 29f0686:	48 8b 84 24 f8 00 00 	mov    rax,QWORD PTR [rsp+0xf8]
 29f068d:	00 
 29f068e:	e9 6e fa ff ff       	jmp    29f0101 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x341>
 29f0693:	48 89 9c 24 e0 00 00 	mov    QWORD PTR [rsp+0xe0],rbx
 29f069a:	00 
 29f069b:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 29f069f:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
 29f06a4:	e8 87 96 d8 fe       	call   1779d30 <github.com/docker/docker/vendor/github.com/sirupsen/logrus.WithError>
 29f06a9:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
 29f06ae:	48 89 84 24 d8 00 00 	mov    QWORD PTR [rsp+0xd8],rax
 29f06b5:	00 
 29f06b6:	0f 57 c0             	xorps  xmm0,xmm0
 29f06b9:	0f 11 84 24 18 01 00 	movups XMMWORD PTR [rsp+0x118],xmm0
 29f06c0:	00 
 29f06c1:	48 8b 8c 24 e0 00 00 	mov    rcx,QWORD PTR [rsp+0xe0]
 29f06c8:	00 
 29f06c9:	48 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],rcx
 29f06ce:	48 8d 0d 2b 82 a1 00 	lea    rcx,[rip+0xa1822b]        # 3408900 <type.string>
 29f06d5:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 29f06d9:	e8 c2 7a c0 fe       	call   15f81a0 <runtime.convT2Estring>
 29f06de:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
 29f06e3:	48 8b 4c 24 18       	mov    rcx,QWORD PTR [rsp+0x18]
 29f06e8:	48 89 84 24 18 01 00 	mov    QWORD PTR [rsp+0x118],rax
 29f06ef:	00 
 29f06f0:	48 89 8c 24 20 01 00 	mov    QWORD PTR [rsp+0x120],rcx
 29f06f7:	00 
 29f06f8:	48 8b 84 24 d8 00 00 	mov    rax,QWORD PTR [rsp+0xd8]
 29f06ff:	00 
 29f0700:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f0704:	48 8d 05 74 21 25 00 	lea    rax,[rip+0x252174]        # 2c4287f <go.string.*+0x61d1f>
 29f070b:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
 29f0710:	48 c7 44 24 10 2d 00 	mov    QWORD PTR [rsp+0x10],0x2d
 29f0717:	00 00 
 29f0719:	48 8d 84 24 18 01 00 	lea    rax,[rsp+0x118]
 29f0720:	00 
 29f0721:	48 89 44 24 18       	mov    QWORD PTR [rsp+0x18],rax
 29f0726:	48 c7 44 24 20 01 00 	mov    QWORD PTR [rsp+0x20],0x1
 29f072d:	00 00 
 29f072f:	48 c7 44 24 28 01 00 	mov    QWORD PTR [rsp+0x28],0x1
 29f0736:	00 00 
 29f0738:	e8 f3 87 d8 fe       	call   1778f30 <github.com/docker/docker/vendor/github.com/sirupsen/logrus.(*Entry).Warnf>
 29f073d:	48 8b 94 24 b8 00 00 	mov    rdx,QWORD PTR [rsp+0xb8]
 29f0744:	00 
 29f0745:	e9 d1 f8 ff ff       	jmp    29f001b <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x25b>
 29f074a:	48 8b 88 38 01 00 00 	mov    rcx,QWORD PTR [rax+0x138]
 29f0751:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 29f0755:	48 8b 8c 24 20 03 00 	mov    rcx,QWORD PTR [rsp+0x320]
 29f075c:	00 
 29f075d:	48 8b 94 24 18 03 00 	mov    rdx,QWORD PTR [rsp+0x318]
 29f0764:	00 
 29f0765:	48 89 54 24 08       	mov    QWORD PTR [rsp+0x8],rdx
 29f076a:	48 89 4c 24 10       	mov    QWORD PTR [rsp+0x10],rcx
 29f076f:	e8 4c 70 5f ff       	call   1fe77c0 <github.com/docker/docker/daemon/exec.(*Store).Get>
 29f0774:	48 8b 44 24 18       	mov    rax,QWORD PTR [rsp+0x18]
 29f0779:	48 85 c0             	test   rax,rax
 29f077c:	0f 84 6d 03 00 00    	je     29f0aef <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xd2f>
 29f0782:	48 89 84 24 90 00 00 	mov    QWORD PTR [rsp+0x90],rax
 29f0789:	00 
 29f078a:	48 8d 05 af 38 a1 00 	lea    rax,[rip+0xa138af]        # 3404040 <type.int>
 29f0791:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f0795:	e8 d6 a3 c0 fe       	call   15fab70 <runtime.newobject>
 29f079a:	48 8b 44 24 08       	mov    rax,QWORD PTR [rsp+0x8]
 29f079f:	48 89 84 24 00 01 00 	mov    QWORD PTR [rsp+0x100],rax
 29f07a6:	00 
 29f07a7:	8b 8c 24 2c 03 00 00 	mov    ecx,DWORD PTR [rsp+0x32c]
 29f07ae:	48 89 08             	mov    QWORD PTR [rax],rcx
 29f07b1:	48 8b 8c 24 90 00 00 	mov    rcx,QWORD PTR [rsp+0x90]
 29f07b8:	00 
 29f07b9:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 29f07bd:	e8 de c8 c5 fe       	call   164d0a0 <sync.(*Mutex).Lock>
 29f07c2:	48 8b 84 24 90 00 00 	mov    rax,QWORD PTR [rsp+0x90]
 29f07c9:	00 
 29f07ca:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
 29f07cf:	c7 04 24 08 00 00 00 	mov    DWORD PTR [rsp],0x8
 29f07d6:	48 8d 0d 6b cf e4 00 	lea    rcx,[rip+0xe4cf6b]        # 383d748 <sync.(*Mutex).Unlock·f>
 29f07dd:	48 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],rcx
 29f07e2:	e8 99 34 c2 fe       	call   1613c80 <runtime.deferproc>
 29f07e7:	85 c0                	test   eax,eax
 29f07e9:	0f 85 ea 02 00 00    	jne    29f0ad9 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xd19>
 29f07ef:	8b 0d 5b 40 aa 01    	mov    ecx,DWORD PTR [rip+0x1aa405b]        # 4494850 <runtime.writeBarrier>
 29f07f5:	48 8b 94 24 90 00 00 	mov    rdx,QWORD PTR [rsp+0x90]
 29f07fc:	00 
 29f07fd:	48 8d 7a 30          	lea    rdi,[rdx+0x30]
 29f0801:	85 c9                	test   ecx,ecx
 29f0803:	0f 85 be 02 00 00    	jne    29f0ac7 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xd07>
 29f0809:	48 8b 84 24 00 01 00 	mov    rax,QWORD PTR [rsp+0x100]
 29f0810:	00 
 29f0811:	48 89 42 30          	mov    QWORD PTR [rdx+0x30],rax
 29f0815:	c6 42 28 00          	mov    BYTE PTR [rdx+0x28],0x0
 29f0819:	48 8b 42 10          	mov    rax,QWORD PTR [rdx+0x10]
 29f081d:	84 00                	test   BYTE PTR [rax],al
 29f081f:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f0823:	e8 d8 db c5 fe       	call   164e400 <sync.(*WaitGroup).Wait>
 29f0828:	48 8b 84 24 90 00 00 	mov    rax,QWORD PTR [rsp+0x90]
 29f082f:	00 
 29f0830:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f0834:	e8 67 6c 5f ff       	call   1fe74a0 <github.com/docker/docker/daemon/exec.(*Config).CloseStreams>
 29f0839:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
 29f083e:	48 8b 4c 24 08       	mov    rcx,QWORD PTR [rsp+0x8]
 29f0843:	48 85 c9             	test   rcx,rcx
 29f0846:	0f 84 bc 00 00 00    	je     29f0908 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xb48>
 29f084c:	48 89 84 24 a0 00 00 	mov    QWORD PTR [rsp+0xa0],rax
 29f0853:	00 
 29f0854:	74 04                	je     29f085a <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xa9a>
 29f0856:	48 8b 49 08          	mov    rcx,QWORD PTR [rcx+0x8]
 29f085a:	48 89 8c 24 f0 00 00 	mov    QWORD PTR [rsp+0xf0],rcx
 29f0861:	00 
 29f0862:	0f 57 c0             	xorps  xmm0,xmm0
 29f0865:	0f 11 84 24 48 01 00 	movups XMMWORD PTR [rsp+0x148],xmm0
 29f086c:	00 
 29f086d:	0f 11 84 24 58 01 00 	movups XMMWORD PTR [rsp+0x158],xmm0
 29f0874:	00 
 29f0875:	48 8b 84 24 b8 00 00 	mov    rax,QWORD PTR [rsp+0xb8]
 29f087c:	00 
 29f087d:	48 8d 50 40          	lea    rdx,[rax+0x40]
 29f0881:	48 89 54 24 08       	mov    QWORD PTR [rsp+0x8],rdx
 29f0886:	48 8d 15 73 80 a1 00 	lea    rdx,[rip+0xa18073]        # 3408900 <type.string>
 29f088d:	48 89 14 24          	mov    QWORD PTR [rsp],rdx
 29f0891:	e8 0a 79 c0 fe       	call   15f81a0 <runtime.convT2Estring>
 29f0896:	48 8b 44 24 18       	mov    rax,QWORD PTR [rsp+0x18]
 29f089b:	48 8b 4c 24 10       	mov    rcx,QWORD PTR [rsp+0x10]
 29f08a0:	48 89 8c 24 48 01 00 	mov    QWORD PTR [rsp+0x148],rcx
 29f08a7:	00 
 29f08a8:	48 89 84 24 50 01 00 	mov    QWORD PTR [rsp+0x150],rax
 29f08af:	00 
 29f08b0:	48 8b 84 24 f0 00 00 	mov    rax,QWORD PTR [rsp+0xf0]
 29f08b7:	00 
 29f08b8:	48 89 84 24 58 01 00 	mov    QWORD PTR [rsp+0x158],rax
 29f08bf:	00 
 29f08c0:	48 8b 84 24 a0 00 00 	mov    rax,QWORD PTR [rsp+0xa0]
 29f08c7:	00 
 29f08c8:	48 89 84 24 60 01 00 	mov    QWORD PTR [rsp+0x160],rax
 29f08cf:	00 
 29f08d0:	48 8d 05 c2 a9 23 00 	lea    rax,[rip+0x23a9c2]        # 2c2b299 <go.string.*+0x4a739>
 29f08d7:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f08db:	48 c7 44 24 08 25 00 	mov    QWORD PTR [rsp+0x8],0x25
 29f08e2:	00 00 
 29f08e4:	48 8d 84 24 48 01 00 	lea    rax,[rsp+0x148]
 29f08eb:	00 
 29f08ec:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
 29f08f1:	48 c7 44 24 18 02 00 	mov    QWORD PTR [rsp+0x18],0x2
 29f08f8:	00 00 
 29f08fa:	48 c7 44 24 20 02 00 	mov    QWORD PTR [rsp+0x20],0x2
 29f0901:	00 00 
 29f0903:	e8 68 99 d8 fe       	call   177a270 <github.com/docker/docker/vendor/github.com/sirupsen/logrus.Errorf>
 29f0908:	48 8b 84 24 b8 00 00 	mov    rax,QWORD PTR [rsp+0xb8]
 29f090f:	00 
 29f0910:	48 8b 88 38 01 00 00 	mov    rcx,QWORD PTR [rax+0x138]
 29f0917:	48 8b 94 24 90 00 00 	mov    rdx,QWORD PTR [rsp+0x90]
 29f091e:	00 
 29f091f:	48 8b 5a 20          	mov    rbx,QWORD PTR [rdx+0x20]
 29f0923:	48 8b 72 18          	mov    rsi,QWORD PTR [rdx+0x18]
 29f0927:	48 8b ba d0 00 00 00 	mov    rdi,QWORD PTR [rdx+0xd0]
 29f092e:	48 89 7c 24 18       	mov    QWORD PTR [rsp+0x18],rdi
 29f0933:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 29f0937:	48 89 74 24 08       	mov    QWORD PTR [rsp+0x8],rsi
 29f093c:	48 89 5c 24 10       	mov    QWORD PTR [rsp+0x10],rbx
 29f0941:	e8 2a 6f 5f ff       	call   1fe7870 <github.com/docker/docker/daemon/exec.(*Store).Delete>
 29f0946:	48 8b 84 24 00 01 00 	mov    rax,QWORD PTR [rsp+0x100]
 29f094d:	00 
 29f094e:	48 8b 00             	mov    rax,QWORD PTR [rax]
 29f0951:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f0955:	e8 36 71 c7 fe       	call   1667a90 <strconv.Itoa>
 29f095a:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
 29f095f:	48 89 44 24 70       	mov    QWORD PTR [rsp+0x70],rax
 29f0964:	48 8b 4c 24 08       	mov    rcx,QWORD PTR [rsp+0x8]
 29f0969:	48 89 8c 24 f0 00 00 	mov    QWORD PTR [rsp+0xf0],rcx
 29f0970:	00 
 29f0971:	e8 aa 07 c0 fe       	call   15f1120 <runtime.makemap_small>
 29f0976:	48 8b 04 24          	mov    rax,QWORD PTR [rsp]
 29f097a:	48 89 84 24 c8 00 00 	mov    QWORD PTR [rsp+0xc8],rax
 29f0981:	00 
 29f0982:	48 8b 8c 24 90 00 00 	mov    rcx,QWORD PTR [rsp+0x90]
 29f0989:	00 
 29f098a:	48 8b 51 20          	mov    rdx,QWORD PTR [rcx+0x20]
 29f098e:	48 89 54 24 68       	mov    QWORD PTR [rsp+0x68],rdx
 29f0993:	48 8b 49 18          	mov    rcx,QWORD PTR [rcx+0x18]
 29f0997:	48 89 8c 24 d0 00 00 	mov    QWORD PTR [rsp+0xd0],rcx
 29f099e:	00 
 29f099f:	48 8d 1d 1a 2d af 00 	lea    rbx,[rip+0xaf2d1a]        # 34e36c0 <type.wnzCXIht>
 29f09a6:	48 89 1c 24          	mov    QWORD PTR [rsp],rbx
 29f09aa:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
 29f09af:	48 8d 35 db 41 1f 00 	lea    rsi,[rip+0x1f41db]        # 2be4b91 <go.string.*+0x4031>
 29f09b6:	48 89 74 24 10       	mov    QWORD PTR [rsp+0x10],rsi
 29f09bb:	48 c7 44 24 18 06 00 	mov    QWORD PTR [rsp+0x18],0x6
 29f09c2:	00 00 
 29f09c4:	e8 67 4c c0 fe       	call   15f5630 <runtime.mapassign_faststr>
 29f09c9:	48 8b 7c 24 20       	mov    rdi,QWORD PTR [rsp+0x20]
 29f09ce:	48 8b 44 24 68       	mov    rax,QWORD PTR [rsp+0x68]
 29f09d3:	48 89 47 08          	mov    QWORD PTR [rdi+0x8],rax
 29f09d7:	8b 05 73 3e aa 01    	mov    eax,DWORD PTR [rip+0x1aa3e73]        # 4494850 <runtime.writeBarrier>
 29f09dd:	85 c0                	test   eax,eax
 29f09df:	0f 85 d0 00 00 00    	jne    29f0ab5 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xcf5>
 29f09e5:	48 8b 84 24 d0 00 00 	mov    rax,QWORD PTR [rsp+0xd0]
 29f09ec:	00 
 29f09ed:	48 89 07             	mov    QWORD PTR [rdi],rax
 29f09f0:	48 8d 05 c9 2c af 00 	lea    rax,[rip+0xaf2cc9]        # 34e36c0 <type.wnzCXIht>
 29f09f7:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f09fb:	48 8b 84 24 c8 00 00 	mov    rax,QWORD PTR [rsp+0xc8]
 29f0a02:	00 
 29f0a03:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
 29f0a08:	48 8d 0d 65 81 1f 00 	lea    rcx,[rip+0x1f8165]        # 2be8b74 <go.string.*+0x8014>
 29f0a0f:	48 89 4c 24 10       	mov    QWORD PTR [rsp+0x10],rcx
 29f0a14:	48 c7 44 24 18 08 00 	mov    QWORD PTR [rsp+0x18],0x8
 29f0a1b:	00 00 
 29f0a1d:	e8 0e 4c c0 fe       	call   15f5630 <runtime.mapassign_faststr>
 29f0a22:	48 8b 7c 24 20       	mov    rdi,QWORD PTR [rsp+0x20]
 29f0a27:	48 8b 44 24 70       	mov    rax,QWORD PTR [rsp+0x70]
 29f0a2c:	48 89 47 08          	mov    QWORD PTR [rdi+0x8],rax
 29f0a30:	8b 05 1a 3e aa 01    	mov    eax,DWORD PTR [rip+0x1aa3e1a]        # 4494850 <runtime.writeBarrier>
 29f0a36:	85 c0                	test   eax,eax
 29f0a38:	75 6c                	jne    29f0aa6 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xce6>
 29f0a3a:	48 8b 84 24 f0 00 00 	mov    rax,QWORD PTR [rsp+0xf0]
 29f0a41:	00 
 29f0a42:	48 89 07             	mov    QWORD PTR [rdi],rax
 29f0a45:	48 8b 84 24 e0 02 00 	mov    rax,QWORD PTR [rsp+0x2e0]
 29f0a4c:	00 
 29f0a4d:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f0a51:	48 8b 84 24 b8 00 00 	mov    rax,QWORD PTR [rsp+0xb8]
 29f0a58:	00 
 29f0a59:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
 29f0a5e:	48 8d 05 f7 80 1f 00 	lea    rax,[rip+0x1f80f7]        # 2be8b5c <go.string.*+0x7ffc>
 29f0a65:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
 29f0a6a:	48 c7 44 24 18 08 00 	mov    QWORD PTR [rsp+0x18],0x8
 29f0a71:	00 00 
 29f0a73:	48 8b 84 24 c8 00 00 	mov    rax,QWORD PTR [rsp+0xc8]
 29f0a7a:	00 
 29f0a7b:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
 29f0a80:	e8 7b 67 fe ff       	call   29d7200 <github.com/docker/docker/daemon.(*Daemon).LogContainerEventWithAttributes>
 29f0a85:	0f 57 c0             	xorps  xmm0,xmm0
 29f0a88:	0f 11 84 24 60 03 00 	movups XMMWORD PTR [rsp+0x360],xmm0
 29f0a8f:	00 
 29f0a90:	90                   	nop
 29f0a91:	e8 fa 3a c2 fe       	call   1614590 <runtime.deferreturn>
 29f0a96:	48 8b ac 24 d0 02 00 	mov    rbp,QWORD PTR [rsp+0x2d0]
 29f0a9d:	00 
 29f0a9e:	48 81 c4 d8 02 00 00 	add    rsp,0x2d8
 29f0aa5:	c3                   	ret    
 29f0aa6:	48 8b 84 24 f0 00 00 	mov    rax,QWORD PTR [rsp+0xf0]
 29f0aad:	00 
 29f0aae:	e8 fd 41 c5 fe       	call   1644cb0 <runtime.gcWriteBarrier>
 29f0ab3:	eb 90                	jmp    29f0a45 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xc85>
 29f0ab5:	48 8b 84 24 d0 00 00 	mov    rax,QWORD PTR [rsp+0xd0]
 29f0abc:	00 
 29f0abd:	e8 ee 41 c5 fe       	call   1644cb0 <runtime.gcWriteBarrier>
 29f0ac2:	e9 29 ff ff ff       	jmp    29f09f0 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xc30>
 29f0ac7:	48 8b 84 24 00 01 00 	mov    rax,QWORD PTR [rsp+0x100]
 29f0ace:	00 
 29f0acf:	e8 dc 41 c5 fe       	call   1644cb0 <runtime.gcWriteBarrier>
 29f0ad4:	e9 3c fd ff ff       	jmp    29f0815 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xa55>
 29f0ad9:	90                   	nop
 29f0ada:	e8 b1 3a c2 fe       	call   1614590 <runtime.deferreturn>
 29f0adf:	48 8b ac 24 d0 02 00 	mov    rbp,QWORD PTR [rsp+0x2d0]
 29f0ae6:	00 
 29f0ae7:	48 81 c4 d8 02 00 00 	add    rsp,0x2d8
 29f0aee:	c3                   	ret    
 29f0aef:	0f 57 c0             	xorps  xmm0,xmm0
 29f0af2:	0f 11 84 24 90 01 00 	movups XMMWORD PTR [rsp+0x190],xmm0
 29f0af9:	00 
 29f0afa:	0f 11 84 24 a0 01 00 	movups XMMWORD PTR [rsp+0x1a0],xmm0
 29f0b01:	00 
 29f0b02:	0f 11 84 24 b0 01 00 	movups XMMWORD PTR [rsp+0x1b0],xmm0
 29f0b09:	00 
 29f0b0a:	48 8d bc 24 c0 01 00 	lea    rdi,[rsp+0x1c0]
 29f0b11:	00 
 29f0b12:	48 8d 7f d0          	lea    rdi,[rdi-0x30]
 29f0b16:	48 89 6c 24 f0       	mov    QWORD PTR [rsp-0x10],rbp
 29f0b1b:	48 8d 6c 24 f0       	lea    rbp,[rsp-0x10]
 29f0b20:	e8 67 43 c5 fe       	call   1644e8c <runtime.duffzero+0xdc>
 29f0b25:	48 8b 6d 00          	mov    rbp,QWORD PTR [rbp+0x0]
 29f0b29:	48 8d 84 24 c0 01 00 	lea    rax,[rsp+0x1c0]
 29f0b30:	00 
 29f0b31:	48 89 84 24 a0 01 00 	mov    QWORD PTR [rsp+0x1a0],rax
 29f0b38:	00 
 29f0b39:	e8 92 fe c3 fe       	call   16309d0 <runtime.fastrand>
 29f0b3e:	8b 04 24             	mov    eax,DWORD PTR [rsp]
 29f0b41:	89 84 24 9c 01 00 00 	mov    DWORD PTR [rsp+0x19c],eax
 29f0b48:	48 8b 84 24 b8 00 00 	mov    rax,QWORD PTR [rsp+0xb8]
 29f0b4f:	00 
 29f0b50:	48 83 c0 40          	add    rax,0x40
 29f0b54:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
 29f0b59:	48 8d 05 a0 7d a1 00 	lea    rax,[rip+0xa17da0]        # 3408900 <type.string>
 29f0b60:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f0b64:	e8 37 76 c0 fe       	call   15f81a0 <runtime.convT2Estring>
 29f0b69:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
 29f0b6e:	48 89 84 24 f0 00 00 	mov    QWORD PTR [rsp+0xf0],rax
 29f0b75:	00 
 29f0b76:	48 8b 4c 24 18       	mov    rcx,QWORD PTR [rsp+0x18]
 29f0b7b:	48 89 8c 24 d0 00 00 	mov    QWORD PTR [rsp+0xd0],rcx
 29f0b82:	00 
 29f0b83:	48 8d 15 d6 25 b2 00 	lea    rdx,[rip+0xb225d6]        # 3513160 <type.AYxI/6LG>
 29f0b8a:	48 89 14 24          	mov    QWORD PTR [rsp],rdx
 29f0b8e:	48 8d 9c 24 90 01 00 	lea    rbx,[rsp+0x190]
 29f0b95:	00 
 29f0b96:	48 89 5c 24 08       	mov    QWORD PTR [rsp+0x8],rbx
 29f0b9b:	48 8d 35 b2 99 1f 00 	lea    rsi,[rip+0x1f99b2]        # 2bea554 <go.string.*+0x99f4>
 29f0ba2:	48 89 74 24 10       	mov    QWORD PTR [rsp+0x10],rsi
 29f0ba7:	48 c7 44 24 18 09 00 	mov    QWORD PTR [rsp+0x18],0x9
 29f0bae:	00 00 
 29f0bb0:	e8 7b 4a c0 fe       	call   15f5630 <runtime.mapassign_faststr>
 29f0bb5:	48 8b 44 24 20       	mov    rax,QWORD PTR [rsp+0x20]
 29f0bba:	48 8b 8c 24 f0 00 00 	mov    rcx,QWORD PTR [rsp+0xf0]
 29f0bc1:	00 
 29f0bc2:	48 89 08             	mov    QWORD PTR [rax],rcx
 29f0bc5:	8b 0d 85 3c aa 01    	mov    ecx,DWORD PTR [rip+0x1aa3c85]        # 4494850 <runtime.writeBarrier>
 29f0bcb:	48 8d 78 08          	lea    rdi,[rax+0x8]
 29f0bcf:	85 c9                	test   ecx,ecx
 29f0bd1:	0f 85 c3 01 00 00    	jne    29f0d9a <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xfda>
 29f0bd7:	48 8b 8c 24 d0 00 00 	mov    rcx,QWORD PTR [rsp+0xd0]
 29f0bde:	00 
 29f0bdf:	48 89 48 08          	mov    QWORD PTR [rax+0x8],rcx
 29f0be3:	48 8d 05 16 7d a1 00 	lea    rax,[rip+0xa17d16]        # 3408900 <type.string>
 29f0bea:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f0bee:	48 8d 8c 24 18 03 00 	lea    rcx,[rsp+0x318]
 29f0bf5:	00 
 29f0bf6:	48 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],rcx
 29f0bfb:	e8 a0 75 c0 fe       	call   15f81a0 <runtime.convT2Estring>
 29f0c00:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
 29f0c05:	48 89 84 24 f0 00 00 	mov    QWORD PTR [rsp+0xf0],rax
 29f0c0c:	00 
 29f0c0d:	48 8b 4c 24 18       	mov    rcx,QWORD PTR [rsp+0x18]
 29f0c12:	48 89 8c 24 d0 00 00 	mov    QWORD PTR [rsp+0xd0],rcx
 29f0c19:	00 
 29f0c1a:	48 8d 15 3f 25 b2 00 	lea    rdx,[rip+0xb2253f]        # 3513160 <type.AYxI/6LG>
 29f0c21:	48 89 14 24          	mov    QWORD PTR [rsp],rdx
 29f0c25:	48 8d 9c 24 90 01 00 	lea    rbx,[rsp+0x190]
 29f0c2c:	00 
 29f0c2d:	48 89 5c 24 08       	mov    QWORD PTR [rsp+0x8],rbx
 29f0c32:	48 8d 35 a1 5e 1f 00 	lea    rsi,[rip+0x1f5ea1]        # 2be6ada <go.string.*+0x5f7a>
 29f0c39:	48 89 74 24 10       	mov    QWORD PTR [rsp+0x10],rsi
 29f0c3e:	48 c7 44 24 18 07 00 	mov    QWORD PTR [rsp+0x18],0x7
 29f0c45:	00 00 
 29f0c47:	e8 e4 49 c0 fe       	call   15f5630 <runtime.mapassign_faststr>
 29f0c4c:	48 8b 44 24 20       	mov    rax,QWORD PTR [rsp+0x20]
 29f0c51:	48 8b 8c 24 f0 00 00 	mov    rcx,QWORD PTR [rsp+0xf0]
 29f0c58:	00 
 29f0c59:	48 89 08             	mov    QWORD PTR [rax],rcx
 29f0c5c:	8b 0d ee 3b aa 01    	mov    ecx,DWORD PTR [rip+0x1aa3bee]        # 4494850 <runtime.writeBarrier>
 29f0c62:	48 8d 78 08          	lea    rdi,[rax+0x8]
 29f0c66:	85 c9                	test   ecx,ecx
 29f0c68:	0f 85 1a 01 00 00    	jne    29f0d88 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xfc8>
 29f0c6e:	48 8b 8c 24 d0 00 00 	mov    rcx,QWORD PTR [rsp+0xd0]
 29f0c75:	00 
 29f0c76:	48 89 48 08          	mov    QWORD PTR [rax+0x8],rcx
 29f0c7a:	48 8d 05 7f 88 a1 00 	lea    rax,[rip+0xa1887f]        # 3409500 <type.uint32>
 29f0c81:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f0c85:	48 8d 84 24 28 03 00 	lea    rax,[rsp+0x328]
 29f0c8c:	00 
 29f0c8d:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
 29f0c92:	e8 f9 73 c0 fe       	call   15f8090 <runtime.convT2E32>
 29f0c97:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
 29f0c9c:	48 89 84 24 f0 00 00 	mov    QWORD PTR [rsp+0xf0],rax
 29f0ca3:	00 
 29f0ca4:	48 8b 4c 24 18       	mov    rcx,QWORD PTR [rsp+0x18]
 29f0ca9:	48 89 8c 24 d0 00 00 	mov    QWORD PTR [rsp+0xd0],rcx
 29f0cb0:	00 
 29f0cb1:	48 8d 15 a8 24 b2 00 	lea    rdx,[rip+0xb224a8]        # 3513160 <type.AYxI/6LG>
 29f0cb8:	48 89 14 24          	mov    QWORD PTR [rsp],rdx
 29f0cbc:	48 8d 94 24 90 01 00 	lea    rdx,[rsp+0x190]
 29f0cc3:	00 
 29f0cc4:	48 89 54 24 08       	mov    QWORD PTR [rsp+0x8],rdx
 29f0cc9:	48 8d 1d 84 7e 1f 00 	lea    rbx,[rip+0x1f7e84]        # 2be8b54 <go.string.*+0x7ff4>
 29f0cd0:	48 89 5c 24 10       	mov    QWORD PTR [rsp+0x10],rbx
 29f0cd5:	48 c7 44 24 18 08 00 	mov    QWORD PTR [rsp+0x18],0x8
 29f0cdc:	00 00 
 29f0cde:	e8 4d 49 c0 fe       	call   15f5630 <runtime.mapassign_faststr>
 29f0ce3:	48 8b 44 24 20       	mov    rax,QWORD PTR [rsp+0x20]
 29f0ce8:	48 8b 8c 24 f0 00 00 	mov    rcx,QWORD PTR [rsp+0xf0]
 29f0cef:	00 
 29f0cf0:	48 89 08             	mov    QWORD PTR [rax],rcx
 29f0cf3:	8b 0d 57 3b aa 01    	mov    ecx,DWORD PTR [rip+0x1aa3b57]        # 4494850 <runtime.writeBarrier>
 29f0cf9:	48 8d 78 08          	lea    rdi,[rax+0x8]
 29f0cfd:	85 c9                	test   ecx,ecx
 29f0cff:	75 78                	jne    29f0d79 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xfb9>
 29f0d01:	48 8b 8c 24 d0 00 00 	mov    rcx,QWORD PTR [rsp+0xd0]
 29f0d08:	00 
 29f0d09:	48 89 48 08          	mov    QWORD PTR [rax+0x8],rcx
 29f0d0d:	48 8d 84 24 90 01 00 	lea    rax,[rsp+0x190]
 29f0d14:	00 
 29f0d15:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f0d19:	e8 12 91 d8 fe       	call   1779e30 <github.com/docker/docker/vendor/github.com/sirupsen/logrus.WithFields>
 29f0d1e:	48 8b 44 24 08       	mov    rax,QWORD PTR [rsp+0x8]
 29f0d23:	0f 57 c0             	xorps  xmm0,xmm0
 29f0d26:	0f 11 84 24 08 01 00 	movups XMMWORD PTR [rsp+0x108],xmm0
 29f0d2d:	00 
 29f0d2e:	48 8d 0d cb 7b a1 00 	lea    rcx,[rip+0xa17bcb]        # 3408900 <type.string>
 29f0d35:	48 89 8c 24 08 01 00 	mov    QWORD PTR [rsp+0x108],rcx
 29f0d3c:	00 
 29f0d3d:	48 8d 0d 3c d9 e4 00 	lea    rcx,[rip+0xe4d93c]        # 383e680 <github.com/docker/docker/daemon.statictmp_135>
 29f0d44:	48 89 8c 24 10 01 00 	mov    QWORD PTR [rsp+0x110],rcx
 29f0d4b:	00 
 29f0d4c:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f0d50:	48 8d 84 24 08 01 00 	lea    rax,[rsp+0x108]
 29f0d57:	00 
 29f0d58:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
 29f0d5d:	48 c7 44 24 10 01 00 	mov    QWORD PTR [rsp+0x10],0x1
 29f0d64:	00 00 
 29f0d66:	48 c7 44 24 18 01 00 	mov    QWORD PTR [rsp+0x18],0x1
 29f0d6d:	00 00 
 29f0d6f:	e8 6c 7b d8 fe       	call   17788e0 <github.com/docker/docker/vendor/github.com/sirupsen/logrus.(*Entry).Warn>
 29f0d74:	e9 0c fd ff ff       	jmp    29f0a85 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xcc5>
 29f0d79:	48 8b 84 24 d0 00 00 	mov    rax,QWORD PTR [rsp+0xd0]
 29f0d80:	00 
 29f0d81:	e8 2a 3f c5 fe       	call   1644cb0 <runtime.gcWriteBarrier>
 29f0d86:	eb 85                	jmp    29f0d0d <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xf4d>
 29f0d88:	48 8b 84 24 d0 00 00 	mov    rax,QWORD PTR [rsp+0xd0]
 29f0d8f:	00 
 29f0d90:	e8 1b 3f c5 fe       	call   1644cb0 <runtime.gcWriteBarrier>
 29f0d95:	e9 e0 fe ff ff       	jmp    29f0c7a <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xeba>
 29f0d9a:	48 8b 84 24 d0 00 00 	mov    rax,QWORD PTR [rsp+0xd0]
 29f0da1:	00 
 29f0da2:	e8 09 3f c5 fe       	call   1644cb0 <runtime.gcWriteBarrier>
 29f0da7:	e9 37 fe ff ff       	jmp    29f0be3 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xe23>
 29f0dac:	48 8b 48 08          	mov    rcx,QWORD PTR [rax+0x8]
 29f0db0:	84 01                	test   BYTE PTR [rcx],al
 29f0db2:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 29f0db6:	e8 e5 c2 c5 fe       	call   164d0a0 <sync.(*Mutex).Lock>
 29f0dbb:	48 8b 84 24 b8 00 00 	mov    rax,QWORD PTR [rsp+0xb8]
 29f0dc2:	00 
 29f0dc3:	48 8b 48 08          	mov    rcx,QWORD PTR [rax+0x8]
 29f0dc7:	84 01                	test   BYTE PTR [rcx],al
 29f0dc9:	48 89 4c 24 10       	mov    QWORD PTR [rsp+0x10],rcx
 29f0dce:	c7 04 24 08 00 00 00 	mov    DWORD PTR [rsp],0x8
 29f0dd5:	48 8d 0d 6c c9 e4 00 	lea    rcx,[rip+0xe4c96c]        # 383d748 <sync.(*Mutex).Unlock·f>
 29f0ddc:	48 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],rcx
 29f0de1:	e8 9a 2e c2 fe       	call   1613c80 <runtime.deferproc>
 29f0de6:	85 c0                	test   eax,eax
 29f0de8:	0f 85 b6 00 00 00    	jne    29f0ea4 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x10e4>
 29f0dee:	48 8b 84 24 e0 02 00 	mov    rax,QWORD PTR [rsp+0x2e0]
 29f0df5:	00 
 29f0df6:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f0dfa:	48 8b 8c 24 b8 00 00 	mov    rcx,QWORD PTR [rsp+0xb8]
 29f0e01:	00 
 29f0e02:	48 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],rcx
 29f0e07:	e8 04 ec fe ff       	call   29dfa10 <github.com/docker/docker/daemon.(*Daemon).updateHealthMonitor>
 29f0e0c:	48 8b 84 24 e0 02 00 	mov    rax,QWORD PTR [rsp+0x2e0]
 29f0e13:	00 
 29f0e14:	48 8b 48 38          	mov    rcx,QWORD PTR [rax+0x38]
 29f0e18:	48 8b 50 30          	mov    rdx,QWORD PTR [rax+0x30]
 29f0e1c:	48 89 54 24 08       	mov    QWORD PTR [rsp+0x8],rdx
 29f0e21:	48 89 4c 24 10       	mov    QWORD PTR [rsp+0x10],rcx
 29f0e26:	48 8b 8c 24 b8 00 00 	mov    rcx,QWORD PTR [rsp+0xb8]
 29f0e2d:	00 
 29f0e2e:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 29f0e32:	e8 29 4e 67 ff       	call   2065c60 <github.com/docker/docker/container.(*Container).CheckpointTo>
 29f0e37:	48 8b 44 24 20       	mov    rax,QWORD PTR [rsp+0x20]
 29f0e3c:	48 8b 4c 24 18       	mov    rcx,QWORD PTR [rsp+0x18]
 29f0e41:	48 85 c9             	test   rcx,rcx
 29f0e44:	75 38                	jne    29f0e7e <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x10be>
 29f0e46:	48 8b 84 24 e0 02 00 	mov    rax,QWORD PTR [rsp+0x2e0]
 29f0e4d:	00 
 29f0e4e:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f0e52:	48 8b 84 24 b8 00 00 	mov    rax,QWORD PTR [rsp+0xb8]
 29f0e59:	00 
 29f0e5a:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
 29f0e5f:	48 8d 05 82 07 1f 00 	lea    rax,[rip+0x1f0782]        # 2be15e8 <go.string.*+0xa88>
 29f0e66:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
 29f0e6b:	48 c7 44 24 18 03 00 	mov    QWORD PTR [rsp+0x18],0x3
 29f0e72:	00 00 
 29f0e74:	e8 17 63 fe ff       	call   29d7190 <github.com/docker/docker/daemon.(*Daemon).LogContainerEvent>
 29f0e79:	e9 07 fc ff ff       	jmp    29f0a85 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xcc5>
 29f0e7e:	48 89 8c 24 60 03 00 	mov    QWORD PTR [rsp+0x360],rcx
 29f0e85:	00 
 29f0e86:	48 89 84 24 68 03 00 	mov    QWORD PTR [rsp+0x368],rax
 29f0e8d:	00 
 29f0e8e:	90                   	nop
 29f0e8f:	e8 fc 36 c2 fe       	call   1614590 <runtime.deferreturn>
 29f0e94:	48 8b ac 24 d0 02 00 	mov    rbp,QWORD PTR [rsp+0x2d0]
 29f0e9b:	00 
 29f0e9c:	48 81 c4 d8 02 00 00 	add    rsp,0x2d8
 29f0ea3:	c3                   	ret    
 29f0ea4:	90                   	nop
 29f0ea5:	e8 e6 36 c2 fe       	call   1614590 <runtime.deferreturn>
 29f0eaa:	48 8b ac 24 d0 02 00 	mov    rbp,QWORD PTR [rsp+0x2d0]
 29f0eb1:	00 
 29f0eb2:	48 81 c4 d8 02 00 00 	add    rsp,0x2d8
 29f0eb9:	c3                   	ret    
 29f0eba:	48 83 f9 04          	cmp    rcx,0x4
 29f0ebe:	e9 b2 f0 ff ff       	jmp    29eff75 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x1b5>
 29f0ec3:	48 83 f9 04          	cmp    rcx,0x4
 29f0ec7:	48 8b 94 24 f8 02 00 	mov    rdx,QWORD PTR [rsp+0x2f8]
 29f0ece:	00 
 29f0ecf:	e9 a1 f0 ff ff       	jmp    29eff75 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x1b5>
 29f0ed4:	0f 84 75 04 00 00    	je     29f134f <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x158f>
 29f0eda:	48 83 f9 05          	cmp    rcx,0x5
 29f0ede:	0f 85 5e 04 00 00    	jne    29f1342 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x1582>
 29f0ee4:	48 8b 94 24 f8 02 00 	mov    rdx,QWORD PTR [rsp+0x2f8]
 29f0eeb:	00 
 29f0eec:	8b 1a                	mov    ebx,DWORD PTR [rdx]
 29f0eee:	81 fb 73 74 61 72    	cmp    ebx,0x72617473
 29f0ef4:	75 0d                	jne    29f0f03 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x1143>
 29f0ef6:	0f b6 5a 04          	movzx  ebx,BYTE PTR [rdx+0x4]
 29f0efa:	80 fb 74             	cmp    bl,0x74
 29f0efd:	0f 84 d3 02 00 00    	je     29f11d6 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x1416>
 29f0f03:	48 83 f9 06          	cmp    rcx,0x6
 29f0f07:	75 19                	jne    29f0f22 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x1162>
 29f0f09:	8b 1a                	mov    ebx,DWORD PTR [rdx]
 29f0f0b:	81 fb 70 61 75 73    	cmp    ebx,0x73756170
 29f0f11:	75 0f                	jne    29f0f22 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x1162>
 29f0f13:	0f b7 5a 04          	movzx  ebx,WORD PTR [rdx+0x4]
 29f0f17:	66 81 fb 65 64       	cmp    bx,0x6465
 29f0f1c:	0f 84 74 01 00 00    	je     29f1096 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x12d6>
 29f0f22:	48 83 f9 07          	cmp    rcx,0x7
 29f0f26:	0f 85 59 fb ff ff    	jne    29f0a85 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xcc5>
 29f0f2c:	8b 0a                	mov    ecx,DWORD PTR [rdx]
 29f0f2e:	81 f9 72 65 73 75    	cmp    ecx,0x75736572
 29f0f34:	0f 85 4b fb ff ff    	jne    29f0a85 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xcc5>
 29f0f3a:	0f b7 4a 04          	movzx  ecx,WORD PTR [rdx+0x4]
 29f0f3e:	66 81 f9 6d 65       	cmp    cx,0x656d
 29f0f43:	0f 85 3c fb ff ff    	jne    29f0a85 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xcc5>
 29f0f49:	0f b6 4a 06          	movzx  ecx,BYTE PTR [rdx+0x6]
 29f0f4d:	80 f9 64             	cmp    cl,0x64
 29f0f50:	0f 85 2f fb ff ff    	jne    29f0a85 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xcc5>
 29f0f56:	48 8b 48 08          	mov    rcx,QWORD PTR [rax+0x8]
 29f0f5a:	84 01                	test   BYTE PTR [rcx],al
 29f0f5c:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 29f0f60:	e8 3b c1 c5 fe       	call   164d0a0 <sync.(*Mutex).Lock>
 29f0f65:	48 8b 84 24 b8 00 00 	mov    rax,QWORD PTR [rsp+0xb8]
 29f0f6c:	00 
 29f0f6d:	48 8b 48 08          	mov    rcx,QWORD PTR [rax+0x8]
 29f0f71:	84 01                	test   BYTE PTR [rcx],al
 29f0f73:	48 89 4c 24 10       	mov    QWORD PTR [rsp+0x10],rcx
 29f0f78:	c7 04 24 08 00 00 00 	mov    DWORD PTR [rsp],0x8
 29f0f7f:	48 8d 0d c2 c7 e4 00 	lea    rcx,[rip+0xe4c7c2]        # 383d748 <sync.(*Mutex).Unlock·f>
 29f0f86:	48 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],rcx
 29f0f8b:	e8 f0 2c c2 fe       	call   1613c80 <runtime.deferproc>
 29f0f90:	85 c0                	test   eax,eax
 29f0f92:	0f 85 e8 00 00 00    	jne    29f1080 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x12c0>
 29f0f98:	48 8b 84 24 b8 00 00 	mov    rax,QWORD PTR [rsp+0xb8]
 29f0f9f:	00 
 29f0fa0:	48 8b 48 08          	mov    rcx,QWORD PTR [rax+0x8]
 29f0fa4:	0f b6 51 09          	movzx  edx,BYTE PTR [rcx+0x9]
 29f0fa8:	84 d2                	test   dl,dl
 29f0faa:	0f 84 d5 fa ff ff    	je     29f0a85 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xcc5>
 29f0fb0:	c6 41 09 00          	mov    BYTE PTR [rcx+0x9],0x0
 29f0fb4:	48 8b 8c 24 e0 02 00 	mov    rcx,QWORD PTR [rsp+0x2e0]
 29f0fbb:	00 
 29f0fbc:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 29f0fc0:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
 29f0fc5:	e8 a6 eb ff ff       	call   29efb70 <github.com/docker/docker/daemon.(*Daemon).setStateCounter>
 29f0fca:	48 8b 84 24 e0 02 00 	mov    rax,QWORD PTR [rsp+0x2e0]
 29f0fd1:	00 
 29f0fd2:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f0fd6:	48 8b 8c 24 b8 00 00 	mov    rcx,QWORD PTR [rsp+0xb8]
 29f0fdd:	00 
 29f0fde:	48 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],rcx
 29f0fe3:	e8 28 ea fe ff       	call   29dfa10 <github.com/docker/docker/daemon.(*Daemon).updateHealthMonitor>
 29f0fe8:	48 8b 84 24 e0 02 00 	mov    rax,QWORD PTR [rsp+0x2e0]
 29f0fef:	00 
 29f0ff0:	48 8b 48 38          	mov    rcx,QWORD PTR [rax+0x38]
 29f0ff4:	48 8b 50 30          	mov    rdx,QWORD PTR [rax+0x30]
 29f0ff8:	48 89 54 24 08       	mov    QWORD PTR [rsp+0x8],rdx
 29f0ffd:	48 89 4c 24 10       	mov    QWORD PTR [rsp+0x10],rcx
 29f1002:	48 8b 8c 24 b8 00 00 	mov    rcx,QWORD PTR [rsp+0xb8]
 29f1009:	00 
 29f100a:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 29f100e:	e8 4d 4c 67 ff       	call   2065c60 <github.com/docker/docker/container.(*Container).CheckpointTo>
 29f1013:	48 8b 44 24 18       	mov    rax,QWORD PTR [rsp+0x18]
 29f1018:	48 8b 4c 24 20       	mov    rcx,QWORD PTR [rsp+0x20]
 29f101d:	48 85 c0             	test   rax,rax
 29f1020:	75 38                	jne    29f105a <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x129a>
 29f1022:	48 8b 84 24 e0 02 00 	mov    rax,QWORD PTR [rsp+0x2e0]
 29f1029:	00 
 29f102a:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f102e:	48 8b 84 24 b8 00 00 	mov    rax,QWORD PTR [rsp+0xb8]
 29f1035:	00 
 29f1036:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
 29f103b:	48 8d 05 e8 69 1f 00 	lea    rax,[rip+0x1f69e8]        # 2be7a2a <go.string.*+0x6eca>
 29f1042:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
 29f1047:	48 c7 44 24 18 07 00 	mov    QWORD PTR [rsp+0x18],0x7
 29f104e:	00 00 
 29f1050:	e8 3b 61 fe ff       	call   29d7190 <github.com/docker/docker/daemon.(*Daemon).LogContainerEvent>
 29f1055:	e9 2b fa ff ff       	jmp    29f0a85 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xcc5>
 29f105a:	48 89 84 24 60 03 00 	mov    QWORD PTR [rsp+0x360],rax
 29f1061:	00 
 29f1062:	48 89 8c 24 68 03 00 	mov    QWORD PTR [rsp+0x368],rcx
 29f1069:	00 
 29f106a:	90                   	nop
 29f106b:	e8 20 35 c2 fe       	call   1614590 <runtime.deferreturn>
 29f1070:	48 8b ac 24 d0 02 00 	mov    rbp,QWORD PTR [rsp+0x2d0]
 29f1077:	00 
 29f1078:	48 81 c4 d8 02 00 00 	add    rsp,0x2d8
 29f107f:	c3                   	ret    
 29f1080:	90                   	nop
 29f1081:	e8 0a 35 c2 fe       	call   1614590 <runtime.deferreturn>
 29f1086:	48 8b ac 24 d0 02 00 	mov    rbp,QWORD PTR [rsp+0x2d0]
 29f108d:	00 
 29f108e:	48 81 c4 d8 02 00 00 	add    rsp,0x2d8
 29f1095:	c3                   	ret    
 29f1096:	48 8b 48 08          	mov    rcx,QWORD PTR [rax+0x8]
 29f109a:	84 01                	test   BYTE PTR [rcx],al
 29f109c:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 29f10a0:	e8 fb bf c5 fe       	call   164d0a0 <sync.(*Mutex).Lock>
 29f10a5:	48 8b 84 24 b8 00 00 	mov    rax,QWORD PTR [rsp+0xb8]
 29f10ac:	00 
 29f10ad:	48 8b 48 08          	mov    rcx,QWORD PTR [rax+0x8]
 29f10b1:	84 01                	test   BYTE PTR [rcx],al
 29f10b3:	48 89 4c 24 10       	mov    QWORD PTR [rsp+0x10],rcx
 29f10b8:	c7 04 24 08 00 00 00 	mov    DWORD PTR [rsp],0x8
 29f10bf:	48 8d 0d 82 c6 e4 00 	lea    rcx,[rip+0xe4c682]        # 383d748 <sync.(*Mutex).Unlock·f>
 29f10c6:	48 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],rcx
 29f10cb:	e8 b0 2b c2 fe       	call   1613c80 <runtime.deferproc>
 29f10d0:	85 c0                	test   eax,eax
 29f10d2:	0f 85 e8 00 00 00    	jne    29f11c0 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x1400>
 29f10d8:	48 8b 84 24 b8 00 00 	mov    rax,QWORD PTR [rsp+0xb8]
 29f10df:	00 
 29f10e0:	48 8b 48 08          	mov    rcx,QWORD PTR [rax+0x8]
 29f10e4:	0f b6 51 09          	movzx  edx,BYTE PTR [rcx+0x9]
 29f10e8:	84 d2                	test   dl,dl
 29f10ea:	0f 85 95 f9 ff ff    	jne    29f0a85 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xcc5>
 29f10f0:	c6 41 09 01          	mov    BYTE PTR [rcx+0x9],0x1
 29f10f4:	48 8b 8c 24 e0 02 00 	mov    rcx,QWORD PTR [rsp+0x2e0]
 29f10fb:	00 
 29f10fc:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 29f1100:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
 29f1105:	e8 66 ea ff ff       	call   29efb70 <github.com/docker/docker/daemon.(*Daemon).setStateCounter>
 29f110a:	48 8b 84 24 e0 02 00 	mov    rax,QWORD PTR [rsp+0x2e0]
 29f1111:	00 
 29f1112:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f1116:	48 8b 8c 24 b8 00 00 	mov    rcx,QWORD PTR [rsp+0xb8]
 29f111d:	00 
 29f111e:	48 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],rcx
 29f1123:	e8 e8 e8 fe ff       	call   29dfa10 <github.com/docker/docker/daemon.(*Daemon).updateHealthMonitor>
 29f1128:	48 8b 84 24 e0 02 00 	mov    rax,QWORD PTR [rsp+0x2e0]
 29f112f:	00 
 29f1130:	48 8b 48 38          	mov    rcx,QWORD PTR [rax+0x38]
 29f1134:	48 8b 50 30          	mov    rdx,QWORD PTR [rax+0x30]
 29f1138:	48 89 54 24 08       	mov    QWORD PTR [rsp+0x8],rdx
 29f113d:	48 89 4c 24 10       	mov    QWORD PTR [rsp+0x10],rcx
 29f1142:	48 8b 8c 24 b8 00 00 	mov    rcx,QWORD PTR [rsp+0xb8]
 29f1149:	00 
 29f114a:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 29f114e:	e8 0d 4b 67 ff       	call   2065c60 <github.com/docker/docker/container.(*Container).CheckpointTo>
 29f1153:	48 8b 44 24 20       	mov    rax,QWORD PTR [rsp+0x20]
 29f1158:	48 8b 4c 24 18       	mov    rcx,QWORD PTR [rsp+0x18]
 29f115d:	48 85 c9             	test   rcx,rcx
 29f1160:	75 38                	jne    29f119a <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x13da>
 29f1162:	48 8b 84 24 e0 02 00 	mov    rax,QWORD PTR [rsp+0x2e0]
 29f1169:	00 
 29f116a:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f116e:	48 8b 84 24 b8 00 00 	mov    rax,QWORD PTR [rsp+0xb8]
 29f1175:	00 
 29f1176:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
 29f117b:	48 8d 05 c5 25 1f 00 	lea    rax,[rip+0x1f25c5]        # 2be3747 <go.string.*+0x2be7>
 29f1182:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
 29f1187:	48 c7 44 24 18 05 00 	mov    QWORD PTR [rsp+0x18],0x5
 29f118e:	00 00 
 29f1190:	e8 fb 5f fe ff       	call   29d7190 <github.com/docker/docker/daemon.(*Daemon).LogContainerEvent>
 29f1195:	e9 eb f8 ff ff       	jmp    29f0a85 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xcc5>
 29f119a:	48 89 8c 24 60 03 00 	mov    QWORD PTR [rsp+0x360],rcx
 29f11a1:	00 
 29f11a2:	48 89 84 24 68 03 00 	mov    QWORD PTR [rsp+0x368],rax
 29f11a9:	00 
 29f11aa:	90                   	nop
 29f11ab:	e8 e0 33 c2 fe       	call   1614590 <runtime.deferreturn>
 29f11b0:	48 8b ac 24 d0 02 00 	mov    rbp,QWORD PTR [rsp+0x2d0]
 29f11b7:	00 
 29f11b8:	48 81 c4 d8 02 00 00 	add    rsp,0x2d8
 29f11bf:	c3                   	ret    
 29f11c0:	90                   	nop
 29f11c1:	e8 ca 33 c2 fe       	call   1614590 <runtime.deferreturn>
 29f11c6:	48 8b ac 24 d0 02 00 	mov    rbp,QWORD PTR [rsp+0x2d0]
 29f11cd:	00 
 29f11ce:	48 81 c4 d8 02 00 00 	add    rsp,0x2d8
 29f11d5:	c3                   	ret    
 29f11d6:	48 8b 48 08          	mov    rcx,QWORD PTR [rax+0x8]
 29f11da:	84 01                	test   BYTE PTR [rcx],al
 29f11dc:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 29f11e0:	e8 bb be c5 fe       	call   164d0a0 <sync.(*Mutex).Lock>
 29f11e5:	48 8b 84 24 b8 00 00 	mov    rax,QWORD PTR [rsp+0xb8]
 29f11ec:	00 
 29f11ed:	48 8b 48 08          	mov    rcx,QWORD PTR [rax+0x8]
 29f11f1:	84 01                	test   BYTE PTR [rcx],al
 29f11f3:	48 89 4c 24 10       	mov    QWORD PTR [rsp+0x10],rcx
 29f11f8:	c7 04 24 08 00 00 00 	mov    DWORD PTR [rsp],0x8
 29f11ff:	48 8d 0d 42 c5 e4 00 	lea    rcx,[rip+0xe4c542]        # 383d748 <sync.(*Mutex).Unlock·f>
 29f1206:	48 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],rcx
 29f120b:	e8 70 2a c2 fe       	call   1613c80 <runtime.deferproc>
 29f1210:	85 c0                	test   eax,eax
 29f1212:	0f 85 14 01 00 00    	jne    29f132c <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x156c>
 29f1218:	48 8b 84 24 b8 00 00 	mov    rax,QWORD PTR [rsp+0xb8]
 29f121f:	00 
 29f1220:	48 8b 48 08          	mov    rcx,QWORD PTR [rax+0x8]
 29f1224:	0f b6 51 08          	movzx  edx,BYTE PTR [rcx+0x8]
 29f1228:	84 d2                	test   dl,dl
 29f122a:	0f 85 55 f8 ff ff    	jne    29f0a85 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xcc5>
 29f1230:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 29f1234:	8b 84 24 28 03 00 00 	mov    eax,DWORD PTR [rsp+0x328]
 29f123b:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
 29f1240:	c6 44 24 10 00       	mov    BYTE PTR [rsp+0x10],0x0
 29f1245:	e8 86 ea 67 ff       	call   206fcd0 <github.com/docker/docker/container.(*State).SetRunning>
 29f124a:	48 8b 84 24 b8 00 00 	mov    rax,QWORD PTR [rsp+0xb8]
 29f1251:	00 
 29f1252:	c6 80 21 01 00 00 00 	mov    BYTE PTR [rax+0x121],0x0
 29f1259:	c6 80 20 01 00 00 01 	mov    BYTE PTR [rax+0x120],0x1
 29f1260:	48 8b 8c 24 e0 02 00 	mov    rcx,QWORD PTR [rsp+0x2e0]
 29f1267:	00 
 29f1268:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 29f126c:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
 29f1271:	e8 fa e8 ff ff       	call   29efb70 <github.com/docker/docker/daemon.(*Daemon).setStateCounter>
 29f1276:	48 8b 84 24 e0 02 00 	mov    rax,QWORD PTR [rsp+0x2e0]
 29f127d:	00 
 29f127e:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f1282:	48 8b 8c 24 b8 00 00 	mov    rcx,QWORD PTR [rsp+0xb8]
 29f1289:	00 
 29f128a:	48 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],rcx
 29f128f:	e8 8c e8 fe ff       	call   29dfb20 <github.com/docker/docker/daemon.(*Daemon).initHealthMonitor>
 29f1294:	48 8b 84 24 e0 02 00 	mov    rax,QWORD PTR [rsp+0x2e0]
 29f129b:	00 
 29f129c:	48 8b 48 38          	mov    rcx,QWORD PTR [rax+0x38]
 29f12a0:	48 8b 50 30          	mov    rdx,QWORD PTR [rax+0x30]
 29f12a4:	48 89 54 24 08       	mov    QWORD PTR [rsp+0x8],rdx
 29f12a9:	48 89 4c 24 10       	mov    QWORD PTR [rsp+0x10],rcx
 29f12ae:	48 8b 8c 24 b8 00 00 	mov    rcx,QWORD PTR [rsp+0xb8]
 29f12b5:	00 
 29f12b6:	48 89 0c 24          	mov    QWORD PTR [rsp],rcx
 29f12ba:	e8 a1 49 67 ff       	call   2065c60 <github.com/docker/docker/container.(*Container).CheckpointTo>
 29f12bf:	48 8b 44 24 20       	mov    rax,QWORD PTR [rsp+0x20]
 29f12c4:	48 8b 4c 24 18       	mov    rcx,QWORD PTR [rsp+0x18]
 29f12c9:	48 85 c9             	test   rcx,rcx
 29f12cc:	75 38                	jne    29f1306 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x1546>
 29f12ce:	48 8b 84 24 e0 02 00 	mov    rax,QWORD PTR [rsp+0x2e0]
 29f12d5:	00 
 29f12d6:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f12da:	48 8b 84 24 b8 00 00 	mov    rax,QWORD PTR [rsp+0xb8]
 29f12e1:	00 
 29f12e2:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
 29f12e7:	48 8d 05 a7 26 1f 00 	lea    rax,[rip+0x1f26a7]        # 2be3995 <go.string.*+0x2e35>
 29f12ee:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
 29f12f3:	48 c7 44 24 18 05 00 	mov    QWORD PTR [rsp+0x18],0x5
 29f12fa:	00 00 
 29f12fc:	e8 8f 5e fe ff       	call   29d7190 <github.com/docker/docker/daemon.(*Daemon).LogContainerEvent>
 29f1301:	e9 7f f7 ff ff       	jmp    29f0a85 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0xcc5>
 29f1306:	48 89 8c 24 60 03 00 	mov    QWORD PTR [rsp+0x360],rcx
 29f130d:	00 
 29f130e:	48 89 84 24 68 03 00 	mov    QWORD PTR [rsp+0x368],rax
 29f1315:	00 
 29f1316:	90                   	nop
 29f1317:	e8 74 32 c2 fe       	call   1614590 <runtime.deferreturn>
 29f131c:	48 8b ac 24 d0 02 00 	mov    rbp,QWORD PTR [rsp+0x2d0]
 29f1323:	00 
 29f1324:	48 81 c4 d8 02 00 00 	add    rsp,0x2d8
 29f132b:	c3                   	ret    
 29f132c:	90                   	nop
 29f132d:	e8 5e 32 c2 fe       	call   1614590 <runtime.deferreturn>
 29f1332:	48 8b ac 24 d0 02 00 	mov    rbp,QWORD PTR [rsp+0x2d0]
 29f1339:	00 
 29f133a:	48 81 c4 d8 02 00 00 	add    rsp,0x2d8
 29f1341:	c3                   	ret    
 29f1342:	48 8b 94 24 f8 02 00 	mov    rdx,QWORD PTR [rsp+0x2f8]
 29f1349:	00 
 29f134a:	e9 b4 fb ff ff       	jmp    29f0f03 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x1143>
 29f134f:	48 8b 84 24 f8 02 00 	mov    rax,QWORD PTR [rsp+0x2f8]
 29f1356:	00 
 29f1357:	48 89 04 24          	mov    QWORD PTR [rsp],rax
 29f135b:	48 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],rcx
 29f1360:	48 8d 15 dc 0c 1f 00 	lea    rdx,[rip+0x1f0cdc]        # 2be2043 <go.string.*+0x14e3>
 29f1367:	48 89 54 24 10       	mov    QWORD PTR [rsp+0x10],rdx
 29f136c:	48 c7 44 24 18 04 00 	mov    QWORD PTR [rsp+0x18],0x4
 29f1373:	00 00 
 29f1375:	e8 d6 2f c5 fe       	call   1644350 <runtime.cmpstring>
 29f137a:	48 8b 44 24 20       	mov    rax,QWORD PTR [rsp+0x20]
 29f137f:	48 85 c0             	test   rax,rax
 29f1382:	7f 15                	jg     29f1399 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x15d9>
 29f1384:	48 8b 84 24 b8 00 00 	mov    rax,QWORD PTR [rsp+0xb8]
 29f138b:	00 
 29f138c:	48 8b 8c 24 00 03 00 	mov    rcx,QWORD PTR [rsp+0x300]
 29f1393:	00 
 29f1394:	e9 ab eb ff ff       	jmp    29eff44 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x184>
 29f1399:	48 8b 84 24 b8 00 00 	mov    rax,QWORD PTR [rsp+0xb8]
 29f13a0:	00 
 29f13a1:	48 8b 8c 24 00 03 00 	mov    rcx,QWORD PTR [rsp+0x300]
 29f13a8:	00 
 29f13a9:	e9 2c fb ff ff       	jmp    29f0eda <github.com/docker/docker/daemon.(*Daemon).ProcessEvent+0x111a>
 29f13ae:	e8 7d 0e c5 fe       	call   1642230 <runtime.morestack_noctxt>
 29f13b3:	e9 08 ea ff ff       	jmp    29efdc0 <github.com/docker/docker/daemon.(*Daemon).ProcessEvent>
 29f13b8:	cc                   	int3   
 29f13b9:	cc                   	int3   
 29f13ba:	cc                   	int3   
 29f13bb:	cc                   	int3   
 29f13bc:	cc                   	int3   
 29f13bd:	cc                   	int3   
 29f13be:	cc                   	int3   
 29f13bf:	cc                   	int3   

