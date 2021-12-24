Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n0aXQ-00Dh9d-OW
 for linux-um@lists.infradead.org; Fri, 24 Dec 2021 02:42:34 +0000
From: Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] um: Remove duplicated include in syscalls_64.c
Date: Fri, 24 Dec 2021 10:42:23 +0800
Message-Id: <20211224024223.9356-1-yang.lee@linux.alibaba.com>
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
To: jdike@addtoit.com, viro@zeniv.linux.org.uk
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>, Abaci Robot <abaci@linux.alibaba.com>

Fix following includecheck warning:
./arch/x86/um/syscalls_64.c: registers.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: dbba7f704aa0 ("um: stop polluting the namespace with registers.h contents")
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
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
2.20.1.7.g153144c


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

