Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3e3j-0004fZ-IM	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:15:11 -0700
Received: from mail-relay-1.tiscali.it ([213.205.33.41])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3e3i-0000jt-SW
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:15:11 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812182145.DF52E24E7F3@zion.home.lan>
Subject: [uml-devel] [patch 18/39] remap_file_pages protection support: add
	VM_FAULT_SIGSEGV
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
Date: Fri, 12 Aug 2005 20:21:45 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, mingo@elte.hu


From: Ingo Molnar <mingo@elte.hu>

Since with remap_file_pages w/prot we may put PROT_NONE on a single PTE rather
than a VMA, we must handle that inside handle_mm_fault.

This value must be handled in the arch-specific fault handlers, and this
change must be ported to every arch on the world; now the new support is not
in a separate syscall, so this *must* be done unless we want stability /
security issues (the *BUG()* for unknown return values of handle_mm_fault() is
triggerable from userspace calling remap_file_pages, and on other archs, we
have VM_FAULT_OOM which is worse). However, I've alleviated this need via the
previous "safety net" patch.

This patch includes the arch-specific part for i386.

Note, however, that _proper_ support is more intrusive; we can allow a write
on a readonly VMA, but the arch fault handler currently stops that; it should
test VM_NONUNIFORM instead and call handle_mm_fault() in case it's set. And it
will have to do on its own all protection checks. This is in the following
patches.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/i386/mm/fault.c |    2 ++
 linux-2.6.git-paolo/include/linux/mm.h   |    9 +++++----
 linux-2.6.git-paolo/mm/memory.c          |   12 ++++++++++++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff -puN arch/i386/mm/fault.c~rfp-add-vm_fault_sigsegv arch/i386/mm/fault.c
--- linux-2.6.git/arch/i386/mm/fault.c~rfp-add-vm_fault_sigsegv	2005-08-11 14:19:57.000000000 +0200
+++ linux-2.6.git-paolo/arch/i386/mm/fault.c	2005-08-11 14:19:58.000000000 +0200
@@ -351,6 +351,8 @@ good_area:
 			goto do_sigbus;
 		case VM_FAULT_OOM:
 			goto out_of_memory;
+		case VM_FAULT_SIGSEGV:
+			goto bad_area;
 		default:
 			BUG();
 	}
diff -puN include/linux/mm.h~rfp-add-vm_fault_sigsegv include/linux/mm.h
--- linux-2.6.git/include/linux/mm.h~rfp-add-vm_fault_sigsegv	2005-08-11 14:19:58.000000000 +0200
+++ linux-2.6.git-paolo/include/linux/mm.h	2005-08-11 14:19:58.000000000 +0200
@@ -632,10 +632,11 @@ static inline int page_mapped(struct pag
  * Used to decide whether a process gets delivered SIGBUS or
  * just gets major/minor fault counters bumped up.
  */
-#define VM_FAULT_OOM	(-1)
-#define VM_FAULT_SIGBUS	0
-#define VM_FAULT_MINOR	1
-#define VM_FAULT_MAJOR	2
+#define VM_FAULT_OOM		(-1)
+#define VM_FAULT_SIGBUS		0
+#define VM_FAULT_MINOR		1
+#define VM_FAULT_MAJOR		2
+#define VM_FAULT_SIGSEGV	3
 
 #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
 
diff -puN mm/memory.c~rfp-add-vm_fault_sigsegv mm/memory.c
--- linux-2.6.git/mm/memory.c~rfp-add-vm_fault_sigsegv	2005-08-11 14:19:58.000000000 +0200
+++ linux-2.6.git-paolo/mm/memory.c	2005-08-11 14:19:58.000000000 +0200
@@ -1995,6 +1995,18 @@ static inline int handle_pte_fault(struc
 		return do_swap_page(mm, vma, address, pte, pmd, entry, write_access);
 	}
 
+	/*
+	 * Generate a SIGSEGV if a PROT_NONE page is accessed; this is handled
+	 * in arch-specific code if the whole VMA has PROT_NONE, and here if
+	 * just this pte has PROT_NONE (which can be done only with
+	 * remap_file_pages).
+	 */
+	if (pgprot_val(pte_to_pgprot(entry)) == pgprot_val(__P000)) {
+		pte_unmap(pte);
+		spin_unlock(&mm->page_table_lock);
+		return VM_FAULT_SIGSEGV;
+	}
+
 	if (write_access) {
 		if (!pte_write(entry))
 			return do_wp_page(mm, vma, address, pte, pmd, entry);
_


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
