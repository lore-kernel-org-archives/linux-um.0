Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161202102942.GA17332@gmail.com>
References: <20161128030521.4423-1-khuey@kylehuey.com> <20161202102942.GA17332@gmail.com>
From: Kyle Huey <me@kylehuey.com>
Date: Sat, 3 Dec 2016 07:37:32 -0800
Message-ID: <CAP045AoQE2MDUzFiRC3Qko9BSF=aUk2XxtY=Qn9eiOMKvbFe7g@mail.gmail.com>
Subject: Re: [PATCH v13 0/8] x86/arch_prctl Add ARCH_[GET|SET]_CPUID for
 controlling the CPUID instruction
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, open list <linux-kernel@vger.kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, "open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, Dec 2, 2016 at 2:29 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Kyle Huey <me@kylehuey.com> wrote:
>
>> rr (http://rr-project.org/), a userspace record-and-replay reverse-
>> execution debugger, would like to trap and emulate the CPUID instruction.
>> This would allow us to a) mask away certain hardware features that rr does
>> not support (e.g. RDRAND) and b) enable trace portability across machines
>> by providing constant results.
>>
>> Newer Intel CPUs (Ivy Bridge and later) can fault when CPUID is executed at
>> CPL > 0. Expose this capability to userspace as a new pair of arch_prctls,
>> ARCH_GET_CPUID and ARCH_SET_CPUID.
>>
>> Since v12:
>> Patch 4: x86/syscalls/32: Wire up arch_prctl on x86-32
>> - compat_sys_arch_prctl prototype has argument names.
>
> So while I am fine with the feature, I'm still unconvinced about the
> implementation:
>
> 1)
>
> As I pointed out before, the arbitrary 'code' argument name x86-ism should be
> changed to 'option' like the canonical core kernel option name is for prctls().
>
> This is still unfixed.

Yeah, it'll be fixed next time around.

