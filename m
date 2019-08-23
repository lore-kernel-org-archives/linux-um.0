Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i19GM-0004pl-G9
 for linux-um@lists.infradead.org; Fri, 23 Aug 2019 13:05:56 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] arch: um: fix VDSO compiler warning
Date: Fri, 23 Aug 2019 15:05:46 +0200
Message-Id: <20190823130546.15787-1-johannes@sipsolutions.net>
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

Fix a warning about the function type being wrong.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/x86/um/vdso/um_vdso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/um/vdso/um_vdso.c b/arch/x86/um/vdso/um_vdso.c
index ac9c02b9d92c..891868756a51 100644
--- a/arch/x86/um/vdso/um_vdso.c
+++ b/arch/x86/um/vdso/um_vdso.c
@@ -47,7 +47,7 @@ time_t __vdso_time(time_t *t)
 
 	return secs;
 }
-int time(time_t *t) __attribute__((weak, alias("__vdso_time")));
+time_t time(time_t *t) __attribute__((weak, alias("__vdso_time")));
 
 long
 __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

