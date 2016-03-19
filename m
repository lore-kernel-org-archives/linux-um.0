Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <elicooper@gmx.com>) id 1ahKDN-0007R3-FF
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Mar 2016 16:59:01 +0000
Received: from mout.gmx.net ([212.227.17.21])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ahKDM-0006c8-6d
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Mar 2016 16:59:01 +0000
From: Eli Cooper <elicooper@gmx.com>
Date: Sun, 20 Mar 2016 00:58:39 +0800
Message-Id: <1458406721-7478-2-git-send-email-elicooper@gmx.com>
In-Reply-To: <1458406721-7478-1-git-send-email-elicooper@gmx.com>
References: <1458406721-7478-1-git-send-email-elicooper@gmx.com>
Subject: [uml-devel] [PATCH v3 1/3] um: fix FPU state preservation around
	signal handlers
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>

This patch makes UML saves/restores FPU state from/to the fpstate in
pt_regs when setting up or returning from a signal stack, rather than
calling ptrace directly. This ensures that FPU state is correctly
preserved around signal handlers in a multi-threaded scenario.

Signed-off-by: Eli Cooper <elicooper@gmx.com>
---
 arch/x86/um/signal.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
index 14fcd01..dac23ee 100644
--- a/arch/x86/um/signal.c
+++ b/arch/x86/um/signal.c
@@ -225,20 +225,10 @@ static int copy_sc_from_user(struct pt_regs *regs,
 	} else
 #endif
 	{
-		struct user_i387_struct fp;
-
-		err = copy_from_user(&fp, (void *)sc.fpstate,
+		err = copy_from_user(regs->regs.fp, (void *)sc.fpstate,
 				     sizeof(struct user_i387_struct));
 		if (err)
 			return 1;
-
-		err = restore_fp_registers(pid, (unsigned long *) &fp);
-		if (err < 0) {
-			printk(KERN_ERR "copy_sc_from_user - "
-			       "restore_fp_registers failed, errno = %d\n",
-			       -err);
-			return 1;
-		}
 	}
 	return 0;
 }
@@ -325,10 +315,8 @@ static int copy_sc_to_user(struct sigcontext __user *to,
 	} else
 #endif
 	{
-		struct user_i387_struct fp;
-
-		err = save_fp_registers(pid, (unsigned long *) &fp);
-		if (copy_to_user(to_fp, &fp, sizeof(struct user_i387_struct)))
+		if (copy_to_user(to_fp, regs->regs.fp,
+				 sizeof(struct user_i387_struct)))
 			return 1;
 	}
 
-- 
2.7.2


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785231&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

