Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTqx-005UJA-3x
 for linux-um@lists.infradead.org; Wed, 03 Mar 2021 15:56:07 +0000
From: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 01/27] um: Switch printk calls to adhere to correct coding
 style
Date: Wed,  3 Mar 2021 16:54:57 +0100
Message-Id: <20210303155523.124277-2-benjamin@sipsolutions.net>
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

This means having the string literal in one line and using __func__
where appropriate.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/kernel/exec.c           |   4 +-
 arch/um/os-Linux/skas/mem.c     |  19 +++--
 arch/um/os-Linux/skas/process.c | 121 ++++++++++++++++----------------
 3 files changed, 69 insertions(+), 75 deletions(-)

diff --git a/arch/um/kernel/exec.c b/arch/um/kernel/exec.c
index 4d8498100341..cd05bf98265d 100644
--- a/arch/um/kernel/exec.c
+++ b/arch/um/kernel/exec.c
@@ -28,8 +28,8 @@ void flush_thread(void)
 
 	ret = unmap(&current->mm->context.id, 0, TASK_SIZE, 1, &data);
 	if (ret) {
-		printk(KERN_ERR "flush_thread - clearing address space failed, "
-		       "err = %d\n", ret);
+		printk(KERN_ERR "%s - clearing address space failed, err = %d\n",
+		       __func__, ret);
 		force_sig(SIGKILL);
 	}
 	get_safe_registers(current_pt_regs()->regs.gp,
diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index 3b4975ee67e2..953fb10f3f93 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -60,8 +60,8 @@ static inline long do_syscall_stub(struct mm_id * mm_idp, void **addr)
 		printk(UM_KERN_ERR "Registers - \n");
 		for (i = 0; i < MAX_REG_NR; i++)
 			printk(UM_KERN_ERR "\t%d\t0x%lx\n", i, syscall_regs[i]);
-		panic("do_syscall_stub : PTRACE_SETREGS failed, errno = %d\n",
-		      -n);
+		panic("%s : PTRACE_SETREGS failed, errno = %d\n",
+		      __func__, -n);
 	}
 
 	err = ptrace(PTRACE_CONT, pid, 0, 0);
