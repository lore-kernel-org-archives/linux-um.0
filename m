Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 05/30] misc/pvpanic: Convert regular spinlock into trylock on
 panic path
Date: Wed, 27 Apr 2022 19:48:59 -0300
Message-Id: <20220427224924.592546-6-gpiccoli@igalia.com>
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
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, coresight@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, kernel-dev@igalia.com, gpiccoli@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org, mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Mihai Carabas <mihai.carabas@oracle.com>, Shile Zhang <shile.zhang@linux.alibaba.com>, Wang ShaoBo <bobo.shaobowang@huawei.com>, zhenwei pi <pizhenwei@bytedance.com>

The pvpanic driver relies on panic notifiers to execute a callback
on panic event. Such function is executed in atomic context - the
panic function disables local IRQs, preemption and all other CPUs
that aren't running the panic code.

With that said, it's dangerous to use regular spinlocks in such path,
as introduced by commit b3c0f8774668 ("misc/pvpanic: probe multiple instances").
This patch fixes that by replacing regular spinlocks with the trylock
safer approach.

It also fixes an old comment (about a long gone framebuffer code) and
the notifier priority - we should execute hypervisor notifiers early,
deferring this way the panic action to the hypervisor, as expected by
the users that are setting up pvpanic.

Fixes: b3c0f8774668 ("misc/pvpanic: probe multiple instances")
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Mihai Carabas <mihai.carabas@oracle.com>
Cc: Shile Zhang <shile.zhang@linux.alibaba.com>
Cc: Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc: zhenwei pi <pizhenwei@bytedance.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 drivers/misc/pvpanic/pvpanic.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index 4b8f1c7d726d..049a12006348 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -34,7 +34,9 @@ pvpanic_send_event(unsigned int event)
 {
 	struct pvpanic_instance *pi_cur;
 
-	spin_lock(&pvpanic_lock);
+	if (!spin_trylock(&pvpanic_lock))
+		return;
+
 	list_for_each_entry(pi_cur, &pvpanic_list, list) {
 		if (event & pi_cur->capability & pi_cur->events)
 			iowrite8(event, pi_cur->base);
@@ -55,9 +57,13 @@ pvpanic_panic_notify(struct notifier_block *nb, unsigned long code, void *unused
 	return NOTIFY_DONE;
 }
 
+/*
+ * Call our notifier very early on panic, deferring the
+ * action taken to the hypervisor.
+ */
 static struct notifier_block pvpanic_panic_nb = {
 	.notifier_call = pvpanic_panic_notify,
-	.priority = 1, /* let this called before broken drm_fb_helper() */
+	.priority = INT_MAX,
 };
 
 static void pvpanic_remove(void *param)
-- 
2.36.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

