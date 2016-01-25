Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH] Revert "um: Fix get_signal() usage"
Date: Mon, 25 Jan 2016 23:33:30 +0100
Message-Id: <1453761212-1652-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Commit db2f24dc240856fb1d78005307f1523b7b3c121b
was plain wrong. I did not realize the we are
allowed to loop here.
In fact we have to loop and must not return to userspace
before all SIGSEGVs have been delivered.
Other archs do this directly in their entry code, UML
does it here.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Richard Weinberger <richard@nod.at>

diff --git a/arch/um/kernel/signal.c b/arch/um/kernel/signal.c
index fc8be0e..57acbd6 100644
--- a/arch/um/kernel/signal.c
+++ b/arch/um/kernel/signal.c
@@ -69,7 +69,7 @@ void do_signal(struct pt_regs *regs)
 	struct ksignal ksig;
 	int handled_sig = 0;
 
-	if (get_signal(&ksig)) {
+	while (get_signal(&ksig)) {
 		handled_sig = 1;
 		/* Whee!  Actually deliver the signal.  */
 		handle_signal(&ksig, regs);
-- 
1.8.4.5