@@ -81,20 +81,17 @@ static inline long do_syscall_stub(struct mm_id * mm_idp, void **addr)
 	offset = *((unsigned long *) mm_idp->stack + 1);
 	if (offset) {
 		data = (unsigned long *)(mm_idp->stack + offset - STUB_DATA);
-		printk(UM_KERN_ERR "do_syscall_stub : ret = %ld, offset = %ld, "
-		       "data = %p\n", ret, offset, data);
+		printk(UM_KERN_ERR "%s : ret = %ld, offset = %ld, data = %p\n",
+		       __func__, ret, offset, data);
 		syscall = (unsigned long *)((unsigned long)data + data[0]);
-		printk(UM_KERN_ERR "do_syscall_stub: syscall %ld failed, "
-		       "return value = 0x%lx, expected return value = 0x%lx\n",
-		       syscall[0], ret, syscall[7]);
-		printk(UM_KERN_ERR "    syscall parameters: "
-		       "0x%lx 0x%lx 0x%lx 0x%lx 0x%lx 0x%lx\n",
+		printk(UM_KERN_ERR "%s: syscall %ld failed, return value = 0x%lx, expected return value = 0x%lx\n",
+		       __func__, syscall[0], ret, syscall[7]);
+		printk(UM_KERN_ERR "    syscall parameters: 0x%lx 0x%lx 0x%lx 0x%lx 0x%lx 0x%lx\n",
 		       syscall[1], syscall[2], syscall[3],
 		       syscall[4], syscall[5], syscall[6]);
 		for (n = 1; n < data[0]/sizeof(long); n++) {
 			if (n == 1)
-				printk(UM_KERN_ERR "    additional syscall "
-				       "data:");
+				printk(UM_KERN_ERR "    additional syscall data:");
 			if (n % 4 == 1)
 				printk("\n" UM_KERN_ERR "      ");
 			printk("  0x%lx", data[n]);
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index fba674fac8b7..8c524e27571c 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -117,8 +117,8 @@ void wait_stub_done(int pid)
 
 		err = ptrace(PTRACE_CONT, pid, 0, 0);
 		if (err) {
-			printk(UM_KERN_ERR "wait_stub_done : continue failed, "
-			       "errno = %d\n", errno);
+			printk(UM_KERN_ERR "%s : continue failed, errno = %d\n",
+			       __func__, errno);
 			fatal_sigsegv();
 		}
 	}
@@ -129,11 +129,10 @@ void wait_stub_done(int pid)
 bad_wait:
 	err = ptrace_dump_regs(pid);
 	if (err)
-		printk(UM_KERN_ERR "Failed to get registers from stub, "
-		       "errno = %d\n", -err);
-	printk(UM_KERN_ERR "wait_stub_done : failed to wait for SIGTRAP, "
-	       "pid = %d, n = %d, errno = %d, status = 0x%x\n", pid, n, errno,
-	       status);
+		printk(UM_KERN_ERR "Failed to get registers from stub, errno = %d\n",
+		       -err);
+	printk(UM_KERN_ERR "%s : failed to wait for SIGTRAP, pid = %d, n = %d, errno = %d, status = 0x%x\n",
+	       __func__, pid, n, errno, status);
 	fatal_sigsegv();
 }
 
@@ -194,15 +193,15 @@ static void handle_trap(int pid, struct uml_pt_regs *regs,
 		err = ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_NR_OFFSET,
 			     __NR_getpid);
 		if (err < 0) {
-			printk(UM_KERN_ERR "handle_trap - nullifying syscall "
-			       "failed, errno = %d\n", errno);
+			printk(UM_KERN_ERR "%s - nullifying syscall failed, errno = %d\n",
+			       __func__, errno);
 			fatal_sigsegv();
 		}
 
 		err = ptrace(PTRACE_SYSCALL, pid, 0, 0);
 		if (err < 0) {
-			printk(UM_KERN_ERR "handle_trap - continuing to end of "
-			       "syscall failed, errno = %d\n", errno);
+			printk(UM_KERN_ERR "%s - continuing to end of syscall failed, errno = %d\n",
+			       __func__, errno);
 			fatal_sigsegv();
 		}
 
@@ -211,11 +210,10 @@ static void handle_trap(int pid, struct uml_pt_regs *regs,
 		    (WSTOPSIG(status) != SIGTRAP + 0x80)) {
 			err = ptrace_dump_regs(pid);
 			if (err)
-				printk(UM_KERN_ERR "Failed to get registers "
-				       "from process, errno = %d\n", -err);
-			printk(UM_KERN_ERR "handle_trap - failed to wait at "
-			       "end of syscall, errno = %d, status = %d\n",
-			       errno, status);
+				printk(UM_KERN_ERR "Failed to get registers from process, errno = %d\n",
+				       -err);
+			printk(UM_KERN_ERR "%s - failed to wait at end of syscall, errno = %d, status = %d\n",
+			       __func__, errno, status);
 			fatal_sigsegv();
 		}
 	}
@@ -255,8 +253,8 @@ static int userspace_tramp(void *stack)
 	addr = mmap64((void *) STUB_CODE, UM_KERN_PAGE_SIZE,
 		      PROT_EXEC, MAP_FIXED | MAP_PRIVATE, fd, offset);
 	if (addr == MAP_FAILED) {
-		printk(UM_KERN_ERR "mapping mmap stub at 0x%lx failed, "
-		       "errno = %d\n", STUB_CODE, errno);
+		printk(UM_KERN_ERR "mapping mmap stub at 0x%lx failed, errno = %d\n",
+		       STUB_CODE, errno);
 		exit(1);
 	}
 
@@ -266,8 +264,7 @@ static int userspace_tramp(void *stack)
 			    UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
 			    MAP_FIXED | MAP_SHARED, fd, offset);
 		if (addr == MAP_FAILED) {
-			printk(UM_KERN_ERR "mapping segfault stack "
-			       "at 0x%lx failed, errno = %d\n",
+			printk(UM_KERN_ERR "mapping segfault stack at 0x%lx failed, errno = %d\n",
 			       STUB_DATA, errno);
 			exit(1);
 		}
@@ -285,8 +282,8 @@ static int userspace_tramp(void *stack)
 		sa.sa_sigaction = (void *) v;
 		sa.sa_restorer = NULL;
 		if (sigaction(SIGSEGV, &sa, NULL) < 0) {
-			printk(UM_KERN_ERR "userspace_tramp - setting SIGSEGV "
-			       "handler failed - errno = %d\n", errno);
+			printk(UM_KERN_ERR "%s - setting SIGSEGV handler failed - errno = %d\n",
+			       __func__, errno);
 			exit(1);
 		}
 	}
