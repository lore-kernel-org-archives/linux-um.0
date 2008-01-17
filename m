Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFcU3-00018d-SX for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:11 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFcU3-00017j-4d
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:11 -0800
Date: Thu, 17 Jan 2008 16:40:45 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080117214045.GA6752@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 13/20] UML - Spelling fix
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
To: Andrew Morton <akpm@osdl.org>
Cc: Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

From: Joe Perches <joe@perches.com>

Spelling fix

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/sys-x86_64/signal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-git/arch/um/sys-x86_64/signal.c
===================================================================
--- linux-2.6-git.orig/arch/um/sys-x86_64/signal.c	2008-01-02 11:25:13.000000000 -0500
+++ linux-2.6-git/arch/um/sys-x86_64/signal.c	2008-01-02 12:01:05.000000000 -0500
@@ -112,7 +112,7 @@ static int copy_sc_to_user(struct sigcon
 	err |= PUTREG(regs, RSI, to, rsi);
 	err |= PUTREG(regs, RBP, to, rbp);
 	/*
-	 * Must use orignal RSP, which is passed in, rather than what's in
+	 * Must use original RSP, which is passed in, rather than what's in
 	 * the pt_regs, because that's already been updated to point at the
 	 * signal frame.
 	 */

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
