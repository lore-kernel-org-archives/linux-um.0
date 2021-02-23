Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEUEu-0004SS-6D
 for linux-um@lists.infradead.org; Tue, 23 Feb 2021 09:44:21 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: fix tag order in stub_32.h
Date: Tue, 23 Feb 2021 10:44:08 +0100
Message-Id: <20210223104408.d0783602b9b8.I166e8f9ed51f0df5e32936cec1ed8cff00b48b2e@changeid>
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
Cc: kernel test robot <lkp@intel.com>, Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

"static void inline" is the wrong way around, fix that.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 9f0b4807a44f ("um: rework userspace stubs to not hard-code stub location")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/x86/um/shared/sysdep/stub_32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/um/shared/sysdep/stub_32.h b/arch/x86/um/shared/sysdep/stub_32.h
index c3891c1ada26..b95db9daf0e8 100644
--- a/arch/x86/um/shared/sysdep/stub_32.h
+++ b/arch/x86/um/shared/sysdep/stub_32.h
@@ -77,7 +77,7 @@ static inline void trap_myself(void)
 	__asm("int3");
 }
 
-static void inline remap_stack_and_trap(void)
+static inline void remap_stack_and_trap(void)
 {
 	__asm__ volatile (
 		"movl %%esp,%%ebx ;"
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

