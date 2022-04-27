Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 04/30] firmware: google: Convert regular spinlock into trylock
 on panic path
Date: Wed, 27 Apr 2022 19:48:58 -0300
Message-Id: <20220427224924.592546-5-gpiccoli@igalia.com>
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
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, coresight@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, kernel-dev@igalia.com, gpiccoli@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org, mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org, Ard Biesheuvel <ardb@kernel.org>, David Gow <davidgow@google.com>, Evan Green <evgreen@chromium.org>, Julius Werner <jwerner@chromium.org>

Currently the gsmi driver registers a panic notifier as well as
reboot and die notifiers. The callbacks registered are called in
atomic and very limited context - for instance, panic disables
preemption, local IRQs and all other CPUs that aren't running the
current panic function.

With that said, taking a spinlock in this scenario is a
dangerous invitation for a deadlock scenario. So, we fix
that in this commit by changing the regular spinlock with
a trylock, which is a safer approach.

Fixes: 74c5b31c6618 ("driver: Google EFI SMI")
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: David Gow <davidgow@google.com>
Cc: Evan Green <evgreen@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 drivers/firmware/google/gsmi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index adaa492c3d2d..b01ed02e4a87 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -629,7 +629,10 @@ static int gsmi_shutdown_reason(int reason)
 	if (saved_reason & (1 << reason))
 		return 0;
 
-	spin_lock_irqsave(&gsmi_dev.lock, flags);
+	if (!spin_trylock_irqsave(&gsmi_dev.lock, flags)) {
+		rc = -EBUSY;
+		goto out;
+	}
 
 	saved_reason |= (1 << reason);
 
@@ -646,6 +649,7 @@ static int gsmi_shutdown_reason(int reason)
 
 	spin_unlock_irqrestore(&gsmi_dev.lock, flags);
 
+out:
 	if (rc < 0)
 		printk(KERN_ERR "gsmi: Log Shutdown Reason failed\n");
 	else
-- 
2.36.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

