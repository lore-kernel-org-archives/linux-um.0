Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Thu, 29 May 2014 11:51:28 +0200
Message-Id: <1401357089-24959-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 1/2] um: Detect NULL dereferences earlier
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

There is no need to go through handle_page_fault().
If we try to access the zero page in kernel mode just panic().

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/kernel/trap.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 974b874..b0a3017 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -218,10 +218,15 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 		panic("Segfault with no mm");
 	}
 
-	if (SEGV_IS_FIXABLE(&fi) || SEGV_MAYBE_FIXABLE(&fi))
+	if (SEGV_IS_FIXABLE(&fi) || SEGV_MAYBE_FIXABLE(&fi)) {
+		if (!is_user && address < PAGE_SIZE) {
+			show_regs(container_of(regs, struct pt_regs, regs));
+			panic("NULL pointer dereference at ip:0x%lx address:0x%lx", ip, address);
+		}
+
 		err = handle_page_fault(address, ip, is_write, is_user,
 					&si.si_code);
-	else {
+	} else {
 		err = -EFAULT;
 		/*
 		 * A thread accessed NULL, we get a fault, but CR2 is invalid.
-- 
1.8.4.2

