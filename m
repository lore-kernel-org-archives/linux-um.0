Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IL3tb-0008GA-3p for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Aug 2007 14:25:47 -0700
Received: from emailhub.stusta.mhn.de ([141.84.69.5]
	helo=mailhub.stusta.mhn.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IL3ta-0002Zy-L2
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Aug 2007 14:25:47 -0700
Date: Tue, 14 Aug 2007 23:25:33 +0200
From: Adrian Bunk <bunk@kernel.org>
Message-ID: <20070814212533.GT18945@stusta.de>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [2.6 patch] UML: "extern inline" -> "static inline"
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
To: jdike@karaya.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

"extern inline" will have different semantics with gcc 4.3.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 include/asm-um/pgalloc.h          |    2 +-
 include/asm-um/pgtable-3level.h   |    2 +-
 include/asm-um/processor-x86_64.h |    2 +-
 include/asm-um/smp.h              |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

536a148260f539edfbd81819a087dab0ea773350 
diff --git a/include/asm-um/pgalloc.h b/include/asm-um/pgalloc.h
index 34ab268..1490487 100644
--- a/include/asm-um/pgalloc.h
+++ b/include/asm-um/pgalloc.h
@@ -42,7 +42,7 @@ static inline void pte_free(struct page *pte)
 
 #ifdef CONFIG_3_LEVEL_PGTABLES
 
-extern __inline__ void pmd_free(pmd_t *pmd)
+static inline void pmd_free(pmd_t *pmd)
 {
 	free_page((unsigned long)pmd);
 }
diff --git a/include/asm-um/pgtable-3level.h b/include/asm-um/pgtable-3level.h
index ca0c2a9..aa82b88 100644
--- a/include/asm-um/pgtable-3level.h
+++ b/include/asm-um/pgtable-3level.h
@@ -69,7 +69,7 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
         return pmd;
 }
 
-extern inline void pud_clear (pud_t *pud)
+static inline void pud_clear (pud_t *pud)
 {
         set_pud(pud, __pud(0));
 }
diff --git a/include/asm-um/processor-x86_64.h b/include/asm-um/processor-x86_64.h
index 31c2d4d..d946bf2 100644
--- a/include/asm-um/processor-x86_64.h
+++ b/include/asm-um/processor-x86_64.h
@@ -18,7 +18,7 @@ struct arch_thread {
 };
 
 /* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
-extern inline void rep_nop(void)
+static inline void rep_nop(void)
 {
 	__asm__ __volatile__("rep;nop": : :"memory");
 }
diff --git a/include/asm-um/smp.h b/include/asm-um/smp.h
index 84f8cf2..f27a963 100644
--- a/include/asm-um/smp.h
+++ b/include/asm-um/smp.h
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
