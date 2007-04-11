Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HbfL6-00025G-4Y for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Apr 2007 09:06:32 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HbfL5-0001U2-IZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Apr 2007 09:06:32 -0700
Date: Wed, 11 Apr 2007 12:01:27 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070411160127.GA6334@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 4/4] UML - Don't try to handle signals on
	initial process stack
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Code running on the initial UML stack can't receive or process signals
since current must be valid when IRQs are handled, and there is no
current for this stack.

So, instead of using UML_LONGJMP and UML_SETJMP, which are careful
to save and restore signal state, and, as a side-effect, handle any
deferred signals, start_idle_thread must use the bare equivalents,
which don't do anything with signals.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/os-Linux/skas/process.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

Index: linux-2.6.21-mm/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/skas/process.c	2007-04-10 20:21:06.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/skas/process.c	2007-04-10 20:21:12.000000000 -0400
@@ -494,7 +494,15 @@ int start_idle_thread(void *stack, jmp_b
 		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGALRM,
 		    SIGVTALRM, -1);
 
-	n = UML_SETJMP(&initial_jmpbuf);
+	/*
+	 * Can't use UML_SETJMP or UML_LONGJMP here because they save
+	 * and restore signals, with the possible side-effect of
+	 * trying to handle any signals which came when they were
+	 * blocked, which can't be done on this stack.
+	 * Signals must be blocked when jumping back here and restored
+	 * after returning to the jumper.
+	 */
+	n = setjmp(initial_jmpbuf);
 	switch(n){
 	case INIT_JMP_NEW_THREAD:
 		(*switch_buf)[0].JB_IP = (unsigned long) new_thread_handler;
@@ -504,7 +512,7 @@ int start_idle_thread(void *stack, jmp_b
 		break;
 	case INIT_JMP_CALLBACK:
 		(*cb_proc)(cb_arg);
-		UML_LONGJMP(cb_back, 1);
+		longjmp(*cb_back, 1);
 		break;
 	case INIT_JMP_HALT:
 		kmalloc_ok = 0;
@@ -515,7 +523,7 @@ int start_idle_thread(void *stack, jmp_b
 	default:
 		panic("Bad sigsetjmp return in start_idle_thread - %d\n", n);
 	}
-	UML_LONGJMP(switch_buf, 1);
+	longjmp(*switch_buf, 1);
 }
 
 void initial_thread_cb_skas(void (*proc)(void *), void *arg)

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
