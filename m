Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B07C43217
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 10:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1f5F7lIFXxWrRBKWv0PZP7iPScM1lFFjg0hHIq/bI1s=; b=BDLlj7U5cv7efM
	p/pFmn9qAwvH4ymN6NSgz1ns4ezo7HFZgIGhv3SkB90UejN3omdR+ktAqd05sUNa288lUPZ31DkPb
	t/0xAuXmMsCYE9UmTO4UtpSdD5S09r9NvZmQpxJaqTah10c4/Bu47KGdWKNkLRqFQAWPts9bPvQS7
	M3WbZaYu3X+IPkfxI8Txlk5GS/tNXHZ2cjaYRQzWfP/enAVl6BWaUJNrUcGzCH0+m/nuBwnr3AiSD
	f+85i6iHBkGyg5XqU4wK7og+Kt+hgeXOAGIkFBT5au0V6WSsH3eHBCpCtHL5WPKYemrTw7w/JznX7
	yQnZEUQSjicernmfxrnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQUR-007nuB-In; Tue, 22 Nov 2022 10:26:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQTK-007nKg-AU
	for linux-um@bombadil.infradead.org; Tue, 22 Nov 2022 10:25:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=C5uViLYbfzqIQxjpXCXFRcIYOLSByVh51zHclzVAsh8=; b=T9bCcqTZwHOWOOVA8hSksUxY8K
	gMXwqxOg2bUfp1OB+EZpvAFzO2jxJvA+bkyCXftKuvn8rl41BJfj1CoBvr/Z49HeMIZt2Jcvw/s5q
	W6j8556rduL4w7F1xBbPsHLkWVYyWN7/topKtU3ERTW4kHJwJtkxlcTmzd/jgijTz23eU6D1z2TzK
	nlHf6UBvVcrc1gT/d/r9xJYqfJkdXwkwArDPvML677I9kd6SxLQlh+rlRgOJcXq5/Arc/0UTn6rTf
	EF9U3m51xQnRmn7ddBusLBOTXYfqqRp7XDbvrAC47r2WigvptHLTI5WiLsoKL+DhPcPHRPdZTa0Hz
	1eJN4yrg==;
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQF1-003P1l-8C
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 10:11:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=C5uViLYbfzqIQxjpXCXFRcIYOLSByVh51zHclzVAsh8=;
	t=1669111857; x=1670321457; b=pTWsWPRSPM+WW3IM6Tz/udFehlskifqx8F/xQUNCFynt0IF
	v2Cztn7lBqY4D90VKW2YhgXLmIf+bAnT7OowgUXkQR9hQ0nXpmRWCPe8C7R3WUiERtg4SqvS65Yei
	ZXu2D3taSGXcXi87tHpxXgcaha2IAebEhnFW7OVUBaQ0xo4Pu0igQpofzdEFw77HYMyPzrBAxu19u
	74DGas56D8KchQJUGfwOFC/rvDoX5oNWcCESEqQE99cplsADqqFKkQvcfrBsF5A8fBTYX21QdmyHc
	4wfNyTfIAVaZXFwwJNZCRrx+9xzeugDDeJ7CnWJgl1kNoVnCfv7Ul4ntIP3HSYjA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1oxQEw-006IGn-1X;
	Tue, 22 Nov 2022 11:10:54 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 28/28] um: Delay flushing syscalls until the thread is restarted
Date: Tue, 22 Nov 2022 11:07:59 +0100
Message-Id: <20221122100759.208290-29-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122100759.208290-1-benjamin@sipsolutions.net>
References: <20221122100759.208290-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_101103_248680_D07EA555 
X-CRM114-Status: GOOD (  17.76  )
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