> 2)
>
> As I complained about in my first review, TIF_NOCPUID flag is too far removed from
> the value what will be written into the MSR.
>
> The result is poor code generation on 64-bit defconfig+CONFIG_PREEMPT=y:
>
>         if (test_tsk_thread_flag(prev_p, TIF_NOCPUID) ^
>             test_tsk_thread_flag(next_p, TIF_NOCPUID)) {
>                 set_cpuid_faulting(test_tsk_thread_flag(next_p, TIF_NOCPUID));
>
> is compiled as:
>
>   476:   49 8b 06                mov    (%r14),%rax
>   479:   49 8b 55 00             mov    0x0(%r13),%rdx
>   47d:   48 c1 e8 0f             shr    $0xf,%rax
>   481:   48 c1 ea 0f             shr    $0xf,%rdx
>   485:   83 e2 01                and    $0x1,%edx
>   488:   83 e0 01                and    $0x1,%eax
>   48b:   38 c2                   cmp    %al,%dl
>   48d:   74 10                   je     49f <__switch_to_xtra+0x9f>
>   48f:   49 8b 7d 00             mov    0x0(%r13),%rdi
>   493:   48 c1 ef 0f             shr    $0xf,%rdi
>   497:   83 e7 01                and    $0x1,%edi
>   49a:   e8 61 fb ff ff          callq  0 <set_cpuid_faulting>
>
> ... the first 7 instructions burdens all __switch_to_xtra() users, not just the
> faulting-CPUID users.

That's fair.  This is certainly suboptimal, and it's suboptimal for
TIF_BLOCKSTEP and TIF_NOTSC too which generate essentially identical
code.  A much better code sequence here would be:

mov (%r14), %rax
xor (%r13), %rax
test $0x80, %ah
jz <elsewhere>
/* do cpuid faulting work */

We could do this by introducing a test_tsk_thread_flag_differs(...),
and supporting infrastructure, that XORs the flags of the two tasks
before doing the bit test.

Once we do that, the non-faulting case is pretty much equivalent to
the mov, mov, cmp, je sequence that would be needed if we stored the
MSR values in the task_struct.  The faulting case becomes a
straightforward time vs space tradeoff, and I'm inclined to think that
calling set_cpuid_faulting (which I don't think is as bad as you
suggest, see below) is better than taking up 8 bytes in every
task_struct for an uncommon feature.

And, as a bonus, we can improve the TIF_BLOCKSTEP and TIF_NOTSC cases too.

> The set_cpuid_faulting() call is also unnecessary and the set_cpuid_faulting()
> call generates into an obscene sequence of:
>
> 0000000000000000 <set_cpuid_faulting>:
>    0:   8b 15 00 00 00 00       mov    0x0(%rip),%edx        # 6 <set_cpuid_faulting+0x6>
>    6:   55                      push   %rbp
>    7:   48 89 e5                mov    %rsp,%rbp
>    a:   53                      push   %rbx
>    b:   40 0f b6 df             movzbl %dil,%ebx
>    f:   85 d2                   test   %edx,%edx
>   11:   75 07                   jne    1a <set_cpuid_faulting+0x1a>
>   13:   9c                      pushfq
>   14:   58                      pop    %rax
>   15:   f6 c4 02                test   $0x2,%ah
>   18:   75 48                   jne    62 <set_cpuid_faulting+0x62>
>   1a:   65 48 8b 05 00 00 00    mov    %gs:0x0(%rip),%rax        # 22 <set_cpuid_faulting+0x22>
>   21:   00
>   22:   48 83 e0 fe             and    $0xfffffffffffffffe,%rax
>   26:   b9 40 01 00 00          mov    $0x140,%ecx
>   2b:   48 09 d8                or     %rbx,%rax
>   2e:   48 89 c2                mov    %rax,%rdx
>   31:   65 48 89 05 00 00 00    mov    %rax,%gs:0x0(%rip)        # 39 <set_cpuid_faulting+0x39>
>   38:   00
>   39:   48 c1 ea 20             shr    $0x20,%rdx
>   3d:   0f 30                   wrmsr
>   3f:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>   44:   5b                      pop    %rbx
>   45:   5d                      pop    %rbp
>   46:   c3                      retq
>   47:   48 c1 e2 20             shl    $0x20,%rdx
>   4b:   89 c0                   mov    %eax,%eax
>   4d:   bf 40 01 00 00          mov    $0x140,%edi
>   52:   48 09 d0                or     %rdx,%rax
>   55:   31 d2                   xor    %edx,%edx
>   57:   48 89 c6                mov    %rax,%rsi
>   5a:   e8 00 00 00 00          callq  5f <set_cpuid_faulting+0x5f>
>   5f:   5b                      pop    %rbx
>   60:   5d                      pop    %rbp
>   61:   c3                      retq
>   62:   e8 00 00 00 00          callq  67 <set_cpuid_faulting+0x67>
>   67:   85 c0                   test   %eax,%eax
>   69:   74 af                   je     1a <set_cpuid_faulting+0x1a>
>   6b:   8b 05 00 00 00 00       mov    0x0(%rip),%eax        # 71 <set_cpuid_faulting+0x71>
>   71:   85 c0                   test   %eax,%eax
>   73:   75 a5                   jne    1a <set_cpuid_faulting+0x1a>
>   75:   48 c7 c1 00 00 00 00    mov    $0x0,%rcx
>   7c:   48 c7 c2 00 00 00 00    mov    $0x0,%rdx
>   83:   be b9 00 00 00          mov    $0xb9,%esi
>   88:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi
>   8f:   e8 00 00 00 00          callq  94 <set_cpuid_faulting+0x94>
>   94:   eb 84                   jmp    1a <set_cpuid_faulting+0x1a>
>   96:   66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
>   9d:   00 00 00

I don't know why you're getting that.  Locally (with gcc 5.4) I have,
with CONFIG_PARAVIRT=y:

0000000000000000 <set_cpuid_faulting>:
   0:   e8 00 00 00 00          callq  5 <set_cpuid_faulting+0x5>
   5:   55                      push   %rbp
   6:   65 48 8b 15 00 00 00    mov    %gs:0x0(%rip),%rdx        # e
<set_cpuid_faulting+0xe>
   d:   00
   e:   48 89 d0                mov    %rdx,%rax
  11:   40 0f b6 d7             movzbl %dil,%edx
  15:   48 89 e5                mov    %rsp,%rbp
  18:   48 83 e0 fe             and    $0xfffffffffffffffe,%rax
  1c:   bf 40 01 00 00          mov    $0x140,%edi
  21:   48 09 c2                or     %rax,%rdx
  24:   89 d6                   mov    %edx,%esi
  26:   65 48 89 15 00 00 00    mov    %rdx,%gs:0x0(%rip)        # 2e
<set_cpuid_faulting+0x2e>
  2d:   00
  2e:   48 c1 ea 20             shr    $0x20,%rdx
  32:   ff 14 25 00 00 00 00    callq  *0x0
  39:   5d                      pop    %rbp
  3a:   c3                      retq
  3b:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)

