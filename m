Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FCCE7107E
	for <linux-um@archiver.kernel.org>; Thu, 21 Sep 2023 14:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=odK7dbfQ2t1/1Rhs+4q8ZvtmpQAMfNdsv5DeoMEcGCU=; b=hLmTENCtIwBI4b
	yvPrqj6AyLdWVHB6P2SdFU/lYUU3GWwY3/23xUqGfxRmAS984M2yhCV8aDhWIZASn/u2yxbb9lSZl
	Xi6a60HLhW705IUJetd1ujlsW8ZLtrd4/yyfLfYEAdYP4ryrtMIgEAKqe7sxq57HTuZ8moGsScRB7
	XLsnQDB27H9T2YUNaJZZWJf6bWrbVnU72/Y4ccjoycWGXagCLO6phqSk51HYTWnT3ZMkjqUX34aOR
	nm3+RzqTh4qWxudLZbFTzxsVnqRnFC8PKnaFdtci1hH4WeClbGa6xxx8a+XuhAdaGOFfj8CFEW81K
	cGYqpT7kJ+qii94lyBHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjKlZ-006IkS-2m;
	Thu, 21 Sep 2023 14:34:53 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjKlX-006Ij1-2D
	for linux-um@lists.infradead.org;
	Thu, 21 Sep 2023 14:34:53 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjKlV-002Ypz-LJ; Thu, 21 Sep 2023 14:34:49 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjKlS-0016sa-5J; Thu, 21 Sep 2023 15:34:48 +0100
From: anton.ivanov@cambridgegreys.com
To: linux-um@lists.infradead.org
Cc: johannes@sipsolutions.net,
	richard@nod.at,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [PATCH] um: Fix naming clash between UML and scheduler
Date: Thu, 21 Sep 2023 15:34:44 +0100
Message-Id: <20230921143444.264668-1-anton.ivanov@cambridgegreys.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_073451_721389_A9E4838F 
X-CRM114-Status: GOOD (  10.40  )
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

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

__cant_sleep was already used and exported by the scheduler.
The name had to be changed to a UML specific one.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/include/shared/kern_util.h | 2 +-
 arch/um/kernel/process.c           | 2 +-
 arch/um/os-Linux/helper.c          | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index d8b8b4f07e42..444bae755b16 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -50,7 +50,7 @@ extern void do_uml_exitcalls(void);
  * Are we disallowed to sleep? Used to choose between GFP_KERNEL and
  * GFP_ATOMIC.
  */
-extern int __cant_sleep(void);
+extern int __uml_cant_sleep(void);
 extern int get_current_pid(void);
 extern int copy_from_user_proc(void *to, void *from, int size);
 extern char *uml_strdup(const char *string);
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 106b7da2f8d6..6daffb9d8a8d 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -220,7 +220,7 @@ void arch_cpu_idle(void)
 	um_idle_sleep();
 }
 
-int __cant_sleep(void) {
+int __uml_cant_sleep(void) {
 	return in_atomic() || irqs_disabled() || in_interrupt();
 	/* Is in_interrupt() really needed? */
 }
diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index b459745f52e2..3cb8ac63be6e 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -46,7 +46,7 @@ int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv)
 	unsigned long stack, sp;
 	int pid, fds[2], ret, n;
 
-	stack = alloc_stack(0, __cant_sleep());
+	stack = alloc_stack(0, __uml_cant_sleep());
 	if (stack == 0)
 		return -ENOMEM;
 
@@ -70,7 +70,7 @@ int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv)
 	data.pre_data = pre_data;
 	data.argv = argv;
 	data.fd = fds[1];
-	data.buf = __cant_sleep() ? uml_kmalloc(PATH_MAX, UM_GFP_ATOMIC) :
+	data.buf = __uml_cant_sleep() ? uml_kmalloc(PATH_MAX, UM_GFP_ATOMIC) :
 					uml_kmalloc(PATH_MAX, UM_GFP_KERNEL);
 	pid = clone(helper_child, (void *) sp, CLONE_VM, &data);
 	if (pid < 0) {
@@ -121,7 +121,7 @@ int run_helper_thread(int (*proc)(void *), void *arg, unsigned int flags,
 	unsigned long stack, sp;
 	int pid, status, err;
 
-	stack = alloc_stack(0, __cant_sleep());
+	stack = alloc_stack(0, __uml_cant_sleep());
 	if (stack == 0)
 		return -ENOMEM;
 
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
