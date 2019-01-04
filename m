Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfRYO-0003yf-Qp
 for linux-um@lists.infradead.org; Fri, 04 Jan 2019 15:38:35 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH] um: Revert to using stack for pt_regs in signal handling
Date: Fri,  4 Jan 2019 15:38:21 +0000
Message-Id: <20190104153821.8642-1-anton.ivanov@cambridgegreys.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: richard@nod.at, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Reverts commit b6024b21fec8367ef961a771cc9dde31f1831965 and
adjusts default stack sizing to cope with larger size of
floating point save registers on the newer Intel CPUs.

b6024b21fec8367ef961a771cc9dde31f1831965 replaced storing the
register state on the stack with kmalloc-ed storage. That has
a number of issues and a panic if that fails.
    1. kmalloc/ATOMIC can fail. There was a latent hard crash
in all interrupt and fault handling as a result.
    2. kmalloc in the interrupt path introduces a considerable
performance penalty for networking ~ 14% on iperf.

This commit restores uml to a stable state until a better
solution is found.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/Kconfig           | 10 +++++++---
 arch/um/os-Linux/signal.c | 28 ++++++++--------------------
 2 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index ec9711d068b7..41913504a56e 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -142,13 +142,17 @@ config MAGIC_SYSRQ
 
 config KERNEL_STACK_ORDER
 	int "Kernel stack size order"
-	default 1 if 64BIT
-	range 1 10 if 64BIT
-	default 0 if !64BIT
+	default 2 if 64BIT
+	range 2 10 if 64BIT
+	default 1 if !64BIT
 	help
 	  This option determines the size of UML kernel stacks.  They will
 	  be 1 << order pages.  The default is OK unless you're running Valgrind
 	  on UML, in which case, set this to 3.
+	  It is possible to reduce the stack to 1 for 64BIT and 0 for 32BIT on
+	  older (pre-2017) CPUs. It is not recommended on newer CPUs due to the
+	  increase in the size of the state which needs to be saved when handling
+          signals.
 
 config MMAPPER
 	tristate "iomem emulation driver"
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index bf0acb8aad8b..75b10235d369 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -31,29 +31,23 @@ void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
 
 static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 {
-	struct uml_pt_regs *r;
+	struct uml_pt_regs r;
 	int save_errno = errno;
 
-	r = uml_kmalloc(sizeof(struct uml_pt_regs), UM_GFP_ATOMIC);
-	if (!r)
-		panic("out of memory");
-
-	r->is_user = 0;
+	r.is_user = 0;
 	if (sig == SIGSEGV) {
 		/* For segfaults, we want the data from the sigcontext. */
-		get_regs_from_mc(r, mc);
-		GET_FAULTINFO_FROM_MC(r->faultinfo, mc);
+		get_regs_from_mc(&r, mc);
+		GET_FAULTINFO_FROM_MC(r.faultinfo, mc);
 	}
 
 	/* enable signals if sig isn't IRQ signal */
 	if ((sig != SIGIO) && (sig != SIGWINCH) && (sig != SIGALRM))
 		unblock_signals();
 
-	(*sig_info[sig])(sig, si, r);
+	(*sig_info[sig])(sig, si, &r);
 
 	errno = save_errno;
-
-	free(r);
 }
 
 /*
@@ -91,17 +85,11 @@ void sig_handler(int sig, struct siginfo *si, mcontext_t *mc)
 
 static void timer_real_alarm_handler(mcontext_t *mc)
 {
-	struct uml_pt_regs *regs;
-
-	regs = uml_kmalloc(sizeof(struct uml_pt_regs), UM_GFP_ATOMIC);
-	if (!regs)
-		panic("out of memory");
+	struct uml_pt_regs regs;
 
 	if (mc != NULL)
-		get_regs_from_mc(regs, mc);
-	timer_handler(SIGALRM, NULL, regs);
-
-	free(regs);
+		get_regs_from_mc(&regs, mc);
+	timer_handler(SIGALRM, NULL, &regs);
 }
 
 void timer_alarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

