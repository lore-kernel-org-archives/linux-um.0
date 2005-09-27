Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EK7lg-0006b8-Sq	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Sep 2005 22:12:40 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EK7lf-0001mS-Cv
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Sep 2005 22:12:40 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] sysrq patch
Message-ID: <20050927045446.GA19032@ccure.user-mode-linux.org>
References: <43383859.7090301@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43383859.7090301@oracle.com>
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
Date: Tue, 27 Sep 2005 00:54:46 -0400
To: Allan Graves <allan.graves@oracle.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Sep 26, 2005 at 02:05:13PM -0400, Allan Graves wrote:
> Let me know what you want changed, jeff, 

OK, you asked for it :-)

> i set vim to hardtabs, i hope 
> the white space comes out okay, don't want to get you in trouble again.  

The tabs look OK this time, thanks.

> i ran this in both frame pointer and no frame pointer mode.

+union uml_pt_regs *get_thread_regs(union uml_pt_regs *uml_regs, void *buffer)
+{
	...
+       return uml_regs;
+}

This should just be a void, there's usually no sense in returning an argument.
I see why you do it this way, but see my comments later.

	//jmp_buf * jmpbuf=(jmp_buf  *)buffer;

Just get rid of commented code - act like you mean it :-)

	+int stop_here=0;

You should have gotten rid of that.

+               printk("ASM\n");

What's that?

+#ifdef CONFIG_MODE_SKAS
+
+#define KSTK_EIP(tsk) UPT_REG(get_thread_regs(&tsk->thread.sysrq_regs, tsk->thread.mode.skas.switch_buf), EIP);
+#define KSTK_ESP(tsk) UPT_REG(get_thread_regs(&tsk->thread.sysrq_regs, tsk->thread.mode.skas.switch_buf), UESP);
+#define KSTK_EBP(tsk) UPT_REG(get_thread_regs(&tsk->thread.sysrq_regs, tsk->thread.mode.skas.switch_buf), EBP);
+
+#else

With this, I would prefer something like 

static inline unsigned long KSTK_EIP(struct task_struct *task)
{
	union uml_pt_regs regs;

	get_thread_regs(&regs, task->thread.mode.skas.switch_buf);
	return(UPT_REG(regs, EIP));
}

No need to make the thread structure any larger than it needs to be.  Plus
the typechecking is better with a function than a macro.

Also, is KSTK_EBP needed?  It wasn't defined before, and yet UML still
linked.

And I would make the tt mode versions return obviously bogus values
(0x00badbad, maybe :-), rather than non-obviously bogus values.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
