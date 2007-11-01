Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ing6v-00006F-Aa for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Nov 2007 12:53:49 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ing6u-0006yT-IQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Nov 2007 12:53:49 -0700
Date: Thu, 1 Nov 2007 15:53:27 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071101195327.GA8882@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 4/4] UML - kill subprocesses on exit
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
To: stable@kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Lepton Wu <ytht.net@gmail.com>

commit 5161a303c94d812dc854278b58faa1885a669a48
Author: Lepton Wu <ytht.net@gmail.com>
Date:   Tue Oct 16 01:27:35 2007 -0700

    uml: definitively kill subprocesses on panic
    
    In a stock 2.6.22.6 kernel, poweroff a user mode linux guest (2.6.22.6 running
    in skas0 mode) will halt the host linux.  I think the reason is the kernel
    thread abort because of a bug.  Then the sys_reboot in process of user mode
    linux guest is not trapped by the user mode linux kernel and is executed by
    host.  I think it is better to make sure all of our children process to quit
    when user mode linux kernel abort.
    
    [ jdike - the kernel process needs to ignore SIGTERM, plus the waitpid/kill
    loop is needed to make sure that all of our children are dead before the
    kernel exits ]
    
    Signed-off-by: Lepton Wu <ytht.net@gmail.com>
    Signed-off-by: Jeff Dike <jdike@linux.intel.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/um/os-Linux/skas/process.c |    2 +-
 arch/um/os-Linux/util.c         |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index ba9af8d..607d2b8 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -182,7 +182,7 @@ static int userspace_tramp(void *stack)
 
 	ptrace(PTRACE_TRACEME, 0, 0, 0);
 
-	init_new_thread_signals();
+	signal(SIGTERM, SIG_DFL);
 	err = set_interval(1);
 	if(err)
 		panic("userspace_tramp - setting timer failed, errno = %d\n",
diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index 7cbcf48..ef09543 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -105,6 +105,44 @@ int setjmp_wrapper(void (*proc)(void *, void *), ...)
 
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


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
