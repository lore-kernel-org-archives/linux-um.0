Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i174u-00053Z-2D
 for linux-um@lists.infradead.org; Fri, 23 Aug 2019 10:45:57 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 2/4] arch: um: avoid using uninitialized regs
Date: Fri, 23 Aug 2019 12:44:27 +0200
Message-Id: <20190823104429.11047-2-johannes@sipsolutions.net>
In-Reply-To: <20190823104429.11047-1-johannes@sipsolutions.net>
References: <20190823104429.11047-1-johannes@sipsolutions.net>
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

In timer_real_alarm_handler(), regs is only initialized if
the context argument is non-NULL, also initialize in the
other case.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/os-Linux/signal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 35d1b2bc00cb..4cd88b5b9006 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -10,6 +10,7 @@
 #include <stdarg.h>
 #include <errno.h>
 #include <signal.h>
+#include <string.h>
 #include <strings.h>
 #include <as-layout.h>
 #include <kern_util.h>
@@ -88,6 +89,8 @@ static void timer_real_alarm_handler(mcontext_t *mc)
 
 	if (mc != NULL)
 		get_regs_from_mc(&regs, mc);
+	else
+		memset(&regs, 0, sizeof(regs));
 	timer_handler(SIGALRM, NULL, &regs);
 }
 
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

