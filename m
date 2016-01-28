Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jeffrey Merkey <jeffmerkey@gmail.com>
Subject: [PATCH 16/31] Add debugger entry points for UM
Date: Thu, 28 Jan 2016 12:47:01 -0700
Message-Id: <1454010421-29055-1-git-send-email-jeffmerkey@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: jdike@addtoit.com, richard@nod.at, linux.mdb@gmail.com, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This patch series adds an export which can be set by system debuggers to
direct the hard lockup and soft lockup detector to trigger a breakpoint
exception and enter a debugger if one is active.  It is assumed that if
someone sets this variable, then an breakpoint handler of some sort will
be actively loaded or registered via the notify die handler chain.

This addition is extremely useful for debugging hard and soft lockups
real time and quickly from a console debugger.

Signed-off-by: Jeffrey Merkey <jeffmerkey@gmail.com>
---
 arch/um/include/asm/kdebug.h | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 arch/um/include/asm/kdebug.h

diff --git a/arch/um/include/asm/kdebug.h b/arch/um/include/asm/kdebug.h
new file mode 100644
index 0000000..5d09de1
--- /dev/null
+++ b/arch/um/include/asm/kdebug.h
@@ -0,0 +1,4 @@
+
+static inline void arch_breakpoint(void)
+{
+}
-- 
1.8.3.1


