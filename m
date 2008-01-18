Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFvdD-00034b-Eu for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Jan 2008 10:07:55 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFvdC-000391-TB
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Jan 2008 10:07:55 -0800
Date: Fri, 18 Jan 2008 13:07:49 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080118180749.GA7688@c2.user-mode-linux.org>
References: <E1JFsQo-0000aG-BZ@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1JFsQo-0000aG-BZ@pomaz-ex.szeredi.hu>
Subject: Re: [uml-devel] UML is leaking memory in arch_dup_mmap
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Fri, Jan 18, 2008 at 03:42:54PM +0100, Miklos Szeredi wrote:
> uml:~#  grep arch_dup_mmap /proc/slab_allocators
> size-32: 10861 arch_dup_mmap+0x9f/0x130

Whoops - try the patch below.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

Index: linux-2.6.22/arch/um/include/um_mmu.h
===================================================================
--- linux-2.6.22.orig/arch/um/include/um_mmu.h	2008-01-17 13:44:49.000000000 -0500
+++ linux-2.6.22/arch/um/include/um_mmu.h	2008-01-18 12:53:10.000000000 -0500
@@ -17,6 +17,7 @@ typedef struct mm_context {
 	unsigned long last_pmd;
 #endif
 	struct uml_ldt ldt;
+	struct page **stub_pages;
 } mm_context_t;
 
 extern void __switch_mm(struct mm_id * mm_idp);
Index: linux-2.6.22/arch/um/kernel/skas/mmu.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/skas/mmu.c	2008-01-18 13:02:52.000000000 -0500
+++ linux-2.6.22/arch/um/kernel/skas/mmu.c	2008-01-18 13:04:42.000000000 -0500
@@ -91,6 +91,8 @@ int init_new_context(struct task_struct 
 		goto out_free;
 	}
 
+	to_mm->stub_pages = NULL;
+
 	return 0;
 
  out_free:
@@ -126,6 +128,7 @@ void arch_dup_mmap(struct mm_struct *old
 
 	pages[0] = virt_to_page(&__syscall_stub_start);
 	pages[1] = virt_to_page(mm->context.id.stack);
+	mm->context.stub_pages = pages;
 
 	/* dup_mmap already holds mmap_sem */
 	err = install_special_mapping(mm, STUB_START, STUB_END - STUB_START,
@@ -147,6 +150,8 @@ void arch_exit_mmap(struct mm_struct *mm
 {
 	pte_t *pte;
 
+	if(mm->context.stub_pages != NULL)
+		kfree(mm->context.stub_pages);
 	pte = virt_to_pte(mm, STUB_CODE);
 	if (pte != NULL)
 		pte_clear(mm, STUB_CODE, pte);

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
