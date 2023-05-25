Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942F7C7EE29
	for <linux-um@archiver.kernel.org>; Thu, 25 May 2023 19:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TeQyB7qM2No60DIG9FmpY8ZCQ1xaoBvJzPzaTGK2hLY=; b=ieeCRIAuXThMCb
	6qwCxnC8mrAcWx1OAy3NxJyHHDtHURXs+PikY/MWmFe82qMoqH5bypRZjdnZhCxjyt8YoYHzXbFY2
	kjx1uKyoClFtxLUqog6+0TkEAOHAxF8iFlqrRxv5ZHIB9qZ3EksJGEBl8T/1ERsyhF35ooSr3AJDs
	2aH2MjptjXwm5ihXojmS+EQ17EG96cDsSP4JdJAknR+xhVEzrGNNV0wyIx/8ieCkTxT4lE3TRTTCD
	1/H27DxjOp3K355PYTAWA1Z+CPOss4Vc/olQ2kCbH9HVDz9kpqL2wMitdj+unV4zjnR40DM0aM/K/
	UYBtT/226H2zF24eYA4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2GtT-0000Pq-2t;
	Thu, 25 May 2023 19:45:03 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2GtS-0000Ox-1d
	for linux-um@bombadil.infradead.org;
	Thu, 25 May 2023 19:45:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=624oLw7os3EpwIXLCI7BNRK4nuSK6Sw+a1R80XpNFaw=; b=QkM4hW+FzreL26dMajQimyLb23
	H3I6STWPrHib8z86unyLHgNz4pF+psUXfWO0sIJMRw3lm3YHDRpGhKWi2t/IfrJwUCqT6UTl+Smc4
	NBS0o+RvMLbjvmag9Lb1hDkPkZ4R0aANWQbV3u2qotTL/Evt9iy//z5Ctd66d6XlYYImEAhJMAW2b
	Mcw/nStN86gB0W7eaTHccHZq9ezlBfeEy9ltOKuTyBgPrIxXi1h1t1ijMj7kAKhLnUm81XENV+Y8R
	FYAvAYIxdnq4HPxLF3xADrrS/h8g6x83rWiaFO3u6c/NXKqGqFLzUbdz8mQfjRHH777TGQR+S1D4l
	z/8sY6NQ==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FpP-006dQV-2E
	for linux-um@lists.infradead.org;
	Thu, 25 May 2023 18:36:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9C72B648FE;
	Thu, 25 May 2023 18:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1220DC433EF;
	Thu, 25 May 2023 18:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685039802;
	bh=k4xLpc2kDfrZGIzuPUhhZcsIyB570BeLmlOecqYVjjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GlD5ngPP8Jcu4BRFJKag4ChNIRsGBzk0QeNXBrpV5ZjxIXvCT3TqiU+tOZ3LOAd9u
	 +UA3mJ1Or/WgsB5hpiAZoXo1E6NSXM9eIsjayHPs4oZ4qP0cyHTLBqSO6pobyNlxxn
	 aJn6+3776OphXtpebLv7dAouWM9778cTbVr9zl6fWlcwoRPxCYfWH3+6XgaBuIo1TK
	 TF4V+aIJCrgTnAH7HQBByFsGorTGYjnimIfSwDpEcrG5fVkKkTxSZ6jvBCF8XQwW2t
	 UHPXF8aJFxGNu36/ETLyG3IjaY3hSXZ+wK+rCIdljAta7eXtcz6MjSqTkvAQ35eYqs
	 zwUkh/iQ1OTDw==
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
Subject: [PATCH AUTOSEL 6.1 06/57] um: harddog: fix modular build
Date: Thu, 25 May 2023 14:35:16 -0400
Message-Id: <20230525183607.1793983-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183607.1793983-1-sashal@kernel.org>
References: <20230525183607.1793983-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_193648_066398_2CC83B31 
X-CRM114-Status: GOOD (  17.00  )
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
index e1dc4292bd22e..65b449c992d2c 100644
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
