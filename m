Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IcSjX-0004H2-No for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 14:23:19 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IcSjW-0008Oo-Sm
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 14:23:19 -0700
Date: Mon, 1 Oct 2007 17:23:07 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071001212307.GA10123@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 3/3] UML - Definitively kill subprocesses on panic
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Lepton Wu <ytht.net@gmail.com>

From: Lepton Wu <ytht.net@gmail.com>

  In a stock 2.6.22.6 kernel, poweroff a user mode linux guest
(2.6.22.6 running in skas0 mode) will halt the host linux. I
think the reason is the kernel thread abort because of a bug.
Then the sys_reboot in process of user mode linux guest is
not trapped by the user mode linux kernel and is executed by host.
  I think it is better to make sure all of our children process
to quit when user mode linux kernel abort.

[ jdike - the kernel process needs to ignore SIGTERM, plus the
  waitpid/kill loop is needed to make sure that all of our children
  are dead before the kernel exits ]

Signed-off-by: Lepton Wu <ytht.net@gmail.com>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/os-Linux/skas/process.c |    2 +-
 arch/um/os-Linux/util.c         |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

Index: linux-2.6.22/arch/um/os-Linux/util.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/util.c	2007-10-01 15:11:14.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/util.c	2007-10-01 17:04:34.000000000 -0400
@@ -105,6 +105,44 @@ int setjmp_wrapper(void (*proc)(void *, 
 
 void os_dump_core(void)
 {
+	int pid;
+
 	signal(SIGSEGV, SIG_DFL);
+
+	/*
+	 * We are about to SIGTERM this entire process group to ensure that
+	 * nothing is around to run after the kernel exits.  The
+	 * kernel wants to abort, not die through SIGTERM, so we
+	 * ignore it here.
+	 */
+
+	signal(SIGTERM, SIG_IGN);
+	kill(0, SIGTERM);
+	/*
+	 * Most of the other processes associated with this UML are
+	 * likely sTopped, so give them a SIGCONT so they see the
+	 * SIGTERM.
+	 */
+	kill(0, SIGCONT);
+
+	/*
+	 * Now, having sent signals to everyone but us, make sure they
+	 * die by ptrace.  Processes can survive what's been done to
+	 * them so far - the mechanism I understand is receiving a
+	 * SIGSEGV and segfaulting immediately upon return.  There is
+	 * always a SIGSEGV pending, and (I'm guessing) signals are
+	 * processed in numeric order so the SIGTERM (signal 15 vs
+	 * SIGSEGV being signal 11) is never handled.
+	 *
+	 * Run a waitpid loop until we get some kind of error.
+	 * Hopefully, it's ECHILD, but there's not a lot we can do if
+	 * it's something else.  Tell os_kill_ptraced_process not to
+	 * wait for the child to report its death because there's
+	 * nothing reasonable to do if that fails.
+	 */
+
+	while ((pid = waitpid(-1, NULL, WNOHANG)) > 0)
+		os_kill_ptraced_process(pid, 0);
+
 	abort();
 }
Index: linux-2.6.22/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/skas/process.c	2007-10-01 16:41:26.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/skas/process.c	2007-10-01 17:03:48.000000000 -0400
@@ -177,7 +177,7 @@ static int userspace_tramp(void *stack)
 
 	ptrace(PTRACE_TRACEME, 0, 0, 0);
 
-	init_new_thread_signals();
+	signal(SIGTERM, SIG_DFL);
 	err = set_interval();
 	if (err)
 		panic("userspace_tramp - setting timer failed, errno = %d\n",

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
