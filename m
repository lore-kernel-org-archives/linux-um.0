Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190FAC021B6
	for <linux-um@archiver.kernel.org>; Fri, 21 Feb 2025 08:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uTUBY6NOSciWXb+Cz+BPg9RpaQ+XcUESJIcfVNloPW4=; b=gYvVrCDtLyGqQoxnPJV5YLQ7gB
	63qQVuUxI/MyVr47Q4ISBEMQCxDLqii/FY7UJvJedngZ7e8aG7dm1646eVb+f3THQQbqhVZRDfjya
	f8iX8fEpyF+LVIRJOrxmmJPeuj6pkz8emPy4O9YbzZY+griAW6sHYJBBxkxwOl/ijvVJf1eFwZbPB
	L11F2MQgq4FVXiIunzOSFaNL0d9TqzTvMBl/fVZjvgobbFcB2u9vF/bZ3ev/xDTwurGMbvvbs1E3i
	GfxbXdD48QvIPLV5eaYs5kEC7IZwVqwCejODRgc9adM7PteqL4rp2au6/HFPAGWhm7cwikG0swoHM
	M7O9QRMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlOao-00000004kZ2-3VmH;
	Fri, 21 Feb 2025 08:41:06 +0000
Received: from out0-210.mail.aliyun.com ([140.205.0.210])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlOak-00000004kVO-1cwV
	for linux-um@lists.infradead.org;
	Fri, 21 Feb 2025 08:41:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1740127260; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=uTUBY6NOSciWXb+Cz+BPg9RpaQ+XcUESJIcfVNloPW4=;
	b=GFIh/gNzHCPRH8J7cKNtmGfsGoZcGugBTMIrekpN/sihMmfLpR9k+p+zrsavctWLS8ZRScZYjyCYt3+Qlsx/iq8KKJ/zF+xMUlo5eTPGVC7GYUJNaHMOU7vtOsTK09ejz/libIM7Lw4grYJsgqELNhGQW05Vqfgwk5QD9ID+bp4=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.bYJdX6V_1740127258 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 21 Feb 2025 16:40:58 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 3/4] um: Switch to the pthread-based helper in sigio workaround
Date: Fri, 21 Feb 2025 16:40:48 +0800
Message-Id: <20250221084049.1332318-4-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221084049.1332318-1-tiwei.btw@antgroup.com>
References: <20250221084049.1332318-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250221_004102_955247_E25DCD77 
X-CRM114-Status: GOOD (  16.48  )
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

The write_sigio thread and UML kernel thread share the same errno,
which can lead to conflicts when both call syscalls concurrently.
Switch to the pthread-based helper to address this issue.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/sigio.c | 44 +++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
index 9aac8def4d63..84edfef505a0 100644
--- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -21,8 +21,7 @@
  * Protected by sigio_lock(), also used by sigio_cleanup, which is an
  * exitcall.
  */
-static int write_sigio_pid = -1;
-static unsigned long write_sigio_stack;
+static void *write_sigio_td;
 
 /*
  * These arrays are initialized before the sigio thread is started, and
@@ -48,15 +47,15 @@ static struct pollfds current_poll;
 static struct pollfds next_poll;
 static struct pollfds all_sigio_fds;
 
-static int write_sigio_thread(void *unused)
+static void *write_sigio_thread(void *unused)
 {
 	struct pollfds *fds, tmp;
 	struct pollfd *p;
 	int i, n, respond_fd;
 	char c;
 
-	os_set_pdeathsig();
-	os_fix_helper_signals();
+	os_fix_helper_thread_signals();
+
 	fds = &current_poll;
 	while (1) {
 		n = poll(fds->poll, fds->used, -1);
@@ -98,7 +97,7 @@ static int write_sigio_thread(void *unused)
 		}
 	}
 
-	return 0;
+	return NULL;
 }
 
 static int need_poll(struct pollfds *polls, int n)
@@ -152,11 +151,10 @@ static void update_thread(void)
 	return;
  fail:
 	/* Critical section start */
-	if (write_sigio_pid != -1) {
-		os_kill_process(write_sigio_pid, 1);
-		free_stack(write_sigio_stack, 0);
+	if (write_sigio_td) {
+		os_kill_helper_thread(write_sigio_td);
+		write_sigio_td = NULL;
 	}
-	write_sigio_pid = -1;
 	close(sigio_private[0]);
 	close(sigio_private[1]);
 	close(write_sigio_fds[0]);
@@ -220,7 +218,7 @@ int __ignore_sigio_fd(int fd)
 	 * sigio_cleanup has already run, then update_thread will hang
 	 * or fail because the thread is no longer running.
 	 */
-	if (write_sigio_pid == -1)
+	if (!write_sigio_td)
 		return -EIO;
 
 	for (i = 0; i < current_poll.used; i++) {
@@ -279,14 +277,14 @@ static void write_sigio_workaround(void)
 	int err;
 	int l_write_sigio_fds[2];
 	int l_sigio_private[2];
-	int l_write_sigio_pid;
+	void *l_write_sigio_td;
 
 	/* We call this *tons* of times - and most ones we must just fail. */
 	sigio_lock();
-	l_write_sigio_pid = write_sigio_pid;
+	l_write_sigio_td = write_sigio_td;
 	sigio_unlock();
 
-	if (l_write_sigio_pid != -1)
+	if (l_write_sigio_td)
 		return;
 
 	err = os_pipe(l_write_sigio_fds, 1, 1);
@@ -312,7 +310,7 @@ static void write_sigio_workaround(void)
 	 * Did we race? Don't try to optimize this, please, it's not so likely
 	 * to happen, and no more than once at the boot.
 	 */
-	if (write_sigio_pid != -1)
+	if (write_sigio_td)
 		goto out_free;
 
 	current_poll = ((struct pollfds) { .poll 	= p,
@@ -325,18 +323,15 @@ static void write_sigio_workaround(void)
 	memcpy(write_sigio_fds, l_write_sigio_fds, sizeof(l_write_sigio_fds));
 	memcpy(sigio_private, l_sigio_private, sizeof(l_sigio_private));
 
-	write_sigio_pid = run_helper_thread(write_sigio_thread, NULL,
-					    CLONE_FILES | CLONE_VM,
-					    &write_sigio_stack);
-
-	if (write_sigio_pid < 0)
+	err = os_run_helper_thread(write_sigio_thread, NULL, &write_sigio_td);
+	if (err < 0)
 		goto out_clear;
 
 	sigio_unlock();
 	return;
 
 out_clear:
-	write_sigio_pid = -1;
+	write_sigio_td = NULL;
 	write_sigio_fds[0] = -1;
 	write_sigio_fds[1] = -1;
 	sigio_private[0] = -1;
@@ -394,12 +389,11 @@ void maybe_sigio_broken(int fd)
 
 static void sigio_cleanup(void)
 {
-	if (write_sigio_pid == -1)
+	if (!write_sigio_td)
 		return;
 
-	os_kill_process(write_sigio_pid, 1);
-	free_stack(write_sigio_stack, 0);
-	write_sigio_pid = -1;
+	os_kill_helper_thread(write_sigio_td);
+	write_sigio_td = NULL;
 }
 
 __uml_exitcall(sigio_cleanup);
-- 
2.34.1


