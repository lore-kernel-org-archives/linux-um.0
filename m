Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E05CC531DC
	for <linux-um@archiver.kernel.org>; Fri, 16 Aug 2024 10:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MIeh/tkxVuBeL/Hw9D50Dh+vi6krP1UrWPdznGMpxyA=; b=IuheNrhbcLHGyrEohyiBhgT63D
	GHLB8mrsUoSE6xRN16/PxQTmXv3XGMjOputc6X9l78cmFu19+BN7AMR2w85caspPfRJh5kQ9qtjfG
	thVmOsvQNtVOp/JTk6LMpmeJjUNrbP1hu7RYloEc6n5Oj0iraYW8QiINCZjbdEnixXEjyNrXoddxw
	xz1DAqattG3hGC+jBMyZX1Qt0nBTPlR8zIOYUk8YsXki3Uy6LYycIcei399osVp7zFIMobKQjMwYv
	GUlUno21tIAGYEGeTmyZv6bQtTtxnFexSN4NoPLKnR3e9hDya5GRia/qSKImnNxEfpn9vchIabhj6
	uZ51r2TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1setlO-0000000CWb8-3wRS;
	Fri, 16 Aug 2024 10:00:54 +0000
Received: from out0-213.mail.aliyun.com ([140.205.0.213])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1setke-0000000CWKB-0oc9
	for linux-um@lists.infradead.org;
	Fri, 16 Aug 2024 10:00:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1723802405; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=MIeh/tkxVuBeL/Hw9D50Dh+vi6krP1UrWPdznGMpxyA=;
	b=zl6c25HpNA8zuIv8MBJTy5Y/lppVz6PKHS65q7z8o8x/GhOKaG8eUNqYuixMhjB6T3ar/hS5azPjMa7NHII12OxjM5sJlY5yxZlswNLmWh5Bn+W36q4NYQiYfFbzNK3oeI3XnFJ9OVmwXOyQ0r7R0sDWA0Pdd+qtBkxxUAu6PVo=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.YtmFE8Z_1723802404)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 18:00:04 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 4/6] um: Remove unused mm_fd field from mm_id
Date: Fri, 16 Aug 2024 17:59:51 +0800
Message-Id: <20240816095953.638401-5-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816095953.638401-1-tiwei.btw@antgroup.com>
References: <20240816095953.638401-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240816_030008_744840_B180CFB5 
X-CRM114-Status: GOOD (  12.23  )
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

It's no longer used since the removal of the SKAS3/4 support.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/skas/mm_id.h |  5 +----
 arch/um/kernel/reboot.c             |  2 +-
 arch/um/kernel/skas/mmu.c           | 12 ++++++------
 arch/um/kernel/time.c               |  2 +-
 arch/um/os-Linux/skas/mem.c         |  2 +-
 arch/um/os-Linux/skas/process.c     |  2 +-
 6 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/um/include/shared/skas/mm_id.h b/arch/um/include/shared/skas/mm_id.h
index 1e76ba40feba..140388c282f6 100644
--- a/arch/um/include/shared/skas/mm_id.h
+++ b/arch/um/include/shared/skas/mm_id.h
@@ -7,10 +7,7 @@
 #define __MM_ID_H
 
 struct mm_id {
-	union {
-		int mm_fd;
-		int pid;
-	} u;
+	int pid;
 	unsigned long stack;
 	int syscall_data_len;
 };
diff --git a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c
index 3736bca626ba..680bce4bd8fa 100644
--- a/arch/um/kernel/reboot.c
+++ b/arch/um/kernel/reboot.c
@@ -29,7 +29,7 @@ static void kill_off_processes(void)
 		t = find_lock_task_mm(p);
 		if (!t)
 			continue;
-		pid = t->mm->context.id.u.pid;
+		pid = t->mm->context.id.pid;
 		task_unlock(t);
 		os_kill_ptraced_process(pid, 1);
 	}
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 47f98d87ea3c..886ed5e65674 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -32,11 +32,11 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 	new_id->stack = stack;
 
 	block_signals_trace();
-	new_id->u.pid = start_userspace(stack);
+	new_id->pid = start_userspace(stack);
 	unblock_signals_trace();
 
-	if (new_id->u.pid < 0) {
-		ret = new_id->u.pid;
+	if (new_id->pid < 0) {
+		ret = new_id->pid;
 		goto out_free;
 	}
 
@@ -83,12 +83,12 @@ void destroy_context(struct mm_struct *mm)
 	 * whole UML suddenly dying.  Also, cover negative and
 	 * 1 cases, since they shouldn't happen either.
 	 */
-	if (mmu->id.u.pid < 2) {
+	if (mmu->id.pid < 2) {
 		printk(KERN_ERR "corrupt mm_context - pid = %d\n",
-		       mmu->id.u.pid);
+		       mmu->id.pid);
 		return;
 	}
-	os_kill_ptraced_process(mmu->id.u.pid, 1);
+	os_kill_ptraced_process(mmu->id.pid, 1);
 
 	free_pages(mmu->id.stack, ilog2(STUB_DATA_PAGES));
 }
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 47b9f5e63566..29b27b90581f 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -839,7 +839,7 @@ static irqreturn_t um_timer(int irq, void *dev)
 	if (get_current()->mm != NULL)
 	{
         /* userspace - relay signal, results in correct userspace timers */
-		os_alarm_process(get_current()->mm->context.id.u.pid);
+		os_alarm_process(get_current()->mm->context.id.pid);
 	}
 
 	(*timer_clockevent.event_handler)(&timer_clockevent);
diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index c55430775efd..9a13ac23c606 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -78,7 +78,7 @@ static inline long do_syscall_stub(struct mm_id *mm_idp)
 {
 	struct stub_data *proc_data = (void *)mm_idp->stack;
 	int n, i;
-	int err, pid = mm_idp->u.pid;
+	int err, pid = mm_idp->pid;
 
 	n = ptrace_setregs(pid, syscall_regs);
 	if (n < 0) {
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index f7088345b3fc..b6f656bcffb1 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -588,5 +588,5 @@ void reboot_skas(void)
 
 void __switch_mm(struct mm_id *mm_idp)
 {
-	userspace_pid[0] = mm_idp->u.pid;
+	userspace_pid[0] = mm_idp->pid;
 }
-- 
2.34.1


