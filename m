Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DkRSy-0000xm-TU	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 11:57:52 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DkRSy-0007cy-CU	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 11:57:52 -0700
Message-Id: <200506201851.j5KIpBBc008473@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/8] UML - Fix sizeof usage
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
Date: Mon, 20 Jun 2005 14:51:11 -0400
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, domen@coderock.org

From: Domen Puncer <domen@coderock.org>
Subject: [KJ] [patch] um: copy_from_user size fix in signal.c

Size of pointer doesn't seem right, but maybe my solution isn't
either (sig_size maybe?).

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/sys-i386/signal.c
===================================================================
--- linux-2.6.12.orig/arch/um/sys-i386/signal.c	2005-06-20 11:54:53.000000000 -0400
+++ linux-2.6.12/arch/um/sys-i386/signal.c	2005-06-20 11:55:47.000000000 -0400
@@ -312,7 +312,7 @@ long sys_sigreturn(struct pt_regs regs)
 	unsigned long __user *extramask = frame->extramask;
 	int sig_size = (_NSIG_WORDS - 1) * sizeof(unsigned long);
 
-	if(copy_from_user(&set.sig[0], oldmask, sizeof(&set.sig[0])) ||
+	if(copy_from_user(&set.sig[0], oldmask, sizeof(set.sig[0])) ||
 	   copy_from_user(&set.sig[1], extramask, sig_size))
 		goto segfault;
 



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
