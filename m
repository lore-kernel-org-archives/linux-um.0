Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNLQM-0007VO-7d for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 18:19:26 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CNLQK-0003kB-St for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 18:19:26 -0700
Message-ID: <41819A8A.20403@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: [patch 1/1] SYSEMU: avoid intercepting syscall
	on return when using SYSCALL again.
References: <20041021231834.9D3833F37@zion.localdomain>
	<200410290104.22725.blaisorblade_spam@yahoo.it>
	<41818295.5000209@fujitsu-siemens.com>
	<200410290200.46907.blaisorblade_spam@yahoo.it>
In-Reply-To: <200410290200.46907.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Fri, 29 Oct 2004 03:19:06 +0200
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: jdike@addtoit.com, Gerd Knorr <kraxel@bytesex.org>, user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:
> No. Just strace any process inside UML. Let's "strace ls". Last time I 
> checked, it does not work. Oh hell! It works (as of 2.6.9)! Well, you already 
> fixed that.
> 
No. Here you are wrong. The problem is still there (or is it again there?).
Sorry.

My latest patch "patch-singlestep-sighdlr" has been too complete!
Setting TIF_SIGPENDING after ptrace_notify() in syscall_trace() in neccessary
only on the 2nd tracepoint (entryexit == 1).
And setting it on the 1st tracepoint lets some specific systemcalls loop.
Example: sys_rt_sigaction() wants to be called without SIGPENDING. Thus it returns
with -ERESTARTNOINTR. On return do_signal() is called, which resets TIF_SIGPENDING
and sets EIP back to the syscall. Now the syscall starts, runs through
syscall_trace() and TIF_SIGPENDING is set again. Now it returns with -ERESTARTNOINTR
...
...

Here's the patch:

---

--- a/arch/um/kernel/ptrace.c	2004-10-29 02:27:42.000000000 +0200
+++ b/arch/um/kernel/ptrace.c	2004-10-29 02:28:24.000000000 +0200
@@ -330,7 +330,8 @@ void syscall_trace(union uml_pt_regs *re
  	   between a syscall stop and SIGTRAP delivery */
  	ptrace_notify(SIGTRAP | (((current->ptrace & PT_TRACESYSGOOD) &&
  				 !is_singlestep) ? SYSCALL_TRAP : 0));
-	set_thread_flag(TIF_SIGPENDING); /* force do_signal() --> is_syscall() */
+	if ( entryexit ) /* force do_signal() --> is_syscall() */
+		set_thread_flag(TIF_SIGPENDING);

  	/*
  	 * this isn't the same as continuing with a signal, but it will do



-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
