Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyDKW-00071M-9i	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Jul 2005 11:42:04 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1DyDKU-0007o9-R3
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Jul 2005 11:42:04 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050728185702.B5CB95EFD@zion.home.lan>
Subject: [uml-devel] [patch 3/3] uml: fix tlb flushing for accessed bit
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
Date: Thu, 28 Jul 2005 20:57:02 +0200
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


Mark a page with _PAGE_NEWPROT on pte_mkold() to get it remapped not-readable
on the host when it is not marked as accessed, to be able to emulate correctly
the accessed bit.

This patch, as said in the comment for the previous one (fixing this for
pte_mkclean()) should be merged only after benchmarking, since the additional
costs for the read faults are very big (a lot bigger than on the host).

Possibly, increasing the timeout for scanning pages and marking them as
accessed could be useful for us.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/asm-um/pgtable.h |    3 +++
 1 files changed, 3 insertions(+)

diff -puN include/asm-um/pgtable.h~uml-fix-tlb-flushing-accessed include/asm-um/pgtable.h
--- linux-2.6.git/include/asm-um/pgtable.h~uml-fix-tlb-flushing-accessed	2005-07-28 20:53:57.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-um/pgtable.h	2005-07-28 20:53:57.000000000 +0200
@@ -268,6 +268,9 @@ static inline pte_t pte_mkclean(pte_t pt
 static inline pte_t pte_mkold(pte_t pte)	
 { 
 	pte_clear_bits(pte, _PAGE_ACCESSED);
+	/* We want that next flush makes this page again not-readable, so we'll
+	 * mark it as accessed again */
+	pte_set_bits(pte, _PAGE_NEWPROT);
 	return(pte);
 }
 
_


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
