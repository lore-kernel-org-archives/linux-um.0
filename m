Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 27/30] powerpc: Do not force all panic notifiers to execute before kdump
Date: Wed, 27 Apr 2022 19:49:21 -0300
Message-Id: <20220427224924.592546-28-gpiccoli@igalia.com>
In-Reply-To: <20220427224924.592546-1-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: akpm@linux-foundation.org, bhe@redhat.com, pmladek@suse.com, kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, coresight@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, kernel-dev@igalia.com, gpiccoli@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org, mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Hari Bathini <hbathini@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>
List-ID: <linux-um.lists.infradead.org>

Commit 06e629c25daa ("powerpc/fadump: Fix inaccurate CPU state info in
vmcore generated with panic") introduced a hardcoded setting of kernel
parameter "crash_kexec_post_notifiers", effectively forcing all the
panic notifiers to execute earlier in the panic path, before kdump.

The reason for that was a fadump issue on collecting data accurately,
due to smp_send_stop() setting all CPUs offline, so the net effect
desired with this change was to avoid calling the regular CPU
shutdown function, and instead rely on crash_smp_send_stop(), which
copes fine with fadump. The collateral effect was to increase the
risk for kdump if fadump is not used, since it forces all panic
notifiers to execute early, before kdump.

Happens that, after a panic refactor, crash_smp_send_stop() is
now used by default in the panic path, so there is no reason to
mess with the notifiers ordering (which was also improved in the
refactor) from within arch code.

Fixes: 06e629c25daa ("powerpc/fadump: Fix inaccurate CPU state info in vmcore generated with panic")
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---

We'd like to thanks specially the MiniCloud infrastructure [0] maintainers,
that allow us to test PowerPC code in a very complete, functional and FREE
environment.

[0] https://openpower.ic.unicamp.br/minicloud

 arch/powerpc/kernel/fadump.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 65562c4a0a69..35ae8c09af66 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1649,14 +1649,6 @@ int __init setup_fadump(void)
 		register_fadump();
 	}
 
-	/*
-	 * In case of panic, fadump is triggered via ppc_panic_event()
-	 * panic notifier. Setting crash_kexec_post_notifiers to 'true'
-	 * lets panic() function take crash friendly path before panic
-	 * notifiers are invoked.
-	 */
-	crash_kexec_post_notifiers = true;
-
 	return 1;
 }
 /*
-- 
2.36.0