and with CONFIG_PARAVIRT=n, set_cpuid_faulting gets inlined into
__switch_to_xtra producing:

 4da:   48 8b 03                mov    (%rbx),%rax
 4dd:   49 33 04 24             xor    (%r12),%rax
 4e2:   f6 c4 80                test   $0x80,%ah
 4e5:   0f 85 ee 00 00 00       jne    5d9 <__switch_to_xtra+0x179>
...
5d9:   48 8b 33                mov    (%rbx),%rsi
 5dc:   b9 40 01 00 00          mov    $0x140,%ecx
 5e1:   65 48 8b 05 00 00 00    mov    %gs:0x0(%rip),%rax        # 5e9
<__switch_to_xtra+0x189>
 5e8:   00
 5e9:   48 83 e0 fe             and    $0xfffffffffffffffe,%rax
 5ed:   48 89 c2                mov    %rax,%rdx
 5f0:   48 89 f0                mov    %rsi,%rax
 5f3:   48 c1 e8 0f             shr    $0xf,%rax
 5f7:   83 e0 01                and    $0x1,%eax
 5fa:   48 09 d0                or     %rdx,%rax
 5fd:   48 89 c2                mov    %rax,%rdx
 600:   65 48 89 05 00 00 00    mov    %rax,%gs:0x0(%rip)        # 608
<__switch_to_xtra+0x1a8>
 607:   00
 608:   48 c1 ea 20             shr    $0x20,%rdx
 60c:   0f 30                   wrmsr
 60e:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
 613:   e9 d3 fe ff ff          jmpq   4eb <__switch_to_xtra+0x8b>

both of which are much saner code.

> The affected object file code size blows up as well, by 17%:
>
>  arch/x86/kernel/process.o:
>     text    data     bss     dec     hex filename
>     3325    8577      32   11934    2e9e process.o.before
>     3889    8609      32   12530    30f2 process.o.after
>
> A good deal of this overhead and complexity comes from the implementation
> inefficiency I pointed out, and all this can be avoided with the method I
> suggested in my previous review, by caching the per task MSR value in the thread
> struct.

12% here, where .before is before any of my changes, .as-is is with
these patches as submitted, and .after is with the changes as
described above.

size process.o*
   text       data        bss        dec        hex    filename
   4669       8521         96      13286       33e6    process.o.after
   4685       8521         96      13302       33f6    process.o.as-is
   4197       8506         96      12799       31ff    process.o.before

> So sorry, NAK for this implementation - especially considering how relatively
> straightforward the changes I suggested are to implement.

Would these proposed changes satisfy you?  Obviously I want to get
this into the kernel or I wouldn't be here.  So if you insist on
caching the MSR in the task_struct I'll do it, but I think this is at
least as good of an approach.

- Kyle

