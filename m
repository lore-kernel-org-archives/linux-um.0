Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7HBc-00019F-9s
 for linux-um@lists.infradead.org; Wed, 03 Feb 2021 12:23:09 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: io.h: include <linux/types.h>
Date: Wed,  3 Feb 2021 13:22:51 +0100
Message-Id: <20210203132251.23b844e9955f.If15f127996772db0fa885e0e0edd3c6c87d2dd33@changeid>
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
Cc: Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

This may be needed for size_t if something doesn't get
it included elsewhere before including <asm/io.h>, so
add the include.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/include/asm/io.h b/arch/um/include/asm/io.h
index cef03e3aa0f9..6ce18d343997 100644
--- a/arch/um/include/asm/io.h
+++ b/arch/um/include/asm/io.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_UM_IO_H
 #define _ASM_UM_IO_H
+#include <linux/types.h>
 
 #define ioremap ioremap
 static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

