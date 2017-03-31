Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH] um: Fix PTRACE_POKEUSER on x86_64
Date: Sat,  1 Apr 2017 00:41:57 +0200
Message-Id: <20170331224157.12922-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com, richard@nod.at, stable@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is broken since ever but sadly nobody noticed.
Recent versions of GDB set DR_CONTROL unconditionally and
UML dies due to a heap corruption. It turns out that
the PTRACE_POKEUSER was copy&pasted from i386 and assumes
that addresses are 4 bytes long.

Fix that by using 8 as address size in the calculation.

Cc: <stable@vger.kernel.org>
Reported-by: jie cao <cj3054@gmail.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/x86/um/ptrace_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/um/ptrace_64.c b/arch/x86/um/ptrace_64.c
index a5c9910d234f..09a085bde0d4 100644
--- a/arch/x86/um/ptrace_64.c
+++ b/arch/x86/um/ptrace_64.c
@@ -125,7 +125,7 @@ int poke_user(struct task_struct *child, long addr, long data)
 	else if ((addr >= offsetof(struct user, u_debugreg[0])) &&
 		(addr <= offsetof(struct user, u_debugreg[7]))) {
 		addr -= offsetof(struct user, u_debugreg[0]);
-		addr = addr >> 2;
+		addr = addr >> 3;
 		if ((addr == 4) || (addr == 5))
 			return -EIO;
 		child->thread.arch.debugregs[addr] = data;
-- 
2.10.2


