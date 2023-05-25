Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C81C77B7E
	for <linux-um@archiver.kernel.org>; Thu, 25 May 2023 18:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o78/Py3gIHDSmV0EUAEes+1zw/puksBMQPNUf5RwG/Q=; b=OGFWWab3u3J8md
	atIhfO8nmNQSTWxc+uCa9DQ/Mk8qac9z9wfckvyxEukN6mTuRPyEnJ6kP/ZTUyzt/73m5RQTtc3BX
	awlCkWfwW4VIqsgl9p3pQXS5U2i0fmBCsxC5dymXfqX/GfgbOykMjFa4dOZH8dbT/zzG/A88PgCf0
	z3HN2LToWYA0BnOXzH7IrNdsKNEex8VAXiAtvSt6f6zGjpZEDay2q9RHEhBzP+HQ3XjweiOgNJELf
	tIQCXMabjXnZyEFtwqmX8R++4AptpwzcWTktuRk3gnQBnD49ThZll6/ioqnCCPp++4cJqZNssvWhT
	l9EhzwziPzHJkGw3KUYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Frz-00HReL-2L;
	Thu, 25 May 2023 18:39:27 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Frw-00HRdM-07
	for linux-um@lists.infradead.org;
	Thu, 25 May 2023 18:39:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9356B6494E;
	Thu, 25 May 2023 18:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E0EC433D2;
	Thu, 25 May 2023 18:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685039963;
	bh=p9ZR0WsujbR4gx/eZToGB1JXDe5wcbAbu4U+5ciWCss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hNdreVg5apfd+V88IWs6akC0Eq0L2wxVr14qcT/nV8osx/mRXAQ8cL+bhxT/BUU/G
	 FmDEheujujd8IGozxh7j0qyzFy2iJfZSQF0xTCL8OlX8WhxC/d+pcn7DnXPA4JzlQW
	 0p81stV+EMniukppPVPhZugiihpNTSctaz1pPH6Djc8IVzxl9/nQ3T0mtoEoTvWTBU
	 pW7X3igxW5hTQ5+FeWEBrw3g1SZJdGydQG1I/pIleXOaScCFI14C960uGDxXY6JXST
	 r4k5vfgT0AhqWOo/6hvAWoItuDBnGqO3aYMHGIYbSlE0zibMJ+EDi+pGqdNyjyIw+s
	 3C8g8Cuh1uaMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	kernel test robot <lkp@intel.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	masahiroy@kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 05/43] um: harddog: fix modular build
Date: Thu, 25 May 2023 14:38:16 -0400
Message-Id: <20230525183854.1855431-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183854.1855431-1-sashal@kernel.org>
References: <20230525183854.1855431-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_113924_162192_9AF015AF 
X-CRM114-Status: GOOD (  17.06  )
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 73a23d7710331a530e972903318528b75e5a5f58 ]

Since we no longer (want to) export any libc symbols the
_user portions of any drivers need to be built into image
rather than the module. I missed this for the watchdog.
Fix the watchdog accordingly.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/Makefile           | 4 +++-
 arch/um/drivers/harddog.h          | 9 +++++++++
 arch/um/drivers/harddog_kern.c     | 7 +------
 arch/um/drivers/harddog_user.c     | 1 +
 arch/um/drivers/harddog_user_exp.c | 9 +++++++++
 5 files changed, 23 insertions(+), 7 deletions(-)
 create mode 100644 arch/um/drivers/harddog.h
 create mode 100644 arch/um/drivers/harddog_user_exp.c

diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index 803666e85414a..cd1a58bb3e9cd 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -16,7 +16,8 @@ mconsole-objs := mconsole_kern.o mconsole_user.o
 hostaudio-objs := hostaudio_kern.o
 ubd-objs := ubd_kern.o ubd_user.o
 port-objs := port_kern.o port_user.o
