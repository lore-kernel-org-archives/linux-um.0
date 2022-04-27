Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 15/30] bus: brcmstb_gisb: Clean-up panic/die notifiers
Date: Wed, 27 Apr 2022 19:49:09 -0300
Message-Id: <20220427224924.592546-16-gpiccoli@igalia.com>
In-Reply-To: <20220427224924.592546-1-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
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
To: akpm@linux-foundation.org, bhe@redhat.com, pmladek@suse.com, kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, coresight@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, kernel-dev@igalia.com, gpiccoli@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org, mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org, Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>

This patch improves the panic/die notifiers in this driver by
making use of a passed "id" instead of comparing pointer
address; also, it removes an useless prototype declaration
and unnecessary header inclusion.

This is part of a panic notifiers refactor - this notifier in
the future will be moved to a new list, that encompass the
information notifiers only.

Fixes: 9eb60880d9a9 ("bus: brcmstb_gisb: add notifier handling")
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 drivers/bus/brcmstb_gisb.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index 183d5cc37d42..1ea7b015e225 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -19,7 +19,6 @@
 #include <linux/pm.h>
 #include <linux/kernel.h>
 #include <linux/kdebug.h>
-#include <linux/notifier.h>
 
 #ifdef CONFIG_MIPS
 #include <asm/traps.h>
@@ -347,25 +346,14 @@ static irqreturn_t brcmstb_gisb_bp_handler(int irq, void *dev_id)
 /*
  * Dump out gisb errors on die or panic.
  */
-static int dump_gisb_error(struct notifier_block *self, unsigned long v,
-			   void *p);
-
-static struct notifier_block gisb_die_notifier = {
-	.notifier_call = dump_gisb_error,
-};
-
-static struct notifier_block gisb_panic_notifier = {
-	.notifier_call = dump_gisb_error,
-};
-
 static int dump_gisb_error(struct notifier_block *self, unsigned long v,
 			   void *p)
 {
 	struct brcmstb_gisb_arb_device *gdev;
-	const char *reason = "panic";
+	const char *reason = "die";
 
-	if (self == &gisb_die_notifier)
-		reason = "die";
+	if (v == PANIC_NOTIFIER)
+		reason = "panic";
 
 	/* iterate over each GISB arb registered handlers */
 	list_for_each_entry(gdev, &brcmstb_gisb_arb_device_list, next)
@@ -374,6 +362,14 @@ static int dump_gisb_error(struct notifier_block *self, unsigned long v,
 	return NOTIFY_DONE;
 }
 
+static struct notifier_block gisb_die_notifier = {
+	.notifier_call = dump_gisb_error,
+};
+
+static struct notifier_block gisb_panic_notifier = {
+	.notifier_call = dump_gisb_error,
+};
+
 static DEVICE_ATTR(gisb_arb_timeout, S_IWUSR | S_IRUGO,
 		gisb_arb_get_timeout, gisb_arb_set_timeout);
 
-- 
2.36.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

