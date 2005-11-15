Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ec8zM-0001DI-0a for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Nov 2005 14:09:16 -0800
Received: from web25208.mail.ukl.yahoo.com ([217.12.10.68])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Ec8zJ-00087W-80
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Nov 2005 14:09:15 -0800
Message-ID: <20051115220903.73648.qmail@web25208.mail.ukl.yahoo.com>
From: Paolo Giarrusso <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] Ok, I build x86-64 -skas0,
	and it still segfaults.
In-Reply-To: <20051114215517.GA9579@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Tue, 15 Nov 2005 23:09:03 +0100 (CET)
To: Jeff Dike <jdike@addtoit.com>, Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade@yahoo.it>


--- Jeff Dike <jdike@addtoit.com> ha scritto: 

> On Sun, Nov 13, 2005 at 05:32:10PM -0600, Rob Landley wrote:
> > moan moan
> 
> Can you try the x86-64-clobbers-rcx patch below?
> 
> If you don't have it already, apply the fix-x86-stubs patch first.
> 
> Paolo, could you eyeball this one for me?  This applies the
> stub_syscall*
> goodness to stub_segv.c.

Thanks for requesting.

I've come to a (possible) conclusion - probably we could try to adapt
and reuse the batching syscall stub to do everything. With the
original single-syscall stub it didn't make sense, with this one it
could do. Yep, there's something to do since stub_segv does some
interesting stuff, but I guess it's solvable - I'll look to the code
ASAP (I'm finding it difficult these days to leave some time for
proper hacking, and I'm very sorry for that).

Or anyway, it's possibly becoming harder to write all this in C with
assembly inserts rather than directly in assembly. It also does not
work well on some strange compilers (aka Hardened GCC, as reported by
Antoine Martin).

However, back on _this_ patch, I have a couple of
complaints/suggestions (and sorry for the mess-up, I'm currently
answering from web-mail :-( ):

> Index: linux-2.6.14/arch/um/sys-i386/stub_segv.c
> ===================================================================
> --- linux-2.6.14.orig/arch/um/sys-i386/stub_segv.c	2005-11-10
> 11:41:46.000000000 -0500
> +++ linux-2.6.14/arch/um/sys-i386/stub_segv.c	2005-11-14
> 15:56:22.000000000 -0500
> @@ -3,9 +3,11 @@
>   * Licensed under the GPL
>   */
>  
> +#include <sys/select.h> /* The only way I can see to get sigset_t
> */
>  #include <asm/signal.h>
>  #include <asm/unistd.h>
>  #include "uml-config.h"
> +#include "sysdep/stub.h"
>  #include "sysdep/sigcontext.h"
>  #include "sysdep/faultinfo.h"
>  
> @@ -17,13 +19,10 @@ stub_segv_handler(int sig)
>  	GET_FAULTINFO_FROM_SC(*((struct faultinfo *)
> UML_CONFIG_STUB_DATA),
>  			      sc);
>  
> -/*	__asm__("movl %0, %%eax ; int $0x80": : "g" (__NR_getpid));
> -	__asm__("movl %%eax, %%ebx ; movl %0, %%eax ; movl %1, %%ecx ;"
> -		"int $0x80": : "g" (__NR_kill), "g" (SIGUSR1)); */

Where does this commented getpid + kill comes from? It seems to come
from rubbish in some patch.

Actually, you leave it there for x86-64 - and while I've not looked
at the meaning of what it's doing (sorry but it's late here), it's
anyway bogus (and in fact it doesn't apply anywhere).

And, more important:

>  	/* Load pointer to sigcontext into esp, since we need to leave
>  	 * the stack in its original form when we do the sigreturn here,
> by
>  	 * hand.
>  	 */
> -	__asm__("mov %0,%%esp ; movl %1, %%eax ; "
> -		"int $0x80" : : "a" (sc), "g" (__NR_sigreturn));
> +	__asm__("mov %0,%%esp" : : "a" (sc));
> +	stub_syscall0(__NR_sigreturn);
>  }

The idea would be nice, but I am reluctant in trusting GCC to leave
%esp unaltered; also, without volatile, GCC feels probably allowed to
move this instruction anywhere in the code.

Actually, I start feeling this could be moved to assembly.

Here and for x86-64, I would rather hardcode this final syscall as
done currently, rather than using the common macros.

For the other syscalls, it's fully ok to reuse the common macros.
> Index: linux-2.6.14/arch/um/sys-x86_64/stub_segv.c
> ===================================================================
> --- linux-2.6.14.orig/arch/um/sys-x86_64/stub_segv.c	2005-11-14
> 15:45:09.000000000 -0500
> +++ linux-2.6.14/arch/um/sys-x86_64/stub_segv.c	2005-11-14
> 15:45:21.000000000 -0500
> @@ -3,13 +3,16 @@
>   * Licensed under the GPL
>   */
>  
> -#include <asm/signal.h>
>  #include <linux/compiler.h>
> +#include <asm/signal.h>
>  #include <asm/unistd.h>
> +#include <asm/sigcontext.h>
> +#include <asm/siginfo.h>
>  #include <asm/ucontext.h>
>  #include "uml-config.h"
>  #include "sysdep/sigcontext.h"
>  #include "sysdep/faultinfo.h"
> +#include "sysdep/stub.h"
>  #include <stddef.h>
>  
>  /* Copied from sys-x86_64/signal.c - Can't find an equivalent
> definition
> @@ -31,15 +34,15 @@ void __attribute__ ((__section__ (".__sy
>  stub_segv_handler(int sig)
>  {
>  	struct ucontext *uc;
> +        int pid;
>  
>  	__asm__("movq %%rdx, %0" : "=g" (uc) :);
>  	GET_FAULTINFO_FROM_SC(*((struct faultinfo *)
> UML_CONFIG_STUB_DATA),
>  			      &uc->uc_mcontext);
>  
> -	__asm__("movq %0, %%rax ; syscall": : "g" (__NR_getpid));	
> -	__asm__("movq %%rax, %%rdi ; movq %0, %%rax ; movq %1, %%rsi ;"
> -		"syscall": : "g" (__NR_kill), "g" (SIGUSR1) : 
> -		"%rdi", "%rax", "%rsi");
> +	pid = stub_syscall0(__NR_getpid);
> +	stub_syscall2(__NR_kill, pid, SIGUSR1);
> +
>  	/* sys_sigreturn expects that the stack pointer will be 8 bytes
> into
>  	 * the signal frame.  So, we use the ucontext pointer, which we
> know
>  	 * already, to get the signal frame pointer, and add 8 to that.
> @@ -47,5 +50,5 @@ stub_segv_handler(int sig)
>  	__asm__("movq %0, %%rsp": : 
>  		"g" ((unsigned long) container_of(uc, struct rt_sigframe, 
>  						  uc) + 8));
> -	__asm__("movq %0, %%rax ; syscall" : : "g" (__NR_rt_sigreturn));
> +	stub_syscall0(__NR_rt_sigreturn);
>  }




		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
