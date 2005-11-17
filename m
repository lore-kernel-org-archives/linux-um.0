Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EcqVq-0000s5-5X for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 12:37:42 -0800
Received: from spirit.analogic.com ([204.178.40.4])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EcqVm-0003Hc-Ks
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 12:37:42 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <200511172110.jAHLASIB010204@ccure.user-mode-linux.org>
References: <200511172110.jAHLASIB010204@ccure.user-mode-linux.org>
Content-class: urn:content-classes:message
Message-ID: <Pine.LNX.4.61.0511171528570.10664@chaos.analogic.com>
From: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Reply-To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: [uml-devel] Re: [PATCH 3/4] UML - Properly invoke x86_64 system calls
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 17 Nov 2005 15:37:14 -0500
Content-Transfer-Encoding: quoted-printable
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, Linux kernel <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net


On Thu, 17 Nov 2005, Jeff Dike wrote:

> This patch makes stub_segv use the stub_syscall macros.  This was
> needed anyway, but the bug that prompted this was the discovery that
> gcc was storing stuff in RCX, which is trashed across a system
> call.

But the C-calling convention used by gcc for 32-bit systems
is supposed to allow the called-function to destroy general-
purpose registers but not index registers. In other words,
ECX, EDX are supposed to be available and EAX is used for
return-values. The register size isn't supposed to have
anything to do with it (longword/quadword)!

In 64-bit world, the same is supposed to apply as well.
If RCX is now precious, it's a GCC bug that should be fixed.

Yes?

   This is exactly the sort of problem that the new macros fix.
