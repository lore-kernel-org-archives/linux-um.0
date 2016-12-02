Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 2 Dec 2016 11:29:42 +0100
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v13 0/8] x86/arch_prctl Add ARCH_[GET|SET]_CPUID for
 controlling the CPUID instruction
Message-ID: <20161202102942.GA17332@gmail.com>
References: <20161128030521.4423-1-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161128030521.4423-1-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


* Kyle Huey <me@kylehuey.com> wrote:

> rr (http://rr-project.org/), a userspace record-and-replay reverse-
> execution debugger, would like to trap and emulate the CPUID instruction.
> This would allow us to a) mask away certain hardware features that rr does
> not support (e.g. RDRAND) and b) enable trace portability across machines
> by providing constant results.
> 
> Newer Intel CPUs (Ivy Bridge and later) can fault when CPUID is executed at
> CPL > 0. Expose this capability to userspace as a new pair of arch_prctls,
> ARCH_GET_CPUID and ARCH_SET_CPUID.
> 
> Since v12:
> Patch 4: x86/syscalls/32: Wire up arch_prctl on x86-32
> - compat_sys_arch_prctl prototype has argument names.

So while I am fine with the feature, I'm still unconvinced about the 
implementation:

1)

As I pointed out before, the arbitrary 'code' argument name x86-ism should be 
changed to 'option' like the canonical core kernel option name is for prctls(). 

This is still unfixed.

2)

As I complained about in my first review, TIF_NOCPUID flag is too far removed from 
the value what will be written into the MSR.

The result is poor code generation on 64-bit defconfig+CONFIG_PREEMPT=y:

        if (test_tsk_thread_flag(prev_p, TIF_NOCPUID) ^
            test_tsk_thread_flag(next_p, TIF_NOCPUID)) {
		set_cpuid_faulting(test_tsk_thread_flag(next_p, TIF_NOCPUID));

is compiled as:

  476:   49 8b 06                mov    (%r14),%rax
  479:   49 8b 55 00             mov    0x0(%r13),%rdx
  47d:   48 c1 e8 0f             shr    $0xf,%rax
  481:   48 c1 ea 0f             shr    $0xf,%rdx
  485:   83 e2 01                and    $0x1,%edx
  488:   83 e0 01                and    $0x1,%eax
  48b:   38 c2                   cmp    %al,%dl
  48d:   74 10                   je     49f <__switch_to_xtra+0x9f>
  48f:   49 8b 7d 00             mov    0x0(%r13),%rdi
  493:   48 c1 ef 0f             shr    $0xf,%rdi
  497:   83 e7 01                and    $0x1,%edi
  49a:   e8 61 fb ff ff          callq  0 <set_cpuid_faulting>

... the first 7 instructions burdens all __switch_to_xtra() users, not just the 
faulting-CPUID users.

The set_cpuid_faulting() call is also unnecessary and the set_cpuid_faulting() 
call generates into an obscene sequence of:

0000000000000000 <set_cpuid_faulting>:
   0:	8b 15 00 00 00 00    	mov    0x0(%rip),%edx        # 6 <set_cpuid_faulting+0x6>
   6:	55                   	push   %rbp
   7:	48 89 e5             	mov    %rsp,%rbp
   a:	53                   	push   %rbx
   b:	40 0f b6 df          	movzbl %dil,%ebx
   f:	85 d2                	test   %edx,%edx
  11:	75 07                	jne    1a <set_cpuid_faulting+0x1a>
  13:	9c                   	pushfq 
  14:	58                   	pop    %rax
  15:	f6 c4 02             	test   $0x2,%ah
  18:	75 48                	jne    62 <set_cpuid_faulting+0x62>
  1a:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 22 <set_cpuid_faulting+0x22>
  21:	00 
  22:	48 83 e0 fe          	and    $0xfffffffffffffffe,%rax
  26:	b9 40 01 00 00       	mov    $0x140,%ecx
  2b:	48 09 d8             	or     %rbx,%rax
  2e:	48 89 c2             	mov    %rax,%rdx
  31:	65 48 89 05 00 00 00 	mov    %rax,%gs:0x0(%rip)        # 39 <set_cpuid_faulting+0x39>
  38:	00 
  39:	48 c1 ea 20          	shr    $0x20,%rdx
  3d:	0f 30                	wrmsr  
  3f:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  44:	5b                   	pop    %rbx
  45:	5d                   	pop    %rbp
  46:	c3                   	retq   
  47:	48 c1 e2 20          	shl    $0x20,%rdx
  4b:	89 c0                	mov    %eax,%eax
  4d:	bf 40 01 00 00       	mov    $0x140,%edi
  52:	48 09 d0             	or     %rdx,%rax
  55:	31 d2                	xor    %edx,%edx
  57:	48 89 c6             	mov    %rax,%rsi
  5a:	e8 00 00 00 00       	callq  5f <set_cpuid_faulting+0x5f>
  5f:	5b                   	pop    %rbx
  60:	5d                   	pop    %rbp
  61:	c3                   	retq   
  62:	e8 00 00 00 00       	callq  67 <set_cpuid_faulting+0x67>
  67:	85 c0                	test   %eax,%eax
  69:	74 af                	je     1a <set_cpuid_faulting+0x1a>
  6b:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 71 <set_cpuid_faulting+0x71>
  71:	85 c0                	test   %eax,%eax
  73:	75 a5                	jne    1a <set_cpuid_faulting+0x1a>
  75:	48 c7 c1 00 00 00 00 	mov    $0x0,%rcx
  7c:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx
  83:	be b9 00 00 00       	mov    $0xb9,%esi
  88:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
  8f:	e8 00 00 00 00       	callq  94 <set_cpuid_faulting+0x94>
  94:	eb 84                	jmp    1a <set_cpuid_faulting+0x1a>
  96:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  9d:	00 00 00 

The affected object file code size blows up as well, by 17%:

 arch/x86/kernel/process.o:
    text    data     bss     dec     hex filename
    3325    8577      32   11934    2e9e process.o.before
    3889    8609      32   12530    30f2 process.o.after

A good deal of this overhead and complexity comes from the implementation 
inefficiency I pointed out, and all this can be avoided with the method I 
suggested in my previous review, by caching the per task MSR value in the thread 
struct.

So sorry, NAK for this implementation - especially considering how relatively 
straightforward the changes I suggested are to implement.

Thanks,

	Ingo

