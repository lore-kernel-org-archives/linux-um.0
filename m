Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0536AC4332F
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 10:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CF6BE3KMC2NLKEO98IrkvJCYPqbwTMjA4C+a6WDRh/c=; b=NDVfTAMe7akAaC
	soZqf92fY1UaxrOjMA/EoS0wwKf0OSwsFUKLpiR9X9DwmDj93Se8ZJzLmR4Df2wQUGLbV6V5nTugz
	vyrJWjrkAtq6gwtGwjRjRXvGNtCO4uFzdebN5NpMjxgxMYJQXGeNA1LnW2nJxQ9Y74UvPU6keEmUj
	nru7PQ/PzY7FIR5lRNn2ofstcSZuTws178lLFwKoTQnGmp6pyojFvybyd9bQ2uRWtUs4Q2/IihFo/
	4P1iqBwbf8JNUaOkFN3AZh9yzpPySZYqYoMIzmxLHU8mdYv8Y16D+9j2UoaJKVOMoaOCRuzFT8Q0o
	Ib1NXG9X6+P0RInIEfRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQUQ-007ntt-TC; Tue, 22 Nov 2022 10:26:54 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQTK-007nKg-PZ
	for linux-um@bombadil.infradead.org; Tue, 22 Nov 2022 10:25:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=yBeGg1yOlJJQ+w3KGj6EaxA4OEaEKz0gIyDSlhBDuVU=; b=olE+BNqKYi6cnrictcgUbdj81O
	EpwWazdlcPNRi8UXjpfLpD0oqqr77d8dquDjn6h4mec9R4iWjAakxfJfOH+4M35130jt962ljOfRj
	CcjoG15oxNk+Aetgm/KCB6oQHNd7zBEjUP3NkePuOvNrPb/1mmFJpdaeRiRJCR2lwtwsLucG9GsZq
	/p9FPDUZYUGPFJnwKG0RYP//y672i9Tga8eb93uLYYfyEQcGBEgv47kF7VIMSsnRONxt1AqWqEzZH
	MQ1nZOgzvnEB5fHH9z/uLSQSBSewhBRyMAQEg1ErfiifJSVEXfnptGkOggFOH5Y3Q5KqtMZfdvhu3
	7A55lybQ==;
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQF3-003P3r-Jp
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 10:11:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=yBeGg1yOlJJQ+w3KGj6EaxA4OEaEKz0gIyDSlhBDuVU=;
	t=1669111861; x=1670321461; b=hp3Hb1Hhl+WmhxqcLX7SijMmU4Wyb16i0M24lHeO9YJMUlJ
	c/swz6dBI6/uLQIyqfmihRHj31cZE+crs5guNl32SUo+MYuAfJGpMR0dWCVTtfb7j1FnJilQNNvsV
	6KRiDpJCs8sV63+LL76TYATHBHxT792ap3llR2RswGpJbi6Q8eWV5Ux47mmlKuacYM1IG7RFmKGst
	/d28gnaQ43gA9aQRRmSbK9Bd9spQGUSQ35C1RqR/4IcmjCrv94u1VOjPLPTN3DbHJcr2kggCYw3nk
	CvPQL+ePnc1Odk34iotV70fEpRu62w50rDEWPLMM8PD5zNampQ1mbZf0She+zViw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1oxQEq-006IGn-2v;
	Tue, 22 Nov 2022 11:10:49 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 19/28] um: Pass full mm_id to functions creating helper processes
Date: Tue, 22 Nov 2022 11:07:50 +0100
Message-Id: <20221122100759.208290-20-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122100759.208290-1-benjamin@sipsolutions.net>
References: <20221122100759.208290-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_101101_942053_47A0EB1D 
X-CRM114-Status: GOOD (  15.53  )
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

For seccomp, we need all information about the original process in
copy_context_skas0. For consistency, change both copy_context_skas0 and
start_userspace to take the mm_id struct as parameter and directly set
PID in addition to returning it.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/include/shared/os.h     |  4 +--
 arch/um/kernel/skas/mmu.c       | 10 +++---
 arch/um/os-Linux/skas/process.c | 57 ++++++++++++++++-----------------
 3 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 22ea525165b7..d1f1dedad83b 100644
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
 extern void new_thread(void *stack, jmp_buf *buf, void (*handler)(void));
 extern void switch_threads(jmp_buf *me, jmp_buf *you);
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 6ccb561b4373..d5838ff702dc 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -31,15 +31,13 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 
 	block_signals_trace();
 	if (from_mm)
