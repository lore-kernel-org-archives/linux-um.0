Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4MsU-0004M2-G5 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Sep 2004 10:02:02 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C4MsS-0004BY-4H for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Sep 2004 10:02:02 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] sysemu
References: <200408230454.i7N4soOV006652@ccure.user-mode-linux.org>
In-Reply-To: <200408230454.i7N4soOV006652@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200409061224.39494.blaisorblade_spam@yahoo.it>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Mon, 6 Sep 2004 13:07:55 +0200
To: LaurentVivier@wanadoo.fr, Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Monday 23 August 2004 06:54, Jeff Dike wrote:
> Call me a lamer, but I only now got around to looking at the sysemu
> patch in detail.

> As it stands, it can't be merged into mainline because it adds two
> instructions to the system call fast path.  This is the sort of thing
> that make Linus and others go ballistic.

> The duplication of syscall_trace as syscall_emulate is also pretty
> ugly.

> Below, see a patch which tweaks things to eliminate both problems.
> Now, PT_SCEMU is set in conjunction with PT_TRACESYS, rather than
> one or the other, but not both, being set.

This is not needed. You can still set just one of them (which is cleaner) and 
replace, in the fast path, 
        testb $0x02,tsk_ptrace(%ebx)    # PT_TRACESYS
with
        testb $0x22,tsk_ptrace(%ebx)    # PT_TRACESYS | PT_SYSEMU

> This means that the PT_TRACESYS test in entry.S covers both cases, and
> the fast path is unchanged.

> The other change was to make syscall_trace return zero or non-zero,
> according as it should run the system call or immediately return.
> This adds a line to syscall_trace and eliminates syscall_emulate.


> I've run it with both a little test case, and a tt mode UML.  The getpid()
> benchmark there showed little improvement (~1-2%), surprisingly.  I'm going
> to profile to see what's going on there.
What is the surprising thing? Did you expect more or less improvement?

You ran the getpid() benchmark with TT or with SKAS mode? Also, please note 
that many people said that glibc caches the getpid() result, so some other 
benchmark should be used (any sys_ni_syscall should be good, IMHO, especially 
it if can exist somewhere. 137 is reserved for afs_syscall, so glibc must run 
the syscall and it's even better for the benchmark.
Also, saving two context switches for syscall may still be a little saving, 
compared to the signal delivery. But, still, I don't understand why signal 
delivering is slower than context switching.

> Have a look and see if it looks reasonable.


> diff -Naur linux-2.4.22-1.2197.nptl/arch/i386/kernel/ptrace.c
> linux-2.4.22-1.2197.nptl-sysemu/arch/i386/kernel/ptrace.c ---
> linux-2.4.22-1.2197.nptl/arch/i386/kernel/ptrace.c	2004-07-01
> 15:04:37.000000000 -0400 +++
> linux-2.4.22-1.2197.nptl-sysemu/arch/i386/kernel/ptrace.c	2004-08-21
> 12:05:12.000000000 -0400 @@ -351,6 +351,7 @@
>  		  }
>  		  break;
>
> +	case PTRACE_SCEMU: /* continue and replace next syscall */
>  	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall
> */ case PTRACE_CONT: { /* restart after signal. */
>  		long tmp;
> @@ -360,6 +361,8 @@
>  			break;
>  		if (request == PTRACE_SYSCALL)
>  			child->ptrace |= PT_TRACESYS;
> +		else if (request == PTRACE_SCEMU)
> +			child->ptrace |= PT_TRACESYS | PT_SCEMU;
>  		else
>  			child->ptrace &= ~PT_TRACESYS;
Here there needs to be another change:
 
-			child->ptrace &= ~PT_TRACESYS;
+			child->ptrace &= ~(PT_TRACESYS | PT_SCEMU);

Do you agree?

>  		child->exit_code = data;
> @@ -396,7 +399,7 @@
>  		ret = -EIO;
>  		if ((unsigned long) data > _NSIG)
>  			break;
> -		child->ptrace &= ~PT_TRACESYS;
> +		child->ptrace &= ~(PT_TRACESYS | PT_SCEMU);
>  		if ((child->ptrace & PT_DTRACE) == 0) {
>  			/* Spurious delayed TF traps may occur */
>  			child->ptrace |= PT_DTRACE;
> @@ -512,7 +515,7 @@
>  	return ret;
>  }
>
> -asmlinkage void syscall_trace(void)
> +asmlinkage int syscall_trace(void)
>  {
>  	if ((current->ptrace & (PT_PTRACED|PT_TRACESYS)) !=
>  						(PT_PTRACED|PT_TRACESYS))
> @@ -534,4 +537,7 @@
>  		current->exit_code = 0;
>  	}
>  	recalc_sigpending();
> +
> +	/* 1 if nullifying the syscall, 0 if running it */
> +	return(current->ptrace & PT_SCEMU);
>  }
Well, obviously the comment must say "!= 0", not "1". And return() is not the 
official coding style. However for 2.4 this does not matter (Marcelo will 
never merge this).

> +#define PTRACE_SCEMU		  31

> +#define PT_SCEMU	0x00000800	/* syscall emulation for UML */
As said, please rename them to PTRACE_SYSEMU and PT_SYSEMU; otherwise, I'll 
change the guest patch to use PTRACE_SCEMU as name (calling "31" in different 
ways is as good as using 31 directly).

Now I'm doing a similar work for the 2.6 patch, with some bugfixing, and then 
I'll start sending it on the LKML to review, discuss and eventually merge it.

For instance (luckily I don't see any other bug for now):

+               clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE|
TIF_SYSCALL_EMU);
will never work, because TIF_* are not bitmasks, unlike _TIF_*. I also don't 
understand why most code works with this API, but I'll follow it.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