@@ -321,8 +318,8 @@ int start_userspace(unsigned long stub_stack)
 		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	if (stack == MAP_FAILED) {
 		err = -errno;
-		printk(UM_KERN_ERR "start_userspace : mmap failed, "
-		       "errno = %d\n", errno);
+		printk(UM_KERN_ERR "%s : mmap failed, errno = %d\n",
+		       __func__, errno);
 		return err;
 	}
 
@@ -335,8 +332,8 @@ int start_userspace(unsigned long stub_stack)
 	pid = clone(userspace_tramp, (void *) sp, flags, (void *) stub_stack);
 	if (pid < 0) {
 		err = -errno;
-		printk(UM_KERN_ERR "start_userspace : clone failed, "
-		       "errno = %d\n", errno);
+		printk(UM_KERN_ERR "%s : clone failed, errno = %d\n",
+		       __func__, errno);
 		return err;
 	}
 
@@ -344,31 +341,31 @@ int start_userspace(unsigned long stub_stack)
 		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED | __WALL));
 		if (n < 0) {
 			err = -errno;
-			printk(UM_KERN_ERR "start_userspace : wait failed, "
-			       "errno = %d\n", errno);
+			printk(UM_KERN_ERR "%s : wait failed, errno = %d\n",
+			       __func__, errno);
 			goto out_kill;
 		}
 	} while (WIFSTOPPED(status) && (WSTOPSIG(status) == SIGALRM));
 
 	if (!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP)) {
 		err = -EINVAL;
-		printk(UM_KERN_ERR "start_userspace : expected SIGSTOP, got "
-		       "status = %d\n", status);
+		printk(UM_KERN_ERR "%s : expected SIGSTOP, got status = %d\n",
+		       __func__, status);
 		goto out_kill;
 	}
 
 	if (ptrace(PTRACE_OLDSETOPTIONS, pid, NULL,
 		   (void *) PTRACE_O_TRACESYSGOOD) < 0) {
 		err = -errno;
-		printk(UM_KERN_ERR "start_userspace : PTRACE_OLDSETOPTIONS "
-		       "failed, errno = %d\n", errno);
+		printk(UM_KERN_ERR "%s : PTRACE_OLDSETOPTIONS failed, errno = %d\n",
+		       __func__, errno);
 		goto out_kill;
 	}
 
 	if (munmap(stack, UM_KERN_PAGE_SIZE) < 0) {
 		err = -errno;
-		printk(UM_KERN_ERR "start_userspace : munmap failed, "
-		       "errno = %d\n", errno);
+		printk(UM_KERN_ERR "%s : munmap failed, errno = %d\n",
+		       __func__, errno);
 		goto out_kill;
 	}
 
@@ -402,14 +399,14 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 		 * just kill the process.
 		 */
 		if (ptrace(PTRACE_SETREGS, pid, 0, regs->gp)) {
-			printk(UM_KERN_ERR "userspace - ptrace set regs "
-			       "failed, errno = %d\n", errno);
+			printk(UM_KERN_ERR "%s - ptrace set regs failed, errno = %d\n",
+			       __func__, errno);
 			fatal_sigsegv();
 		}
 
 		if (put_fp_registers(pid, regs->fp)) {
-			printk(UM_KERN_ERR "userspace - ptrace set fp regs "
-			       "failed, errno = %d\n", errno);
+			printk(UM_KERN_ERR "%s - ptrace set fp regs failed, errno = %d\n",
+			       __func__, errno);
 			fatal_sigsegv();
 		}
 
@@ -420,28 +417,28 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 					     singlestepping(NULL));
 
 		if (ptrace(op, pid, 0, 0)) {
-			printk(UM_KERN_ERR "userspace - ptrace continue "
-			       "failed, op = %d, errno = %d\n", op, errno);
+			printk(UM_KERN_ERR "%s - ptrace continue failed, op = %d, errno = %d\n",
+			       __func__, op, errno);
 			fatal_sigsegv();
 		}
 
 		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED | __WALL));
 		if (err < 0) {
-			printk(UM_KERN_ERR "userspace - wait failed, "
-			       "errno = %d\n", errno);
+			printk(UM_KERN_ERR "%s - wait failed, errno = %d\n",
+			       __func__, errno);
 			fatal_sigsegv();
 		}
 
 		regs->is_user = 1;
 		if (ptrace(PTRACE_GETREGS, pid, 0, regs->gp)) {
-			printk(UM_KERN_ERR "userspace - PTRACE_GETREGS failed, "
-			       "errno = %d\n", errno);
+			printk(UM_KERN_ERR "%s - PTRACE_GETREGS failed, errno = %d\n",
+			       __func__, errno);
 			fatal_sigsegv();
 		}
 
 		if (get_fp_registers(pid, regs->fp)) {
-			printk(UM_KERN_ERR "userspace -  get_fp_registers failed, "
-			       "errno = %d\n", errno);
+			printk(UM_KERN_ERR "%s -  get_fp_registers failed, errno = %d\n",
+			       __func__, errno);
 			fatal_sigsegv();
 		}
 
