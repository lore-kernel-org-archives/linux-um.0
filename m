Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <aivanov@brocade.com>) id 1aAydv-0005il-Fd
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 21 Dec 2015 11:28:43 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aAydu-0002QB-J7
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 21 Dec 2015 11:28:43 +0000
From: Anton Ivanov <aivanov@brocade.com>
Date: Mon, 21 Dec 2015 11:28:02 +0000
Message-Id: <1450697283-339440-1-git-send-email-aivanov@brocade.com>
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
Subject: [uml-devel] [PATCH 1/2] Prevent IRQ handler reentrancy
To: user-mode-linux-devel@lists.sourceforge.net
Cc: richard@nod.at, Anton Ivanov <aivanov@brocade.com>

The existing IRQ handler design in UML does not prevent reentrancy

This is mitigated by fd-enable/fd-disable semantics for the IO
portion of the UML subsystem. The timer, however, can and is
re-entered resulting in very deep stack usage and occasional
stack exhaustion.

This patch prevents this by checking if there is a timer
interrupt in-flight before processing any pending timer interrupts.

Signed-off-by: Anton Ivanov <aivanov@brocade.com>
---
 arch/um/os-Linux/signal.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index c211153..7801666 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -62,6 +62,7 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 
 static int signals_enabled;
 static unsigned int signals_pending;
+static unsigned int signals_active = 0;
 
 void sig_handler(int sig, struct siginfo *si, mcontext_t *mc)
 {
@@ -101,7 +102,12 @@ void timer_alarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
 
 	block_signals();
 
+	signals_active |= SIGALRM_MASK;
+
 	timer_real_alarm_handler(mc);
+
+	signals_active &= ~SIGALRM_MASK;
+
 	set_signals(enabled);
 }
 
@@ -286,8 +292,16 @@ void unblock_signals(void)
 		if (save_pending & SIGIO_MASK)
 			sig_handler_common(SIGIO, NULL, NULL);
 
-		if (save_pending & SIGALRM_MASK)
+		/* Do not reenter the handler */
+
+		if ((save_pending & SIGALRM_MASK) && (!(signals_active & SIGALRM_MASK)))
 			timer_real_alarm_handler(NULL);
+
+		/* Rerun the loop only if there is still pending SIGIO and not in TIMER handler */
+
+		if (!(signals_pending & SIGIO_MASK) && (signals_active & SIGALRM_MASK))
+			return;
+
 	}
 }
 
-- 
2.1.4


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

