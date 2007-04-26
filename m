Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HhA80-0005F3-GK for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Apr 2007 12:59:51 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HhA7z-0002Fb-2z
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Apr 2007 12:59:43 -0700
Date: Thu, 26 Apr 2007 15:56:24 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070426195624.GA9578@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 3/5] UML - Only flush areas covered by VMA
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

When doing a full address space flush, only look at areas covered by a VMA.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/kernel/skas/tlb.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Index: linux-2.6.21-mm/arch/um/kernel/skas/tlb.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/skas/tlb.c	2007-04-17 12:20:05.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/skas/tlb.c	2007-04-17 12:55:38.000000000 -0400
@@ -89,8 +89,13 @@ void flush_tlb_mm_skas(struct mm_struct 
 
 void force_flush_all_skas(void)
 {
-	unsigned long end = proc_mm ? task_size : CONFIG_STUB_START;
-        fix_range(current->mm, 0, end, 1);
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma = mm->mmap;
+
+	while(vma != NULL) {
+		fix_range(mm, vma->vm_start, vma->vm_end, 1);
+		vma = vma->vm_next;
+	}
 }
 
 void flush_tlb_page_skas(struct vm_area_struct *vma, unsigned long address)

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