> There is a stub_syscall0 for getpid.
> stub_segv was changed to be a libc file, and that caused some
> include changes.
>
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
>
> Index: linux-2.6.15/arch/um/include/sysdep-i386/stub.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.15.orig/arch/um/include/sysdep-i386/stub.h	2005-11-17 14:59=
:30.000000000 -0500
> +++ linux-2.6.15/arch/um/include/sysdep-i386/stub.h	2005-11-17 14:59:55.0=
00000000 -0500
> @@ -16,6 +16,15 @@
> #define STUB_MMAP_NR __NR_mmap2
> #define MMAP_OFFSET(o) ((o) >> PAGE_SHIFT)
>
> +static inline long stub_syscall0(long syscall)
> +{
> +	long ret;
> +
> +	__asm__ volatile ("int $0x80" : "=3Da" (ret) : "0" (syscall));
> +
> +	return ret;
> +}
> +
> static inline long stub_syscall1(long syscall, long arg1)
> {
> 	long ret;
> Index: linux-2.6.15/arch/um/include/sysdep-x86_64/stub.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.15.orig/arch/um/include/sysdep-x86_64/stub.h	2005-11-17 14:=
59:30.000000000 -0500
> +++ linux-2.6.15/arch/um/include/sysdep-x86_64/stub.h	2005-11-17 14:59:55=
.000000000 -0500
> @@ -6,7 +6,6 @@
> #ifndef __SYSDEP_STUB_H
> #define __SYSDEP_STUB_H
>
> -#include <asm/ptrace.h>
> #include <asm/unistd.h>
> #include <sysdep/ptrace_user.h>
>
> @@ -20,6 +19,17 @@
> #define __syscall_clobber "r11","rcx","memory"
> #define __syscall "syscall"
>
> +static inline long stub_syscall0(long syscall)
> +{
> +	long ret;
> +
> +	__asm__ volatile (__syscall
> +		: "=3Da" (ret)
> +		: "0" (syscall) : __syscall_clobber );
> +
> +	return ret;
> +}
> +
> static inline long stub_syscall2(long syscall, long arg1, long arg2)
> {
> 	long ret;
> Index: linux-2.6.15/arch/um/sys-i386/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.15.orig/arch/um/sys-i386/Makefile	2005-11-17 14:59:30.00000=
0000 -0500
> +++ linux-2.6.15/arch/um/sys-i386/Makefile	2005-11-17 14:59:55.000000000 =
-0500
> @@ -5,7 +5,7 @@
> obj-$(CONFIG_HIGHMEM) +=3D highmem.o
> obj-$(CONFIG_MODULES) +=3D module.o
>
> -USER_OBJS :=3D bugs.o ptrace_user.o sigcontext.o fault.o
> +USER_OBJS :=3D bugs.o ptrace_user.o sigcontext.o fault.o stub_segv.o
>
> SYMLINKS =3D bitops.c semaphore.c highmem.c module.c
>
> Index: linux-2.6.15/arch/um/sys-i386/stub_segv.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.15.orig/arch/um/sys-i386/stub_segv.c	2005-11-17 14:59:30.00=
0000000 -0500
> +++ linux-2.6.15/arch/um/sys-i386/stub_segv.c	2005-11-17 14:59:55.0000000=
00 -0500
> @@ -3,9 +3,11 @@
>  * Licensed under the GPL
>  */
>
> -#include <asm/signal.h>
> +#include <signal.h>
> +#include <sys/select.h> /* The only way I can see to get sigset_t */
> #include <asm/unistd.h>
> #include "uml-config.h"
> +#include "sysdep/stub.h"
> #include "sysdep/sigcontext.h"
> #include "sysdep/faultinfo.h"
>
> @@ -13,13 +15,14 @@
> stub_segv_handler(int sig)
> {
> 	struct sigcontext *sc =3D (struct sigcontext *) (&sig + 1);
> +	int pid;
>
> 	GET_FAULTINFO_FROM_SC(*((struct faultinfo *) UML_CONFIG_STUB_DATA),
> 			      sc);
>
> -	__asm__("movl %0, %%eax ; int $0x80": : "g" (__NR_getpid));
> -	__asm__("movl %%eax, %%ebx ; movl %0, %%eax ; movl %1, %%ecx ;"
> -		"int $0x80": : "g" (__NR_kill), "g" (SIGUSR1));
> +	pid =3D stub_syscall0(__NR_getpid);
> +	stub_syscall2(__NR_kill, pid, SIGUSR1);
> +
> 	/* Load pointer to sigcontext into esp, since we need to leave
> 	 * the stack in its original form when we do the sigreturn here, by
> 	 * hand.
> Index: linux-2.6.15/arch/um/sys-x86_64/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.15.orig/arch/um/sys-x86_64/Makefile	2005-11-17 14:59:30.000=
000000 -0500
> +++ linux-2.6.15/arch/um/sys-x86_64/Makefile	2005-11-17 14:59:55.00000000=
0 -0500
> @@ -12,7 +12,7 @@
> obj-y :=3D ksyms.o
> obj-$(CONFIG_MODULES) +=3D module.o um_module.o
>
> -USER_OBJS :=3D ptrace_user.o sigcontext.o
> +USER_OBJS :=3D ptrace_user.o sigcontext.o stub_segv.o
>
> SYMLINKS =3D bitops.c csum-copy.S csum-partial.c csum-wrappers.c ldt.c me=
mcpy.S \
> 	thunk.S module.c
> Index: linux-2.6.15/arch/um/sys-x86_64/stub_segv.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.15.orig/arch/um/sys-x86_64/stub_segv.c	2005-11-17 14:59:30.=
000000000 -0500
> +++ linux-2.6.15/arch/um/sys-x86_64/stub_segv.c	2005-11-17 15:12:23.00000=
0000 -0500
> @@ -3,14 +3,14 @@
>  * Licensed under the GPL
>  */
>
> -#include <asm/signal.h>
> +#include <stddef.h>
> +#include <signal.h>
> #include <linux/compiler.h>
> #include <asm/unistd.h>
> -#include <asm/ucontext.h>
> #include "uml-config.h"
> #include "sysdep/sigcontext.h"
> #include "sysdep/faultinfo.h"
> -#include <stddef.h>
> +#include "sysdep/stub.h"
>
> /* Copied from sys-x86_64/signal.c - Can't find an equivalent definition
>  * in the libc headers anywhere.
> @@ -31,21 +31,21 @@
> stub_segv_handler(int sig)
> {
> 	struct ucontext *uc;
> +        int pid;
>
> 	__asm__("movq %%rdx, %0" : "=3Dg" (uc) :);
> 	GET_FAULTINFO_FROM_SC(*((struct faultinfo *) UML_CONFIG_STUB_DATA),
> 			      &uc->uc_mcontext);
>
> -	__asm__("movq %0, %%rax ; syscall": : "g" (__NR_getpid));
> -	__asm__("movq %%rax, %%rdi ; movq %0, %%rax ; movq %1, %%rsi ;"
> -		"syscall": : "g" (__NR_kill), "g" (SIGUSR1) :
> -		"%rdi", "%rax", "%rsi");
> +	pid =3D stub_syscall0(__NR_getpid);
> +	stub_syscall2(__NR_kill, pid, SIGUSR1);
> +
> 	/* sys_sigreturn expects that the stack pointer will be 8 bytes into
> 	 * the signal frame.  So, we use the ucontext pointer, which we know
> 	 * already, to get the signal frame pointer, and add 8 to that.
> 	 */
> -	__asm__("movq %0, %%rsp": :
> +	__asm__("movq %0, %%rsp; movq %1, %%rax ; syscall": :
> 		"g" ((unsigned long) container_of(uc, struct rt_sigframe,
> -						  uc) + 8));
> -	__asm__("movq %0, %%rax ; syscall" : : "g" (__NR_rt_sigreturn));
> +						  uc) + 8),
> +                "g" (__NR_rt_sigreturn));
> }
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.44 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be priv=
ileged.  Any review, retransmission, dissemination, or other use of this in=
formation by persons or entities other than the intended recipient is prohi=
bited.  If you are not the intended recipient, please notify Analogic Corpo=
ration immediately - by replying to this message or by sending an email to =
DeliveryErrors@analogic.com - and destroy all copies of this information, i=
ncluding any attachments, without reading or disclosing them.

Thank you.


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_idv28&alloc_id=16845&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
