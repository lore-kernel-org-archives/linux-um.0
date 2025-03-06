Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE2DC28B26
	for <linux-um@archiver.kernel.org>; Thu,  6 Mar 2025 15:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LO55YnJPL63/5LkQVrpMrZ7iNo6O82vjLztXQCcsOWU=; b=xucoKdnuWy2MSxqoP4fSaEZLDK
	TiMsqckvUHknuyVUt1nc39EMqALLtiwY8bI1WAqAcyWcDD6PLq5xKW1PZ5oJBXYzl1PNSQuRqngq2
	PHpJ6PyFiYpV9G0yCwueQhL7FleUtmCtrF7FA4l3A2bfEzaNtuIss/M0PLQKL65bQvy1+thIY5F4T
	YNPotffjiDC5tFZIaz6v8uta6wGFqgmXaU/THxFZjhApNXf17oJM71Jr7x+IpW//Y+08vewQF9nmR
	aXeNIxhYvhxViQRrMDQsICSDicnNXqfbXxqolaVP+9yIXf1nYVqqGcRNBI33VIrK5X6K6ccz8ydnW
	pcdSLbMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqCpT-0000000BHQu-1QK2;
	Thu, 06 Mar 2025 15:08:07 +0000
Received: from out0-200.mail.aliyun.com ([140.205.0.200])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqCpQ-0000000BHNj-1cSw
	for linux-um@lists.infradead.org;
	Thu, 06 Mar 2025 15:08:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1741273679; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=LO55YnJPL63/5LkQVrpMrZ7iNo6O82vjLztXQCcsOWU=;
	b=dB1gdIjfRDJ6AskNuxcQMzE4S9TN3qGKwfbr1sMITyrfxVlpdHKGXK0KKnpwoo1kAiuKOCWT5JRTLRhy+oEZYpaJxKzekMzd6U0oVeK3eFXEPL8CAJfZSc3QCe5inDa7Wj1jBbOQGcPSNggyFXmakanohRjHetE0NJivP1cwCb4=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.blx0wDE_1741273676 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 06 Mar 2025 23:07:56 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 2/4] um: ubd: Switch to the pthread-based helper
Date: Thu, 06 Mar 2025 23:07:45 +0800
Message-Id: <20250306150747.2926434-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306150747.2926434-1-tiwei.btw@antgroup.com>
References: <20250306150747.2926434-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_070804_749317_A862DD3D 
X-CRM114-Status: GOOD (  13.24  )
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

The ubd io thread and UML kernel thread share the same errno, which
can lead to conflicts when both call syscalls concurrently. Switch to
the pthread-based helper to address this issue.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/ubd.h      |  6 ++++--
 arch/um/drivers/ubd_kern.c | 25 +++++++++++--------------
 arch/um/drivers/ubd_user.c | 14 +++++++-------
 3 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/arch/um/drivers/ubd.h b/arch/um/drivers/ubd.h
index f016fe15499f..2985c14661f4 100644
--- a/arch/um/drivers/ubd.h
+++ b/arch/um/drivers/ubd.h
@@ -7,8 +7,10 @@
 #ifndef __UM_UBD_USER_H
 #define __UM_UBD_USER_H
 
-extern int start_io_thread(unsigned long sp, int *fds_out);
-extern int io_thread(void *arg);
+#include <os.h>
+
+int start_io_thread(struct os_helper_thread **td_out, int *fd_out);
+void *io_thread(void *arg);
 extern int kernel_fd;
 
 extern int ubd_read_poll(int timeout);
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 0b1e61f72fb3..4de6613e7468 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -474,12 +474,12 @@ static irqreturn_t ubd_intr(int irq, void *dev)
 }
 
 /* Only changed by ubd_init, which is an initcall. */
-static int io_pid = -1;
+static struct os_helper_thread *io_td;
 
 static void kill_io_thread(void)
 {
-	if(io_pid != -1)
-		os_kill_process(io_pid, 1);
+	if (io_td)
+		os_kill_helper_thread(io_td);
 }
 
 __uml_exitcall(kill_io_thread);
@@ -1104,8 +1104,8 @@ static int __init ubd_init(void)
 
 late_initcall(ubd_init);
 
-static int __init ubd_driver_init(void){
-	unsigned long stack;
+static int __init ubd_driver_init(void)
+{
 	int err;
 
 	/* Set by CONFIG_BLK_DEV_UBD_SYNC or ubd=sync.*/
@@ -1114,13 +1114,11 @@ static int __init ubd_driver_init(void){
 		/* Letting ubd=sync be like using ubd#s= instead of ubd#= is
 		 * enough. So use anyway the io thread. */
 	}
-	stack = alloc_stack(0, 0);
-	io_pid = start_io_thread(stack + PAGE_SIZE, &thread_fd);
-	if(io_pid < 0){
+	err = start_io_thread(&io_td, &thread_fd);
+	if (err < 0) {
 		printk(KERN_ERR
 		       "ubd : Failed to start I/O thread (errno = %d) - "
-		       "falling back to synchronous I/O\n", -io_pid);
-		io_pid = -1;
+		       "falling back to synchronous I/O\n", -err);
 		return 0;
 	}
 	err = um_request_irq(UBD_IRQ, thread_fd, IRQ_READ, ubd_intr,
@@ -1496,12 +1494,11 @@ int kernel_fd = -1;
 /* Only changed by the io thread. XXX: currently unused. */
 static int io_count;
 
-int io_thread(void *arg)
+void *io_thread(void *arg)
 {
 	int n, count, written, res;
 
-	os_set_pdeathsig();
-	os_fix_helper_signals();
+	os_fix_helper_thread_signals();
 
 	while(1){
 		n = bulk_req_safe_read(
@@ -1543,5 +1540,5 @@ int io_thread(void *arg)
 		} while (written < n);
 	}
 
-	return 0;
+	return NULL;
 }
diff --git a/arch/um/drivers/ubd_user.c b/arch/um/drivers/ubd_user.c
index b4f8b8e60564..c5e6545f6fcf 100644
--- a/arch/um/drivers/ubd_user.c
+++ b/arch/um/drivers/ubd_user.c
@@ -25,9 +25,9 @@
 
 static struct pollfd kernel_pollfd;
 
-int start_io_thread(unsigned long sp, int *fd_out)
+int start_io_thread(struct os_helper_thread **td_out, int *fd_out)
 {
-	int pid, fds[2], err;
+	int fds[2], err;
 
 	err = os_pipe(fds, 1, 1);
 	if(err < 0){
@@ -47,14 +47,14 @@ int start_io_thread(unsigned long sp, int *fd_out)
 		goto out_close;
 	}
 
-	pid = clone(io_thread, (void *) sp, CLONE_FILES | CLONE_VM, NULL);
-	if(pid < 0){
-		err = -errno;
-		printk("start_io_thread - clone failed : errno = %d\n", errno);
+	err = os_run_helper_thread(td_out, io_thread, NULL);
+	if (err < 0) {
+		printk("%s - failed to run helper thread, err = %d\n",
+		       __func__, -err);
 		goto out_close;
 	}
 
-	return(pid);
+	return 0;
 
  out_close:
 	os_close_file(fds[0]);
-- 
2.34.1


