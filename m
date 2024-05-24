Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2603C25B74
	for <linux-um@archiver.kernel.org>; Fri, 24 May 2024 21:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OfVjvD7azwaVYTcmN7MOir1ljo0mRX8QF8KyFDv+Pfo=; b=TexsemaqEpw35O9TP3UHLmUKv9
	oavxrsw3wjQD8mALoHFXnShJMi+za1owhyeOeEYPN8mqNS7UIaIskNEcJgUsYC8xCeTKPqp5HhjEO
	E9k8L3fqEMAaaO7J4E6LmIipzgnOb/xOXgwZ5dMwINELG1z5os6K4h/YBnJ0qTPFIFU1418X3M+xx
	7pWpQ2A9/OkwpRpL6KbFYlZHQaCVtkuK2r7Ubr/iFRzK0tXN8Yrntpqgd8TDS8Y4Ho7pXkBU01k3n
	89BU2LqMPI7BKVAUCM7WjdBHWonS9Ibqjb27ePX1/fp5VtiAKd5BeZRWXMWN2M8eUnBZYG7dn9g3t
	KB8hZLUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAcfD-00000009wig-22f8;
	Fri, 24 May 2024 21:41:23 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAcfA-00000009wgG-0q5x
	for linux-um@lists.infradead.org;
	Fri, 24 May 2024 21:41:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OfVjvD7azwaVYTcmN7MOir1ljo0mRX8QF8KyFDv+Pfo=;
	t=1716586880; x=1717796480; b=e9bdu1PsLAro5ZJ3TNorRj+4uk9IBDgPmtSdUiA8iCcrPDi
	BOTip1Cv/UavtdSDufW/qXpt/eqT+uW5RV11/+hXt9g46OYkidEcIzBspu6TYU8alIUMlKKuQoPo0
	Be5nPPGRhUyrWHPTeAWQVmceUJV6ge7+thqShudfSVv73qHWSz3YZXxcMzXCdxLPrBxGM+fNU1ghV
	srzM8+k3Fcs01yJL2TBH2/ymzbXZrlfhNpnMe7YHqeg9SUApI+m+PNlveKxJcFChixDq1259jTcJ1
	+LXzj7Re1x3HjZ0Hm4yL0LdPRXTd9O+F1h06eWN5XWOGtyRlkO1iMkGpiUnkoX+A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sAcf5-00000008ke7-0VgT;
	Fri, 24 May 2024 23:41:15 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v3 08/12] um: Delay flushing syscalls until the thread is restarted
Date: Fri, 24 May 2024 23:37:14 +0200
Message-ID: <20240524213718.1757703-9-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524213718.1757703-1-benjamin@sipsolutions.net>
References: <20240524213718.1757703-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_144120_500518_84746FA7 
X-CRM114-Status: GOOD (  22.30  )
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

From: Benjamin Berg <benjamin@sipsolutions.net>

As running the syscalls is expensive due to context switches, we should
do so as late as possible in case more syscalls need to be queued later
on. This will also benefit a later move to a SECCOMP enabled userspace
as in that case the need of extra context switches is removed entirely.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>

---

v2:
 * Remove report_enomem from tlbflush.h, it was never needed there
---
 arch/um/include/shared/os.h         |  4 +++
 arch/um/include/shared/skas/mm_id.h |  1 -
 arch/um/include/shared/skas/skas.h  |  1 +
 arch/um/kernel/skas/process.c       |  8 +++++
 arch/um/kernel/tlb.c                | 21 ++------------
 arch/um/os-Linux/skas/mem.c         | 45 +++++++++++++++++------------
 arch/um/os-Linux/skas/process.c     | 12 ++++++--
 7 files changed, 50 insertions(+), 42 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index dc341ed4724e..ecc1273fd230 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -191,6 +191,9 @@ extern void get_host_cpu_features(
 /* mem.c */
 extern int create_mem_file(unsigned long long len);
 
+/* tlb.c */
+extern void report_enomem(void);
+
 /* process.c */
 extern unsigned long os_process_pc(int pid);
 extern int os_process_parent(int pid);
@@ -270,6 +273,7 @@ extern long long os_nsecs(void);
 /* skas/mem.c */
 int syscall_stub_flush(struct mm_id *mm_idp);
 struct stub_syscall *syscall_stub_alloc(struct mm_id *mm_idp);
+void syscall_stub_dump_error(struct mm_id *mm_idp);
 
 void map(struct mm_id *mm_idp, unsigned long virt,
 	 unsigned long len, int prot, int phys_fd,
diff --git a/arch/um/include/shared/skas/mm_id.h b/arch/um/include/shared/skas/mm_id.h
index bcb951719b51..10edf40f60e9 100644
--- a/arch/um/include/shared/skas/mm_id.h
+++ b/arch/um/include/shared/skas/mm_id.h
@@ -12,7 +12,6 @@ struct mm_id {
 		int pid;
 	} u;
 	unsigned long stack;
-	int kill;
 	int syscall_data_len;
 };
 
diff --git a/arch/um/include/shared/skas/skas.h b/arch/um/include/shared/skas/skas.h
index c93d2cbc8f32..5c78b0cc3dd4 100644
--- a/arch/um/include/shared/skas/skas.h
+++ b/arch/um/include/shared/skas/skas.h
@@ -15,5 +15,6 @@ extern void new_thread_handler(void);
 extern void handle_syscall(struct uml_pt_regs *regs);
 extern long execute_syscall_skas(void *r);
 extern unsigned long current_stub_stack(void);
+extern struct mm_id *current_mm_id(void);
 
 #endif
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index f2ac134c9752..c7345c83e07b 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -53,3 +53,11 @@ unsigned long current_stub_stack(void)
 
 	return current->mm->context.id.stack;
 }
