Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IrbUB-0008T9-WB for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Nov 2007 07:46:04 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IrbU9-0007YW-9b
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Nov 2007 07:46:03 -0800
Date: Mon, 12 Nov 2007 10:45:44 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071112154544.GA5576@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 2/2] UML - Update address space affected by
	pud_clear
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

pud_clear wasn't setting the _PAGE_NEWPAGE bit, fooling tlb_flush into
thinking that this area of the address space was up-to-date and not
unmapping whatever was covered by the pud.

This manifested itself as ldconfig on x86_64 complaining about the
first library it looked at not being a valid ELF file.  A config file
is mapped at 0x4000000, as the only thing mapped under its pud, and
unmapped.  The unmapping caused a pud_clear, which, due to this bug,
didn't actually unmap the config file data on the host.  The first
library is then mapped at the same location, but is not actually
mapped on the host because accesses to it cause no page faults.  As a
result, ldconfig sees the old config file data.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 include/asm-um/pgtable-3level.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.22/include/asm-um/pgtable-3level.h
===================================================================
--- linux-2.6.22.orig/include/asm-um/pgtable-3level.h	2007-10-12 12:09:08.000000000 -0400
+++ linux-2.6.22/include/asm-um/pgtable-3level.h	2007-11-07 12:20:02.000000000 -0500
@@ -71,7 +71,7 @@ static inline pmd_t *pmd_alloc_one(struc
 
 static inline void pud_clear (pud_t *pud)
 {
-        set_pud(pud, __pud(0));
+        set_pud(pud, __pud(_PAGE_NEWPAGE));
 }
 
 #define pud_page(pud) phys_to_page(pud_val(pud) & PAGE_MASK)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
