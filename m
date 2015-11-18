Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Wed, 18 Nov 2015 09:51:43 +0100
Message-Id: <1447836703-32594-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] um: Fix get_signal() usage
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, Richard Weinberger <richard@nod.at>, stable@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

If get_signal() returns us a signal to post
we must not call it again, otherwise the already
posted signal will be overridden.
Before commit a610d6e672d this was the case as we stopped
the while after a successful handle_signal().

Cc: <stable@vger.kernel.org> # 3.10-
Fixes: a610d6e672d ("pull clearing RESTORE_SIGMASK into block_sigmask()")
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/signal.c b/arch/um/kernel/signal.c
index 57acbd6..fc8be0e 100644
--- a/arch/um/kernel/signal.c
+++ b/arch/um/kernel/signal.c
@@ -69,7 +69,7 @@ void do_signal(struct pt_regs *regs)
 	struct ksignal ksig;
 	int handled_sig = 0;
 
-	while (get_signal(&ksig)) {
+	if (get_signal(&ksig)) {
 		handled_sig = 1;
 		/* Whee!  Actually deliver the signal.  */
 		handle_signal(&ksig, regs);
-- 
2.5.0

