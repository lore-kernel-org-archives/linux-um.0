Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FAFCF8852
	for <linux-um@archiver.kernel.org>; Fri,  4 Oct 2024 23:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5jRlSgp23qR0Cyzu9QHIiDtMBpvyeilzzyEhkpp7IwM=; b=TliZS0Ugd40SaZfznEQeC4aCmG
	Eg+ThJDgl/StZCb5MOKSokTGUJq2mUg+Qplty3UMvy62JlPHXnz24FxHVBqrTt5aP5wxjgdvzC+re
	OPLovtZahIQ6TWLxl7kZgmao4S/vpe/ZmA6es7VkmgcUr58LGI0y4hzpNtlUvWxTeK7MOj4NqYt0I
	cThBZr5qoZNV0tv87SkdXcIlI4aJRXFLA3COPTphzz0KF2Eet4AeVkp4gpKM+Bv/g/Pq7h0miIHz9
	5e0oyCjHkgqz8FM2lv+WxgZbVi+60qb1k992mMLZvOR96FIuHHj+xAAKwY+MImvQwdS1UjapvUAfj
	XyISpa8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swrso-0000000ESqk-2jDB;
	Fri, 04 Oct 2024 23:38:50 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swrsf-0000000ESpP-1MOv
	for linux-um@lists.infradead.org;
	Fri, 04 Oct 2024 23:38:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=5jRlSgp23qR0Cyzu9QHIiDtMBpvyeilzzyEhkpp7IwM=; t=1728085120; x=1729294720; 
	b=h3IdbFARcmiZzAmvb/iQ3koWolfjNFjdrNS5Ay6CnQf8pfsF5SHyl3UpOhqZLD+Z//OF2UV3DvJ
	Ux7NHcphj6rNVieUdDUdYIky77g1P/QE39ymo/eYsTmFBadPn78qDcHUT/26aRuDOSNbO+VyDuZsh
	yPwGuWsvhbMaV1T3VOS6VKbU4sLci2BFvst14Gqy9vDBUU3mbVYYZ2lUwdO5wx6/V6vQ3NxrVNBCa
	GI+gknRqBTwNRdp9Ge3iKzuLV4CO3JNjd2ig/D3Zl/ZcdhUDk9xekHZVZaEN6EiJ1txxRDuvj33GE
	vBI97WA8lOxtdcjGxzVdnhpZY/NLdLL4sX2g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1swrsb-00000000AkR-3Jcn;
	Sat, 05 Oct 2024 01:38:38 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH] um: remove auxiliary FP registers
Date: Sat,  5 Oct 2024 01:38:21 +0200
Message-ID: <20241004233821.2130874-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241004_163841_410201_D3BE9629 
X-CRM114-Status: GOOD (  14.95  )
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

We do not need the extra save/restore of the FP registers when getting
the fault information. This was originally added in commit 2f56debd77a8
("uml: fix FP register corruption") but at that time the code was not
saving/restoring the FP registers when switching to userspace. This was
fixed in commit fbfe9c847edf ("um: Save FPU registers between task
switches") and since then the auxiliary registers have not been useful.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/include/asm/thread_info.h |  2 --
 arch/um/include/shared/os.h       |  2 +-
 arch/um/kernel/process.c          |  4 ++--
 arch/um/os-Linux/skas/process.c   | 25 ++++++-------------------
 4 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/arch/um/include/asm/thread_info.h b/arch/um/include/asm/thread_info.h
index c7b4b49826a2..4d2a768246bc 100644
--- a/arch/um/include/asm/thread_info.h
+++ b/arch/um/include/asm/thread_info.h
@@ -23,8 +23,6 @@ struct thread_info {
 	int			preempt_count;  /* 0 => preemptable,
 						   <0 => BUG */
 	struct thread_info	*real_thread;    /* Points to non-IRQ stack */
-	unsigned long aux_fp_regs[FP_SIZE];	/* auxiliary fp_regs to save/restore
-						   them out-of-band */
 };
 
 #define INIT_THREAD_INFO(tsk)			\
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 33c4d2677591..bf539fee7831 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -285,7 +285,7 @@ int protect(struct mm_id *mm_idp, unsigned long addr,
 /* skas/process.c */
 extern int is_skas_winch(int pid, int fd, void *data);
 extern int start_userspace(unsigned long stub_stack);
-extern void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs);
+extern void userspace(struct uml_pt_regs *regs);
 extern void new_thread(void *stack, jmp_buf *buf, void (*handler)(void));
 extern void switch_threads(jmp_buf *me, jmp_buf *you);
 extern int start_idle_thread(void *stack, jmp_buf *switch_buf);
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 701b7bb2525e..d45c79f82d7c 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -116,7 +116,7 @@ void new_thread_handler(void)
 	 * callback returns only if the kernel thread execs a process
 	 */
 	fn(arg);
-	userspace(&current->thread.regs.regs, current_thread_info()->aux_fp_regs);
+	userspace(&current->thread.regs.regs);
 }
 
 /* Called magically, see new_thread_handler above */
