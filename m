Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51AFC4332F
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 10:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XMfsknU3KoQknp541Kw3r6/8zRrWyUfkADSLJw1c8I4=; b=hUe1BjUiYw4XN3
	HRAYqyTtYYig2L4ICj7izukEZLrkWhy2p9ofkHj39NOt3z+Nujn3a83v/jwEAGk3w0dYKOYmsIkkF
	3MgkyyI4NHFJeGvutiymzMqsnpGLyXCmXmlPh1KKszylE5NXKPtxqqCOEW/RurDU7/sI2roth6Z9l
	cdCEWe/2GHnU4rXDHqcrQNKRQY2dmWv2QBzmZHHo6w4F3ZsoVdm02eroeVKQNMCY5Tlc+I8XtSc1e
	9dfOmE+BzpkP9PeIItwpHmqKR7iqxn6cPLt0Zg/hlRjzFy+RZesr60s3FvJVmqTloMUXc8FsF+N//
	atsoaE9QgzwLM2RoA2kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQFQ-007g2q-Hd; Tue, 22 Nov 2022 10:11:24 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQF1-007feT-Bt
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 10:11:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JB3lfilSF1J9JO/pvnubRjhNm1U9ITXTS4W64o9aBok=;
	t=1669111856; x=1670321456; b=iuNkD5ZEvBU1eMvmT63dc+9eN3b/87v8m+gumapM5fjcrWk
	k/3t/5gvJBoeYN4RKoHNHJ9+lvEc4b2wLfBHUyN1E+SA9Z4dV5ytSLSCRSeBSeKBI/hwvw1n1Zg8i
	SUu1U23uFZQbkVb0Rc/QNKnjnhyjrXpAE8lWYNdyiz1ZJ3WCJ8KuqTQluealeS4dD7lceX8yre9dT
	tiB44Hs28yW3oDu/W0wbKgsaa0nre6tdY1w4Srj3nvWC17XwgshRrwbbtcTe/ghcA3tBoKHN+hQgY
	s/tY1+hHgb92iACiJdHOOSmpXF7EBVPP7u8AZ5cxsIWFw1iSPXDiW1UHxT8Kw8JA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1oxQEm-006IGn-1i;
	Tue, 22 Nov 2022 11:10:44 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 01/28] um: Switch printk calls to adhere to correct coding style
Date: Tue, 22 Nov 2022 11:07:32 +0100
Message-Id: <20221122100759.208290-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122100759.208290-1-benjamin@sipsolutions.net>
References: <20221122100759.208290-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_021059_734848_FE21A931 
X-CRM114-Status: GOOD (  15.23  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin@sipsolutions.net>

This means having the string literal in one line and using __func__
where appropriate.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/kernel/exec.c           |   4 +-
 arch/um/os-Linux/skas/mem.c     |  19 +++--
 arch/um/os-Linux/skas/process.c | 121 ++++++++++++++++----------------
 3 files changed, 69 insertions(+), 75 deletions(-)

diff --git a/arch/um/kernel/exec.c b/arch/um/kernel/exec.c
index 58938d75871a..827a0d3fa589 100644
--- a/arch/um/kernel/exec.c
+++ b/arch/um/kernel/exec.c
@@ -29,8 +29,8 @@ void flush_thread(void)
 
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
index b24db6017ded..b1ea53285af1 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -118,8 +118,8 @@ void wait_stub_done(int pid)
 
 		err = ptrace(PTRACE_CONT, pid, 0, 0);
 		if (err) {
-			printk(UM_KERN_ERR "wait_stub_done : continue failed, "
-			       "errno = %d\n", errno);
+			printk(UM_KERN_ERR "%s : continue failed, errno = %d\n",
+			       __func__, errno);
 			fatal_sigsegv();
 		}
 	}
@@ -130,11 +130,10 @@ void wait_stub_done(int pid)
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
 
