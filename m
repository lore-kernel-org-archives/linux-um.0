Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Date: Sun, 12 Oct 2014 13:02:11 +0200
Message-Id: <1413111733-10763-1-git-send-email-nicolas.iooss_linux@m4x.org>
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
Subject: [uml-devel] [PATCH 1/3] um: Create asm/sections.h
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

arch/um/kernel/dyn.lds.S and arch/um/kernel/uml.lds.S define some
UML-specific symbols.  These symbols are used in the kernel part of UML
with extern declarations.

Move these declarations to a new header, asm/sections.h, like other
architectures do.

Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
---
 arch/um/include/asm/Kbuild     | 1 -
 arch/um/include/asm/sections.h | 9 +++++++++
 arch/um/kernel/physmem.c       | 3 +--
 arch/um/kernel/skas/mmu.c      | 3 +--
 arch/um/kernel/um_arch.c       | 2 --
 5 files changed, 11 insertions(+), 7 deletions(-)
 create mode 100644 arch/um/include/asm/sections.h

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 244b12c8cb39..21fd5c647442 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -23,7 +23,6 @@ generic-y += pci.h
 generic-y += percpu.h
 generic-y += preempt.h
 generic-y += scatterlist.h
-generic-y += sections.h
 generic-y += switch_to.h
 generic-y += topology.h
 generic-y += trace_clock.h
diff --git a/arch/um/include/asm/sections.h b/arch/um/include/asm/sections.h
new file mode 100644
index 000000000000..3a6ebcc65519
--- /dev/null
+++ b/arch/um/include/asm/sections.h
@@ -0,0 +1,9 @@
+#ifndef __UM_SECTIONS_H
+#define __UM_SECTIONS_H
+
+#include <asm-generic/sections.h>
+
+extern char __binary_start;
+extern int __syscall_stub_start, __syscall_stub_end;
+
+#endif
diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index 30fdd5d0067b..db05c067665a 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -8,6 +8,7 @@
 #include <linux/mm.h>
 #include <linux/pfn.h>
 #include <asm/page.h>
+#include <asm/sections.h>
 #include <as-layout.h>
 #include <init.h>
 #include <kern.h>
@@ -75,8 +76,6 @@ void map_memory(unsigned long virt, unsigned long phys, unsigned long len,
 	}
 }
 
-extern int __syscall_stub_start;
-
 void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 			  unsigned long len, unsigned long long highmem)
 {
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 007d5503f49b..d2a0a4c0cd91 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -8,12 +8,11 @@
 #include <linux/slab.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
+#include <asm/sections.h>
 #include <as-layout.h>
 #include <os.h>
 #include <skas.h>
 
-extern int __syscall_stub_start;
-
 static int init_stub_pte(struct mm_struct *mm, unsigned long proc,
 			 unsigned long kernel)
 {
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 016adf0985d5..02c21f6e0983 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -259,8 +259,6 @@ EXPORT_SYMBOL(end_iomem);
 
 #define MIN_VMALLOC (32 * 1024 * 1024)
 
-extern char __binary_start;
-
 int __init linux_main(int argc, char **argv)
 {
 	unsigned long avail, diff;
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

