Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 06/30] soc: bcm: brcmstb: Document panic notifier action and
 remove useless header
Date: Wed, 27 Apr 2022 19:49:00 -0300
Message-Id: <20220427224924.592546-7-gpiccoli@igalia.com>
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
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, coresight@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, kernel-dev@igalia.com, gpiccoli@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org, mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org, Brian Norris <computersforpeace@gmail.com>, Doug Berger <opendmb@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Justin Chen <justinpopo6@gmail.com>, Lee Jones <lee.jones@linaro.org>, Markus Mayer <mmayer@broadcom.com>

The panic notifier of this driver is very simple code-wise, just a memory
write to a special position with some numeric code. But this is not clear
from the semantic point-of-view, and there is no public documentation
about that either.

After discussing this in the mailing-lists [0] and having Florian explained
it very well, this patch just document that in the code for the future
generations asking the same questions. Also, it removes a useless header.

[0] https://lore.kernel.org/lkml/781cafb0-8d06-8b56-907a-5175c2da196a@gmail.com

Fixes: 0b741b8234c8 ("soc: bcm: brcmstb: Add support for S2/S3/S5 suspend states (ARM)")
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Doug Berger <opendmb@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Justin Chen <justinpopo6@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Markus Mayer <mmayer@broadcom.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 drivers/soc/bcm/brcmstb/pm/pm-arm.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/bcm/brcmstb/pm/pm-arm.c b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
index 3cbb165d6e30..870686ae042b 100644
--- a/drivers/soc/bcm/brcmstb/pm/pm-arm.c
+++ b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
@@ -25,7 +25,6 @@
 #include <linux/kernel.h>
 #include <linux/memblock.h>
 #include <linux/module.h>
-#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/panic_notifier.h>
@@ -664,7 +663,20 @@ static void __iomem *brcmstb_ioremap_match(const struct of_device_id *matches,
 
 	return of_io_request_and_map(dn, index, dn->full_name);
 }
-
+/*
+ * The AON is a small domain in the SoC that can retain its state across
+ * various system wide sleep states and specific reset conditions; the
+ * AON DATA RAM is a small RAM of a few words (< 1KB) which can store
+ * persistent information across such events.
+ *
+ * The purpose of the below panic notifier is to help with notifying
+ * the bootloader that a panic occurred and so that it should try its
+ * best to preserve the DRAM contents holding that buffer for recovery
+ * by the kernel as opposed to wiping out DRAM clean again.
+ *
+ * Reference: comment from Florian Fainelli, at
+ * https://lore.kernel.org/lkml/781cafb0-8d06-8b56-907a-5175c2da196a@gmail.com
+ */
 static int brcmstb_pm_panic_notify(struct notifier_block *nb,
 		unsigned long action, void *data)
 {
-- 
2.36.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

