Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FOO7z-0004PD-7w for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 16:01:35 -0800
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FOO7y-0003GB-MJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 16:01:35 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060328235702.13838.48788.stgit@zion.home.lan>
In-Reply-To: <20060328235442.13838.26861.stgit@zion.home.lan>
References: <20060328235442.13838.26861.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 6/7] uml: add arch_switch_to for newly forked
	thread
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 29 Mar 2006 01:57:03 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Newly forked threads have no arch_switch_to_skas() called before their first
run, because when schedule() switches to them they're resumed in the body of
thread_wait() inside fork_handler() rather than in switch_threads() in
switch_to_skas().
Compensate this missing call.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/skas/process_kern.c |    7 +++++++
 arch/um/sys-i386/ptrace.c          |    9 ++++++++-
 arch/um/sys-i386/tls.c             |   13 ++++++++++---
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/um/kernel/skas/process_kern.c b/arch/um/kernel/skas/process_kern.c
index 38b1853..2135eaf 100644
--- a/arch/um/kernel/skas/process_kern.c
+++ b/arch/um/kernel/skas/process_kern.c
@@ -91,10 +91,17 @@ void fork_handler(int sig)
 		panic("blech");
 
 	schedule_tail(current->thread.prev_sched);
+
+	/* XXX: if interrupt_end() calls schedule, this call to
+	 * arch_switch_to_skas isn't needed. We could want to apply this to
+	 * improve performance. -bb */
+	arch_switch_to_skas(current->thread.prev_sched, current);
+
 	current->thread.prev_sched = NULL;
 
 /* Handle any immediate reschedules or signals */
 	interrupt_end();
+
 	userspace(&current->thread.regs.regs);
 }
 
diff --git a/arch/um/sys-i386/ptrace.c b/arch/um/sys-i386/ptrace.c
index b587b4b..ce71923 100644
--- a/arch/um/sys-i386/ptrace.c
+++ b/arch/um/sys-i386/ptrace.c
@@ -23,7 +23,14 @@ void arch_switch_to_tt(struct task_struc
 
 void arch_switch_to_skas(struct task_struct *from, struct task_struct *to)
 {
-	arch_switch_tls_skas(from, to);
+	int err = arch_switch_tls_skas(from, to);
+	if (!err)
+		return;
+
+	if (err != -EINVAL)
+		printk(KERN_WARNING "arch_switch_tls_skas failed, errno %d, not EINVAL\n", -err);
+	else
+		printk(KERN_WARNING "arch_switch_tls_skas failed, errno = EINVAL\n");
 }
 
 int is_syscall(unsigned long addr)
diff --git a/arch/um/sys-i386/tls.c b/arch/um/sys-i386/tls.c
index e3c5bc5..2251654 100644
--- a/arch/um/sys-i386/tls.c
+++ b/arch/um/sys-i386/tls.c
@@ -70,8 +70,6 @@ static int get_free_idx(struct task_stru
 	return -ESRCH;
 }
 
-#define O_FORCE 1
-
 static inline void clear_user_desc(struct user_desc* info)
 {
 	/* Postcondition: LDT_empty(info) returns true. */
@@ -84,6 +82,8 @@ static inline void clear_user_desc(struc
 	info->seg_not_present = 1;
 }
 
+#define O_FORCE 1
+
 static int load_TLS(int flags, struct task_struct *to)
 {
 	int ret = 0;
@@ -162,7 +162,13 @@ void clear_flushed_tls(struct task_struc
  * SKAS patch. */
 int arch_switch_tls_skas(struct task_struct *from, struct task_struct *to)
 {
-	return load_TLS(O_FORCE, to);
+	/* We have no need whatsoever to switch TLS for kernel threads; beyond
+	 * that, that would also result in us calling os_set_thread_area with
+	 * userspace_pid[cpu] == 0, which gives an error. */
+	if (likely(to->mm))
+		return load_TLS(O_FORCE, to);
+
+	return 0;
 }
 
 int arch_switch_tls_tt(struct task_struct *from, struct task_struct *to)
@@ -324,3 +330,4 @@ int ptrace_get_thread_area(struct task_s
 out:
 	return ret;
 }
+


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
