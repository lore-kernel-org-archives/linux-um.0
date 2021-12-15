Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] x86/mtrr: remove the mtrr_bp_init stub
Date: Wed, 15 Dec 2021 17:56:11 +0100
Message-Id: <20211215165612.554426-2-hch@lst.de>
In-Reply-To: <20211215165612.554426-1-hch@lst.de>
References: <20211215165612.554426-1-hch@lst.de>
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
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: x86@kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

Add an IS_ENABLED check in setup_arch and call pat_disable directly
if MTRRs are not supported.  This allows to remove the <asm/memtype.h>
include in <asm/mtrr.h>, which pull in lowlevel x86 headers that should
not be included for UML builds and will cause build warnings with a
futher patch.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/mtrr.h | 8 +-------
 arch/x86/kernel/setup.c     | 7 ++++++-
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 829df26fd7a3e..76d726074c163 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -24,8 +24,8 @@
 #define _ASM_X86_MTRR_H
 
 #include <uapi/asm/mtrr.h>
-#include <asm/memtype.h>
 
+void mtrr_bp_init(void);
 
 /*
  * The following functions are for use by other drivers that cannot use
@@ -43,7 +43,6 @@ extern int mtrr_del(int reg, unsigned long base, unsigned long size);
 extern int mtrr_del_page(int reg, unsigned long base, unsigned long size);
 extern void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi);
 extern void mtrr_ap_init(void);
-extern void mtrr_bp_init(void);
 extern void set_mtrr_aps_delayed_init(void);
 extern void mtrr_aps_init(void);
 extern void mtrr_bp_restore(void);
@@ -84,11 +83,6 @@ static inline int mtrr_trim_uncached_memory(unsigned long end_pfn)
 static inline void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi)
 {
 }
-static inline void mtrr_bp_init(void)
-{
-	pat_disable("PAT support disabled because CONFIG_MTRR is disabled in the kernel.");
-}
-
 #define mtrr_ap_init() do {} while (0)
 #define set_mtrr_aps_delayed_init() do {} while (0)
 #define mtrr_aps_init() do {} while (0)
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 6a190c7f4d71b..2f5129bd49dc4 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -40,6 +40,7 @@
 #include <asm/kasan.h>
 #include <asm/kaslr.h>
 #include <asm/mce.h>
+#include <asm/memtype.h>
 #include <asm/mtrr.h>
 #include <asm/realmode.h>
 #include <asm/olpc_ofw.h>
@@ -979,7 +980,11 @@ void __init setup_arch(char **cmdline_p)
 	max_pfn = e820__end_of_ram_pfn();
 
 	/* update e820 for memory not covered by WB MTRRs */
-	mtrr_bp_init();
+	if (IS_ENABLED(CONFIG_MTRR))
+		mtrr_bp_init();
+	else
+		pat_disable("PAT support disabled because CONFIG_MTRR is disabled in the kernel.");
+
 	if (mtrr_trim_uncached_memory(max_pfn))
 		max_pfn = e820__end_of_ram_pfn();
 
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

