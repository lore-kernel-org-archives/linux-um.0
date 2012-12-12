Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Joe Perches <joe@perches.com>
Date: Wed, 12 Dec 2012 10:19:03 -0800
Message-Id: <3d4ff2048cd8a3d928e8021bd6900fa3e2dcbd0d.1355335228.git.joe@perches.com>
In-Reply-To: <cover.1355335227.git.joe@perches.com>
References: <cover.1355335227.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [TRIVIAL PATCH 14/26] um: Convert print_symbol to %pSR
To: Jiri Kosina <trivial@kernel.org>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Use the new vsprintf extension to avoid any possible
message interleaving.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/um/kernel/sysrq.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index e562ff8..6fa632c 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -24,10 +24,8 @@ void show_trace(struct task_struct *task, unsigned long * stack)
 	while (((long) stack & (THREAD_SIZE-1)) != 0) {
 		addr = *stack;
 		if (__kernel_text_address(addr)) {
-			printk(KERN_INFO "%08lx:  [<%08lx>]",
-			       (unsigned long) stack, addr);
-			print_symbol(KERN_CONT " %s", addr);
-			printk(KERN_CONT "\n");
+			printk(KERN_INFO "%08lx:  [<%08lx>] %pSR\n",
+			       (unsigned long)stack, addr, (void *)addr);
 		}
 		stack++;
 	}
-- 
1.7.8.112.g3fd21

