Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD813C04FF8
	for <linux-um@archiver.kernel.org>; Thu, 18 Apr 2024 09:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cZJr/itt6AGI6qV5OZKLhUEPuP/79ht/6lzAeJhcYVA=; b=wapvL2mnFlHaIa4CAdhYtdZdAc
	0iAinI6cPbW3BSTVEI7VVEQluGdgahQLIRa9QvkKFx8L6ktuyS4ZCD+OYz/LukCOPQnjWLluk9MEH
	ZuhSgAjBYrSVhGDgtACJvuvybqFSBXkYl7mNz9WXTediklwqSeH4PsE56lrmSHUuPJ5bPNLmAwNR7
	PNP/Veel+leV1+qjnSEipYPK+Fb9y1n8shFh1V0fjdz3uiB4T5kywrOCfwIBI4J4uXdmV2Zhk1hmn
	9l5bhgE9QquVzhVjJ5i+JyYcXMhaAe92aT2sR8IYUegjlB671E3vc7TcZqOeE8KeyfawQAa2FBban
	/txY4StQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxO0w-00000001bPL-0glu;
	Thu, 18 Apr 2024 09:25:06 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxO0p-00000001bHW-08Gr
	for linux-um@lists.infradead.org;
	Thu, 18 Apr 2024 09:25:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cZJr/itt6AGI6qV5OZKLhUEPuP/79ht/6lzAeJhcYVA=;
	t=1713432298; x=1714641898; b=WUqhiV8zui+EdSmscw93X88YIErStZvWvJFJo8T8QDl1n6C
	1+PsJrN2EmQuM0WdOzJ2E/FceoJPC6sZcnTHvwv3O2aa5s99cLC1TGjCGQpOVDx0Krz4xY4tYfqoo
	c5L331EnWtC5ztU5e6hPhgUjtX1UHUXzKFyPRKkvvi7/rOx7+8T1D8DmEckB261FVd8eODmyH/OAv
	PIMQIiEQXSia8hDXfU25COGFp1ZLocBvbRondI8QPtoJLvLFcJq+v3Cdcjv54K2gwH9vAeumseRk9
	bodHqVuJunzydrhY8eGJPQiyM1JaBFtVjIDgxz+zFe5RXYIaMQMrbOyXNaEdh9bg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1rxO0m-0000000CKXH-2leW;
	Thu, 18 Apr 2024 11:24:56 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 07/12] um: remove copy_context_skas0
