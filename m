Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/3] um: Remove update_debugregs()
Date: Fri, 15 Jun 2018 16:42:55 +0200
Message-Id: <20180615144256.13343-2-richard@nod.at>
In-Reply-To: <20180615144256.13343-1-richard@nod.at>
References: <20180615144256.13343-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
List-ID: <linux-um.lists.infradead.org>

This function is nowhere used, let's get rid of it.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/x86/um/shared/sysdep/ptrace_32.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/um/shared/sysdep/ptrace_32.h b/arch/x86/um/shared/sysdep/ptrace_32.h
index ae00d22bce02..db8478a83a09 100644
--- a/arch/x86/um/shared/sysdep/ptrace_32.h
+++ b/arch/x86/um/shared/sysdep/ptrace_32.h
@@ -8,8 +8,6 @@
 
 #define MAX_FP_NR HOST_FPX_SIZE
 
-static inline void update_debugregs(int seq) {}
-
 void set_using_sysemu(int value);
 int get_using_sysemu(void);
 extern int sysemu_supported;
-- 
2.13.6


