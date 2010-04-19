Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH 3/5] uml: Fix warning due to missing task_struct declaration
Date: Mon, 19 Apr 2010 23:53:06 +0200
Message-Id: <1d97cd7761a1eae73923b1adda4c6915a0647bb3.1271713955.git.jan.kiszka@web.de>
In-Reply-To: <cover.1271713955.git.jan.kiszka@web.de>
References: <cover.1271713955.git.jan.kiszka@web.de>
In-Reply-To: <cover.1271713955.git.jan.kiszka@web.de>
References: <cover.1271713955.git.jan.kiszka@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

We can't pull in linux/sched.h, so just declare the struct.

Signed-off-by: Jan Kiszka <jan.kiszka@web.de>
---
 arch/um/sys-i386/asm/elf.h   |    2 ++
 arch/um/sys-x86_64/asm/elf.h |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/um/sys-i386/asm/elf.h b/arch/um/sys-i386/asm/elf.h
index e64cd41..a979a22 100644
--- a/arch/um/sys-i386/asm/elf.h
+++ b/arch/um/sys-i386/asm/elf.h
@@ -75,6 +75,8 @@ typedef struct user_i387_struct elf_fpregset_t;
 	pr_reg[16] = PT_REGS_SS(regs);		\
 } while (0);
 
+struct task_struct;
+
 extern int elf_core_copy_fpregs(struct task_struct *t, elf_fpregset_t *fpu);
 
 #define ELF_CORE_COPY_FPREGS(t, fpu) elf_core_copy_fpregs(t, fpu)
diff --git a/arch/um/sys-x86_64/asm/elf.h b/arch/um/sys-x86_64/asm/elf.h
index 49655c8..d760967 100644
--- a/arch/um/sys-x86_64/asm/elf.h
+++ b/arch/um/sys-x86_64/asm/elf.h
@@ -95,6 +95,8 @@ typedef struct user_i387_struct elf_fpregset_t;
 	(pr_reg)[25] = 0;					\
 	(pr_reg)[26] = 0;
 
+struct task_struct;
+
 extern int elf_core_copy_fpregs(struct task_struct *t, elf_fpregset_t *fpu);
 
 #define ELF_CORE_COPY_FPREGS(t, fpu) elf_core_copy_fpregs(t, fpu)
-- 
1.6.0.2

