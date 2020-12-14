Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kotsG-0006fO-1V
 for linux-um@lists.infradead.org; Mon, 14 Dec 2020 19:51:13 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: fix build w/o CONFIG_PM_SLEEP
Date: Mon, 14 Dec 2020 20:51:02 +0100
Message-Id: <20201214205101.27cb3eb8d19a.Ic09b2e3a99bc19009d85516f857e6c38d31edc00@changeid>
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
Cc: Randy Dunlap <rdunlap@infradead.org>, Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

uml_pm_wake() is unconditionally called from the SIGUSR1 wakeup
handler since that's in the userspace portion of UML, and thus
a bit tricky to ifdef out. Since pm_system_wakeup() can always
be called (but may be an empty inline), also simply always have
uml_pm_wake() to fix the build.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/um_arch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 9c7e6d7ea1b3..31d356b1ffd8 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -379,12 +379,12 @@ void text_poke_sync(void)
 {
 }
 
-#ifdef CONFIG_PM_SLEEP
 void uml_pm_wake(void)
 {
 	pm_system_wakeup();
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int um_suspend_valid(suspend_state_t state)
 {
 	return state == PM_SUSPEND_MEM;
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

