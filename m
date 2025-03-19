Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EC9C35FFC
	for <linux-um@archiver.kernel.org>; Wed, 19 Mar 2025 13:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LO55YnJPL63/5LkQVrpMrZ7iNo6O82vjLztXQCcsOWU=; b=ARZ1NFyLh81NIrwPRdMtIBhxJV
	Y2HLFdgGoM60hlB21jWGBOfR5MBfxbhpn5ONm7HKsFz3pSM0RPWkLonbCX4Cm1EMX2+IK+HrWgY0F
	LX1C/GHxMnBfLQHgZHUzDka8JZnJevoGAN+RREyhgqUEc3hRDDqz/zp6DNrlHwwEqaw63m2C1qG02
	HkBV7dDit1bsDSUli2g+5MGP8pWim1x8bBn4tdpsDh1xvUI/PMibP7s8F8s5dGoropoR9247Mcvn5
	LhIQq4V5YrpzUl6p6gxOyn8xNCQ3ulu4uTVtDCQrVetmayvnWeNdPhQE+vtV28uQeIQLhMiQ9jz5a
	kTAR5e7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuttX-000000098VG-2gfZ;
	Wed, 19 Mar 2025 13:55:43 +0000
Received: from out0-198.mail.aliyun.com ([140.205.0.198])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuttT-000000098Sz-1UJ7
	for linux-um@lists.infradead.org;
	Wed, 19 Mar 2025 13:55:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1742392536; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=LO55YnJPL63/5LkQVrpMrZ7iNo6O82vjLztXQCcsOWU=;
	b=l4nYxjUGh5fxpTIZSDFL0z+kb96EW3sq7gM+t//y5NTdavs0Z009i+lXjnODFe1oYL4tubCBBoeyaKfgbtV9+zbXQscpMZoNDvNYsRw1eEweVJq3uRxTpeVqTamV5j053hk0C4tiUuzibnogUFVt2DSj/UHEwhAuuFM8IxQqnzc=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.byXmrk._1742392533 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 19 Mar 2025 21:55:33 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 2/4] um: ubd: Switch to the pthread-based helper
Date: Wed, 19 Mar 2025 21:55:21 +0800
Message-Id: <20250319135523.97050-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319135523.97050-1-tiwei.btw@antgroup.com>
References: <20250319135523.97050-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_065539_904274_770580D6 
X-CRM114-Status: GOOD (  13.89  )
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


