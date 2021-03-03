Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTwJ-005VYw-Lp
 for linux-um@lists.infradead.org; Wed, 03 Mar 2021 16:01:33 +0000
From: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 20/27] um: Use struct uml_pt_regs for copy_context_skas0
Date: Wed,  3 Mar 2021 16:55:16 +0100
Message-Id: <20210303155523.124277-21-benjamin@sipsolutions.net>
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

This is done as preparation for seccomp support as we have no helper to
copy the registers from a plain array.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/os-Linux/skas/process.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 660b23389016..3bfc28d28fc0 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -462,20 +462,19 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 	}
 }
 
-static unsigned long thread_regs[MAX_REG_NR];
-static unsigned long thread_fp_regs[FP_SIZE];
+static struct uml_pt_regs thread_regs;
 
 static int __init init_thread_regs(void)
 {
-	get_safe_registers(thread_regs, thread_fp_regs);
+	get_safe_registers(thread_regs.gp, thread_regs.fp);
 	/* Set parent's instruction pointer to start of clone-stub */
-	thread_regs[REGS_IP_INDEX] = STUB_CODE +
+	thread_regs.gp[REGS_IP_INDEX] = STUB_CODE +
 				(unsigned long) stub_clone_handler -
 				(unsigned long) __syscall_stub_start;
-	thread_regs[REGS_SP_INDEX] = STUB_DATA + UM_KERN_PAGE_SIZE -
+	thread_regs.gp[REGS_SP_INDEX] = STUB_DATA + UM_KERN_PAGE_SIZE -
 		sizeof(void *);
 #ifdef __SIGNAL_FRAMESIZE
-	thread_regs[REGS_SP_INDEX] -= __SIGNAL_FRAMESIZE;
+	thread_regs.gp[REGS_SP_INDEX] -= __SIGNAL_FRAMESIZE;
 #endif
 	return 0;
 }
@@ -506,7 +505,7 @@ int copy_context_skas0(struct mm_id *id, struct mm_id *from)
 		.child_err = -ESRCH,
 	});
 
-	err = ptrace_setregs(from->u.pid, thread_regs);
+	err = ptrace_setregs(from->u.pid, thread_regs.gp);
 	if (err < 0) {
 		err = -errno;
 		printk(UM_KERN_ERR "%s : PTRACE_SETREGS failed, pid = %d, errno = %d\n",
@@ -514,7 +513,7 @@ int copy_context_skas0(struct mm_id *id, struct mm_id *from)
 		return err;
 	}
 
-	err = put_fp_registers(from->u.pid, thread_fp_regs);
+	err = put_fp_registers(from->u.pid, thread_regs.fp);
 	if (err < 0) {
 		printk(UM_KERN_ERR "%s : put_fp_registers failed, pid = %d, err = %d\n",
 		       __func__, from->u.pid, err);
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

