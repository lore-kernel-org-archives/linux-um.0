Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <aivanov@brocade.com>) id 1ZzooW-0001Od-8P
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 16:45:32 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZzooV-0001Ws-Ba
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 16:45:32 +0000
From: Anton Ivanov <aivanov@brocade.com>
Date: Fri, 20 Nov 2015 16:45:15 +0000
Message-Id: <1448037915-921549-3-git-send-email-aivanov@brocade.com>
In-Reply-To: <1448037915-921549-1-git-send-email-aivanov@brocade.com>
References: <1448037915-921549-1-git-send-email-aivanov@brocade.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 3/3] Signal handling cleanup
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Anton Ivanov <aivanov@brocade.com>

Fix signal handling to use store/restore instead of block/unblock
as that may cause IRQ reentrancy

Signed-off-by: Anton Ivanov <aivanov@brocade.com>
---
 arch/um/os-Linux/skas/process.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 13c5a2c..5916267 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -313,6 +313,7 @@ void userspace(struct uml_pt_regs *regs)
 	int err, status, op, pid = userspace_pid[0];
 	/* To prevent races if using_sysemu changes under us.*/
 	int local_using_sysemu;
+	unsigned long flags;
 	siginfo_t si;
 
 	/* Handle any immediate reschedules or signals */
@@ -396,9 +397,9 @@ void userspace(struct uml_pt_regs *regs)
 			case SIGBUS:
 			case SIGFPE:
 			case SIGWINCH:
-				block_signals();
+				flags = set_signals(0);
 				(*sig_info[sig])(sig, (struct siginfo *)&si, regs);
-				unblock_signals();
+				set_signals(flags);
 				break;
 			default:
 				printk(UM_KERN_ERR "userspace - child stopped "
@@ -586,15 +587,16 @@ int start_idle_thread(void *stack, jmp_buf *switch_buf)
 void initial_thread_cb_skas(void (*proc)(void *), void *arg)
 {
 	jmp_buf here;
+	unsigned long int flags;
 
 	cb_proc = proc;
 	cb_arg = arg;
 	cb_back = &here;
 
-	block_signals();
+	flags = set_signals(0);
 	if (UML_SETJMP(&here) == 0)
 		UML_LONGJMP(&initial_jmpbuf, INIT_JMP_CALLBACK);
-	unblock_signals();
+	set_signals(flags);
 
 	cb_proc = NULL;
 	cb_arg = NULL;
-- 
2.1.4


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

