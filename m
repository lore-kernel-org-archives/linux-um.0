Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTwh-005VfJ-T9
 for linux-um@lists.infradead.org; Wed, 03 Mar 2021 16:01:58 +0000
From: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 18/27] um: Pass full mm_id to functions creating helper
 processes
Date: Wed,  3 Mar 2021 16:55:14 +0100
Message-Id: <20210303155523.124277-19-benjamin@sipsolutions.net>
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

For seccomp, we need all information about the original process in
copy_context_skas0. For consistency, change both copy_context_skas0 and
start_userspace to take the mm_id struct as parameter and directly set
PID in addition to returning it.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/include/shared/os.h     |  4 +--
 arch/um/kernel/skas/mmu.c       |  6 ++--
 arch/um/os-Linux/skas/process.c | 54 ++++++++++++++++-----------------
 3 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 632c83d83c8d..8514d90cd5fa 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -282,8 +282,8 @@ void protect(struct mm_id *mm_idp, unsigned long addr,
 
 /* skas/process.c */
 extern int is_skas_winch(int pid, int fd, void *data);
-extern int start_userspace(unsigned long stub_stack);
-extern int copy_context_skas0(unsigned long stack, int pid);
+extern int start_userspace(struct mm_id *id);
+extern int copy_context_skas0(struct mm_id *id, struct mm_id *from);
 extern void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs);
 extern int map_stub_pages(int fd, unsigned long code, unsigned long data,
 			  unsigned long stack);
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 125df465e8ea..3f8fe6350234 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -31,9 +31,9 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 
 	block_signals_trace();
 	if (from_mm)