Date: Thu, 18 Apr 2024 11:23:22 +0200
Message-ID: <20240418092327.860135-8-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418092327.860135-1-benjamin@sipsolutions.net>
References: <20240418092327.860135-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_022459_592569_2BA4EB89 
X-CRM114-Status: GOOD (  19.54  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin.berg@intel.com>

The kernel flushes the memory ranges anyway for CoW and does not assume
that the userspace process has anything set up already. So, start with a
fresh process for the new mm context.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/include/shared/os.h     |   1 -
 arch/um/kernel/skas/Makefile    |   8 +--
 arch/um/kernel/skas/clone.c     |  50 ---------------
 arch/um/kernel/skas/mmu.c       |  20 +++---
 arch/um/os-Linux/skas/process.c | 108 --------------------------------
 5 files changed, 10 insertions(+), 177 deletions(-)
 delete mode 100644 arch/um/kernel/skas/clone.c

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 16d726f3df84..dc341ed4724e 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -281,7 +281,6 @@ void protect(struct mm_id *mm_idp, unsigned long addr,
 /* skas/process.c */
 extern int is_skas_winch(int pid, int fd, void *data);
 extern int start_userspace(unsigned long stub_stack);
-extern int copy_context_skas0(unsigned long stack, int pid);
 extern void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs);
 extern void new_thread(void *stack, jmp_buf *buf, void (*handler)(void));
 extern void switch_threads(jmp_buf *me, jmp_buf *you);
diff --git a/arch/um/kernel/skas/Makefile b/arch/um/kernel/skas/Makefile
index dd8bc2167e36..6f86d53e3d69 100644
--- a/arch/um/kernel/skas/Makefile
+++ b/arch/um/kernel/skas/Makefile
@@ -3,16 +3,14 @@
 # Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
 #
 
-obj-y := clone.o stub.o mmu.o process.o syscall.o uaccess.o
+obj-y := stub.o mmu.o process.o syscall.o uaccess.o
 
-# clone.o and stub.o are in the stub, so it can't be built with profiling
+# stub.o is in the stub, so it can't be built with profiling
 # GCC hardened also auto-enables -fpic, but we need %ebx so it can't work ->
 # disable it
 
-CFLAGS_clone.o := $(CFLAGS_NO_HARDENING)
 CFLAGS_stub.o := $(CFLAGS_NO_HARDENING)
-UNPROFILE_OBJS := clone.o stub.o
-
+UNPROFILE_OBJS := stub.o
 KCOV_INSTRUMENT := n
 
 include $(srctree)/arch/um/scripts/Makefile.rules
diff --git a/arch/um/kernel/skas/clone.c b/arch/um/kernel/skas/clone.c
deleted file mode 100644
index b59fa43d68ce..000000000000
--- a/arch/um/kernel/skas/clone.c
+++ /dev/null
@@ -1,50 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2015 Thomas Meyer (thomas@m3y3r.de)
- * Copyright (C) 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- */
-
-#include <signal.h>
-#include <sched.h>
-#include <asm/unistd.h>
-#include <sys/time.h>
-#include <as-layout.h>
-#include <ptrace_user.h>
-#include <stub-data.h>
-#include <sysdep/stub.h>
-
-/*
- * This is in a separate file because it needs to be compiled with any
- * extraneous gcc flags (-pg, -fprofile-arcs, -ftest-coverage) disabled
- *
- * Use UM_KERN_PAGE_SIZE instead of PAGE_SIZE because that calls getpagesize
- * on some systems.
- */
-
-void __attribute__ ((__section__ (".__syscall_stub")))
-stub_clone_handler(void)
-{
-	struct stub_data *data = get_stub_data();
-	long err;
-
-	/* syscall data as a temporary stack area (bottom half). */
-	err = stub_syscall2(__NR_clone, CLONE_PARENT | CLONE_FILES | SIGCHLD,
-			    (unsigned long) data->syscall_data +
-					    sizeof(data->syscall_data) / 2 -
-					    sizeof(void *));
-	if (err) {
-		data->err = err;
-		goto done;
-	}
-
-	err = stub_syscall4(__NR_ptrace, PTRACE_TRACEME, 0, 0, 0);
-	if (err) {
-		data->child_err = err;
-		goto done;
-	}
-
-	remap_stack_and_trap();
-
- done:
-	trap_myself();
-}
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index d6183cfd51fe..76c0c7d600a8 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -20,8 +20,7 @@ static_assert(sizeof(struct stub_data) == STUB_DATA_PAGES * UM_KERN_PAGE_SIZE);
 
 int init_new_context(struct task_struct *task, struct mm_struct *mm)
 {
- 	struct mm_context *from_mm = NULL;
-	struct mm_context *to_mm = &mm->context;
+	struct mm_id *new_id = &mm->context.id;
 	unsigned long stack = 0;
 	int ret = -ENOMEM;
 
@@ -29,27 +28,22 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 	if (stack == 0)
 		goto out;
 
-	to_mm->id.stack = stack;
-	if (current->mm != NULL && current->mm != &init_mm)
-		from_mm = &current->mm->context;
+	new_id->stack = stack;
 
 	block_signals_trace();
-	if (from_mm)
-		to_mm->id.u.pid = copy_context_skas0(stack,
-						     from_mm->id.u.pid);
-	else to_mm->id.u.pid = start_userspace(stack);
+	new_id->u.pid = start_userspace(stack);
 	unblock_signals_trace();
 
-	if (to_mm->id.u.pid < 0) {
-		ret = to_mm->id.u.pid;
+	if (new_id->u.pid < 0) {
+		ret = new_id->u.pid;
 		goto out_free;
 	}
 
 	return 0;
 
  out_free:
-	if (to_mm->id.stack != 0)
-		free_pages(to_mm->id.stack, ilog2(STUB_DATA_PAGES));
+	if (new_id->stack != 0)
+		free_pages(new_id->stack, ilog2(STUB_DATA_PAGES));
  out:
 	return ret;
 }
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 2bf03115817c..70c43e4a9cf0 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -460,114 +460,6 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 	}
 }
 
