Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWYUJ-007VY2-TJ
 for linux-um@lists.infradead.org; Wed, 14 Apr 2021 05:54:57 +0000
Received: by mail-pg1-x52b.google.com with SMTP id t22so13670716pgu.0
 for <linux-um@lists.infradead.org>; Tue, 13 Apr 2021 22:54:55 -0700 (PDT)
From: Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 1/4] signal: add a helper to restore a process state from
 sigcontex
Date: Tue, 13 Apr 2021 22:52:14 -0700
Message-Id: <20210414055217.543246-2-avagin@gmail.com>
In-Reply-To: <20210414055217.543246-1-avagin@gmail.com>
References: <20210414055217.543246-1-avagin@gmail.com>
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
To: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc: linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com, Andrei Vagin <avagin@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Christian Brauner <christian.brauner@ubuntu.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>

It will be used to implement process_vm_exec.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/x86/kernel/signal.c | 78 ++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index be0d7d4152ec..cc269a20dd5f 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -79,51 +79,43 @@ static void force_valid_ss(struct pt_regs *regs)
 # define CONTEXT_COPY_SIZE	sizeof(struct sigcontext)
 #endif
 
-static int restore_sigcontext(struct pt_regs *regs,
-			      struct sigcontext __user *usc,
+static int __restore_sigcontext(struct pt_regs *regs,
+			      struct sigcontext __user *sc,
 			      unsigned long uc_flags)
 {
-	struct sigcontext sc;
-
-	/* Always make any pending restarted system calls return -EINTR */
-	current->restart_block.fn = do_no_restart_syscall;
-
-	if (copy_from_user(&sc, usc, CONTEXT_COPY_SIZE))
-		return -EFAULT;
-
 #ifdef CONFIG_X86_32
-	set_user_gs(regs, sc.gs);
-	regs->fs = sc.fs;
-	regs->es = sc.es;
-	regs->ds = sc.ds;
+	set_user_gs(regs, sc->gs);
+	regs->fs = sc->fs;
+	regs->es = sc->es;
+	regs->ds = sc->ds;
 #endif /* CONFIG_X86_32 */
 
-	regs->bx = sc.bx;
-	regs->cx = sc.cx;
-	regs->dx = sc.dx;
-	regs->si = sc.si;
-	regs->di = sc.di;
-	regs->bp = sc.bp;
-	regs->ax = sc.ax;
-	regs->sp = sc.sp;
-	regs->ip = sc.ip;
+	regs->bx = sc->bx;
+	regs->cx = sc->cx;
+	regs->dx = sc->dx;
+	regs->si = sc->si;
+	regs->di = sc->di;
+	regs->bp = sc->bp;
+	regs->ax = sc->ax;
+	regs->sp = sc->sp;
+	regs->ip = sc->ip;
 
 #ifdef CONFIG_X86_64
-	regs->r8 = sc.r8;
-	regs->r9 = sc.r9;
-	regs->r10 = sc.r10;
-	regs->r11 = sc.r11;
-	regs->r12 = sc.r12;
-	regs->r13 = sc.r13;
-	regs->r14 = sc.r14;
-	regs->r15 = sc.r15;
+	regs->r8 = sc->r8;
+	regs->r9 = sc->r9;
+	regs->r10 = sc->r10;
+	regs->r11 = sc->r11;
+	regs->r12 = sc->r12;
+	regs->r13 = sc->r13;
+	regs->r14 = sc->r14;
+	regs->r15 = sc->r15;
 #endif /* CONFIG_X86_64 */
 
 	/* Get CS/SS and force CPL3 */
-	regs->cs = sc.cs | 0x03;
-	regs->ss = sc.ss | 0x03;
+	regs->cs = sc->cs | 0x03;
+	regs->ss = sc->ss | 0x03;
 
-	regs->flags = (regs->flags & ~FIX_EFLAGS) | (sc.flags & FIX_EFLAGS);
+	regs->flags = (regs->flags & ~FIX_EFLAGS) | (sc->flags & FIX_EFLAGS);
 	/* disable syscall checks */
 	regs->orig_ax = -1;
 
@@ -136,10 +128,26 @@ static int restore_sigcontext(struct pt_regs *regs,
 		force_valid_ss(regs);
 #endif
 
-	return fpu__restore_sig((void __user *)sc.fpstate,
+	return fpu__restore_sig((void __user *)sc->fpstate,
 			       IS_ENABLED(CONFIG_X86_32));
 }
 
+static int restore_sigcontext(struct pt_regs *regs,
+			      struct sigcontext __user *usc,
+			      unsigned long uc_flags)
+{
+	struct sigcontext sc;
+
+	/* Always make any pending restarted system calls return -EINTR */
+	current->restart_block.fn = do_no_restart_syscall;
+
+	if (copy_from_user(&sc, usc, CONTEXT_COPY_SIZE))
+		return -EFAULT;
+
+	return __restore_sigcontext(regs, &sc, uc_flags);
+}
+
+
 static __always_inline int
 __unsafe_setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
 		     struct pt_regs *regs, unsigned long mask)
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

