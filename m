Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jLB22-0000wr-8f
 for linux-um@lists.infradead.org; Sun, 05 Apr 2020 19:34:11 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] arch: um: fix xor.h include
Date: Sun,  5 Apr 2020 21:33:57 +0200
Message-Id: <20200405213357.b6ce1024b276.I7c370e20580d3122c58df5727ee2d6fb53545576@changeid>
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
Cc: Thomas Meyer <thomas@m3y3r.de>, Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

Two independent changes here ended up going into the tree
one after another, without a necessary rename, fix that.

Reported-by: Thomas Meyer <thomas@m3y3r.de>
Fixes: f185063bff91 ("um: Move timer-internal.h to non-shared")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/asm/xor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/include/asm/xor.h b/arch/um/include/asm/xor.h
index 7a3208c47cfc..36b33d62a35d 100644
--- a/arch/um/include/asm/xor.h
+++ b/arch/um/include/asm/xor.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <asm-generic/xor.h>
-#include <shared/timer-internal.h>
+#include <linux/time-internal.h>
 
 /* pick an arbitrary one - measuring isn't possible with inf-cpu */
 #define XOR_SELECT_TEMPLATE(x)	\
-- 
2.25.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