-		to_mm->id.u.pid = copy_context_skas0(stack,
-						     from_mm->id.u.pid);
-	else to_mm->id.u.pid = start_userspace(stack);
+		ret = copy_context_skas0(&to_mm->id, &from_mm->id);
+	else
+		ret = start_userspace(&to_mm->id);
 	unblock_signals_trace();
 
-	if (to_mm->id.u.pid < 0) {
-		ret = to_mm->id.u.pid;
+	if (ret < 0)
 		goto out_free;
-	}
 
 	ret = init_new_ldt(to_mm, from_mm);
 	if (ret < 0) {
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 17164c4a7d7c..1e1c378588ba 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -267,11 +267,11 @@ int kill_userspace_mm[NR_CPUS];
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
@@ -290,8 +290,8 @@ int start_userspace(unsigned long stub_stack)
 	flags = CLONE_FILES | SIGCHLD;
 
 	/* clone into new userspace process */
-	pid = clone(userspace_tramp, (void *) sp, flags, (void *) stub_stack);
-	if (pid < 0) {
+	id->u.pid = clone(userspace_tramp, (void *) sp, flags, (void *) id->stack);
+	if (id->u.pid < 0) {
 		err = -errno;
 		printk(UM_KERN_ERR "%s : clone failed, errno = %d\n",
 		       __func__, errno);
@@ -299,7 +299,7 @@ int start_userspace(unsigned long stub_stack)
 	}
 
 	do {
-		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED | __WALL));
+		CATCH_EINTR(n = waitpid(id->u.pid, &status, WUNTRACED | __WALL));
 		if (n < 0) {
 			err = -errno;
 			printk(UM_KERN_ERR "%s : wait failed, errno = %d\n",
@@ -315,7 +315,7 @@ int start_userspace(unsigned long stub_stack)
 		goto out_kill;
 	}
 
-	if (ptrace(PTRACE_SETOPTIONS, pid, NULL,
+	if (ptrace(PTRACE_SETOPTIONS, id->u.pid, NULL,
 		   (void *) PTRACE_O_TRACESYSGOOD) < 0) {
 		err = -errno;
 		printk(UM_KERN_ERR "%s : PTRACE_SETOPTIONS failed, errno = %d\n",
@@ -330,10 +330,10 @@ int start_userspace(unsigned long stub_stack)
 		goto out_kill;
 	}
 
-	return pid;
+	return id->u.pid;
 
  out_kill:
-	os_kill_ptraced_process(pid, 1);
+	os_kill_ptraced_process(id->u.pid, 1);
 	return err;
 }
 
@@ -483,15 +483,14 @@ static int __init init_thread_regs(void)
 
 __initcall(init_thread_regs);
 
-int copy_context_skas0(unsigned long new_stack, int pid)
+int copy_context_skas0(struct mm_id *id, struct mm_id *from)
 {
 	int err;
 	unsigned long current_stack = current_stub_stack();
-	struct stub_data *data = (struct stub_data *) current_stack;
-	struct stub_data *child_data = (struct stub_data *) new_stack;
+	struct stub_data *data = (struct stub_data *)current_stack;
+	struct stub_data *child_data = (struct stub_data *)id->stack;
 	unsigned long long new_offset;
-	int new_fd = phys_mapping(uml_to_phys((void *)new_stack), &new_offset);
-
+	int new_fd = phys_mapping(uml_to_phys((void *)id->stack), &new_offset);
 	/*
 	 * prepare offset and fd of child's stack as argument for parent's
 	 * and child's mmap2 calls
@@ -507,18 +506,18 @@ int copy_context_skas0(unsigned long new_stack, int pid)
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
 
@@ -526,36 +525,36 @@ int copy_context_skas0(unsigned long new_stack, int pid)
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
 		printk(UM_KERN_ERR "%s : PTRACE_SETOPTIONS failed, errno = %d\n",
@@ -563,10 +562,10 @@ int copy_context_skas0(unsigned long new_stack, int pid)
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
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
