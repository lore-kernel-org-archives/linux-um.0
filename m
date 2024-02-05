Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CFDC48298
	for <linux-um@archiver.kernel.org>; Mon,  5 Feb 2024 11:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h1sc6HXuCrxiSnNkExDrDx4LaNTePU3zIJt7nkVPy0U=; b=BcvowTeFtZqXOLR67/TOUWioo9
	FtmZeUo29ILpUM1hj4mU3e3euaSTR9K9GdwxLd5qV4/+a32P20JTSMBu2TpBw0STcfkV/dKVY04nC
	bEPq+07PDCfbDWq5Q3PbLmHHpM3uN1tXOIPJDhWC9cDhEGyeUOlN2v6mBmwTgdSEbNKFd5SbO9gho
	8wkdSc0AqVtWtkfMd6OHYpj4QvSCJKJzaRES968UBDKiWp3g0z+i26AAOudVvmebiMYg0zlBPNSeq
	yxymj7v02dDakA6xVztFc+3CM721XcfysGNQfv15eY0udYJKG528aNxlIYYZdAzfg8XnbzGTC+6nA
	Ac3nyNuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxRn-000000032sr-0Zwf;
	Mon, 05 Feb 2024 11:47:35 +0000
Received: from out0-202.mail.aliyun.com ([140.205.0.202])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxRh-000000032pd-2d9I
	for linux-um@lists.infradead.org;
	Mon, 05 Feb 2024 11:47:32 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047188;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.WNt.HmM_1707133639;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.WNt.HmM_1707133639)
          by smtp.aliyun-inc.com;
          Mon, 05 Feb 2024 19:47:20 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 6/6] um: Stop tracking host PID in cpu_tasks
Date: Mon, 05 Feb 2024 19:47:08 +0800
Message-Id: <20240205114708.25235-7-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205114708.25235-1-tiwei.btw@antgroup.com>
References: <20240205114708.25235-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_034729_854851_ECE5E2CB 
X-CRM114-Status: GOOD (  10.48  )
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

The host PID tracked in 'cpu_tasks' is no longer used. Stopping
tracking it will also save some cycles.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/as-layout.h |  1 -
 arch/um/kernel/process.c           | 12 ++----------
 arch/um/kernel/skas/process.c      |  4 ----
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
index 9ec3015bc5e2..c22f46a757dc 100644
--- a/arch/um/include/shared/as-layout.h
+++ b/arch/um/include/shared/as-layout.h
@@ -31,7 +31,6 @@
 #include <sysdep/ptrace.h>
 
 struct cpu_task {
-	int pid;
 	void *task;
 };
 
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 4235e2ca2664..1201c1a79b23 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -43,13 +43,7 @@
  * cares about its entry, so it's OK if another processor is modifying its
  * entry.
  */
-struct cpu_task cpu_tasks[NR_CPUS] = { [0 ... NR_CPUS - 1] = { -1, NULL } };
-
-static inline int external_pid(void)
-{
-	/* FIXME: Need to look up userspace_pid by cpu */
-	return userspace_pid[0];
-}
+struct cpu_task cpu_tasks[NR_CPUS] = { [0 ... NR_CPUS - 1] = { NULL } };
 
 void free_stack(unsigned long stack, int order)
 {
@@ -70,8 +64,7 @@ unsigned long alloc_stack(int order, int atomic)
 
 static inline void set_current(struct task_struct *task)
 {
-	cpu_tasks[task_thread_info(task)->cpu] = ((struct cpu_task)
-		{ external_pid(), task });
+	cpu_tasks[task_thread_info(task)->cpu] = ((struct cpu_task) { task });
 }
 
 extern void arch_switch_to(struct task_struct *to);
@@ -208,7 +201,6 @@ void um_idle_sleep(void)
 
 void arch_cpu_idle(void)
 {
-	cpu_tasks[current_thread_info()->cpu].pid = os_getpid();
 	um_idle_sleep();
 }
 
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index fdd5922f9222..99a5cbb36083 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -18,12 +18,8 @@ extern void start_kernel(void);
 
 static int __init start_kernel_proc(void *unused)
 {
-	int pid;
-
 	block_signals_trace();
-	pid = os_getpid();
 
-	cpu_tasks[0].pid = pid;
 	cpu_tasks[0].task = current;
 
 	start_kernel();
-- 
2.34.1


