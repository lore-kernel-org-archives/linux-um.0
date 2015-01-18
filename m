Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Sun, 18 Jan 2015 22:35:08 +0100
Message-Id: <1421616908-30614-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] um: x86: Removed orphaned barrier.h
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, bp@suse.de, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Since commit 9af2452a1839 ("um: Include generic barrier.h")
UML uses the generic barrier.h, remove this orphaned file.

Reported-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/x86/um/asm/barrier.h | 71 -----------------------------------------------
 1 file changed, 71 deletions(-)
 delete mode 100644 arch/x86/um/asm/barrier.h

diff --git a/arch/x86/um/asm/barrier.h b/arch/x86/um/asm/barrier.h
deleted file mode 100644
index 2d7d9a1..0000000
--- a/arch/x86/um/asm/barrier.h
+++ /dev/null
@@ -1,71 +0,0 @@
-#ifndef _ASM_UM_BARRIER_H_
-#define _ASM_UM_BARRIER_H_
-
-#include <asm/asm.h>
-#include <asm/segment.h>
-#include <asm/cpufeature.h>
-#include <asm/cmpxchg.h>
-#include <asm/nops.h>
-
-#include <linux/kernel.h>
-#include <linux/irqflags.h>
-
-/*
- * Force strict CPU ordering.
- * And yes, this is required on UP too when we're talking
- * to devices.
- */
-#ifdef CONFIG_X86_32
-
-#define mb()	alternative("lock; addl $0,0(%%esp)", "mfence", X86_FEATURE_XMM2)
-#define rmb()	alternative("lock; addl $0,0(%%esp)", "lfence", X86_FEATURE_XMM2)
-#define wmb()	alternative("lock; addl $0,0(%%esp)", "sfence", X86_FEATURE_XMM)
-
-#else /* CONFIG_X86_32 */
-
-#define mb()	asm volatile("mfence" : : : "memory")
-#define rmb()	asm volatile("lfence" : : : "memory")
-#define wmb()	asm volatile("sfence" : : : "memory")
-
-#endif /* CONFIG_X86_32 */
-
-#ifdef CONFIG_X86_PPRO_FENCE
-#define dma_rmb()	rmb()
-#else /* CONFIG_X86_PPRO_FENCE */
-#define dma_rmb()	barrier()
-#endif /* CONFIG_X86_PPRO_FENCE */
-#define dma_wmb()	barrier()
-
-#ifdef CONFIG_SMP
-
-#define smp_mb()	mb()
-#define smp_rmb()	dma_rmb()
-#define smp_wmb()	barrier()
-#define set_mb(var, value) do { (void)xchg(&var, value); } while (0)
-
-#else /* CONFIG_SMP */
-
-#define smp_mb()	barrier()
-#define smp_rmb()	barrier()
-#define smp_wmb()	barrier()
-#define set_mb(var, value) do { var = value; barrier(); } while (0)
-
-#endif /* CONFIG_SMP */
-
-#define read_barrier_depends()		do { } while (0)
-#define smp_read_barrier_depends()	do { } while (0)
-
-/*
- * Stop RDTSC speculation. This is needed when you need to use RDTSC
- * (or get_cycles or vread that possibly accesses the TSC) in a defined
- * code region.
- *
- * (Could use an alternative three way for this if there was one.)
- */
-static inline void rdtsc_barrier(void)
-{
-	alternative(ASM_NOP3, "mfence", X86_FEATURE_MFENCE_RDTSC);
-	alternative(ASM_NOP3, "lfence", X86_FEATURE_LFENCE_RDTSC);
-}
-
-#endif
-- 
1.8.4.5

