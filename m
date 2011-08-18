Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7pV-0006YZ-01
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:00:37 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7pU-0008R6-67
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:00:36 +0000
Date: Thu, 18 Aug 2011 20:00:29 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7pN-0007Th-6h@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] Subject: [PATCH 09/91] um: don't rely on sc.fpstate not
 having been reassigned prior to rt_sigreturn()
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


native rt_sigreturn() doesn't...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/sys-x86_64/signal.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/um/sys-x86_64/signal.c b/arch/um/sys-x86_64/signal.c
index 581b64d..ccfa554 100644
--- a/arch/um/sys-x86_64/signal.c
+++ b/arch/um/sys-x86_64/signal.c
@@ -44,10 +44,10 @@ void copy_sc(struct uml_pt_regs *regs, void *from)
 }
 
 static int copy_sc_from_user(struct pt_regs *regs,
-			     struct sigcontext __user *from,
-			     struct _fpstate __user *fpp)
+			     struct sigcontext __user *from)
 {
 	struct user_i387_struct fp;
+	void __user *buf;
 	int err = 0;
 
 #define GETREG(regs, regno, sc, regname)				\
@@ -78,7 +78,11 @@ static int copy_sc_from_user(struct pt_regs *regs,
 
 #undef GETREG
 
-	err = copy_from_user(&fp, fpp, sizeof(struct user_i387_struct));
+	err = __get_user(buf, &from->fpstate);
+	if (err)
+		return 1;
+
+	err = copy_from_user(&fp, buf, sizeof(struct user_i387_struct));
 	if (err)
 		return 1;
 
@@ -272,8 +276,7 @@ long sys_rt_sigreturn(struct pt_regs *regs)
 	sigdelsetmask(&set, ~_BLOCKABLE);
 	set_current_blocked(&set);
 
-	if (copy_sc_from_user(&current->thread.regs, &uc->uc_mcontext,
-			      &frame->fpstate))
+	if (copy_sc_from_user(&current->thread.regs, &uc->uc_mcontext))
 		goto segfault;
 
 	/* Avoid ERESTART handling */
-- 
1.7.2.5



------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

