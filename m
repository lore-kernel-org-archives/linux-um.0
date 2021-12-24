Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-sgaapc01on2090.outbound.protection.outlook.com
 ([40.107.215.90] helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n0adO-00DhIS-Ut
 for linux-um@lists.infradead.org; Fri, 24 Dec 2021 02:48:46 +0000
From: Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] um: remove a duplicate include
Date: Fri, 24 Dec 2021 10:46:35 +0800
Message-Id: <20211224024635.7497-1-guozhengkui@vivo.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "open list:USER-MODE LINUX UML" <linux-um@lists.infradead.org>, "open list:X86 ARCHITECTURE 32-BIT AND 64-BIT" <linux-kernel@vger.kernel.org>
Cc: kernel@vivo.com, Guo Zhengkui <guozhengkui@vivo.com>

Remove a duplicate "#include <registers.h>" in line 15.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 arch/x86/um/syscalls_64.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/um/syscalls_64.c b/arch/x86/um/syscalls_64.c
index fe5323f0c42d..27b29ae6c471 100644
--- a/arch/x86/um/syscalls_64.c
+++ b/arch/x86/um/syscalls_64.c
@@ -12,7 +12,6 @@
 #include <asm/prctl.h> /* XXX This should get the constants from libc */
 #include <registers.h>
 #include <os.h>
-#include <registers.h>
 
 long arch_prctl(struct task_struct *task, int option,
 		unsigned long __user *arg2)
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