+
+struct mm_id *current_mm_id(void)
+{
+	if (current->mm == NULL)
+		return NULL;
+
+	return &current->mm->context.id;
+}
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 2a7b66b6e367..391c98137890 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -52,7 +52,7 @@ struct host_vm_change {
 	   .index	= 0, \
 	   .force	= force })
 
-static void report_enomem(void)
+void report_enomem(void)
 {
 	printk(KERN_ERR "UML ran out of memory on the host side! "
 			"This can happen due to a memory limitation or "
@@ -337,15 +337,6 @@ static void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
 
 	if (!ret)
 		ret = do_ops(&hvc, hvc.index, 1);
-
-	/* This is not an else because ret is modified above */
-	if (ret) {
-		struct mm_id *mm_idp = &current->mm->context.id;
-
-		printk(KERN_ERR "fix_range_common: failed, killing current "
-		       "process: %d\n", task_tgid_vnr(current));
-		mm_idp->kill = 1;
-	}
 }
 
 static int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
@@ -460,7 +451,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
 	pmd_t *pmd;
 	pte_t *pte;
 	struct mm_struct *mm = vma->vm_mm;
-	int r, w, x, prot, err = 0;
+	int r, w, x, prot;
 	struct mm_id *mm_id;
 
 	address &= PAGE_MASK;
@@ -508,14 +499,6 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
 	} else if (pte_newprot(*pte))
 		protect(mm_id, address, PAGE_SIZE, prot);
 
-	err = syscall_stub_flush(mm_id);
-	if (err) {
-		if (err == -ENOMEM)
-			report_enomem();
-
-		goto kill;
-	}
-
 	*pte = pte_mkuptodate(*pte);
 
 	return;
diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index e3128e080365..bb7eace4feac 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -23,6 +23,30 @@ extern char __syscall_stub_start[];
 
 extern void wait_stub_done(int pid);
 
+void syscall_stub_dump_error(struct mm_id *mm_idp)
+{
+	struct stub_data *proc_data = (void *)mm_idp->stack;
+	struct stub_syscall *sc;
+
+	if (proc_data->syscall_data_len < 0 ||
+	    proc_data->syscall_data_len >= ARRAY_SIZE(proc_data->syscall_data))
+		panic("Syscall data was corrupted by stub (len is: %d, expected maximum: %d)!",
+			proc_data->syscall_data_len,
+			mm_idp->syscall_data_len);
+
+	sc = &proc_data->syscall_data[proc_data->syscall_data_len];
+
+	printk(UM_KERN_ERR "%s : length = %d, last offset = %d",
+		__func__, mm_idp->syscall_data_len,
+		proc_data->syscall_data_len);
+	printk(UM_KERN_ERR "%s : stub syscall type %d failed, return value = 0x%lx\n",
+		__func__, sc->syscall, proc_data->err);
+
+	print_hex_dump(UM_KERN_ERR,
+			"    syscall data: ", 0,
+			16, 4, sc, sizeof(*sc), 0);
+}
+
 static inline unsigned long *check_init_stack(struct mm_id *mm_idp,
 					      unsigned long *stack)
 {
@@ -83,26 +107,9 @@ static inline long do_syscall_stub(struct mm_id *mm_idp)
 	 * otherwise it will be zero (but we do not need to rely on that).
 	 */
 	if (proc_data->err < 0) {
-		struct stub_syscall *sc;
-
-		if (proc_data->syscall_data_len < 0 ||
-		    proc_data->syscall_data_len >= ARRAY_SIZE(proc_data->syscall_data))
-			panic("Syscall data was corrupted by stub (len is: %d, expected maximum: %d)!",
-			      proc_data->syscall_data_len,
-			      mm_idp->syscall_data_len);
-
-		sc = &proc_data->syscall_data[proc_data->syscall_data_len];
-
-		printk(UM_KERN_ERR "%s : length = %d, last offset = %d",
-		       __func__, mm_idp->syscall_data_len,
-		       proc_data->syscall_data_len);
-		printk(UM_KERN_ERR "%s : stub syscall type %d failed, return value = 0x%lx\n",
-		       __func__, sc->syscall, proc_data->err);
-
-		print_hex_dump(UM_KERN_ERR,
-			       "    syscall data: ", 0,
-			       16, 4, sc, sizeof(*sc), 0);
+		syscall_stub_dump_error(mm_idp);
 
+		/* Store error code in case someone tries to add more syscalls */
 		mm_idp->syscall_data_len = proc_data->err;
 	} else {
 		mm_idp->syscall_data_len = 0;
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 70c43e4a9cf0..8dca42627f39 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -252,7 +252,6 @@ static int userspace_tramp(void *stack)
 }
 
 int userspace_pid[NR_CPUS];
-int kill_userspace_mm[NR_CPUS];
 
 /**
  * start_userspace() - prepare a new userspace process
@@ -344,8 +343,16 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 	interrupt_end();
 
 	while (1) {
-		if (kill_userspace_mm[0])
+		/* Flush out any pending syscalls */
+		err = syscall_stub_flush(current_mm_id());
+		if (err) {
+			if (err == -ENOMEM)
+				report_enomem();
+
+			printk(UM_KERN_ERR "%s - Error flushing stub syscalls: %d",
+				__func__, -err);
 			fatal_sigsegv();
+		}
 
 		/*
 		 * This can legitimately fail if the process loads a
@@ -576,5 +583,4 @@ void reboot_skas(void)
 void __switch_mm(struct mm_id *mm_idp)
 {
 	userspace_pid[0] = mm_idp->u.pid;
-	kill_userspace_mm[0] = mm_idp->kill;
 }
-- 
2.45.1


