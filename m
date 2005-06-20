Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DkUBy-00029E-6t	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 14:52:30 -0700
Received: from coderock.org
	([193.77.147.115] helo=trashy.coderock.org ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DkUBw-0005SG-Rv	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 14:52:30 -0700
Message-Id: <20050620215041.767887000@nd47.coderock.org>
From: domen@coderock.org
Content-Disposition: inline; filename=size-arch_um_sys-i386_signal
Subject: [uml-devel] [patch 1/1] um: copy_from_user size fix in signal.c
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
Date: Mon, 20 Jun 2005 23:50:42 +0200
To: jdike@karaya.com
Cc: user-mode-linux-devel@lists.sourceforge.net, domen@coderock.org

From: Domen Puncer <domen@coderock.org>


Size of pointer doesn't seem right, but maybe my solution isn't
either (sig_size maybe?).


Signed-off-by: Domen Puncer <domen@coderock.org>

---
 signal.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: quilt/arch/um/sys-i386/signal.c
===================================================================
--- quilt.orig/arch/um/sys-i386/signal.c
+++ quilt/arch/um/sys-i386/signal.c
@@ -312,7 +312,7 @@ long sys_sigreturn(struct pt_regs regs)
 	unsigned long __user *extramask = frame->extramask;
 	int sig_size = (_NSIG_WORDS - 1) * sizeof(unsigned long);
 
-	if(copy_from_user(&set.sig[0], oldmask, sizeof(&set.sig[0])) ||
+	if(copy_from_user(&set.sig[0], oldmask, sizeof(set.sig[0])) ||
 	   copy_from_user(&set.sig[1], extramask, sig_size))
 		goto segfault;
 

--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
