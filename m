Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oD02L-005xut-6j
	for linux-um@lists.infradead.org; Sun, 17 Jul 2022 08:54:02 +0000
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2] um: include sys/types.h for size_t
Date: Sun, 17 Jul 2022 10:53:46 +0200
Message-Id: <20220717085346.1525754-1-Jason@zx2c4.com>
In-Reply-To: <20220713100029.163083-1-Jason@zx2c4.com>
References: <20220713100029.163083-1-Jason@zx2c4.com>
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
To: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Johannes Berg <johannes@sipsolutions.net>

Usually size_t comes from sys/types.h, not stddef.h. This code likely
worked only because something else in its usage chain was pulling in
sys/types.h. stddef.h is still required for NULL, however, so note this.

Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/um/include/shared/user.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/user.h
index dd4badffdeb3..bda66e5a9d4e 100644
--- a/arch/um/include/shared/user.h
+++ b/arch/um/include/shared/user.h
@@ -16,11 +16,12 @@
  */
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
-/* This is to get size_t */
+/* This is to get size_t and NULL */
 #ifndef __UM_HOST__
 #include <linux/types.h>
 #else
 #include <stddef.h>
+#include <sys/types.h>
 #endif
 
 extern void panic(const char *fmt, ...)
-- 
2.35.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