-harddog-objs := harddog_kern.o harddog_user.o
+harddog-objs := harddog_kern.o
+harddog-builtin-$(CONFIG_UML_WATCHDOG) := harddog_user.o harddog_user_exp.o
 rtc-objs := rtc_kern.o rtc_user.o
 
 LDFLAGS_pcap.o = $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libpcap.a)
@@ -60,6 +61,7 @@ obj-$(CONFIG_PTY_CHAN) += pty.o
 obj-$(CONFIG_TTY_CHAN) += tty.o 
 obj-$(CONFIG_XTERM_CHAN) += xterm.o xterm_kern.o
 obj-$(CONFIG_UML_WATCHDOG) += harddog.o
+obj-y += $(harddog-builtin-y) $(harddog-builtin-m)
 obj-$(CONFIG_BLK_DEV_COW_COMMON) += cow_user.o
 obj-$(CONFIG_UML_RANDOM) += random.o
 obj-$(CONFIG_VIRTIO_UML) += virtio_uml.o
diff --git a/arch/um/drivers/harddog.h b/arch/um/drivers/harddog.h
new file mode 100644
index 0000000000000..6d9ea60e7133e
--- /dev/null
+++ b/arch/um/drivers/harddog.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef UM_WATCHDOG_H
+#define UM_WATCHDOG_H
+
+int start_watchdog(int *in_fd_ret, int *out_fd_ret, char *sock);
+void stop_watchdog(int in_fd, int out_fd);
+int ping_watchdog(int fd);
+
+#endif /* UM_WATCHDOG_H */
diff --git a/arch/um/drivers/harddog_kern.c b/arch/um/drivers/harddog_kern.c
index e6d4f43deba82..60d1c6cab8a95 100644
--- a/arch/um/drivers/harddog_kern.c
+++ b/arch/um/drivers/harddog_kern.c
@@ -47,6 +47,7 @@
 #include <linux/spinlock.h>
 #include <linux/uaccess.h>
 #include "mconsole.h"
+#include "harddog.h"
 
 MODULE_LICENSE("GPL");
 
@@ -60,8 +61,6 @@ static int harddog_out_fd = -1;
  *	Allow only one person to hold it open
  */
 
-extern int start_watchdog(int *in_fd_ret, int *out_fd_ret, char *sock);
-
 static int harddog_open(struct inode *inode, struct file *file)
 {
 	int err = -EBUSY;
@@ -92,8 +91,6 @@ static int harddog_open(struct inode *inode, struct file *file)
 	return err;
 }
 
-extern void stop_watchdog(int in_fd, int out_fd);
-
 static int harddog_release(struct inode *inode, struct file *file)
 {
 	/*
@@ -112,8 +109,6 @@ static int harddog_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-extern int ping_watchdog(int fd);
-
 static ssize_t harddog_write(struct file *file, const char __user *data, size_t len,
 			     loff_t *ppos)
 {
diff --git a/arch/um/drivers/harddog_user.c b/arch/um/drivers/harddog_user.c
index 070468d22e394..9ed89304975ed 100644
--- a/arch/um/drivers/harddog_user.c
+++ b/arch/um/drivers/harddog_user.c
@@ -7,6 +7,7 @@
 #include <unistd.h>
 #include <errno.h>
 #include <os.h>
+#include "harddog.h"
 
 struct dog_data {
 	int stdin_fd;
diff --git a/arch/um/drivers/harddog_user_exp.c b/arch/um/drivers/harddog_user_exp.c
new file mode 100644
index 0000000000000..c74d4b815d143
--- /dev/null
+++ b/arch/um/drivers/harddog_user_exp.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/export.h>
+#include "harddog.h"
+
+#if IS_MODULE(CONFIG_UML_WATCHDOG)
+EXPORT_SYMBOL(start_watchdog);
+EXPORT_SYMBOL(stop_watchdog);
+EXPORT_SYMBOL(ping_watchdog);
+#endif
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
