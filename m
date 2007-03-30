Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HXIWZ-0005v3-AE for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Mar 2007 07:56:19 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HXIWY-0007pZ-T6
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Mar 2007 07:56:19 -0700
Date: Fri, 30 Mar 2007 10:52:57 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070330145257.GA5471@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 2/2] UML - Speed up exec
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
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

flush_thread doesn't need to do a full page table walk in order to
clear the address space.  It knows what the end result needs to be, so
it can call unmap directly.

This results in a 10-20% speedup in an exec from bash.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/kernel/skas/exec.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

Index: linux-2.6.21-mm/arch/um/kernel/skas/exec.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/skas/exec.c	2007-03-30 10:28:24.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/skas/exec.c	2007-03-30 10:30:15.000000000 -0400
@@ -17,7 +17,17 @@
 
 void flush_thread_skas(void)
 {
-	force_flush_all();
+	void *data = NULL;
+	unsigned long end = proc_mm ? task_size : CONFIG_STUB_START;
+	int ret;
+
+	ret = unmap(&current->mm->context.skas.id, 0, end, 1, &data);
+	if(ret){
+		printk("flush_thread_skas - clearing address space failed, "
+		       "err = %d\n", ret);
+		force_sig(SIGKILL, current);
+	}
+
 	switch_mm_skas(&current->mm->context.skas.id);
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
