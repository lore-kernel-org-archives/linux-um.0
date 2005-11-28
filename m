Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgZjK-0003N4-AT for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 19:31:02 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EgZjI-0000Wa-V6
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 19:31:02 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Testing requested - [PATCH] Fixing SKAS0 compilation
	problem / TT mode bug report
Message-ID: <20051128042327.GA28500@ccure.user-mode-linux.org>
References: <200511272159.38069.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511272159.38069.blaisorblade@yahoo.it>
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
Date: Sun, 27 Nov 2005 23:23:27 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Nov 27, 2005 at 09:59:37PM +0100, Blaisorblade wrote:
> The attached patch is a (hacky) proposal, alternative to Jeff's 
> fix-stub-syscall6, to fix the SKAS0 compilation problem.

Bleah :-)

> In fact, Jeff's patch makes the problem appear on my system (where I never 
> reproduced it).

What assembly did you end up with, with my patch?

> As an aside, I saw this code crashing at shutdown in TT mode, from 
> fs/proc/array.c:do_task_stat() :
> 
>         if (mm) {
>                 vsize = task_vsize(mm);
>                 eip = KSTK_EIP(task);
>                 esp = KSTK_ESP(task);
>         }
> 
> Went looking and guess what? There is full crap (starting from 2.6.14, due to 
> the fixes for sysrq-t IIRC):
> 
> include/asm-um/processor-i386.h
> 
> #define KSTK_EIP(tsk) KSTK_REG(tsk, EIP)
> #define KSTK_ESP(tsk) KSTK_REG(tsk, UESP)
> #define KSTK_EBP(tsk) KSTK_REG(tsk, EBP)
> 
> include/asm-um/processor-generic.h
> 
> #ifdef CONFIG_MODE_SKAS
> #define KSTK_REG(tsk, reg) \
>         ({ union uml_pt_regs regs; \
>            get_thread_regs(&regs, tsk->thread.mode.skas.switch_buf); \
>            UPT_REG(&regs, reg); })
> #else
> #define KSTK_REG(tsk, reg) (0xbadbabe)
> #endif

Oops, needs fixing.

				Jeff


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
