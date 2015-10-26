Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Mon, 26 Oct 2015 10:48:11 +0100
Message-Id: <1445852897-13102-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 1/7] um: Define PTRACE_OLDSETOPTIONS
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

...such that processes within UML can do a ptrace(PTRACE_OLDSETOPTIONS, ...)

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/include/asm/ptrace-generic.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/ptrace-generic.h
index 2966adb..5ab2062 100644
--- a/arch/um/include/asm/ptrace-generic.h
+++ b/arch/um/include/asm/ptrace-generic.h
@@ -27,6 +27,8 @@ struct pt_regs {
 
 #define instruction_pointer(regs) PT_REGS_IP(regs)
 
+#define PTRACE_OLDSETOPTIONS 21
+
 struct task_struct;
 
 extern long subarch_ptrace(struct task_struct *child, long request,
-- 
1.8.4.5