This way we can avoid doing two extra context switches when managing
processes using seccomp.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/include/shared/os.h        |  1 +
 arch/um/include/shared/skas/skas.h |  1 +
 arch/um/kernel/skas/process.c      |  8 ++++
 arch/um/kernel/tlb.c               | 10 +----
 arch/um/os-Linux/skas/mem.c        | 71 ++++++++++++++++--------------
 arch/um/os-Linux/skas/process.c    | 26 ++++++++++-
 6 files changed, 75 insertions(+), 42 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 07683f45d7e1..aa888d4870d9 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -273,6 +273,7 @@ int syscall_stub_flush(struct mm_id *mm_idp);
 struct stub_syscall *syscall_stub_alloc(struct mm_id *mm_idp,
 					unsigned long data_len,
 					unsigned long *data_addr);
+void syscall_stub_dump_error(struct mm_id *mm_idp);
 
 void map(struct mm_id *mm_idp, unsigned long virt,
 	 unsigned long len, int prot, int phys_fd,
diff --git a/arch/um/include/shared/skas/skas.h b/arch/um/include/shared/skas/skas.h
index f10599995d4d..bc672d607101 100644
--- a/arch/um/include/shared/skas/skas.h
+++ b/arch/um/include/shared/skas/skas.h
@@ -21,5 +21,6 @@ extern void new_thread_handler(void);
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
index c15cac380fcd..bda516cb1186 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -460,7 +460,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
 	pmd_t *pmd;
 	pte_t *pte;
 	struct mm_struct *mm = vma->vm_mm;
-	int r, w, x, prot, err = 0;
+	int r, w, x, prot;
 	struct mm_id *mm_id;
 
 	address &= PAGE_MASK;
@@ -508,14 +508,6 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
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
index 619035151bc6..68155aadea09 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -25,6 +25,44 @@ extern char __syscall_stub_start[];
 extern void wait_stub_done(int pid);
 void wait_stub_done_seccomp(int pid, struct stub_data *data, int running);
 
+void syscall_stub_dump_error(struct mm_id *mm_idp)
+{
+	struct stub_data *proc_data = (void *)mm_idp->stack;
+	struct stub_syscall *sc;
+	int n;
+
+	if (proc_data->syscall_data_len < 0 ||
+	    proc_data->syscall_data_len > (long) mm_idp->syscall_data_len - sizeof(*sc))
+		panic("Syscall data was corrupted by stub (len is: %d, expected maximum: %d)!",
+		      proc_data->syscall_data_len,
+		      mm_idp->syscall_data_len);
+
+	sc = (void *) (((unsigned long) &proc_data->syscall_data) +
+		       proc_data->syscall_data_len);
+
+	printk(UM_KERN_ERR "%s : length = %d, last offset = %d",
+	       __func__, mm_idp->syscall_data_len,
+	       proc_data->syscall_data_len);
+	printk(UM_KERN_ERR "%s : syscall %ld failed, return value = 0x%lx, expected return value = 0x%lx\n",
+	       __func__, sc->syscall, proc_data->err,
+	       sc->expected_result);
+
+	printk(UM_KERN_ERR "    syscall parameters: 0x%lx 0x%lx 0x%lx 0x%lx 0x%lx 0x%lx\n",
+	       sc->arg[0], sc->arg[1], sc->arg[2],
+	       sc->arg[3], sc->arg[4], sc->arg[5]);
+
+	n = sc->cmd_len - sizeof(*sc);
+	if (n > 0) {
+		printk(UM_KERN_ERR "    syscall data 0x%lx + %d",
+		       STUB_DATA + ((unsigned long) (&sc->data) &
+				    (UM_KERN_PAGE_SIZE - 1)),
+		       n);
+		print_hex_dump(UM_KERN_ERR,
+			       "    syscall data: ", 0,
+			       16, 4, sc->data, n, 0);
+	}
+}
+
 static inline unsigned long *check_init_stack(struct mm_id *mm_idp,
 					      unsigned long *stack)
 {
@@ -90,38 +128,7 @@ static inline long do_syscall_stub(struct mm_id *mm_idp)
 	 * otherwise it will be zero (but we do not need to rely on that).
 	 */
 	if (proc_data->err) {
-		struct stub_syscall *sc;
-
-		if (proc_data->syscall_data_len < 0 ||
-		    proc_data->syscall_data_len > (long) mm_idp->syscall_data_len - sizeof(*sc))
-			panic("Syscall data was corrupted by stub (len is: %d, expected maximum: %d)!",
-			      proc_data->syscall_data_len,
-			      mm_idp->syscall_data_len);
-
-		sc = (void *) (((unsigned long) &proc_data->syscall_data) +
-			       proc_data->syscall_data_len);
-
-		printk(UM_KERN_ERR "%s : length = %d, last offset = %d",
-		       __func__, mm_idp->syscall_data_len,
-		       proc_data->syscall_data_len);
-		printk(UM_KERN_ERR "%s : syscall %ld failed, return value = 0x%lx, expected return value = 0x%lx\n",
-		       __func__, sc->syscall, proc_data->err,
-		       sc->expected_result);
-
-		printk(UM_KERN_ERR "    syscall parameters: 0x%lx 0x%lx 0x%lx 0x%lx 0x%lx 0x%lx\n",
-		       sc->arg[0], sc->arg[1], sc->arg[2],
-		       sc->arg[3], sc->arg[4], sc->arg[5]);
-
-		n = sc->cmd_len - sizeof(*sc);
-		if (n > 0) {
-			printk(UM_KERN_ERR "    syscall data 0x%lx + %d",
-			       STUB_DATA + ((unsigned long) (&sc->data) &
-					    (UM_KERN_PAGE_SIZE - 1)),
-			       n);
-			print_hex_dump(UM_KERN_ERR,
-				       "    syscall data: ", 0,
-				       16, 4, sc->data, n, 0);
-		}
+		syscall_stub_dump_error(mm_idp);
 
 		/* Store error code in case someone tries to add more syscalls */
 		mm_idp->syscall_data_len = proc_data->err;
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 55868eb35727..39941d14bb51 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -530,7 +530,8 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 			fatal_sigsegv();
 
 		if (using_seccomp) {
-			struct stub_data *proc_data = (void *)current_stub_stack();
+			struct mm_id *mm_id = current_mm_id();
+			struct stub_data *proc_data = (void *) mm_id->stack;
 			int ret;
 
 			ret = set_stub_state(regs, proc_data, singlestepping());
@@ -544,6 +545,10 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 			if (proc_data->restart_wait != 0)
 				panic("Programming error: Flag to only run syscalls in child was not cleared!");
 
+			/* Mark pending syscalls for flushing */
+			proc_data->syscall_data_len = mm_id->syscall_data_len;
+			mm_id->syscall_data_len = 0;
+
 			proc_data->signal = 0;
 			proc_data->futex = FUTEX_IN_CHILD;
 			CATCH_EINTR(syscall(__NR_futex, &proc_data->futex,
@@ -556,6 +561,13 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 
 			sig = proc_data->signal;
 
+			if (sig == SIGTRAP && proc_data->err != 0) {
+				printk(UM_KERN_ERR "%s - Error flushing stub syscalls",
+				       __func__);
+				syscall_stub_dump_error(mm_id);
+				fatal_sigsegv();
+			}
+
 			ret = get_stub_state(regs, proc_data);
 			if (ret) {
 				printk(UM_KERN_ERR "%s - failed to get regs: %d",
@@ -586,6 +598,14 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 				GET_FAULTINFO_FROM_MC(regs->faultinfo, mcontext);
 			}
 		} else {
+			/* With ptrace, we need to explicitly flush all pending syscalls. */
+			err = syscall_stub_flush(current_mm_id());
+			if (err) {
+				printk(UM_KERN_ERR "%s - Error flushing stub syscalls: %d",
+				       __func__, -err);
+				fatal_sigsegv();
+			}
+
 			/*
 			 * This can legitimately fail if the process loads a
 			 * bogus value into a segment register.  It will
@@ -760,6 +780,10 @@ int copy_context_skas0(struct mm_id *id, struct mm_id *from)
 
 	child_data->child_err = -ESRCH;
 
+	err = syscall_stub_flush(from);
+	if (err)
+		return err;
+
 	if (using_seccomp) {
 		err = set_stub_state(&thread_regs, data, 0);
 		if (err)
-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
