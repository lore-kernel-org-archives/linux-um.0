Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kyle Huey <me@kylehuey.com>
Subject: [PATCH v14 0/9] x86/arch_prctl Add ARCH_[GET|SET]_CPUID for controlling the CPUID instruction
Date: Wed,  8 Feb 2017 00:09:08 -0800
Message-Id: <20170208080917.24320-1-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

rr (http://rr-project.org/), a userspace record-and-replay reverse-
execution debugger, would like to trap and emulate the CPUID instruction.
This would allow us to a) mask away certain hardware features that rr does
not support (e.g. RDRAND) and b) enable trace portability across machines
by providing constant results.

Newer Intel CPUs (Ivy Bridge and later) can fault when CPUID is executed at
CPL > 0. Expose this capability to userspace as a new pair of arch_prctls,
ARCH_GET_CPUID and ARCH_SET_CPUID.

Since v13:
All: rebased on top of tglx's __switch_to_xtra patches
(https://lkml.org/lkml/2016/12/15/432)

Patch 6: x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
- Removed bogus assertion about interrupts

Patch 9: x86/arch_prctl: Rename 'code' argument to 'option'
- New

Three issues were raised last year on the v13 patches. tglx pointed out
that the lock checking assertion in patch 6 was bogus, and it has been
removed. ingo asked that we rename the second argument of arch_prctl to
option, which patch 9 was added to do.

The third issue raised was about performance and code generation. With the
__switch_to_xtra optimizations I suggested in my response that are
implemented in tglx's patches, the extra burden this feature imposes on
context switches that fall into __switch_to_xtra but do not use CPUID faulting
is a single AND and branch.  Compare,

Before:
276:	49 31 dc		xor    %rbx,%r12
279:	41 f7 c4 00 00 00 02 	test   $0x2000000,%r12d
280:	75 43                	jne    2c5 <__switch_to_xtra+0x95>
282:	41 f7 c4 00 00 01 00 	test   $0x10000,%r12d
289:    74 17                   je     2a2 <__switch_to_xtra+0x72>
28b:    65 48 8b 05 00 00 00    mov    %gs:0x0(%rip),%rax        # 293 <__switch_to_xtra+0x63>
292:    00
293:	48 83 f0 04		xor    $0x4,%rax
297:	65 48 89 05 00 00 00 	mov    %rax,%gs:0x0(%rip)        # 29f <__switch_to_xtra+0x6f>
29e:	00
29f:	0f 22 e0		mov    %rax,%cr4

After:
306:	4c 31 e3		xor    %r12,%rbx
309:	f7 c3 00 00 00 02    	test   $0x2000000,%ebx
30f:	0f 85 87 00 00 00    	jne    39c <__switch_to_xtra+0xdc>
315:    f7 c3 00 00 01 00       test   $0x10000,%ebx
31b:    74 17                   je     334 <__switch_to_xtra+0x74>
31d:    65 48 8b 05 00 00 00    mov    %gs:0x0(%rip),%rax        # 325 <__switch_to_xtra+0x65>
324:    00
325:    48 83 f0 04		xor    $0x4,%rax
329:    65 48 89 05 00 00 00 	mov    %rax,%gs:0x0(%rip)        # 331 <__switch_to_xtra+0x71>
330:	00
331:	0f 22 e0		mov    %rax,%cr4
334:    80 e7 80             	and    $0x80,%bh
337:    75 23                   jne    35c <__switch_to_xtra+0x9c>

And this is after the optimizations removed 3 conditional branches from
__switch_to_xtra, so we're still ahead a net 2 branches.

The generated code for set_cpuid_faulting is,

With CONFIG_PARAVIRT=n, inlined into __switch_to_xtra:
35c:    65 48 8b 05 00 00 00	mov    %gs:0x0(%rip),%rax        # 364 <__switch_to_xtra+0xa4>
363:	00
364:	48 83 e0 fe		and    $0xfffffffffffffffe,%rax
368:	b9 40 01 00 00       	mov    $0x140,%ecx
36d:    48 89 c2                mov    %rax,%rdx
370:    4c 89 e0                mov    %r12,%rax
373:    48 c1 e8 0f             shr    $0xf,%rax
377:    83 e0 01                and    $0x1,%eax
37a:    48 09 d0                or     %rdx,%rax
37d:    48 89 c2                mov    %rax,%rdx
380:	65 48 89 05 00 00 00    mov    %rax,%gs:0x0(%rip)        # 388 <__switch_to_xtra+0xc8>
387:	00
388:    48 c1 ea 20		shr    $0x20,%rdx
38c:    0f 30                   wrmsr

With CONFIG_PARAVIRT=y:

in __switch_to_xtra:
354:    80 e7 80                and    $0x80,%bh
357:    74 0f                   je     368 <__switch_to_xtra+0x88>
359:    4c 89 e7                mov    %r12,%rdi
35c:    48 c1 ef 0f             shr    $0xf,%rdi
360:    83 e7 01                and    $0x1,%edi
363:    e8 98 fc ff ff          callq  0 <set_cpuid_faulting>

0000000000000000 <set_cpuid_faulting>:
0:    e8 00 00 00 00          callq  5 <set_cpuid_faulting+0x5>
5:    55                      push   %rbp
6:    65 48 8b 15 00 00 00    mov    %gs:0x0(%rip),%rdx        # e <set_cpuid_faulting+0xe>
d:    00
e:    48 89 d0                mov    %rdx,%rax
11:   40 0f b6 d7             movzbl %dil,%edx
15:   48 89 e5                mov    %rsp,%rbp
18:   48 83 e0 fe             and    $0xfffffffffffffffe,%rax
1c:   bf 40 01 00 00          mov    $0x140,%edi
21:   48 09 c2                or     %rax,%rdx
24:   89 d6                   mov    %edx,%esi
26:   65 48 89 15 00 00 00    mov    %rdx,%gs:0x0(%rip)        # 2e <set_cpuid_faulting+0x2e>
2d:   00
2e:   48 c1 ea 20             shr    $0x20,%rdx
32:   ff 14 25 00 00 00 00    callq  *0x0
39:   5d                      pop    %rbp
3a:   c3                      retq

While these sequences are less efficient than the "load msr from the task struct and wrmsr"
sequence that Ingo's suggestion would produce, this is entirely reasonable code and avoids
taking up 8 bytes in the task_struct that will almost never be used.

As I said last year, obviously I want to get this into the kernel or I wouldn't be here.
So if Ingo or others insist on caching the MSR in the task_struct I'll do it, but I still
think this is a good approach.

- Kyle


