Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HYPn8-0005kg-Dk for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2007 09:54:02 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HYPn6-0003bA-DB
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2007 09:54:02 -0700
Date: Mon, 2 Apr 2007 12:50:12 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070402165012.GA7626@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 4/4] UML - kernel_thread shouldn't panic
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
To: Andrew Morton <akpm@osdl.org>, devzero@web.de
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

kernel_thread should just return an error value on do_fork failure, not panic.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/kernel/process.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux-2.6.21-mm/arch/um/kernel/process.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/process.c	2007-04-02 11:51:43.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/process.c	2007-04-02 12:01:00.000000000 -0400
@@ -97,8 +97,6 @@ int kernel_thread(int (*fn)(void *), voi
 	current->thread.request.u.thread.arg = arg;
 	pid = do_fork(CLONE_VM | CLONE_UNTRACED | flags, 0,
 		      &current->thread.regs, 0, NULL, NULL);
-	if(pid < 0)
-		panic("do_fork failed in kernel_thread, errno = %d", pid);
 	return pid;
 }
 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
