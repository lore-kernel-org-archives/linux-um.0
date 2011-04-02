Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTimPAX+BnXhtV0R=he80DBrQFMLgjobUwKfnWJuZ@mail.gmail.com>
References: <AANLkTimPAX+BnXhtV0R=he80DBrQFMLgjobUwKfnWJuZ@mail.gmail.com>
Date: Sat, 2 Apr 2011 12:38:42 +0200
Message-ID: <BANLkTi=iTRhJwLmUmPqbKWdiu4DtgfGe=w@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: gcc 4.6.0 breaks User Mode Linux
To: LKML <linux-kernel@vger.kernel.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Mar 31, 2011 at 5:28 PM, richard -rw- weinberger
<richard.weinberger@gmail.com> wrote:
> Hi,
>
> The um kernel (Linus's tree as of today) crashes very early during bo=
ot-up.
>
> ---cut---
> $ ./linux
> Locating the bottom of the address space ... 0x10000
> Locating the top of the address space ... 0xc0000000
> Core dump limits :
> =A0 =A0 =A0 =A0soft - 0
> =A0 =A0 =A0 =A0hard - NONE
> Checking that ptrace can change system call numbers...OK
> Checking syscall emulation patch for ptrace...OK
> Checking advanced syscall emulation patch for ptrace...OK
> Checking for tmpfs mount on /dev/shm...nothing mounted on /dev/shm
> Checking PROT_EXEC mmap in /tmp/...OK
> Checking for the skas3 patch in the host:
> =A0- /proc/mm...not found: No such file or directory
> =A0- PTRACE_FAULTINFO...not found
> =A0- PTRACE_LDT...not found
> UML running in SKAS0 mode
> Aborted
> ---cut---
>
> Here the gdb backtrace:
> ---cut---
> Program received signal SIGILL, Illegal instruction.
> kmem_cache_create (name=3D0x81efe77 "pid", size=3D44, align=3D4,
> flags=3D270336, ctor=3D0) at mm/slab.c:2181
> 2181 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BUG();
> (gdb) bt
> #0 =A0kmem_cache_create (name=3D0x81efe77 "pid", size=3D44, align=3D4=
,
> flags=3D270336, ctor=3D0) at mm/slab.c:2181
> #1 =A00x0804c902 in pidmap_init () at kernel/pid.c:565
> #2 =A00x080494e9 in start_kernel () at init/main.c:591
> #3 =A00x0804a539 in start_kernel_proc (unused=3D0x0) at
> arch/um/kernel/skas/process.c:46
> #4 =A00x08063ec2 in run_kernel_thread (fn=3D0x804a50f <start_kernel_p=
roc>,
> arg=3D0x0, jmp_ptr=3D0x823e7dc)
> =A0 =A0at arch/um/os-Linux/process.c:267
> #5 =A00x08057717 in new_thread_handler () at arch/um/kernel/process.c=
:153
> #6 =A00x00000000 in ?? ()
> ---cut---
>
> BUG() was trigged by in_interrupt() at mm/slab.c:2181.
> in_interrupt() returns misleadingly a non-zero value.
> My first idea was that in_interrupt() returns always a non-zero value=
,
> but this is not the case.
> preempt_count() seems broken in some way.
>
> I can reproduce this issue using gcc 4.6.0 on x86 and x86_64 hosts.
> Now I'm wondering whether this is a gcc or a uml bug.
>
> Any ideas where to start?
>
> --
> Thanks,
> //richard
>

current_thread_info() is broken, it returns not always a correct
thread_info struct.
At first place i thought -fpartial-inlining is guilty. But the problem
occurs also with
-fno-partial-inlining.

The attached patch fixes the problem.
It is not a nice solution, but it works for now.
As UML supports only on x86/x86_64 the asm("esp") is not a big deal...

diff --git a/arch/um/include/asm/thread_info.h
b/arch/um/include/asm/thread_info.h
index e2cf786..5da7fa6 100644
--- a/arch/um/include/asm/thread_info.h
+++ b/arch/um/include/asm/thread_info.h
@@ -47,10 +47,8 @@ struct thread_info {
 /* how to get the thread information struct from C */
 static inline struct thread_info *current_thread_info(void)
 {
- struct thread_info *ti;
- unsigned long mask =3D THREAD_SIZE - 1;
- ti =3D (struct thread_info *) (((unsigned long) &ti) & ~mask);
- return ti;
+ register unsigned long sp asm("esp");
+ return (struct thread_info *)(sp & ~(THREAD_SIZE - 1));
 }

 #define THREAD_SIZE_ORDER CONFIG_KERNEL_STACK_ORDER

--=20
Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

