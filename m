Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Mon, 26 Oct 2015 11:04:34 +0100
Message-Id: <1445853874-13763-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 5/7 v2] um: Remove dead symbol from i386 syscall stub
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

syscall_stub is nowhere used these days.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
This time with the correct commit message.
---
 arch/x86/um/stub_32.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/um/stub_32.S b/arch/x86/um/stub_32.S
index b972649..9881680 100644
--- a/arch/x86/um/stub_32.S
+++ b/arch/x86/um/stub_32.S
@@ -1,6 +1,5 @@
 #include <as-layout.h>
 
-	.globl syscall_stub
 .section .__syscall_stub, "ax"
 
 	.globl batch_syscall_stub
-- 
1.8.4.5

