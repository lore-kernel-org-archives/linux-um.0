Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfMM7-0002yP-G0
 for linux-um@lists.infradead.org; Fri, 04 Jan 2019 10:05:33 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH] um: Try to avoid kmalloc in signal handling
Date: Fri,  4 Jan 2019 10:05:17 +0000
Message-Id: <20190104100517.9809-1-anton.ivanov@cambridgegreys.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: richard@nod.at, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Signal handling (which maps to interrupt handling in UML) needs
to pass current registers to the relevant handlers and was
allocating a structure for that using kmalloc. It is possible
to avoid this kmalloc by using a small "signal register stack".
A depth of 4 suffices for normal use. If it is exceeded
further sets of registers are allocated as before via kmalloc.

The end result is >10% performance increase in networking
as measured by iperf and >5% across the board.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/include/shared/os.h |  4 ++++
 arch/um/kernel/signal.c     | 31 +++++++++++++++++++++++++++++++
 arch/um/os-Linux/signal.c   | 16 ++++------------
 3 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index ebf23012a59b..4ec1bc63213b 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -319,4 +319,8 @@ extern unsigned long os_get_top_address(void);
 
 long syscall(long number, ...);
 
+/* signal.c */
+extern struct uml_pt_regs *get_save_register_state(void);
+extern void release_save_register_state(struct uml_pt_regs *r);
+
 #endif
diff --git a/arch/um/kernel/signal.c b/arch/um/kernel/signal.c
index 57acbd67d85d..558ac7e4df97 100644
--- a/arch/um/kernel/signal.c
+++ b/arch/um/kernel/signal.c
@@ -6,11 +6,18 @@
 #include <linux/module.h>
 #include <linux/ptrace.h>
 #include <linux/sched.h>
+#include <linux/slab.h>
 #include <asm/siginfo.h>
 #include <asm/signal.h>
 #include <asm/unistd.h>
 #include <frame_kern.h>
 #include <kern_util.h>
+#include <os.h>
+
+static atomic_t reg_depth;
+
+static struct uml_pt_regs reg_file[4];
+#define REG_SWITCH_TO_KMALLOC_DEPTH 3
 
 EXPORT_SYMBOL(block_signals);
 EXPORT_SYMBOL(unblock_signals);
@@ -111,3 +118,27 @@ void do_signal(struct pt_regs *regs)
 	if (!handled_sig)
 		restore_saved_sigmask();
 }
+
+struct uml_pt_regs *get_save_register_state(void)
+{
+	struct uml_pt_regs *r;
+	int depth = atomic_inc_return(&reg_depth);
+
+	if (depth > REG_SWITCH_TO_KMALLOC_DEPTH) {
+		WARN(1, "Exceeded uml save register space, should not occur");
+		r = kmalloc(sizeof(struct uml_pt_regs), GFP_ATOMIC);
+		if (!r)
+			panic("Cannot allocate extra save register space");
+	} else {
+		r = &reg_file[depth - 1];
+	}
+	return r;
+}
+
+void release_save_register_state(struct uml_pt_regs *r)
+{
+	if (atomic_dec_return(&reg_depth) > REG_SWITCH_TO_KMALLOC_DEPTH)
+		kfree(r);
+}
+
+
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index bf0acb8aad8b..81765abe1c15 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -31,13 +31,9 @@ void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
 
 static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 {
-	struct uml_pt_regs *r;
+	struct uml_pt_regs *r = get_save_register_state();
 	int save_errno = errno;
 
-	r = uml_kmalloc(sizeof(struct uml_pt_regs), UM_GFP_ATOMIC);
-	if (!r)
-		panic("out of memory");
-
 	r->is_user = 0;
 	if (sig == SIGSEGV) {
 		/* For segfaults, we want the data from the sigcontext. */
@@ -53,7 +49,7 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 
 	errno = save_errno;
 
-	free(r);
+	release_save_register_state(r);
 }
 
 /*
@@ -91,17 +87,13 @@ void sig_handler(int sig, struct siginfo *si, mcontext_t *mc)
 
 static void timer_real_alarm_handler(mcontext_t *mc)
 {
-	struct uml_pt_regs *regs;
-
-	regs = uml_kmalloc(sizeof(struct uml_pt_regs), UM_GFP_ATOMIC);
-	if (!regs)
-		panic("out of memory");
+	struct uml_pt_regs *regs = get_save_register_state();
 
 	if (mc != NULL)
 		get_regs_from_mc(regs, mc);
 	timer_handler(SIGALRM, NULL, regs);
 
-	free(regs);
+	release_save_register_state(regs);
 }
 
 void timer_alarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

