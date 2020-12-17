Return-Path: <johannes@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: return error from ioremap()
Date: Thu, 17 Dec 2020 13:15:56 +0100
Message-Id: <20201217131556.6d1a5546bd43.I2fcd1dfac11d31e1a83a26488f396d97ba03ddda@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-um@lists.infradead.org
Cc: Logan Gunthorpe <logang@deltatee.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Johannes Berg <johannes.berg@intel.com>
List-ID: <linux-um.lists.infradead.org>

From: Johannes Berg <johannes.berg@intel.com>

Back a few years ago, ioremap() was added to UML so that we'd
not break the build for everything all the time. However, for
some reason, v1 of the patch got applied, rather than the v2
that returned NULL, which was discussed here:

https://lore.kernel.org/lkml/1495726955-27497-1-git-send-email-logang@deltatee.com/

Fix that now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/asm/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/include/asm/io.h b/arch/um/include/asm/io.h
index 96f77b5232aa..cef03e3aa0f9 100644
--- a/arch/um/include/asm/io.h
+++ b/arch/um/include/asm/io.h
@@ -5,7 +5,7 @@
 #define ioremap ioremap
 static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
 {
-	return (void __iomem *)(unsigned long)offset;
+	return NULL;
 }
 
 #define iounmap iounmap
-- 
2.26.2