-static unsigned long thread_regs[MAX_REG_NR];
-static unsigned long thread_fp_regs[FP_SIZE];
-
-static int __init init_thread_regs(void)
-{
-	get_safe_registers(thread_regs, thread_fp_regs);
-	/* Set parent's instruction pointer to start of clone-stub */
-	thread_regs[REGS_IP_INDEX] = STUB_CODE +
-				(unsigned long) stub_clone_handler -
-				(unsigned long) __syscall_stub_start;
-
-	/* syscall data as a temporary stack area (top half). */
-	thread_regs[REGS_SP_INDEX] = STUB_DATA +
-				     offsetof(struct stub_data, syscall_data) +
-				     sizeof(((struct stub_data *) 0)->syscall_data) -
-				     sizeof(void *);
-	return 0;
-}
-
-__initcall(init_thread_regs);
-
-int copy_context_skas0(unsigned long new_stack, int pid)
-{
-	int err;
-	unsigned long current_stack = current_stub_stack();
-	struct stub_data *data = (struct stub_data *) current_stack;
-	struct stub_data *child_data = (struct stub_data *) new_stack;
-	unsigned long long new_offset;
-	int new_fd = phys_mapping(uml_to_phys((void *)new_stack), &new_offset);
-
-	/*
-	 * prepare offset and fd of child's stack as argument for parent's
-	 * and child's mmap2 calls
-	 */
-	*data = ((struct stub_data) {
-		.offset	= MMAP_OFFSET(new_offset),
-		.fd     = new_fd,
-		.err    = -ESRCH,
-		.child_err = 0,
-	});
-
-	*child_data = ((struct stub_data) {
-		.child_err = -ESRCH,
-	});
-
-	err = ptrace_setregs(pid, thread_regs);
-	if (err < 0) {
-		err = -errno;
-		printk(UM_KERN_ERR "%s : PTRACE_SETREGS failed, pid = %d, errno = %d\n",
-		      __func__, pid, -err);
-		return err;
-	}
-
-	err = put_fp_registers(pid, thread_fp_regs);
-	if (err < 0) {
-		printk(UM_KERN_ERR "%s : put_fp_registers failed, pid = %d, err = %d\n",
-		       __func__, pid, err);
-		return err;
-	}
-
-	/*
-	 * Wait, until parent has finished its work: read child's pid from
-	 * parent's stack, and check, if bad result.
-	 */
-	err = ptrace(PTRACE_CONT, pid, 0, 0);
-	if (err) {
-		err = -errno;
-		printk(UM_KERN_ERR "Failed to continue new process, pid = %d, errno = %d\n",
-		       pid, errno);
-		return err;
-	}
-
-	wait_stub_done(pid);
-
-	pid = data->err;
-	if (pid < 0) {
-		printk(UM_KERN_ERR "%s - stub-parent reports error %d\n",
-		      __func__, -pid);
-		return pid;
-	}
-
-	/*
-	 * Wait, until child has finished too: read child's result from
-	 * child's stack and check it.
-	 */
-	wait_stub_done(pid);
-	if (child_data->child_err != STUB_DATA) {
-		printk(UM_KERN_ERR "%s - stub-child %d reports error %ld\n",
-		       __func__, pid, data->child_err);
-		err = data->child_err;
-		goto out_kill;
-	}
-
-	if (ptrace(PTRACE_SETOPTIONS, pid, NULL,
-		   (void *)PTRACE_O_TRACESYSGOOD) < 0) {
-		err = -errno;
-		printk(UM_KERN_ERR "%s : PTRACE_SETOPTIONS failed, errno = %d\n",
-		       __func__, errno);
-		goto out_kill;
-	}
-
-	return pid;
-
- out_kill:
-	os_kill_ptraced_process(pid, 1);
-	return err;
-}
-
 void new_thread(void *stack, jmp_buf *buf, void (*handler)(void))
 {
 	(*buf)[0].JB_IP = (unsigned long) handler;
-- 
2.44.0


