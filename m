Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400B9C021B3
	for <linux-um@archiver.kernel.org>; Fri, 21 Feb 2025 08:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VryS9Koa85q3UfdP5krPn+J74Yu4B3FcC0RT5qQpTk8=; b=4qUgMuHT8aC+op0/QtFeoKHp7c
	09QzmzeOcgmOP089KLh1A8+BgPOe8vnc+ErdR37l1FccpuGxC9QC/e3zaPy2Mvg3C8NdqJbAJxGNh
	/cfOeAbHAdB2yriUSI0F9NzDImEiRL54KEcEQURai1t4YBe93AmvCBARlSD5LcXnLCIz3h6CvacI/
	A1oNeeX17hlz1LLaD8Tzwrq4QAL4kz6Q3bagsFZdUmcTccF4+BqVfsflSynBrF/I7gL9NS3KHnmF+
	k5qCcqlBCRQpJm6d/MH/lFeZBfwbOBzPcBl7PnD1AykivA/HQnoDYnobwLBpYMwcseEZ7gHouVqBS
	ismF4KYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlOan-00000004kYG-3hCO;
	Fri, 21 Feb 2025 08:41:05 +0000
Received: from out0-203.mail.aliyun.com ([140.205.0.203])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlOak-00000004kVQ-1fiZ
	for linux-um@lists.infradead.org;
	Fri, 21 Feb 2025 08:41:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1740127260; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=VryS9Koa85q3UfdP5krPn+J74Yu4B3FcC0RT5qQpTk8=;
	b=MhlhghgHfQ599f2s7q0ToSDOKj32y65WUpbhY98pDARg3OtYBgWkwRCuJBaJ4DPdwZ8VNsuyGuE9C5zwoZSbREVYNKRYbiK7gQYCjma4pt7w2kV44rygiWqXmWTR/s/+ZGsU8RtvLTsjST97B4gXOPZZiCXDOsKia8EooioqEGI=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.bYJdX6L_1740127258 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 21 Feb 2025 16:40:58 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 2/4] um: ubd: Switch to the pthread-based helper
Date: Fri, 21 Feb 2025 16:40:47 +0800
Message-Id: <20250221084049.1332318-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221084049.1332318-1-tiwei.btw@antgroup.com>
References: <20250221084049.1332318-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250221_004102_954623_DF9D4FA6 
X-CRM114-Status: GOOD (  13.75  )
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
 arch/um/drivers/ubd.h      |  4 ++--
 arch/um/drivers/ubd_kern.c | 25 +++++++++++--------------
 arch/um/drivers/ubd_user.c | 13 ++++++-------
 3 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/arch/um/drivers/ubd.h b/arch/um/drivers/ubd.h
index f016fe15499f..b5fae85a6b04 100644
--- a/arch/um/drivers/ubd.h
+++ b/arch/um/drivers/ubd.h
@@ -7,8 +7,8 @@
 #ifndef __UM_UBD_USER_H
 #define __UM_UBD_USER_H
 
-extern int start_io_thread(unsigned long sp, int *fds_out);
-extern int io_thread(void *arg);
+int start_io_thread(void **handle_out, int *fds_out);
+void *io_thread(void *arg);
 extern int kernel_fd;
 
 extern int ubd_read_poll(int timeout);
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 0b1e61f72fb3..43be5d5a1ed9 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -474,12 +474,12 @@ static irqreturn_t ubd_intr(int irq, void *dev)
 }
 
 /* Only changed by ubd_init, which is an initcall. */
-static int io_pid = -1;
+static void *io_td;
 
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
index b4f8b8e60564..985f6eb27f03 100644
--- a/arch/um/drivers/ubd_user.c
+++ b/arch/um/drivers/ubd_user.c
@@ -25,9 +25,9 @@
 
 static struct pollfd kernel_pollfd;
 
-int start_io_thread(unsigned long sp, int *fd_out)
+int start_io_thread(void **handle_out, int *fd_out)
 {
-	int pid, fds[2], err;
+	int fds[2], err;
 
 	err = os_pipe(fds, 1, 1);
 	if(err < 0){
@@ -47,14 +47,13 @@ int start_io_thread(unsigned long sp, int *fd_out)
 		goto out_close;
 	}
 
-	pid = clone(io_thread, (void *) sp, CLONE_FILES | CLONE_VM, NULL);
-	if(pid < 0){
-		err = -errno;
-		printk("start_io_thread - clone failed : errno = %d\n", errno);
+	err = os_run_helper_thread(io_thread, NULL, handle_out);
+	if (err < 0) {
+		printk("start_io_thread - failed to run helper thread, err = %d\n", -err);
 		goto out_close;
 	}
 
-	return(pid);
+	return 0;
 
  out_close:
 	os_close_file(fds[0]);
-- 
2.34.1


