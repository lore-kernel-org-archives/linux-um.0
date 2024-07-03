Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50EBC3DA43
	for <linux-um@archiver.kernel.org>; Wed,  3 Jul 2024 15:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8im0tXgtEszBPy7Rtlr6ZeIpFN0rJu9QK4jobQlhPNw=; b=4iZRetFXoxtUdDtL4zV01E6k7t
	H04d8JEnux3tHomV3SfrGQlElgLLFPHjyCBIXfXgmAXaQkmDZTmgX+nayA6j3OnjcXRauIbIEP4zQ
	U1r3Aq+Ycq66Oe9/E0tfmrsVNd5jjHha5NswHCO2n8VlZP2bZLAzOtVRvHF4Yq7l/PTxVjjo+WbJi
	Hmn3RnjXB66QE08x9O1TQBAelH6JFh9WEqih8jYTdEcuHpSXO2ibr3x1TyyO8RiHiXV14wWu/F9RM
	QtTxK03lv/ePJwvHDV8q1qUtu8jaRkUyDWSq0ooXYZB7FhQ8hHSLK5WqkQTQt/WGvVW+PnZ/wWgNR
	ZRerc2mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1TX-0000000Aaeh-2Vzp;
	Wed, 03 Jul 2024 15:00:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0Jg-0000000ALM7-2TMc
	for linux-um@bombadil.infradead.org;
	Wed, 03 Jul 2024 13:46:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=8im0tXgtEszBPy7Rtlr6ZeIpFN0rJu9QK4jobQlhPNw=; b=d4r8nQ4HCRRvTtT89xHhays5g8
	JrrZHvD9QciOYItC/GEz2s71GzpXUZPytEgmZfbaCCRuawOIr2I2wopRoXMsZM+LQ2lgwqk9GEfdc
	EaiUpWyuSewq1I/CGnzmbZcBm2thhMGrHX/FvHjIVP67KADFmkqWw5sLNPdWhujxV7CtMrZgatCHI
	44Oj6gc5yA3Xwact75rqAOKjKRicC6N3XpIg79NyhbB1/OEq5AoHkfRxpfR2CxBcZOBKxcaDqPsJU
	y4OAue4HJNpWqRBW10w8rdIyxUHBRP823SnaUcX88L1P5IVObdVboIn8TXXP4XRi7p6xsN2NFSjCw
	5/gvEmGQ==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0JW-0000000A1In-3LYY
	for linux-um@lists.infradead.org;
	Wed, 03 Jul 2024 13:46:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8im0tXgtEszBPy7Rtlr6ZeIpFN0rJu9QK4jobQlhPNw=;
	t=1720014386; x=1721223986; b=mG5qS4HZYD6nyUnfomMnH7immyhor7c2dBIauIZFE8x1p4E
	eimd0Wi4/yHH+w0s+6JtsOC3+Jn+rwLTAvGPeBOmuqrnut7m97T8RctaI3dwwRLWyvq6KP2Bg7zvz
	xoJThUfZmun3PqIrfVW+OtfX5q8FaZ0xXdybYFupUA6GPbDJ0gtzF8z99+5N+18/RPoKJWsMgoPWD
	IeDLFmSDR/VrDE6vZqwt2zYmo3EgSTKDoAu/bksUuOYjKQ0aqOBQU3DNzElo/GfrPRNh56hbvIToM
	LQOFocDzoYNlU89EcAPXvMXe8PSmMUNv6FmavHFo2T5l2KFBmkECmhTAry2ldpvw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sP0JS-000000094nb-2KS1;
	Wed, 03 Jul 2024 15:46:22 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v4 08/12] um: Delay flushing syscalls until the thread is restarted
Date: Wed,  3 Jul 2024 15:45:32 +0200
Message-ID: <20240703134536.1161108-9-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703134536.1161108-1-benjamin@sipsolutions.net>
References: <20240703134536.1161108-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_144627_321349_DB401859 
X-CRM114-Status: GOOD (  22.58  )
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

