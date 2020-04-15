Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jOcq2-0007Pe-2e
 for linux-um@lists.infradead.org; Wed, 15 Apr 2020 07:52:03 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: syscall.c: include <asm/unistd.h>
Date: Wed, 15 Apr 2020 09:51:52 +0200
Message-Id: <20200415095152.85794f817f97.I289cb72f130c19e850d70eacca9e68eb84832600@changeid>
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
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

Without CONFIG_SECCOMP, we don't get this include recursively
through the existing includes, thus failing the build on not
having __NR_syscall_max defined. Add the necessary include to
fix this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/skas/syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index 0a12d5a09217..3d91f89fd852 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -11,6 +11,7 @@
 #include <sysdep/ptrace_user.h>
 #include <sysdep/syscalls.h>
 #include <linux/time-internal.h>
+#include <asm/unistd.h>
 
 void handle_syscall(struct uml_pt_regs *r)
 {
-- 
2.25.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

