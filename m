Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBZAd-002WfQ-GJ
	for linux-um@lists.infradead.org; Wed, 13 Jul 2022 10:00:40 +0000
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] um: include sys/types.h instead of stddef.h for size_t
Date: Wed, 13 Jul 2022 12:00:29 +0200
Message-Id: <20220713100029.163083-1-Jason@zx2c4.com>
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
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>

Usually size_t comes from sys/types.h, not stddef.h. This code likely
worked only because something else in its usage chain was pulling in
sys/types.h.

Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/um/include/shared/user.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/user.h
index dd4badffdeb3..a0a8f0d19a85 100644
--- a/arch/um/include/shared/user.h
+++ b/arch/um/include/shared/user.h
@@ -13,21 +13,21 @@
  * fancier, type-safe, definition.  Using that one would require
  * copying too much infrastructure for my taste, so userspace files
  * get less checking than kernel files.
  */
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
 /* This is to get size_t */
 #ifndef __UM_HOST__
 #include <linux/types.h>
 #else
-#include <stddef.h>
+#include <sys/types.h>
 #endif
 
 extern void panic(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
 
 /* Requires preincluding include/linux/kern_levels.h */
 #define UM_KERN_EMERG	KERN_EMERG
 #define UM_KERN_ALERT	KERN_ALERT
 #define UM_KERN_CRIT	KERN_CRIT
 #define UM_KERN_ERR	KERN_ERR
-- 
2.35.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

