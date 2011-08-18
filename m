Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7pL-0007Nv-0f
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:00:27 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7pK-0003gK-58
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:00:26 +0000
Date: Thu, 18 Aug 2011 20:00:19 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7pD-0007TQ-6T@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 08/91] um: switch {rt_,
 }sigreturn() to set_current_blocked()
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


same story as on x86 native...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/sys-i386/signal.c   |   12 ++----------
 arch/um/sys-x86_64/signal.c |    6 +-----
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/um/sys-i386/signal.c b/arch/um/sys-i386/signal.c
index 89a4662..4403b48 100644
--- a/arch/um/sys-i386/signal.c
+++ b/arch/um/sys-i386/signal.c
@@ -458,11 +458,7 @@ long sys_sigreturn(struct pt_regs regs)
 		goto segfault;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-
-	spin_lock_irq(&current->sighand->siglock);
-	current->blocked = set;
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+	set_current_blocked(&set);
 
 	if (copy_sc_from_user(&current->thread.regs, sc))
 		goto segfault;
@@ -489,11 +485,7 @@ long sys_rt_sigreturn(struct pt_regs regs)
 		goto segfault;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-
-	spin_lock_irq(&current->sighand->siglock);
-	current->blocked = set;
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+	set_current_blocked(&set);
 
 	if (copy_sc_from_user(&current->thread.regs, &uc->uc_mcontext))
 		goto segfault;
diff --git a/arch/um/sys-x86_64/signal.c b/arch/um/sys-x86_64/signal.c
index b6b65c7..581b64d 100644
--- a/arch/um/sys-x86_64/signal.c
+++ b/arch/um/sys-x86_64/signal.c
@@ -270,11 +270,7 @@ long sys_rt_sigreturn(struct pt_regs *regs)
 		goto segfault;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-
-	spin_lock_irq(&current->sighand->siglock);
-	current->blocked = set;
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+	set_current_blocked(&set);
 
 	if (copy_sc_from_user(&current->thread.regs, &uc->uc_mcontext,
 			      &frame->fpstate))
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

