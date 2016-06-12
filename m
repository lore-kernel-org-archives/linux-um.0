Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/2] um: Setup physical memory in setup_arch()
Date: Sun, 12 Jun 2016 21:56:42 +0200
Message-Id: <1465761403-26619-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Currently UML sets up physical memory very early,
long before setup_arch() was called by the kernel main
function.
This can cause problems when code paths in UML's memory setup
code assume that the kernel is already running.
i.e. when kmemleak is enabled it will evaluate current()
in free_bootmem(). That early current() is undefined and
UML explodes.

Solve the problem by setting up physical memory in setup_arch(),
at this stage the kernel has materialized and basic infrastructure
such as current() works.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/kernel/um_arch.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 16630e7..e8175a8 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -319,9 +319,6 @@ int __init linux_main(int argc, char **argv)
 
 	start_vm = VMALLOC_START;
 
-	setup_physmem(uml_physmem, uml_reserved, physmem_size, highmem);
-	mem_total_pages(physmem_size, iomem_size, highmem);
-
 	virtmem_size = physmem_size;
 	stack = (unsigned long) argv;
 	stack &= ~(1024 * 1024 - 1);
@@ -334,7 +331,6 @@ int __init linux_main(int argc, char **argv)
 		printf("Kernel virtual memory size shrunk to %lu bytes\n",
 		       virtmem_size);
 
-	stack_protections((unsigned long) &init_thread_info);
 	os_flush_stdout();
 
 	return start_uml();
@@ -342,6 +338,10 @@ int __init linux_main(int argc, char **argv)
 
 void __init setup_arch(char **cmdline_p)
 {
+	stack_protections((unsigned long) &init_thread_info);
+	setup_physmem(uml_physmem, uml_reserved, physmem_size, highmem);
+	mem_total_pages(physmem_size, iomem_size, highmem);
+
 	paging_init();
 	strlcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
-- 
2.7.3