@@ -493,8 +490,8 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 				unblock_signals_trace();
 				break;
 			default:
-				printk(UM_KERN_ERR "userspace - child stopped "
-				       "with signal %d\n", sig);
+				printk(UM_KERN_ERR "%s - child stopped with signal %d\n",
+				       __func__, sig);
 				fatal_sigsegv();
 			}
 			pid = userspace_pid[0];
@@ -554,15 +551,15 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 	err = ptrace_setregs(pid, thread_regs);
 	if (err < 0) {
 		err = -errno;
-		printk(UM_KERN_ERR "copy_context_skas0 : PTRACE_SETREGS "
-		       "failed, pid = %d, errno = %d\n", pid, -err);
+		printk(UM_KERN_ERR "%s : PTRACE_SETREGS failed, pid = %d, errno = %d\n",
+		      __func__, pid, -err);
 		return err;
 	}
 
 	err = put_fp_registers(pid, thread_fp_regs);
 	if (err < 0) {
-		printk(UM_KERN_ERR "copy_context_skas0 : put_fp_registers "
-		       "failed, pid = %d, err = %d\n", pid, err);
+		printk(UM_KERN_ERR "%s : put_fp_registers failed, pid = %d, err = %d\n",
+		       __func__, pid, err);
 		return err;
 	}
 
@@ -573,8 +570,8 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 	err = ptrace(PTRACE_CONT, pid, 0, 0);
 	if (err) {
 		err = -errno;
-		printk(UM_KERN_ERR "Failed to continue new process, pid = %d, "
-		       "errno = %d\n", pid, errno);
+		printk(UM_KERN_ERR "Failed to continue new process, pid = %d, errno = %d\n",
+		       pid, errno);
 		return err;
 	}
 
@@ -582,8 +579,8 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 
 	pid = data->parent_err;
 	if (pid < 0) {
-		printk(UM_KERN_ERR "copy_context_skas0 - stub-parent reports "
-		       "error %d\n", -pid);
+		printk(UM_KERN_ERR "%s - stub-parent reports error %d\n",
+		      __func__, -pid);
 		return pid;
 	}
 
@@ -593,8 +590,8 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 	 */
 	wait_stub_done(pid);
 	if (child_data->child_err != STUB_DATA) {
-		printk(UM_KERN_ERR "copy_context_skas0 - stub-child %d reports "
-		       "error %ld\n", pid, data->child_err);
+		printk(UM_KERN_ERR "%s - stub-child %d reports error %ld\n",
+		       __func__, pid, data->child_err);
 		err = data->child_err;
 		goto out_kill;
 	}
@@ -602,8 +599,8 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 	if (ptrace(PTRACE_OLDSETOPTIONS, pid, NULL,
 		   (void *)PTRACE_O_TRACESYSGOOD) < 0) {
 		err = -errno;
-		printk(UM_KERN_ERR "copy_context_skas0 : PTRACE_OLDSETOPTIONS "
-		       "failed, errno = %d\n", errno);
+		printk(UM_KERN_ERR "%s : PTRACE_OLDSETOPTIONS failed, errno = %d\n",
+		       __func__, errno);
 		goto out_kill;
 	}
 
@@ -671,8 +668,8 @@ int start_idle_thread(void *stack, jmp_buf *switch_buf)
 		kmalloc_ok = 0;
 		return 1;
 	default:
-		printk(UM_KERN_ERR "Bad sigsetjmp return in "
-		       "start_idle_thread - %d\n", n);
+		printk(UM_KERN_ERR "Bad sigsetjmp return in %s - %d\n",
+		       __func__, n);
 		fatal_sigsegv();
 	}
 	longjmp(*switch_buf, 1);
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

