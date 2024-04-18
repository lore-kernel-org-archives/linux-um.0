Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC2CC04FF8
	for <linux-um@archiver.kernel.org>; Thu, 18 Apr 2024 09:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vXHTf9D/USnGUwIFooNnGokmMl15lis1y2PVVBHZSuQ=; b=iUEcVzJ0uoRt+opQWik5OnEhuO
	ptuc7mt/yNu5nCQRyOBIK2ceYu30lZuovbeKY7dZN2b1nVXAvyhCOqlA/JZuwvtnfddiSgJzP66iw
	Uth9BM5NW0btlBCj7O1DN/joHzrSUG3xi10WB5vomp8mihlBWN7MHzW65/LbO4K/K+P5XcGMwSLCr
	Pn57QD3Iz3smNcoDbMpRCSyW2sts+bYyP9NjhItTT+bWp7Cl/9sEszzVcDWfOW+WtER3XRg4AvHlN
	4qS101KM4Si6De5t/p0c/3WjhJ7Kdw3fjjlpSXBZxfHrkhN3uAme0HCt0h0L4+xjWDNj9Nymdw/dw
	584q5H1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxO0y-00000001bRx-48dX;
	Thu, 18 Apr 2024 09:25:08 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxO0q-00000001bIW-2K9a
	for linux-um@lists.infradead.org;
	Thu, 18 Apr 2024 09:25:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vXHTf9D/USnGUwIFooNnGokmMl15lis1y2PVVBHZSuQ=;
	t=1713432300; x=1714641900; b=gtnZAti7OTqR+7LYh1/4G8LmXO1XsqZQ15yCoUQyuMpZqNg
	SrGA5nwjKLKXpAsUpLtjXAzdlGGOl99KeMyMz4QqI5OlAK80VGoo2yz1af1mNTCzDeILBePuHNPcD
	JcopcRAc2uEbobB0QuYHid8RO4o6TBXP6HZ/MntES2a3hMTEJmEMeU+K6SWsbFk4kVxJRQfoXNu2x
	CyQjzETzzdqHskTuPF62/ogv09L/sHOD3FyUdBr7zbq05rEupXkTLKZTvhvlkRaMAnyL34dauDSsc
	b4q+2/CnJCIVbejfZqr+Q5ilE3ooaao90VpSRC4L1H3CtFyAalGV1a3XCnd1+k/Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1rxO0n-0000000CKXH-1eTf;
	Thu, 18 Apr 2024 11:24:57 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 08/12] um: Delay flushing syscalls until the thread is restarted
Date: Thu, 18 Apr 2024 11:23:23 +0200
Message-ID: <20240418092327.860135-9-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418092327.860135-1-benjamin@sipsolutions.net>
References: <20240418092327.860135-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_022500_897424_A41253B1 
X-CRM114-Status: GOOD (  21.55  )
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
 arch/um/include/asm/tlbflush.h      |  2 ++
 arch/um/include/shared/os.h         |  4 +++
 arch/um/include/shared/skas/mm_id.h |  1 -
 arch/um/include/shared/skas/skas.h  |  1 +
 arch/um/kernel/skas/process.c       |  8 +++++
 arch/um/kernel/tlb.c                | 21 ++------------
 arch/um/os-Linux/skas/mem.c         | 45 +++++++++++++++++------------
 arch/um/os-Linux/skas/process.c     | 12 ++++++--
 8 files changed, 52 insertions(+), 42 deletions(-)

diff --git a/arch/um/include/asm/tlbflush.h b/arch/um/include/asm/tlbflush.h
index a5bda890390d..d7cf82023b74 100644
--- a/arch/um/include/asm/tlbflush.h
+++ b/arch/um/include/asm/tlbflush.h
@@ -28,4 +28,6 @@ extern void flush_tlb_kernel_vm(void);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 extern void __flush_tlb_one(unsigned long addr);
 
+void report_enomem(void);
+
 #endif
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
2.44.0