@@ -133,7 +133,7 @@ static void fork_handler(void)
 
 	current->thread.prev_sched = NULL;
 
-	userspace(&current->thread.regs.regs, current_thread_info()->aux_fp_regs);
+	userspace(&current->thread.regs.regs);
 }
 
 int copy_thread(struct task_struct * p, const struct kernel_clone_args *args)
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 95376357fb17..ad2e45d80c98 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -144,16 +144,10 @@ void wait_stub_done(int pid)
 
 extern unsigned long current_stub_stack(void);
 
-static void get_skas_faultinfo(int pid, struct faultinfo *fi, unsigned long *aux_fp_regs)
+static void get_skas_faultinfo(int pid, struct faultinfo *fi)
 {
 	int err;
 
-	err = get_fp_registers(pid, aux_fp_regs);
-	if (err < 0) {
-		printk(UM_KERN_ERR "save_fp_registers returned %d\n",
-		       err);
-		fatal_sigsegv();
-	}
 	err = ptrace(PTRACE_CONT, pid, 0, SIGSEGV);
 	if (err) {
 		printk(UM_KERN_ERR "Failed to continue stub, pid = %d, "
@@ -167,18 +161,11 @@ static void get_skas_faultinfo(int pid, struct faultinfo *fi, unsigned long *aux
 	 * the stub stack page. We just have to copy it.
 	 */
 	memcpy(fi, (void *)current_stub_stack(), sizeof(*fi));
-
-	err = put_fp_registers(pid, aux_fp_regs);
-	if (err < 0) {
-		printk(UM_KERN_ERR "put_fp_registers returned %d\n",
-		       err);
-		fatal_sigsegv();
-	}
 }
 
-static void handle_segv(int pid, struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
+static void handle_segv(int pid, struct uml_pt_regs *regs)
 {
-	get_skas_faultinfo(pid, &regs->faultinfo, aux_fp_regs);
+	get_skas_faultinfo(pid, &regs->faultinfo);
 	segv(regs->faultinfo, 0, 1, NULL);
 }
 
@@ -408,7 +395,7 @@ int start_userspace(unsigned long stub_stack)
 int unscheduled_userspace_iterations;
 extern unsigned long tt_extra_sched_jiffies;
 
-void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
+void userspace(struct uml_pt_regs *regs)
 {
 	int err, status, op, pid = userspace_pid[0];
 	siginfo_t si;
@@ -527,11 +514,11 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 			case SIGSEGV:
 				if (PTRACE_FULL_FAULTINFO) {
 					get_skas_faultinfo(pid,
-							   &regs->faultinfo, aux_fp_regs);
+							   &regs->faultinfo);
 					(*sig_info[SIGSEGV])(SIGSEGV, (struct siginfo *)&si,
 							     regs);
 				}
-				else handle_segv(pid, regs, aux_fp_regs);
+				else handle_segv(pid, regs);
 				break;
 			case SIGTRAP + 0x80:
 				handle_trap(pid, regs);
-- 
2.46.2


