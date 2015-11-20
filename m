Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <aivanov@brocade.com>) id 1ZzooW-0001Oi-Kp
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 16:45:32 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZzooV-00056E-P7
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 16:45:32 +0000
From: Anton Ivanov <aivanov@brocade.com>
Date: Fri, 20 Nov 2015 16:45:13 +0000
Message-Id: <1448037915-921549-1-git-send-email-aivanov@brocade.com>
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
Subject: [uml-devel] [PATCH 1/3] IRQ Reentrancy guard
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Anton Ivanov <aivanov@brocade.com>

Fixes: IRQ Reentrancy

The code in signal.c used in irq controller emulation does not
prevent IRQ reentrancy which can result in all types of issues
as IRQs including ones on the same device can be executed in
a nested manner

Signed-off-by: Anton Ivanov <aivanov@brocade.com>
---
 arch/um/kernel/irq.c      |  8 ++++++++
 arch/um/os-Linux/signal.c | 15 ++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 23cb935..4813263 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -30,11 +30,17 @@ static struct irq_fd **last_irq_ptr = &active_fds;
 
 extern void free_irqs(void);
 
+static int in_poll_handler = 0;
+
 void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 {
 	struct irq_fd *irq_fd;
 	int n;
 
+	WARN_ON_ONCE(in_poll_handler == 1);
+
+	in_poll_handler = 1;
+
 	while (1) {
 		n = os_waiting_for_events(active_fds);
 		if (n <= 0) {
@@ -52,6 +58,8 @@ void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 		}
 	}
 
+	in_poll_handler = 0;
+
 	free_irqs();
 }
 
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index c211153..9aa7097 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -27,6 +27,8 @@ void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
 	[SIGALRM]	= timer_handler
 };
 
+static int irq_guard = 0;
+
 static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 {
 	struct uml_pt_regs r;
@@ -40,11 +42,17 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 	}
 
 	/* enable signals if sig isn't IRQ signal */
-	if ((sig != SIGIO) && (sig != SIGWINCH) && (sig != SIGALRM))
+	if ((sig != SIGIO) && (sig != SIGWINCH) && (sig != SIGALRM)) {
 		unblock_signals();
+	} else {
+		irq_guard = 1;
+	}
 
 	(*sig_info[sig])(sig, si, &r);
 
+	if (!((sig != SIGIO) && (sig != SIGWINCH) && (sig != SIGALRM)))
+		irq_guard = 0;
+
 	errno = save_errno;
 }
 
@@ -86,7 +94,9 @@ static void timer_real_alarm_handler(mcontext_t *mc)
 
 	if (mc != NULL)
 		get_regs_from_mc(&regs, mc);
+	irq_guard = 1;
 	timer_handler(SIGALRM, NULL, &regs);
+	irq_guard = 0;
 }
 
 void timer_alarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
@@ -243,6 +253,9 @@ void unblock_signals(void)
 	if (signals_enabled == 1)
 		return;
 
+	if (irq_guard == 1)
+		return;
+
 	/*
 	 * We loop because the IRQ handler returns with interrupts off.  So,
 	 * interrupts may have arrived and we need to re-enable them and
-- 
2.1.4


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

