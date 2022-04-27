Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 02/30] ARM: kexec: Disable IRQs/FIQs also on crash CPUs
 shutdown path
Date: Wed, 27 Apr 2022 19:48:56 -0300
Message-Id: <20220427224924.592546-3-gpiccoli@igalia.com>
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
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, coresight@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, kernel-dev@igalia.com, gpiccoli@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org, mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org, Marc Zyngier <maz@kernel.org>, Russell King <linux@armlinux.org.uk>

Currently the regular CPU shutdown path for ARM disables IRQs/FIQs
in the secondary CPUs - smp_send_stop() calls ipi_cpu_stop(), which
is responsible for that. This makes sense, since we're turning off
such CPUs, putting them in an endless busy-wait loop.

Problem is that there is an alternative path for disabling CPUs,
in the form of function crash_smp_send_stop(), used for kexec/panic
paths. This functions relies in a SMP call that also triggers a
busy-wait loop [at machine_crash_nonpanic_core()], but *without*
disabling interrupts. This might lead to odd scenarios, like early
interrupts in the boot of kexec'd kernel or even interrupts in
other CPUs while the main one still works in the panic path and
assumes all secondary CPUs are (really!) off.

This patch mimics the ipi_cpu_stop() interrupt disable mechanism
in the crash CPU shutdown path, hence disabling IRQs/FIQs in all
secondary CPUs in the kexec/panic path as well.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 arch/arm/kernel/machine_kexec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index f567032a09c0..ef788ee00519 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -86,6 +86,9 @@ void machine_crash_nonpanic_core(void *unused)
 	set_cpu_online(smp_processor_id(), false);
 	atomic_dec(&waiting_for_crash_ipi);
 
+	local_fiq_disable();
+	local_irq_disable();
+
 	while (1) {
 		cpu_relax();
 		wfe();
-- 
2.36.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

