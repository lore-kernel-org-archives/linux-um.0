Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jSCQT-0007zT-0m
 for linux-um@lists.infradead.org; Sat, 25 Apr 2020 04:28:26 +0000
Received: by mail-pf1-x449.google.com with SMTP id r198so11151443pfc.8
 for <linux-um@lists.infradead.org>; Fri, 24 Apr 2020 21:28:20 -0700 (PDT)
Date: Fri, 24 Apr 2020 21:28:14 -0700
Message-Id: <20200425042814.132920-1-davidgow@google.com>
Mime-Version: 1.0
Subject: [PATCH] um: Fix "time-internal.h" include in xor.h
From: David Gow <davidgow@google.com>
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
To: Johannes Berg <johannes.berg@intel.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Richard Weinberger <richard@nod.at>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>

It looks like the wrong header was included in xor.h, breaking make
allyesconfig on UML (or, more specifically, kunit.py run --alltests).

----------------------
In file included from crypto/xor.c:17:
./arch/um/include/asm/xor.h:3:10: fatal error: shared/timer-internal.h: No such file or directory
    3 | #include <shared/timer-internal.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~
----------------------

Replacing this with "linux/time-internal.h" builds fine.

Fixes: d65197ad5249 ("um: fix time-travel=inf-cpu with xor/raid6")
Signed-off-by: David Gow <davidgow@google.com>
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
2.26.2.303.gf8c07b1a785-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

