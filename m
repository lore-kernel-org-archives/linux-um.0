Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IMCOH-0008U3-U8 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Aug 2007 17:42:10 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IMCOH-0003zW-C2
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Aug 2007 17:42:09 -0700
Date: Fri, 17 Aug 2007 15:43:40 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070817194340.GA8734@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/6] UML - Fix inlines
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
Cc: Adrian Bunk <bunk@kernel.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

"extern inline" will have different semantics with gcc 4.3.

Signed-off-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 include/asm-um/pgalloc.h          |    2 +-
 include/asm-um/pgtable-3level.h   |    2 +-
 include/asm-um/processor-x86_64.h |    2 +-
 include/asm-um/smp.h              |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.22/include/asm-um/pgalloc.h
===================================================================
--- linux-2.6.22.orig/include/asm-um/pgalloc.h	2007-08-13 22:38:59.000000000 -0400
+++ linux-2.6.22/include/asm-um/pgalloc.h	2007-08-16 12:04:12.000000000 -0400
@@ -42,7 +42,7 @@ static inline void pte_free(struct page 
 
 #ifdef CONFIG_3_LEVEL_PGTABLES
 
-extern __inline__ void pmd_free(pmd_t *pmd)
+static inline void pmd_free(pmd_t *pmd)
 {
 	free_page((unsigned long)pmd);
 }
Index: linux-2.6.22/include/asm-um/pgtable-3level.h
===================================================================
--- linux-2.6.22.orig/include/asm-um/pgtable-3level.h	2007-07-08 19:32:17.000000000 -0400
+++ linux-2.6.22/include/asm-um/pgtable-3level.h	2007-08-15 10:39:59.000000000 -0400
@@ -69,7 +69,7 @@ static inline pmd_t *pmd_alloc_one(struc
         return pmd;
 }
 
-extern inline void pud_clear (pud_t *pud)
+static inline void pud_clear (pud_t *pud)
 {
         set_pud(pud, __pud(0));
 }
Index: linux-2.6.22/include/asm-um/processor-x86_64.h
===================================================================
--- linux-2.6.22.orig/include/asm-um/processor-x86_64.h	2007-07-08 19:32:17.000000000 -0400
+++ linux-2.6.22/include/asm-um/processor-x86_64.h	2007-08-15 10:39:59.000000000 -0400
@@ -18,7 +18,7 @@ struct arch_thread {
 };
 
 /* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
-extern inline void rep_nop(void)
+static inline void rep_nop(void)
 {
 	__asm__ __volatile__("rep;nop": : :"memory");
 }
Index: linux-2.6.22/include/asm-um/smp.h
===================================================================
--- linux-2.6.22.orig/include/asm-um/smp.h	2007-07-08 19:32:17.000000000 -0400
+++ linux-2.6.22/include/asm-um/smp.h	2007-08-15 10:39:59.000000000 -0400
@@ -18,7 +18,7 @@ extern int hard_smp_processor_id(void);
 extern int ncpus;
 
 
-extern inline void smp_cpus_done(unsigned int maxcpus)
+static inline void smp_cpus_done(unsigned int maxcpus)
 {
 }
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