As running the syscalls is expensive due to context switches, we should
do so as late as possible in case more syscalls need to be queued later
on. This will also benefit a later move to a SECCOMP enabled userspace
as in that case the need for extra context switches is removed entirely.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>

---

v4: Fix indentation and typo in commit message
---
 arch/um/include/shared/os.h         |  4 +++
 arch/um/include/shared/skas/mm_id.h |  1 -
 arch/um/include/shared/skas/skas.h  |  1 +
 arch/um/kernel/skas/process.c       |  8 ++++++
 arch/um/kernel/tlb.c                | 21 ++------------
 arch/um/os-Linux/skas/mem.c         | 44 ++++++++++++++++-------------
 arch/um/os-Linux/skas/process.c     | 12 ++++++--
 7 files changed, 49 insertions(+), 42 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index d12fec5d0b4d..345b117aff0b 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -195,6 +195,9 @@ extern void get_host_cpu_features(
 /* mem.c */
 extern int create_mem_file(unsigned long long len);
 
+/* tlb.c */
+extern void report_enomem(void);
+
 /* process.c */
 extern unsigned long os_process_pc(int pid);
 extern int os_process_parent(int pid);
@@ -274,6 +277,7 @@ extern long long os_nsecs(void);
 /* skas/mem.c */
 int syscall_stub_flush(struct mm_id *mm_idp);
 struct stub_syscall *syscall_stub_alloc(struct mm_id *mm_idp);
+void syscall_stub_dump_error(struct mm_id *mm_idp);
 
 void map(struct mm_id *mm_idp, unsigned long virt,
 	 unsigned long len, int prot, int phys_fd,
diff --git a/arch/um/include/shared/skas/mm_id.h b/arch/um/include/shared/skas/mm_id.h
index 4c5311abe42c..1e76ba40feba 100644
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
index 99a5cbb36083..41901a74fccc 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -50,3 +50,11 @@ unsigned long current_stub_stack(void)
 
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
index a89e2886485f..1eee7134cba8 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -53,7 +53,7 @@ struct host_vm_change {
 	   .index	= 0, \
 	   .force	= force })
 
-static void report_enomem(void)
+void report_enomem(void)
 {
 	printk(KERN_ERR "UML ran out of memory on the host side! "
 			"This can happen due to a memory limitation or "
@@ -338,15 +338,6 @@ static void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
 
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
@@ -461,7 +452,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
 	pmd_t *pmd;
 	pte_t *pte;
 	struct mm_struct *mm = vma->vm_mm;
-	int r, w, x, prot, err = 0;
+	int r, w, x, prot;
 	struct mm_id *mm_id;
 
 	address &= PAGE_MASK;
@@ -509,14 +500,6 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
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
index 32c61189110c..46fa10ab9892 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -22,6 +22,29 @@
 
 extern char __syscall_stub_start[];
 
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
+	print_hex_dump(UM_KERN_ERR, "    syscall data: ", 0,
+		       16, 4, sc, sizeof(*sc), 0);
+}
+
 static inline unsigned long *check_init_stack(struct mm_id * mm_idp,
 					      unsigned long *stack)
 {
@@ -82,26 +105,9 @@ static inline long do_syscall_stub(struct mm_id *mm_idp)
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
index 566b8ecccc3f..9cb61610147a 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -254,7 +254,6 @@ static int userspace_tramp(void *stack)
 }
 
 int userspace_pid[NR_CPUS];
-int kill_userspace_mm[NR_CPUS];
 
 /**
  * start_userspace() - prepare a new userspace process
@@ -348,8 +347,16 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 	while (1) {
 		time_travel_print_bc_msg();
 
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
@@ -580,5 +587,4 @@ void reboot_skas(void)
 void __switch_mm(struct mm_id *mm_idp)
 {
 	userspace_pid[0] = mm_idp->u.pid;
-	kill_userspace_mm[0] = mm_idp->kill;
 }
-- 
2.45.2


