Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <menage@google.com>) id 1MGNRg-0007jh-B5
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Jun 2009 01:26:40 +0000
Received: from [216.239.45.13] (helo=smtp-out.google.com)
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MGNRe-0003oE-H7
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Jun 2009 01:26:40 +0000
From: Paul Menage <menage@google.com>
Date: Mon, 15 Jun 2009 17:17:34 -0700
Message-ID: <20090616001734.30398.74530.stgit@menage.mtv.corp.google.com>
In-Reply-To: <20090616001248.30398.84278.stgit@menage.mtv.corp.google.com>
References: <20090616001248.30398.84278.stgit@menage.mtv.corp.google.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH 2/5] UML: Enable CONFIG_TRACE_IRQFLAGS_SUPPORT
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: peterz@infradead.org, mingo@redhat.com, jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

UML: Enable CONFIG_TRACE_IRQFLAGS_SUPPORT

Signed-off-by: Paul Menage <menage@google.com>

---

 arch/um/Kconfig.common        |    2 +-
 arch/um/include/asm/system.h  |   39 ++++++++++++++++++++++-----------------
 arch/um/kernel/irq.c          |    1 +
 arch/um/kernel/process.c      |    1 -
 arch/um/kernel/skas/process.c |    2 +-
 5 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
index 0d207e7..8a54ae4 100644
--- a/arch/um/Kconfig.common
+++ b/arch/um/Kconfig.common
@@ -36,7 +36,7 @@ config PCMCIA
 # Yet to do!
 config TRACE_IRQFLAGS_SUPPORT
 	bool
-	default n
+	default y
 
 config LOCKDEP_SUPPORT
 	bool
diff --git a/arch/um/include/asm/system.h b/arch/um/include/asm/system.h
index 753346e..dd76c29 100644
--- a/arch/um/include/asm/system.h
+++ b/arch/um/include/asm/system.h
@@ -11,23 +11,28 @@ extern int get_signals(void);
 extern void block_signals(void);
 extern void unblock_signals(void);
 
-#define local_save_flags(flags) do { typecheck(unsigned long, flags); \
-				     (flags) = get_signals(); } while(0)
-#define local_irq_restore(flags) do { typecheck(unsigned long, flags); \
-				      set_signals(flags); } while(0)
-
-#define local_irq_save(flags) do { local_save_flags(flags); \
-                                   local_irq_disable(); } while(0)
-
-#define local_irq_enable() unblock_signals()
-#define local_irq_disable() block_signals()
-
-#define irqs_disabled()                 \
-({                                      \
-        unsigned long flags;            \
-        local_save_flags(flags);        \
-        (flags == 0);                   \
-})
+#define raw_local_save_flags(flags) do { typecheck(unsigned long, flags); \
+					 (flags) = get_signals(); } while (0)
+#define raw_local_irq_restore(flags) do { typecheck(unsigned long, flags); \
+					  set_signals(flags); } while (0)
+
+#define raw_local_irq_save(flags) do { raw_local_save_flags(flags); \
+				       raw_local_irq_disable(); } while (0)
+
+#define raw_local_irq_enable() unblock_signals()
+#define raw_local_irq_disable() block_signals()
+
+static inline int raw_irqs_disabled_flags(unsigned long flags)
+{
+	return (flags == 0);
+}
+
+static inline int raw_irqs_disabled(void)
+{
+	unsigned long flags;
+	raw_local_save_flags(flags);
+	return raw_irqs_disabled_flags(flags);
+}
 
 extern void *_switch_to(void *prev, void *next, void *last);
 #define switch_to(prev, next, last) prev = _switch_to(prev, next, last)
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 454cdb4..f7374a2 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -80,6 +80,7 @@ void sigio_handler(int sig, struct uml_pt_regs *regs)
 	if (smp_sigio_handler())
 		return;
 
+	trace_hardirqs_off();
 	while (1) {
 		n = os_waiting_for_events(active_fds);
 		if (n <= 0) {
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 4a28a15..c55debf 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -450,4 +450,3 @@ int elf_core_copy_fpregs(struct task_struct *t, elf_fpregset_t *fpu)
 
 	return save_fp_registers(userspace_pid[cpu], (unsigned long *) fpu);
 }
-
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index 2e9852c..4a21c5c 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -35,7 +35,7 @@ static int __init start_kernel_proc(void *unused)
 {
 	int pid;
 
-	block_signals();
+	local_irq_disable();
 	pid = os_getpid();
 
 	cpu_tasks[0].pid = pid;


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

