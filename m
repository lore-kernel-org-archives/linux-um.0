Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mKyBd-001drA-4E
 for linux-um@lists.infradead.org; Tue, 31 Aug 2021 07:28:08 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: fix ndelay/udelay defines
Date: Tue, 31 Aug 2021 09:27:53 +0200
Message-Id: <20210831092753.4ea66dc7dff8.Ife5ad95810e75d88a9c8fae6cf1314e7486bfe19@changeid>
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
Cc: Johannes Berg <johannes.berg@intel.com>, kernel test robot <lkp@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

Many places in the kernel use 'udelay' as an identifier, and
are broken with the current "#define udelay um_udelay". Fix
this by adding an argument to the macro, and do the same to
'ndelay' as well, just in case.

Fixes: 0bc8fb4dda2b ("um: Implement ndelay/udelay in time-travel mode")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/asm/delay.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/include/asm/delay.h b/arch/um/include/asm/delay.h
index 56fc2b8f2dd0..e79b2ab6f40c 100644
--- a/arch/um/include/asm/delay.h
+++ b/arch/um/include/asm/delay.h
@@ -14,7 +14,7 @@ static inline void um_ndelay(unsigned long nsecs)
 	ndelay(nsecs);
 }
 #undef ndelay
-#define ndelay um_ndelay
+#define ndelay(n) um_ndelay(n)
 
 static inline void um_udelay(unsigned long usecs)
 {
@@ -26,5 +26,5 @@ static inline void um_udelay(unsigned long usecs)
 	udelay(usecs);
 }
 #undef udelay
-#define udelay um_udelay
+#define udelay(n) um_udelay(n)
 #endif /* __UM_DELAY_H */
-- 
2.31.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

