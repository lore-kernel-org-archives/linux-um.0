Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] um: Fix to call read_initrd after init_bootmem
Date: Thu, 27 Apr 2017 12:15:10 +0900
Message-Id: <149326290055.18877.8217119813162466170.stgit@devbox>
In-Reply-To: <149326283034.18877.3371130154502733533.stgit@devbox>
References: <149326283034.18877.3371130154502733533.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Since read_initrd() invokes alloc_bootmem() for allocating
memory to load initrd image, it must be called after init_bootmem.

This makes read_initrd() called directly from setup_arch()
after init_bootmem() and mem_total_pages().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/um/kernel/initrd.c  |    4 +---
 arch/um/kernel/um_arch.c |    6 ++++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/um/kernel/initrd.c b/arch/um/kernel/initrd.c
index 48bae81..6f6e789 100644
--- a/arch/um/kernel/initrd.c
+++ b/arch/um/kernel/initrd.c
@@ -14,7 +14,7 @@
 static char *initrd __initdata = NULL;
 static int load_initrd(char *filename, void *buf, int size);
 
-static int __init read_initrd(void)
+int __init read_initrd(void)
 {
 	void *area;
 	long long size;
@@ -46,8 +46,6 @@ static int __init read_initrd(void)
 	return 0;
 }
 
-__uml_postsetup(read_initrd);
-
 static int __init uml_initrd_setup(char *line, int *add)
 {
 	initrd = line;
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 4b85acd..64a1fd0 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -338,11 +338,17 @@ int __init linux_main(int argc, char **argv)
 	return start_uml();
 }
 
+int __init __weak read_initrd(void)
+{
+	return 0;
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	stack_protections((unsigned long) &init_thread_info);
 	setup_physmem(uml_physmem, uml_reserved, physmem_size, highmem);
 	mem_total_pages(physmem_size, iomem_size, highmem);
+	read_initrd();
 
 	paging_init();
 	strlcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);


