Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n4PRl-009Npy-8U
 for linux-um@lists.infradead.org; Mon, 03 Jan 2022 15:40:30 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] lib/logic_iomem: correct fallback config references
Date: Mon,  3 Jan 2022 16:40:15 +0100
Message-Id: <20220103164015.6bfbac3b1010.I44342c6303ec35d688631ce9cfb6cfa9b4537006@changeid>
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
To: linux-um@lists.infradead.org
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Arnd Bergmann <arnd@kernel.org>, Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

Due to some renaming, we ended up with the "indirect iomem"
naming in Kconfig, following INDIRECT_PIO. However, clearly
I missed following through on that in the ifdefs, but so far
INDIRECT_IOMEM_FALLBACK isn't used by any architecture.

Reported-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Fixes: ca2e334232b6 ("lib: add iomem emulation (logic_iomem)")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 lib/logic_iomem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/logic_iomem.c b/lib/logic_iomem.c
index 9bdfde0c0f86..8cafe4a9e874 100644
--- a/lib/logic_iomem.c
+++ b/lib/logic_iomem.c
@@ -68,7 +68,7 @@ int logic_iomem_add_region(struct resource *resource,
 }
 EXPORT_SYMBOL(logic_iomem_add_region);
 
-#ifndef CONFIG_LOGIC_IOMEM_FALLBACK
+#ifndef CONFIG_INDIRECT_IOMEM_FALLBACK
 static void __iomem *real_ioremap(phys_addr_t offset, size_t size)
 {
 	WARN(1, "invalid ioremap(0x%llx, 0x%zx)\n",
@@ -81,7 +81,7 @@ static void real_iounmap(void __iomem *addr)
 	WARN(1, "invalid iounmap for addr 0x%llx\n",
 	     (unsigned long long __force)addr);
 }
-#endif /* CONFIG_LOGIC_IOMEM_FALLBACK */
+#endif /* CONFIG_INDIRECT_IOMEM_FALLBACK */
 
 void __iomem *ioremap(phys_addr_t offset, size_t size)
 {
@@ -168,7 +168,7 @@ void iounmap(void __iomem *addr)
 }
 EXPORT_SYMBOL(iounmap);
 
-#ifndef CONFIG_LOGIC_IOMEM_FALLBACK
+#ifndef CONFIG_INDIRECT_IOMEM_FALLBACK
 #define MAKE_FALLBACK(op, sz) 						\
 static u##sz real_raw_read ## op(const volatile void __iomem *addr)	\
 {									\
@@ -212,7 +212,7 @@ static void real_memcpy_toio(volatile void __iomem *addr, const void *buffer,
 	WARN(1, "Invalid memcpy_toio at address 0x%llx\n",
 	     (unsigned long long __force)addr);
 }
-#endif /* CONFIG_LOGIC_IOMEM_FALLBACK */
+#endif /* CONFIG_INDIRECT_IOMEM_FALLBACK */
 
 #define MAKE_OP(op, sz) 						\
 u##sz __raw_read ## op(const volatile void __iomem *addr)		\
-- 
2.33.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

