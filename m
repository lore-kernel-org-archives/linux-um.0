Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqztK-00058r-TP
 for linux-um@lists.infradead.org; Thu, 02 Jul 2020 14:08:43 +0000
Received: by mail-pf1-x442.google.com with SMTP id u5so12599233pfn.7
 for <linux-um@lists.infradead.org>; Thu, 02 Jul 2020 07:08:42 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v5 07/21] um: extend arch_switch_to for alternate SUBARCH
Date: Thu,  2 Jul 2020 23:07:01 +0900
Message-Id: <fa68d878ff34be60075693cd19ad2bec63dec788.1593697069.git.thehajime@gmail.com>
In-Reply-To: <cover.1593697069.git.thehajime@gmail.com>
References: <cover.1593697069.git.thehajime@gmail.com>
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
Cc: Octavian Purdila <tavi.purdila@gmail.com>, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, Hajime Tazaki <thehajime@gmail.com>, Akira Moroo <retrage01@gmail.com>

This commit introduces additional argument of previous task when
context switch happens.  New SUBARCH can use the new information to
switch tasks in a subarch-specific manner.

The patch is particularly required by nommu mode implemented as a
SUBARCH of UML.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/kernel/process.c  | 6 +++---
 arch/x86/um/ptrace_32.c   | 2 +-
 arch/x86/um/syscalls_64.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index cbe33af2a880..e5238a42ea17 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -81,7 +81,7 @@ static inline void set_current(struct task_struct *task)
 		{ external_pid(), task });
 }
 
-extern void arch_switch_to(struct task_struct *to);
+extern void arch_switch_to(struct task_struct *from, struct task_struct *to);
 
 void *__switch_to(struct task_struct *from, struct task_struct *to)
 {
@@ -89,7 +89,7 @@ void *__switch_to(struct task_struct *from, struct task_struct *to)
 	set_current(to);
 
 	switch_threads(&from->thread.switch_buf, &to->thread.switch_buf);
-	arch_switch_to(current);
+	arch_switch_to(from, to);
 
 	return current->thread.prev_sched;
 }
@@ -146,7 +146,7 @@ void fork_handler(void)
 	 * arch_switch_to isn't needed. We could want to apply this to
 	 * improve performance. -bb
 	 */
-	arch_switch_to(current);
+	arch_switch_to(NULL, current);
 
 	current->thread.prev_sched = NULL;
 
diff --git a/arch/x86/um/ptrace_32.c b/arch/x86/um/ptrace_32.c
index 2497bac56066..0f184710d4ca 100644
--- a/arch/x86/um/ptrace_32.c
+++ b/arch/x86/um/ptrace_32.c
@@ -11,7 +11,7 @@
 
 extern int arch_switch_tls(struct task_struct *to);
 
-void arch_switch_to(struct task_struct *to)
+void arch_switch_to(struct task_struct *from, struct task_struct *to)
 {
 	int err = arch_switch_tls(to);
 	if (!err)
diff --git a/arch/x86/um/syscalls_64.c b/arch/x86/um/syscalls_64.c
index 58f51667e2e4..2ef9474d2bd2 100644
--- a/arch/x86/um/syscalls_64.c
+++ b/arch/x86/um/syscalls_64.c
@@ -80,7 +80,7 @@ SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
 	return arch_prctl(current, option, (unsigned long __user *) arg2);
 }
 
-void arch_switch_to(struct task_struct *to)
+void arch_switch_to(struct task_struct *from, struct task_struct *to)
 {
 	if ((to->thread.arch.fs == 0) || (to->mm == NULL))
 		return;
-- 
2.21.0 (Apple Git-122.2)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

