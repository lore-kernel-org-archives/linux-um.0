Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jan.kiszka@web.de>) id 1O3yuG-0005RT-Lo
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2010 21:53:28 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O3yuF-00024U-6y for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2010 21:53:28 +0000
From: Jan Kiszka <jan.kiszka@web.de>
Date: Mon, 19 Apr 2010 23:53:07 +0200
Message-Id: <3e07ad1a38e88a22d7298deb88a8f3962b101998.1271713955.git.jan.kiszka@web.de>
In-Reply-To: <cover.1271713955.git.jan.kiszka@web.de>
References: <cover.1271713955.git.jan.kiszka@web.de>
In-Reply-To: <cover.1271713955.git.jan.kiszka@web.de>
References: <cover.1271713955.git.jan.kiszka@web.de>
Subject: [uml-devel] [PATCH 4/5] uml: i386: Avoid redefinition of NR_syscalls
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
To: trivial@kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

The i386 subarch happens to pull in original NR_syscalls. Maybe we can
make that work for all host arch, but for now just avoid the clash by
using an all-upper-case name.

Signed-off-by: Jan Kiszka <jan.kiszka@web.de>
---
 arch/um/kernel/skas/syscall.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index 4e3b820..f5173e1 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -10,7 +10,7 @@
 #include "sysdep/syscalls.h"
 
 extern int syscall_table_size;
-#define NR_syscalls (syscall_table_size / sizeof(void *))
+#define NR_SYSCALLS (syscall_table_size / sizeof(void *))
 
 void handle_syscall(struct uml_pt_regs *r)
 {
@@ -30,7 +30,7 @@ void handle_syscall(struct uml_pt_regs *r)
 	 * in case it's a compiler bug.
 	 */
 	syscall = UPT_SYSCALL_NR(r);
-	if ((syscall >= NR_syscalls) || (syscall < 0))
+	if ((syscall >= NR_SYSCALLS) || (syscall < 0))
 		result = -ENOSYS;
 	else result = EXECUTE_SYSCALL(syscall, regs);
 
-- 
1.6.0.2


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

