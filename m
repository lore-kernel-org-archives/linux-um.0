Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from zeniv-ca.linux.org.uk ([2607:5300:60:148a::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSQuM-003BNI-DN
 for linux-um@lists.infradead.org; Mon, 20 Sep 2021 21:33:04 +0000
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mSQuL-005yeI-Jm
 for linux-um@lists.infradead.org; Mon, 20 Sep 2021 21:33:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 03/15] logic_io instance of iounmap() needs volatile on
 argument
Date: Mon, 20 Sep 2021 21:32:49 +0000
Message-Id: <20210920213301.1424730-3-viro@zeniv.linux.org.uk>
In-Reply-To: <20210920213301.1424730-1-viro@zeniv.linux.org.uk>
References: <YUj9S+S4Gd86mM6N@zeniv-ca.linux.org.uk>
 <20210920213301.1424730-1-viro@zeniv.linux.org.uk>
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

... same as the rest of implementations

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/asm-generic/logic_io.h | 2 +-
 lib/logic_iomem.c              | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/logic_io.h b/include/asm-generic/logic_io.h
index a53116b8c57ef..8a59b6e567df7 100644
--- a/include/asm-generic/logic_io.h
+++ b/include/asm-generic/logic_io.h
@@ -34,7 +34,7 @@
 void __iomem *ioremap(phys_addr_t offset, size_t size);
 
 #define iounmap iounmap
-void iounmap(void __iomem *addr);
+void iounmap(void volatile __iomem *addr);
 
 #define __raw_readb __raw_readb
 u8 __raw_readb(const volatile void __iomem *addr);
diff --git a/lib/logic_iomem.c b/lib/logic_iomem.c
index 9bdfde0c0f86d..bfb8053205b17 100644
--- a/lib/logic_iomem.c
+++ b/lib/logic_iomem.c
@@ -76,7 +76,7 @@ static void __iomem *real_ioremap(phys_addr_t offset, size_t size)
 	return NULL;
 }
 
-static void real_iounmap(void __iomem *addr)
+static void real_iounmap(volatile void __iomem *addr)
 {
 	WARN(1, "invalid iounmap for addr 0x%llx\n",
 	     (unsigned long long __force)addr);
@@ -149,7 +149,7 @@ get_area(const volatile void __iomem *addr)
 	return NULL;
 }
 
-void iounmap(void __iomem *addr)
+void iounmap(volatile void __iomem *addr)
 {
 	struct logic_iomem_area *area = get_area(addr);
 
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

