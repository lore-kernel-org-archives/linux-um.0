Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Nicolas Iooss <nicolas.iooss@polytechnique.org>
Date: Sat, 11 Oct 2014 13:29:41 +0200
Message-Id: <1413026981-9667-1-git-send-email-nicolas.iooss_linux@m4x.org>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] um: always use the same type for __syscall_stub_start
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

syscall_stub_start is declared with different types in C files:

  arch/um/kernel/physmem.c: extern int __syscall_stub_start;
  arch/um/kernel/skas/mmu.c: extern int __syscall_stub_start;
  arch/um/os-Linux/skas/mem.c: extern unsigned long __syscall_stub_start;
  arch/um/os-Linux/skas/process.c: extern int __syscall_stub_start;

Fix this inconsistency by always using unsigned long.  This does not
change anything in the compiled code because only the address of
__syscall_stub_start is used, but it makes the static checker I use
stop complaining about incompatible declarations.

Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
---
 arch/um/kernel/physmem.c        | 2 +-
 arch/um/kernel/skas/mmu.c       | 2 +-
 arch/um/os-Linux/skas/process.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index 30fdd5d0067b..f1d7ed26d638 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -75,7 +75,7 @@ void map_memory(unsigned long virt, unsigned long phys, unsigned long len,
 	}
 }
 
-extern int __syscall_stub_start;
+extern unsigned long __syscall_stub_start;
 
 void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 			  unsigned long len, unsigned long long highmem)
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 007d5503f49b..4bdd49e0bdc3 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -12,7 +12,7 @@
 #include <os.h>
 #include <skas.h>
 
-extern int __syscall_stub_start;
+extern unsigned long __syscall_stub_start;
 
 static int init_stub_pte(struct mm_struct *mm, unsigned long proc,
 			 unsigned long kernel)
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 908579f2b0ab..f30575557791 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -193,7 +193,7 @@ static void handle_trap(int pid, struct uml_pt_regs *regs,
 	handle_syscall(regs);
 }
 
-extern int __syscall_stub_start;
+extern unsigned long __syscall_stub_start;
 
 static int userspace_tramp(void *stack)
 {
-- 
2.1.2

