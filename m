Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FVpm3-0000LB-9n for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Apr 2006 05:57:43 -0700
Received: from gprs189-60.eurotel.cz ([160.218.189.60] helo=amd.ucw.cz)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FVplz-0004gj-S2
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Apr 2006 05:57:43 -0700
From: Pavel Machek <pavel@ucw.cz>
Message-ID: <20060418125728.GA26554@elf.ucw.cz>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
Subject: [uml-devel] Re: [RFC] PATCH 3/4 - Time virtualization :
	PTRACE_SYSCALL_MASK
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
Date: Tue, 18 Apr 2006 14:57:28 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Hi!

> Add PTRACE_SYSCALL_MASK, which allows system calls to be selectively
> traced.  It takes a bitmask and a length.  A system call is traced
> if its bit is one.  Otherwise, it executes normally, and is
> invisible to the ptracing parent.
> 
> This is not just useful for UML - strace -e could make good use of it as well.

> +	if((current->syscall_mask != NULL) &&

Please put space between if and (.

> @@ -690,6 +693,11 @@ int do_syscall_trace(struct pt_regs *reg
>  	if (!(current->ptrace & PT_PTRACED))
>  		goto out;
>  
> +	if((current->syscall_mask != NULL) && ((long) regs->orig_eax != -1) &&
> +	   !(current->syscall_mask[regs->orig_eax / (8 * sizeof(long))] &
> +	     (1 << (regs->orig_eax % (8 * sizeof(long))))))
> +		goto out;
> +

Same here... and perhaps you can use __get_bit/__set_bit? (this
applies to few more places).

Are you going to fix non-i386, too?
							Pavel
-- 
Thanks for all the (sleeping) penguins.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
