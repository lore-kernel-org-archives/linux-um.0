Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKJlH-0007I0-UY for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Oct 2004 09:56:31 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CKJlH-0004Hr-39 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Oct 2004 09:56:31 -0700
Message-ID: <417699B2.6090909@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Kernel panic: check_ptrace : child exited with status
	0x100
References: <200410081159.i98Bxgr03954@trolli.pdb.fsc.net>
	<200410142033.06629.blaisorblade_spam@yahoo.it>
In-Reply-To: <200410142033.06629.blaisorblade_spam@yahoo.it>
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
Date: Wed, 20 Oct 2004 19:00:34 +0200
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com, "Christopher S. Aker" <caker@theshore.net>

BlaisorBlade wrote:
> 
> Yes, I confirm the patch I sent in my previous email for the host. I still 
> need to test that, but I'll do this soon. It's reattached as 
> "fix-sysemu-when-changing-state.patch".
> 
OK. Now I've had time to test with sysemu. But unfortunately the patch for the
2.6 host isn't enough! It still crashes if sysemu is switched off dynamically
via /proc/sysemu.
The problem is in arch/i386/kernel/entry.S. The latest host-patch v6 inhibits
the syscall-handler to be called, but does not prevent do_syscall_trace to be
called after this for syscall completion interception. The appended patch
fixes this. It reuses the TIF_SINGLESTEP flag to remember "we come from
PTRACE_SYSEMU and now are in PTRACE_SYSCALL", since the flag is unused in the
depicted situation.
Feel free to change it, if you see the need to use  an other or a new defined
flag for this.

The patch is tested, AFAICS, it works fine, i.e. sysemu can be switched on and
off dynamically without crash.

For the 2.4 host, this seems to be not relevant. But I could read the source
only. Does anyone know, whether sysemu on/off works on host 2.4?

Bodo

---

--- linux-2.6.7-old/arch/i386/kernel/ptrace.c	2004-10-20 16:57:25.148861788 +0200
+++ linux-2.6.7/arch/i386/kernel/ptrace.c	2004-10-20 17:08:47.722062593 +0200
@@ -598,6 +598,16 @@

  	if (!test_thread_flag(TIF_SYSCALL_TRACE) && !is_sysemu)
  		return 0;
+	/* We can detect the case of coming from PTRACE_SYSEMU and now
+	 * running with PTRACE_SYSCALL, by TIF_SINGLESTEP being set
+	 * additionally.
+	 * If so let's reset the flag and return without action.
+	 */
+	if (test_thread_flag(TIF_SINGLESTEP) &&
+	    test_thread_flag(TIF_SYSCALL_TRACE)) {
+		clear_thread_flag(TIF_SINGLESTEP);
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
+	 * So we additionally use TIF_SINGLESTEP, which is always unused in this
+	 * special case, to remember, we came from SYSEMU.
+	 */
+	if (is_sysemu && test_thread_flag(TIF_SYSCALL_TRACE))
+		set_thread_flag(TIF_SINGLESTEP);
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
