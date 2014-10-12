Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Date: Sun, 12 Oct 2014 13:02:12 +0200
Message-Id: <1413111733-10763-2-git-send-email-nicolas.iooss_linux@m4x.org>
In-Reply-To: <1413111733-10763-1-git-send-email-nicolas.iooss_linux@m4x.org>
References: <1413111733-10763-1-git-send-email-nicolas.iooss_linux@m4x.org>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 2/3] um: Use char[] for linker script address
	declarations
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

The linker script defines some variables which are declared either with
type char[] in include/asm-generic/sections.h or with a meaningless
integer type in arch/um/include/asm/sections.h.

Fix this inconsistency by declaring every variable char[].

Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
---
 arch/um/include/asm/sections.h | 4 ++--
 arch/um/kernel/physmem.c       | 4 ++--
 arch/um/kernel/skas/mmu.c      | 4 ++--
 arch/um/kernel/um_arch.c       | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/um/include/asm/sections.h b/arch/um/include/asm/sections.h
index 3a6ebcc65519..cafcf684d947 100644
--- a/arch/um/include/asm/sections.h
+++ b/arch/um/include/asm/sections.h
@@ -3,7 +3,7 @@
 
 #include <asm-generic/sections.h>
 
-extern char __binary_start;
-extern int __syscall_stub_start, __syscall_stub_end;
+extern char __binary_start[];
+extern char __syscall_stub_start[], __syscall_stub_end[];
 
 #endif
diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index db05c067665a..c833a5dec1e7 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -100,8 +100,8 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 	 * Special kludge - This page will be mapped in to userspace processes
 	 * from physmem_fd, so it needs to be written out there.
 	 */
-	os_seek_file(physmem_fd, __pa(&__syscall_stub_start));
-	os_write_file(physmem_fd, &__syscall_stub_start, PAGE_SIZE);
+	os_seek_file(physmem_fd, __pa(__syscall_stub_start));
+	os_write_file(physmem_fd, __syscall_stub_start, PAGE_SIZE);
 	os_fsync_file(physmem_fd);
 
 	bootmap_size = init_bootmem(pfn, pfn + delta);
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index d2a0a4c0cd91..e40ce29bdc2c 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -108,7 +108,7 @@ void uml_setup_stubs(struct mm_struct *mm)
 		return;
 
 	ret = init_stub_pte(mm, STUB_CODE,
-			    (unsigned long) &__syscall_stub_start);
+			    (unsigned long) __syscall_stub_start);
 	if (ret)
 		goto out;
 
@@ -116,7 +116,7 @@ void uml_setup_stubs(struct mm_struct *mm)
 	if (ret)
 		goto out;
 
-	mm->context.stub_pages[0] = virt_to_page(&__syscall_stub_start);
+	mm->context.stub_pages[0] = virt_to_page(__syscall_stub_start);
 	mm->context.stub_pages[1] = virt_to_page(mm->context.id.stack);
 
 	/* dup_mmap already holds mmap_sem */
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 02c21f6e0983..5dd632203dca 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -313,7 +313,7 @@ int __init linux_main(int argc, char **argv)
 		physmem_size += UML_ROUND_UP(brk_start) - UML_ROUND_UP(&_end);
 	}
 
-	uml_physmem = (unsigned long) &__binary_start & PAGE_MASK;
+	uml_physmem = (unsigned long) __binary_start & PAGE_MASK;
 
 	/* Reserve up to 4M after the current brk */
 	uml_reserved = ROUND_4M(brk_start) + (1 << 22);
-- 
2.1.1


------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://p.sf.net/sfu/Zoho
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

