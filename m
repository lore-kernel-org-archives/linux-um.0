Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BF6C5321E
	for <linux-um@archiver.kernel.org>; Mon, 26 Aug 2024 10:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EEFoEIJSD/Xa9nH/fAD+A50RNInexen/VIJS9zUQYhU=; b=V25kxDmctgZLS7IlV+JvmWprhU
	pl/4A4eJaVsjpcYmyfW6kMK1F4JX6OPzNS72rwVcvjU078yR3d8DmdFU3Q+nzsA3XhdniHb1ICOGW
	irPXLQ8K+cJucXoNXzzu2wVDvTM4uEfFh+5k7QhOmMnP+hZOWRPfIgKmqPZ1cfmHClRC6GsnIgvxG
	8TZeDvF9lr4ogH0hkUL9iAeTV0K39gt/OZAC6Y5gEHOv4dY21yvKo9PTkbyx/lVhQdO0bzRLjn6MG
	9lgwMRWhyo7Z6dd3V9nFRhui7zruPg1sorGXH88htxaE6t0ivtXoyya2wU1A7w6GnZ4d6A5FemfZg
	lFRpoqUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siWlk-00000006syJ-3Muj;
	Mon, 26 Aug 2024 10:16:16 +0000
Received: from out0-220.mail.aliyun.com ([140.205.0.220])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siWeH-00000006qtj-1Vi9
	for linux-um@lists.infradead.org;
	Mon, 26 Aug 2024 10:08:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1724666908; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=EEFoEIJSD/Xa9nH/fAD+A50RNInexen/VIJS9zUQYhU=;
	b=Z2G5EU4r0Af+NCG8WUpHTmNeRINOozitmi/HrrFWWfVJFGfiVKpbpNwKpFDsisZcHiT7DeSEBk8ZkvFCRfr45uqJJVMtl7i7hLJe4yAZHD5Epv7zUsj45AzJjfyPjHs9k0/19BVBgWb9hLz1lawGgwtvNtdYy0OSdGFQdolS/dE=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Z2YRscv_1724666907)
          by smtp.aliyun-inc.com;
          Mon, 26 Aug 2024 18:08:27 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 3/7] um: Remove unused fields from thread_struct
Date: Mon, 26 Aug 2024 18:08:11 +0800
Message-Id: <20240826100815.904430-4-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826100815.904430-1-tiwei.btw@antgroup.com>
References: <20240826100815.904430-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_030833_674342_A9032660 
X-CRM114-Status: GOOD (  10.33  )
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

These fields are no longer used since the removal of tt mode.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/processor-generic.h | 20 +++++---------------
 arch/um/kernel/process.c                |  8 ++++----
 arch/um/kernel/skas/process.c           |  4 ++--
 3 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index 5a7c05275aa7..bce4595798da 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -28,20 +28,10 @@ struct thread_struct {
 	struct arch_thread arch;
 	jmp_buf switch_buf;
 	struct {
-		int op;
-		union {
-			struct {
-				int pid;
-			} fork, exec;
-			struct {
-				int (*proc)(void *);
-				void *arg;
-			} thread;
-			struct {
-				void (*proc)(void *);
-				void *arg;
-			} cb;
-		} u;
+		struct {
+			int (*proc)(void *);
+			void *arg;
+		} thread;
 	} request;
 };
 
@@ -51,7 +41,7 @@ struct thread_struct {
 	.fault_addr		= NULL, \
 	.prev_sched		= NULL, \
 	.arch			= INIT_ARCH_THREAD, \
-	.request		= { 0 } \
+	.request		= { } \
 }
 
 /*
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index f36b63f53bab..be2856af6d4c 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -109,8 +109,8 @@ void new_thread_handler(void)
 		schedule_tail(current->thread.prev_sched);
 	current->thread.prev_sched = NULL;
 
-	fn = current->thread.request.u.thread.proc;
-	arg = current->thread.request.u.thread.arg;
+	fn = current->thread.request.thread.proc;
+	arg = current->thread.request.thread.arg;
 
 	/*
 	 * callback returns only if the kernel thread execs a process
@@ -158,8 +158,8 @@ int copy_thread(struct task_struct * p, const struct kernel_clone_args *args)
 		arch_copy_thread(&current->thread.arch, &p->thread.arch);
 	} else {
 		get_safe_registers(p->thread.regs.regs.gp, p->thread.regs.regs.fp);
-		p->thread.request.u.thread.proc = args->fn;
-		p->thread.request.u.thread.arg = args->fn_arg;
+		p->thread.request.thread.proc = args->fn;
+		p->thread.request.thread.arg = args->fn_arg;
 		handler = new_thread_handler;
 	}
 
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index 5f9c1c5f36e2..68657988c8d1 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -39,8 +39,8 @@ int __init start_uml(void)
 
 	init_new_thread_signals();
 
-	init_task.thread.request.u.thread.proc = start_kernel_proc;
-	init_task.thread.request.u.thread.arg = NULL;
+	init_task.thread.request.thread.proc = start_kernel_proc;
+	init_task.thread.request.thread.arg = NULL;
 	return start_idle_thread(task_stack_page(&init_task),
 				 &init_task.thread.switch_buf);
 }
-- 
2.34.1


