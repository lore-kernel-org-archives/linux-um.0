Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQZg5-009iGu-0R
 for linux-um@lists.infradead.org; Wed, 15 Sep 2021 18:30:38 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 2/3] lib/logic_iomem: fix 32-bit build
Date: Wed, 15 Sep 2021 20:30:21 +0200
Message-Id: <20210915203021.b48a745c3a3e.I1b11945a1f7c3e701ef5e7fe193e51f2b202090e@changeid>
In-Reply-To: <20210915203021.1454bd968b28.I160cb938058758bba3cb1968419314dbeb9dc004@changeid>
References: <20210915203021.1454bd968b28.I160cb938058758bba3cb1968419314dbeb9dc004@changeid>
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
Cc: Johannes Berg <johannes.berg@intel.com>, Al Viro <viro@zeniv.linux.org.uk>

From: Johannes Berg <johannes.berg@intel.com>

On a 32-bit build, the (unsigned long long) casts throw warnings
(or errors) due to being to a different integer size. Cast to
uintptr_t first (with the __force for sparse) and then further
to get the consistent print on 32 and 64-bit.

Fixes: ca2e334232b6 ("lib: add iomem emulation (logic_iomem)")
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 lib/logic_iomem.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/logic_iomem.c b/lib/logic_iomem.c
index 9bdfde0c0f86..54fa601f3300 100644
--- a/lib/logic_iomem.c
+++ b/lib/logic_iomem.c
@@ -79,7 +79,7 @@ static void __iomem *real_ioremap(phys_addr_t offset, size_t size)
 static void real_iounmap(void __iomem *addr)
 {
 	WARN(1, "invalid iounmap for addr 0x%llx\n",
-	     (unsigned long long __force)addr);
+	     (unsigned long long)(uintptr_t __force)addr);
 }
 #endif /* CONFIG_LOGIC_IOMEM_FALLBACK */
 
@@ -173,7 +173,7 @@ EXPORT_SYMBOL(iounmap);
 static u##sz real_raw_read ## op(const volatile void __iomem *addr)	\
 {									\
 	WARN(1, "Invalid read" #op " at address %llx\n",		\
-	     (unsigned long long __force)addr);				\
+	     (unsigned long long)(uintptr_t __force)addr);		\
 	return (u ## sz)~0ULL;						\
 }									\
 									\
@@ -181,7 +181,8 @@ static void real_raw_write ## op(u ## sz val,				\
 				 volatile void __iomem *addr)		\
 {									\
 	WARN(1, "Invalid writeq" #op " of 0x%llx at address %llx\n",	\
-	     (unsigned long long)val, (unsigned long long __force)addr);\
+	     (unsigned long long)val,					\
+	     (unsigned long long)(uintptr_t __force)addr);\
 }									\
 
 MAKE_FALLBACK(b, 8);
@@ -194,14 +195,14 @@ MAKE_FALLBACK(q, 64);
 static void real_memset_io(volatile void __iomem *addr, int value, size_t size)
 {
 	WARN(1, "Invalid memset_io at address 0x%llx\n",
-	     (unsigned long long __force)addr);
+	     (unsigned long long)(uintptr_t __force)addr);
 }
 
 static void real_memcpy_fromio(void *buffer, const volatile void __iomem *addr,
 			       size_t size)
 {
 	WARN(1, "Invalid memcpy_fromio at address 0x%llx\n",
-	     (unsigned long long __force)addr);
+	     (unsigned long long)(uintptr_t __force)addr);
 
 	memset(buffer, 0xff, size);
 }
@@ -210,7 +211,7 @@ static void real_memcpy_toio(volatile void __iomem *addr, const void *buffer,
 			     size_t size)
 {
 	WARN(1, "Invalid memcpy_toio at address 0x%llx\n",
-	     (unsigned long long __force)addr);
+	     (unsigned long long)(uintptr_t __force)addr);
 }
 #endif /* CONFIG_LOGIC_IOMEM_FALLBACK */
 
-- 
2.31.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

