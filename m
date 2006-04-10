Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FT6rK-0007il-Bj for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Apr 2006 17:35:54 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FT6rK-000671-18
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Apr 2006 17:35:54 -0700
Message-Id: <200604102337.k3ANb8uX006848@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/3] UML - __user annotations
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
Date: Mon, 10 Apr 2006 19:37:08 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@zeniv.linux.org.uk>

From: Al Viro <viro@zeniv.linux.org.uk>

bits of uml __user annotations lost in merge

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16-mm/arch/um/sys-i386/signal.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/sys-i386/signal.c	2006-04-08 17:21:35.000000000 -0400
+++ linux-2.6.16-mm/arch/um/sys-i386/signal.c	2006-04-10 14:39:42.000000000 -0400
@@ -57,7 +57,7 @@ static int copy_sc_from_user_skas(struct
 	return(0);
 }
 
-int copy_sc_to_user_skas(struct sigcontext *to, struct _fpstate __user *to_fp,
+int copy_sc_to_user_skas(struct sigcontext __user *to, struct _fpstate __user *to_fp,
                          struct pt_regs *regs, unsigned long sp)
 {
   	struct sigcontext sc;
@@ -132,7 +132,7 @@ int copy_sc_from_user_tt(struct sigconte
 	return(err);
 }
 
-int copy_sc_to_user_tt(struct sigcontext *to, struct _fpstate __user *fp,
+int copy_sc_to_user_tt(struct sigcontext __user *to, struct _fpstate __user *fp,
 		       struct sigcontext *from, int fpsize, unsigned long sp)
 {
 	struct _fpstate __user *to_fp;
@@ -167,7 +167,7 @@ static int copy_sc_from_user(struct pt_r
 	return(ret);
 }
 
-static int copy_sc_to_user(struct sigcontext *to, struct _fpstate __user *fp,
+static int copy_sc_to_user(struct sigcontext __user *to, struct _fpstate __user *fp,
 			   struct pt_regs *from, unsigned long sp)
 {
 	return(CHOOSE_MODE(copy_sc_to_user_tt(to, fp, UPT_SC(&from->regs),



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
