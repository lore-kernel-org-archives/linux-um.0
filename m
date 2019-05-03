Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hMfnk-0007CN-H0
 for linux-um@lists.infradead.org; Fri, 03 May 2019 21:33:07 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 1/3] arch: um: fix os_timer_one_shot()
Date: Fri,  3 May 2019 23:32:47 +0200
Message-Id: <20190503213249.30008-1-johannes@sipsolutions.net>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Johannes Berg <johannes.berg@intel.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Johannes Berg <johannes.berg@intel.com>

os_timer_one_shot() gets passed a value "unsigned long delta",
so must not have an "int ticks" as that actually ends up being
-1, and thus triggering a timer over and over again.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/shared/os.h | 2 +-
 arch/um/os-Linux/time.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index ebf23012a59b..d579adcb2690 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -252,7 +252,7 @@ extern void os_warn(const char *fmt, ...)
 extern void os_idle_sleep(unsigned long long nsecs);
 extern int os_timer_create(void* timer);
 extern int os_timer_set_interval(void* timer, void* its);
-extern int os_timer_one_shot(int ticks);
+extern int os_timer_one_shot(unsigned long ticks);
 extern long long os_timer_disable(void);
 extern long os_timer_remain(void* timer);
 extern void uml_idle_timer(void);
diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index 0e39b9978729..b28cc35da21f 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -113,7 +113,7 @@ long os_timer_remain(void* timer)
 	return its.it_value.tv_nsec;
 }
 
-int os_timer_one_shot(int ticks)
+int os_timer_one_shot(unsigned long ticks)
 {
 	struct itimerspec its;
 	unsigned long long nsec;
-- 
2.17.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

