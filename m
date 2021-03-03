Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTwd-005Ve5-J1
 for linux-um@lists.infradead.org; Wed, 03 Mar 2021 16:01:54 +0000
From: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 12/27] um: Remove unused register save/restore functions
Date: Wed,  3 Mar 2021 16:55:08 +0100
Message-Id: <20210303155523.124277-13-benjamin@sipsolutions.net>
In-Reply-To: <20210303155523.124277-1-benjamin@sipsolutions.net>
References: <20210303155523.124277-1-benjamin@sipsolutions.net>
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
Cc: Benjamin Berg <benjamin@sipsolutions.net>

These functions were only used when calling PTRACE_ARCH_PRCTL, but this
code has been removed.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/include/shared/registers.h |  2 --
 arch/um/os-Linux/registers.c       | 20 --------------------
 2 files changed, 22 deletions(-)

diff --git a/arch/um/include/shared/registers.h b/arch/um/include/shared/registers.h
index 0c50fa6e8a55..2c84e8bdb35d 100644
--- a/arch/um/include/shared/registers.h
+++ b/arch/um/include/shared/registers.h
@@ -15,8 +15,6 @@ extern int save_fp_registers(int pid, unsigned long *fp_regs);
 extern int restore_fp_registers(int pid, unsigned long *fp_regs);
 extern int save_fpx_registers(int pid, unsigned long *fp_regs);
 extern int restore_fpx_registers(int pid, unsigned long *fp_regs);
-extern int save_registers(int pid, struct uml_pt_regs *regs);
-extern int restore_registers(int pid, struct uml_pt_regs *regs);
 extern int init_registers(int pid);
 extern void get_safe_registers(unsigned long *regs, unsigned long *fp_regs);
 extern unsigned long get_thread_reg(int reg, jmp_buf *buf);
diff --git a/arch/um/os-Linux/registers.c b/arch/um/os-Linux/registers.c
index 2d9270508e15..52823368e15a 100644
--- a/arch/um/os-Linux/registers.c
+++ b/arch/um/os-Linux/registers.c
@@ -11,26 +11,6 @@
 #include <sysdep/ptrace_user.h>
 #include <registers.h>
 
-int save_registers(int pid, struct uml_pt_regs *regs)
-{
-	int err;
-
-	err = ptrace(PTRACE_GETREGS, pid, 0, regs->gp);
-	if (err < 0)
-		return -errno;
-	return 0;
-}
-
-int restore_registers(int pid, struct uml_pt_regs *regs)
-{
-	int err;
-
-	err = ptrace(PTRACE_SETREGS, pid, 0, regs->gp);
-	if (err < 0)
-		return -errno;
-	return 0;
-}
-
 /* This is set once at boot time and not changed thereafter */
 
 static unsigned long exec_regs[MAX_REG_NR];
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

