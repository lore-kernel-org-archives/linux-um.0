Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfQ02-0005zu-CP	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 15:23:14 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DfQ00-0007HD-C1	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 15:23:14 -0700
Message-Id: <200506062008.j56K8AaI008962@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/5] UML - Fix strace -f
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
Date: Mon, 06 Jun 2005 16:08:10 -0400
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

It turns out that we need to check for pending signals when a newly forked 
process is run for the first time.  With strace -f, strace needs to know
about the forked process before it gets going.  If it doesn't, then it
ptraces some bogus values into its registers, and the process segfaults.
So, I added calls to interrupt_end, which does that, plus checks for 
reschedules.  There shouldn't be any of those, but x86 does the same thing,
so I'm copying that behavior to be safe.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/kernel/skas/process_kern.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/skas/process_kern.c	2005-06-02 17:16:46.000000000 -0400
+++ linux-2.6.12-rc/arch/um/kernel/skas/process_kern.c	2005-06-02 17:16:50.000000000 -0400
@@ -68,8 +68,11 @@ void new_thread_handler(int sig)
 	 * 0 if it just exits
 	 */
 	n = run_kernel_thread(fn, arg, &current->thread.exec_buf);
-	if(n == 1)
+	if(n == 1){
+		/* Handle any immediate reschedules or signals */
+		interrupt_end();
 		userspace(&current->thread.regs.regs);
+	}
 	else do_exit(0);
 }
 
@@ -96,6 +99,8 @@ void fork_handler(int sig)
 	schedule_tail(current->thread.prev_sched);
 	current->thread.prev_sched = NULL;
 
+	/* Handle any immediate reschedules or signals */
+	interrupt_end();
 	userspace(&current->thread.regs.regs);
 }
 



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
