Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 30/30] um: Avoid duplicate call to kmsg_dump()
Date: Wed, 27 Apr 2022 19:49:24 -0300
Message-Id: <20220427224924.592546-31-gpiccoli@igalia.com>
In-Reply-To: <20220427224924.592546-1-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: akpm@linux-foundation.org, bhe@redhat.com, pmladek@suse.com, kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, coresight@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, kernel-dev@igalia.com, gpiccoli@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org, mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Richard Weinberger <richard@nod.at>
List-ID: <linux-um.lists.infradead.org>

Currently the panic notifier panic_exit() calls kmsg_dump() and
some console flushing routines - this makes sense since such
panic notifier exits UserMode Linux and never returns.

Happens that after a panic refactor, kmsg_dump() is now always
called *before* the pre_reboot list of panic notifiers, in which
panic_exit() belongs, leading to a double call situation.

This patch changes that by removing such call from the panic
notifier, but leaving the console flushing calls since the
pre_reboot list still runs before console flushing on panic().

Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Richard Weinberger <richard@nod.at>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 arch/um/kernel/um_arch.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index fc6e443299da..651310e3e86f 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -241,7 +241,6 @@ static void __init uml_postsetup(void)
 static int panic_exit(struct notifier_block *self, unsigned long unused1,
 		      void *unused2)
 {
-	kmsg_dump(KMSG_DUMP_PANIC);
 	bust_spinlocks(1);
 	bust_spinlocks(0);
 	uml_exitcode = 1;
-- 
2.36.0