-		to_mm->id.u.pid = copy_context_skas0(stack,
-						     from_mm->id.u.pid);
-	else to_mm->id.u.pid = start_userspace(stack);
+		copy_context_skas0(&to_mm->id, &from_mm->id);
+	else
+		start_userspace(&to_mm->id);
 	unblock_signals_trace();
 
 	if (to_mm->id.u.pid < 0) {
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 5a66d6558851..08ce1798ee96 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -271,11 +271,11 @@ int kill_userspace_mm[NR_CPUS];
  *         when negative: an error number.
  * FIXME: can PIDs become negative?!
  */
-int start_userspace(unsigned long stub_stack)
+int start_userspace(struct mm_id *id)
 {
 	void *stack;
 	unsigned long sp;
-	int pid, status, n, flags, err;
+	int status, n, flags, err;
 
 	/* setup a temporary stack page */
 	stack = mmap(NULL, UM_KERN_PAGE_SIZE,
@@ -294,8 +294,8 @@ int start_userspace(unsigned long stub_stack)
 	flags = CLONE_FILES | SIGCHLD;
 
 	/* clone into new userspace process */
-	pid = clone(userspace_tramp, (void *) sp, flags, (void *) stub_stack);
-	if (pid < 0) {
+	id->u.pid = clone(userspace_tramp, (void *) sp, flags, (void *) id->stack);
+	if (id->u.pid < 0) {
 		err = -errno;
 		printk(UM_KERN_ERR "%s : clone failed, errno = %d\n",
 		       __func__, errno);
@@ -303,7 +303,7 @@ int start_userspace(unsigned long stub_stack)
 	}
 
 	do {
-		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED | __WALL));
+		CATCH_EINTR(n = waitpid(id->u.pid, &status, WUNTRACED | __WALL));
 		if (n < 0) {
 			err = -errno;
 			printk(UM_KERN_ERR "%s : wait failed, errno = %d\n",
@@ -319,7 +319,7 @@ int start_userspace(unsigned long stub_stack)
 		goto out_kill;
 	}
 
-	if (ptrace(PTRACE_SETOPTIONS, pid, NULL,
+	if (ptrace(PTRACE_SETOPTIONS, id->u.pid, NULL,
 		   (void *) PTRACE_O_TRACESYSGOOD) < 0) {
 		err = -errno;
 		printk(UM_KERN_ERR "%s : PTRACE_OLDSETOPTIONS failed, errno = %d\n",
@@ -334,10 +334,10 @@ int start_userspace(unsigned long stub_stack)
 		goto out_kill;
 	}
 
-	return pid;
+	return id->u.pid;
 
  out_kill:
-	os_kill_ptraced_process(pid, 1);
+	os_kill_ptraced_process(id->u.pid, 1);
 	return err;
 }
 
@@ -486,14 +486,14 @@ static int __init init_thread_regs(void)
 
 __initcall(init_thread_regs);
 
-int copy_context_skas0(unsigned long new_stack, int pid)
+int copy_context_skas0(struct mm_id *id, struct mm_id *from)
 {
 	int err;
 	unsigned long current_stack = current_stub_stack();
 	struct stub_data *data = (struct stub_data *) current_stack;
-	struct stub_data *child_data = (struct stub_data *) new_stack;
+	struct stub_data *child_data = (struct stub_data *) id->stack;
 	unsigned long long new_offset;
-	int new_fd = phys_mapping(to_phys((void *)new_stack), &new_offset);
+	int new_fd = phys_mapping(to_phys((void *)id->stack), &new_offset);
 
 	/*
 	 * prepare offset and fd of child's stack as argument for parent's
@@ -510,18 +510,18 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 		.child_err = -ESRCH,
 	});
 
-	err = ptrace_setregs(pid, thread_regs);
+	err = ptrace_setregs(from->u.pid, thread_regs);
 	if (err < 0) {
 		err = -errno;
 		printk(UM_KERN_ERR "%s : PTRACE_SETREGS failed, pid = %d, errno = %d\n",
-		      __func__, pid, -err);
+		      __func__, from->u.pid, -err);
 		return err;
 	}
 
-	err = put_fp_registers(pid, thread_fp_regs);
+	err = put_fp_registers(from->u.pid, thread_fp_regs);
 	if (err < 0) {
 		printk(UM_KERN_ERR "%s : put_fp_registers failed, pid = %d, err = %d\n",
-		       __func__, pid, err);
+		       __func__, from->u.pid, err);
 		return err;
 	}
 
@@ -529,36 +529,36 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 	 * Wait, until parent has finished its work: read child's pid from
 	 * parent's stack, and check, if bad result.
 	 */
-	err = ptrace(PTRACE_CONT, pid, 0, 0);
+	err = ptrace(PTRACE_CONT, from->u.pid, 0, 0);
 	if (err) {
 		err = -errno;
 		printk(UM_KERN_ERR "Failed to continue new process, pid = %d, errno = %d\n",
-		       pid, errno);
+		       from->u.pid, errno);
 		return err;
 	}
 
-	wait_stub_done(pid);
+	wait_stub_done(from->u.pid);
 
-	pid = data->err;
-	if (pid < 0) {
+	id->u.pid = data->err;
+	if (id->u.pid < 0) {
 		printk(UM_KERN_ERR "%s - stub-parent reports error %d\n",
-		      __func__, -pid);
-		return pid;
+		      __func__, -id->u.pid);
+		return id->u.pid;
 	}
 
 	/*
 	 * Wait, until child has finished too: read child's result from
 	 * child's stack and check it.
 	 */
-	wait_stub_done(pid);
+	wait_stub_done(id->u.pid);
 	if (child_data->child_err != STUB_DATA) {
 		printk(UM_KERN_ERR "%s - stub-child %d reports error %ld\n",
-		       __func__, pid, data->child_err);
+		       __func__, id->u.pid, data->child_err);
 		err = data->child_err;
 		goto out_kill;
 	}
 
-	if (ptrace(PTRACE_SETOPTIONS, pid, NULL,
+	if (ptrace(PTRACE_SETOPTIONS, id->u.pid, NULL,
 		   (void *)PTRACE_O_TRACESYSGOOD) < 0) {
 		err = -errno;
 		printk(UM_KERN_ERR "%s : PTRACE_OLDSETOPTIONS failed, errno = %d\n",
@@ -566,10 +566,10 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 		goto out_kill;
 	}
 
-	return pid;
+	return id->u.pid;
 
  out_kill:
-	os_kill_ptraced_process(pid, 1);
+	os_kill_ptraced_process(id->u.pid, 1);
 	return err;
 }
 
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

