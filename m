Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKYDC-00069J-Sp for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Oct 2004 01:22:18 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CKYDC-0006p0-11 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Oct 2004 01:22:18 -0700
Message-ID: <417772D7.5020204@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Kernel panic: check_ptrace : child exited with status
	0x100
References: <200410081159.i98Bxgr03954@trolli.pdb.fsc.net>
	<200410142033.06629.blaisorblade_spam@yahoo.it>
	<417699B2.6090909@fujitsu-siemens.com>
In-Reply-To: <417699B2.6090909@fujitsu-siemens.com>
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
Date: Thu, 21 Oct 2004 10:27:03 +0200
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com, "Christopher S. Aker" <caker@theshore.net>

Bodo Stroesser wrote:
> The patch is tested, AFAICS, it works fine, i.e. sysemu can be switched on and
> off dynamically without crash.
> 
Here is a new version of the patch. I changed it to use TIF_SYSCALL_EMU
instead of TIF_SINGLETSTEP. This is more intuitive, I think.


Bodo

---

--- a/arch/i386/kernel/ptrace.c	2004-10-20 16:57:25.000000000 +0200
+++ b/arch/i386/kernel/ptrace.c	2004-10-21 09:55:00.000000000 +0200
@@ -585,7 +585,7 @@
  __attribute__((regparm(3)))
  int do_syscall_trace(struct pt_regs *regs, int entryexit)
  {
-	int is_sysemu;
+	int is_sysemu, is_systrace;
  	if (unlikely(current->audit_context)) {
  		if (!entryexit)
  			audit_syscall_entry(current, regs->orig_eax,
@@ -595,9 +595,19 @@
  			audit_syscall_exit(current, regs->eax);
  	}
  	is_sysemu = test_thread_flag(TIF_SYSCALL_EMU);
+	is_systrace = test_thread_flag(TIF_SYSCALL_TRACE);

-	if (!test_thread_flag(TIF_SYSCALL_TRACE) && !is_sysemu)
+	if (!is_systrace && !is_sysemu)
  		return 0;
+	/* We can detect the case of coming from PTRACE_SYSEMU and now
+	 * running with PTRACE_SYSCALL, by TIF_SYSCALL_EMU being set
+	 * additionally.
+	 * If so let's reset the flag and return without action.
+	 */
+	if (is_sysemu && is_systrace) {
+		clear_thread_flag(TIF_SYSCALL_EMU);
+		return 0;
+	}
  	if (!(current->ptrace & PT_PTRACED))
  		return 0;
  	/* the 0x80 provides a way for the tracing parent to distinguish
@@ -605,6 +615,15 @@
  	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
  				 ? 0x80 : 0));

+	/* If we came here with PTRACE_SYSEMU and now continue with
+	 * PTRACE_SYSCALL, entry.S used to intercept the syscall return. But it
+	 * shouldn't!
+	 * So we additionally use TIF_SYSCALL_EMU, which is always unused in this
+	 * special case, to remember, we came from SYSEMU.
+	 */
+	if (is_sysemu && test_thread_flag(TIF_SYSCALL_TRACE))
+		set_thread_flag(TIF_SYSCALL_EMU);
+
  	/*
  	 * this isn't the same as continuing with a signal, but it will do
  	 * for normal use.  strace only continues with a signal if the


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