@@ -195,15 +194,15 @@ static void handle_trap(int pid, struct uml_pt_regs *regs,
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
 
@@ -212,11 +211,10 @@ static void handle_trap(int pid, struct uml_pt_regs *regs,
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
@@ -256,8 +254,8 @@ static int userspace_tramp(void *stack)
 	addr = mmap64((void *) STUB_CODE, UM_KERN_PAGE_SIZE,
 		      PROT_EXEC, MAP_FIXED | MAP_PRIVATE, fd, offset);
 	if (addr == MAP_FAILED) {
-		printk(UM_KERN_ERR "mapping mmap stub at 0x%lx failed, "
-		       "errno = %d\n", STUB_CODE, errno);
+		printk(UM_KERN_ERR "mapping mmap stub at 0x%lx failed, errno = %d\n",
+		       STUB_CODE, errno);
 		exit(1);
 	}
 
@@ -267,8 +265,7 @@ static int userspace_tramp(void *stack)
 			    UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
 			    MAP_FIXED | MAP_SHARED, fd, offset);
 		if (addr == MAP_FAILED) {
-			printk(UM_KERN_ERR "mapping segfault stack "
-			       "at 0x%lx failed, errno = %d\n",
+			printk(UM_KERN_ERR "mapping segfault stack at 0x%lx failed, errno = %d\n",
 			       STUB_DATA, errno);
 			exit(1);
 		}
@@ -286,8 +283,8 @@ static int userspace_tramp(void *stack)
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
@@ -322,8 +319,8 @@ int start_userspace(unsigned long stub_stack)
 		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	if (stack == MAP_FAILED) {
 		err = -errno;
-		printk(UM_KERN_ERR "start_userspace : mmap failed, "
-		       "errno = %d\n", errno);
+		printk(UM_KERN_ERR "%s : mmap failed, errno = %d\n",
+		       __func__, errno);
 		return err;
 	}
 
@@ -336,8 +333,8 @@ int start_userspace(unsigned long stub_stack)
 	pid = clone(userspace_tramp, (void *) sp, flags, (void *) stub_stack);
 	if (pid < 0) {
 		err = -errno;
-		printk(UM_KERN_ERR "start_userspace : clone failed, "
-		       "errno = %d\n", errno);
+		printk(UM_KERN_ERR "%s : clone failed, errno = %d\n",
+		       __func__, errno);
 		return err;
 	}
 
@@ -345,31 +342,31 @@ int start_userspace(unsigned long stub_stack)
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
 
@@ -403,14 +400,14 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
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
 
@@ -421,28 +418,28 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
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
 
@@ -494,8 +491,8 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
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
@@ -555,15 +552,15 @@ int copy_context_skas0(unsigned long new_stack, int pid)
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
 
@@ -574,8 +571,8 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 	err = ptrace(PTRACE_CONT, pid, 0, 0);
 	if (err) {
 		err = -errno;
-		printk(UM_KERN_ERR "Failed to continue new process, pid = %d, "
-		       "errno = %d\n", pid, errno);
+		printk(UM_KERN_ERR "Failed to continue new process, pid = %d, errno = %d\n",
+		       pid, errno);
 		return err;
 	}
 
@@ -583,8 +580,8 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 
 	pid = data->parent_err;
 	if (pid < 0) {
-		printk(UM_KERN_ERR "copy_context_skas0 - stub-parent reports "
-		       "error %d\n", -pid);
+		printk(UM_KERN_ERR "%s - stub-parent reports error %d\n",
+		      __func__, -pid);
 		return pid;
 	}
 
@@ -594,8 +591,8 @@ int copy_context_skas0(unsigned long new_stack, int pid)
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
@@ -603,8 +600,8 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 	if (ptrace(PTRACE_OLDSETOPTIONS, pid, NULL,
 		   (void *)PTRACE_O_TRACESYSGOOD) < 0) {
 		err = -errno;
-		printk(UM_KERN_ERR "copy_context_skas0 : PTRACE_OLDSETOPTIONS "
-		       "failed, errno = %d\n", errno);
+		printk(UM_KERN_ERR "%s : PTRACE_OLDSETOPTIONS failed, errno = %d\n",
+		       __func__, errno);
 		goto out_kill;
 	}
 
@@ -672,8 +669,8 @@ int start_idle_thread(void *stack, jmp_buf *switch_buf)
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
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
