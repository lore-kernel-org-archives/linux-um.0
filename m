Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lX98Z-008tHr-BC
 for linux-um@lists.infradead.org; Thu, 15 Apr 2021 21:02:56 +0000
From: Colin King <colin.king@canonical.com>
Subject: [PATCH] um: Fix inline void order in function declaration
Date: Thu, 15 Apr 2021 22:02:42 +0100
Message-Id: <20210415210242.1970216-1-colin.king@canonical.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Johannes Berg <johannes.berg@intel.com>, linux-um@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The inline keyword should be between storage class and type. Fix
this by swapping void inline to inline void.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/x86/um/shared/sysdep/stub_32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/um/shared/sysdep/stub_32.h b/arch/x86/um/shared/sysdep/stub_32.h
index c3891c1ada26..b95db9daf0e8 100644
--- a/arch/x86/um/shared/sysdep/stub_32.h
+++ b/arch/x86/um/shared/sysdep/stub_32.h
@@ -77,7 +77,7 @@ static inline void trap_myself(void)
 	__asm("int3");
 }
 
-static void inline remap_stack_and_trap(void)
+static inline void remap_stack_and_trap(void)
 {
 	__asm__ volatile (
 		"movl %%esp,%%ebx ;"
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

