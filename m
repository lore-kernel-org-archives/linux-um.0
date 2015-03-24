Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andrey Ryabinin <a.ryabinin@samsung.com>
Date: Tue, 24 Mar 2015 18:31:24 +0300
Message-id: <1427211084-24839-3-git-send-email-a.ryabinin@samsung.com>
In-reply-to: <1427211084-24839-1-git-send-email-a.ryabinin@samsung.com>
References: <1427211084-24839-1-git-send-email-a.ryabinin@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] x86, UML: fix integer overflow in ELF_ET_DYN_BASE
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Yury Gribov <y.gribov@samsung.com>, Andrey Ryabinin <a.ryabinin@samsung.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Almost all arches define ELF_ET_DYN_BASE as 2/3 of TASK_SIZE.
Though it seems that some architectures do this in a wrong way.
The problem is that 2*TASK_SIZE may overflow 32-bits so
the real ELF_ET_DYN_BASE becomes wrong.
Fix this overflow by dividing TASK_SIZE prior to multiplying:
	(TASK_SIZE / 3 * 2)

Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
---
 arch/x86/um/asm/elf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index 25a1022..0a656b7 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -210,7 +210,7 @@ extern int elf_core_copy_fpregs(struct task_struct *t, elf_fpregset_t *fpu);
 
 #define ELF_EXEC_PAGESIZE 4096
 
-#define ELF_ET_DYN_BASE (2 * TASK_SIZE / 3)
+#define ELF_ET_DYN_BASE (TASK_SIZE / 3 * 2)
 
 extern long elf_aux_hwcap;
 #define ELF_HWCAP (elf_aux_hwcap)
-- 
2.3.3

