Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JrotK-0000Be-8r for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 May 2008 23:37:10 -0700
Received: from wf-out-1314.google.com ([209.85.200.173])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JrotI-00023Q-VW
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 May 2008 23:37:10 -0700
Received: by wf-out-1314.google.com with SMTP id 28so1165391wfc.4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 01 May 2008 23:37:08 -0700 (PDT)
Date: Fri, 2 May 2008 14:39:45 +0800 (CST)
Message-ID: <alpine.LFD.1.10.0805021436300.3349@localhost.localdomain>
MIME-Version: 1.0
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: [SPAM] [uml-devel] [Patch] (Resend) arch/um/kernel/mem.c: remove
	arch_validate()
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
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net


Remove arch_validate(), because no one uses it.
Remove useless macro HAVE_ARCH_VALIDATE.
Make the variable 'empty_bad_page' static.

Compile testing passed.

Cc: Jeff Dike <jdike@addtoit.com>
Signed-off-by: WANG Cong <wangcong@zeuux.org>

---
  arch/um/kernel/ksyms.c |    1 -
  arch/um/kernel/mem.c   |   33 +--------------------------------
  include/asm-um/page.h  |    3 ---
  3 files changed, 1 insertions(+), 36 deletions(-)

diff --git a/arch/um/kernel/ksyms.c b/arch/um/kernel/ksyms.c
index 66e2a30..cc1b5f1 100644
--- a/arch/um/kernel/ksyms.c
+++ b/arch/um/kernel/ksyms.c
@@ -18,7 +18,6 @@ EXPORT_SYMBOL(get_signals);
  EXPORT_SYMBOL(kernel_thread);
  EXPORT_SYMBOL(sys_waitpid);
  EXPORT_SYMBOL(flush_tlb_range);
-EXPORT_SYMBOL(arch_validate);

  EXPORT_SYMBOL(high_physmem);
  EXPORT_SYMBOL(empty_zero_page);
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 2eea1ff..88fc1c8 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -21,7 +21,7 @@
  /* allocated in paging_init, zeroed in mem_init, and unchanged thereafter */
  unsigned long *empty_zero_page = NULL;
  /* allocated in paging_init and unchanged thereafter */
-unsigned long *empty_bad_page = NULL;
+static unsigned long *empty_bad_page = NULL;

  /*
   * Initialized during boot, and readonly for initializing page tables
@@ -240,37 +240,6 @@ void __init paging_init(void)
  #endif
  }

-struct page *arch_validate(struct page *page, gfp_t mask, int order)
-{
-	unsigned long addr, zero = 0;
-	int i;
-
- again:
-	if (page == NULL)
-		return page;
-	if (PageHighMem(page))
-		return page;
-
-	addr = (unsigned long) page_address(page);
-	for (i = 0; i < (1 << order); i++) {
-		current->thread.fault_addr = (void *) addr;
-		if (__do_copy_to_user((void __user *) addr, &zero,
-				     sizeof(zero),
-				     &current->thread.fault_addr,
-				     &current->thread.fault_catcher)) {
-			if (!(mask & __GFP_WAIT))
-				return NULL;
-			else break;
-		}
-		addr += PAGE_SIZE;
-	}
-
-	if (i == (1 << order))
-		return page;
-	page = alloc_pages(mask, order);
-	goto again;
-}
-
  /*
   * This can't do anything because nothing in the kernel image can be freed
   * since it's not in kernel physical memory.
diff --git a/include/asm-um/page.h b/include/asm-um/page.h
index 381f96b..4b489e3 100644
--- a/include/asm-um/page.h
+++ b/include/asm-um/page.h
@@ -114,9 +114,6 @@ extern unsigned long uml_physmem;
  #define pfn_valid(pfn) ((pfn) < max_mapnr)
  #define virt_addr_valid(v) pfn_valid(phys_to_pfn(__pa(v)))

-extern struct page *arch_validate(struct page *page, gfp_t mask, int order);
-#define HAVE_ARCH_VALIDATE
-
  #include <asm-generic/memory_model.h>
  #include <asm-generic/page.h>

-- 
1.5.2.4

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
