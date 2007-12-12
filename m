Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J2YV8-0001ba-6Z for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Dec 2007 12:48:18 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J2YV6-0006rb-IN
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Dec 2007 12:48:18 -0800
Date: Wed, 12 Dec 2007 15:47:58 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071212204758.GA9124@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 2/6] UML - don't kill pid 0
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
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

A bit of defensive programming - during development, it ocassionally
happens that a call to init_new_context is missed, resulting in
context holding a host pid of zero.  When that address space is torn
down, destroy_context does a kill(0), which instantly kills the whole
UML without any errors whatsoever.

This patch add a check for pids less than 2, to also catch 1 and
negative pids.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/kernel/skas/mmu.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

Index: linux-2.6-git/arch/um/kernel/skas/mmu.c
===================================================================
--- linux-2.6-git.orig/arch/um/kernel/skas/mmu.c	2007-12-12 15:06:14.000000000 -0500
+++ linux-2.6-git/arch/um/kernel/skas/mmu.c	2007-12-12 15:12:11.000000000 -0500
@@ -164,8 +164,20 @@ void destroy_context(struct mm_struct *m
 
 	if (proc_mm)
 		os_close_file(mmu->id.u.mm_fd);
-	else
+	else {
+		/*
+		 * If init_new_context wasn't called, this will be
+		 * zero, resulting in a kill(0), which will result in the
+		 * whole UML suddenly dying.  Also, cover negative and
+		 * 1 cases, since they shouldn't happen either.
+		 */
+		if (mmu->id.u.pid < 2) {
+			printk(KERN_ERR "corrupt mm_context - pid = %d\n",
+			       mmu->id.u.pid);
+			return;
+		}
 		os_kill_ptraced_process(mmu->id.u.pid, 1);
+	}
 
 	if (skas_needs_stub)
 		free_page(mmu->id.stack);

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
