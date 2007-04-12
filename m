Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hc2EZ-0002Ap-Bu for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Apr 2007 09:33:19 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hc2EX-0000fk-Op
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Apr 2007 09:33:19 -0700
Date: Thu, 12 Apr 2007 12:28:03 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070412162803.GA7245@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [ PATCH 4/6 ] UML - Remove debugging remnants
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

I accidentally left the remnants of some debugging in an earlier patch.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/kernel/tlb.c |    3 ---
 1 file changed, 3 deletions(-)

Index: linux-2.6.21-mm/arch/um/kernel/tlb.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/tlb.c	2007-04-12 11:34:40.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/tlb.c	2007-04-12 11:46:27.000000000 -0400
@@ -235,9 +235,7 @@ void fix_range_common(struct mm_struct *
 	unsigned long addr = start_addr, next;
 	int ret = 0, last_op = ARRAY_SIZE(ops) - 1, op_index = -1;
 	void *flush = NULL;
-	unsigned long long start_time, end_time;
 
-	start_time = os_nsecs();
 	ops[0].type = NONE;
 	pgd = pgd_offset(mm, addr);
 	do {
@@ -254,7 +252,6 @@ void fix_range_common(struct mm_struct *
 					    &op_index, force, mmu, &flush,
 					    do_ops);
 	} while (pgd++, addr = next, ((addr != end_addr) && !ret));
-	end_time = os_nsecs();
 
 	if(!ret)
 		ret = (*do_ops)(mmu, ops, op_index, 1, &flush);

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
