Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
From: Richard Weinberger <richard@nod.at>
Date: Mon, 25 Jan 2016 23:24:21 +0100
Message-Id: <1453760661-1444-23-git-send-email-richard@nod.at>
In-Reply-To: <1453760661-1444-1-git-send-email-richard@nod.at>
References: <1453760661-1444-1-git-send-email-richard@nod.at>
Subject: [uml-devel] [PATCH 22/22] um: Export pm_power_off
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

...modules are using this symbol.
Export it like all other archs to.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/kernel/reboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c
index 9bdf67a..b60a9f8 100644
--- a/arch/um/kernel/reboot.c
+++ b/arch/um/kernel/reboot.c
@@ -12,6 +12,7 @@
 #include <skas.h>
 
 void (*pm_power_off)(void);
+EXPORT_SYMBOL(pm_power_off);
 
 static void kill_off_processes(void)
 {
-- 
1.8.4.5


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

