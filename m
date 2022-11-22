Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5768CC4332F
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 10:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r1iLqhhTkKRzqdddibSKMWzqNEU9q3SR+9QcTeHSOW8=; b=qqwyI0pVtZEQoi
	CPK2lv/XEPCw/lHfyU94bxXvTFE4EWURGBw8MQfBEt4iDCjOmt3FkBUPhL+6JVMOB8glVaxnpZSAb
	acUUbUCHqdLscPBhWysTFL7zJh/+piTs+p2rN5sVXen8TKHRqgb4YIhLUwLYvubooOzMJMNN+dlXD
	2CaxPl3oH3hITiYwkvnbWABHRojaYSBkMlulsux9OFSgLPkWtHmJsFx31zQhOa6Ul6pweSrvd1d6v
	k0uc6yJ/WrQNjjJOC0AjQM/uXX050C0lHY9zop5U+R5S3cwcNchdfNMc2hAzYy1Ca30f/3833DING
	hokOPgSsUevoNIxF/oNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQUU-007nwX-Ft; Tue, 22 Nov 2022 10:26:58 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQTL-007nM8-Oc
	for linux-um@bombadil.infradead.org; Tue, 22 Nov 2022 10:25:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=5P81qnzTcChuIaNhaa4ZlDz9aT2og1d1jl4cX4zqzdc=; b=lqrcOMk3PBIc08lNxFiTRWcRQH
	9y8mSDbQ4aVlHmkEBEcf7NK5gEaZ1cJ2DavaXrvGy1p8RxazDnIyPpqQgr/bEKDeV076pj9RfWX54
	ld6byrcSb6bzgg1v4UgTtC4l23CqpT05DlCP8eZQH1uravDwTmzRuzdikT/M99TLB3Yk13hMQ9iCD
	sIoHKrRQAV7tuK7E8iIG1uXpgcuU9MjCjoL8XCkjMbocnXQVEyZB6/QJRrPLgI5qn/r3+W1Zdw5dE
	4PEeiFHBC0/sYSlZQ+rsKT1qPZ3GTDUai7L/NKPUDcS6aHHWqjd0c4yDmX8q+7vX2zfgRSkKwu9cX
	hOaa9J/g==;
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQF1-003P1t-8D
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 10:11:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5P81qnzTcChuIaNhaa4ZlDz9aT2og1d1jl4cX4zqzdc=;
	t=1669111858; x=1670321458; b=r4u2oecFtJ7uBqnvZfGiStlLCH72c+SlX3QjbDmVN3OCjBc
	RE5BAiDFj83EX1RTbSfouYEUBKlm3oLXH9ni2NURJpOwL49Eewc2rs4Styn0KAepae16FlpUhg7WZ
	xRv5MAT7OJ6xA7QgoaQy955Cl0SB/qDZ2cBCLFMtVlmhLO1KqlnltPWwWBLkKCQJhCoC5gB1XJsN0
	rlrQBp4bFIRtpAulmRd7KVpvBZqvW4N/3Xjtawd1RtqYvhhQM/MeZiSEXt7C5UyHZZrpkWZJSAgh1
	CSjU5m+9qArhzzM2pSawZ6eOz/VYBer90jogtrXkVri+YW2/FhgZBOz5B+iPuagQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1oxQEn-006IGn-32;
	Tue, 22 Nov 2022 11:10:46 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 08/28] um: Reap winch thread if it fails
Date: Tue, 22 Nov 2022 11:07:39 +0100
Message-Id: <20221122100759.208290-9-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122100759.208290-1-benjamin@sipsolutions.net>
References: <20221122100759.208290-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_101101_152800_4262880D 
X-CRM114-Status: GOOD (  13.95  )
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

From: Benjamin Berg <benjamin@sipsolutions.net>

When the winch thread runs into an error condition, it would exit(1) and
never be reaped until shutdown time. Change this to write a command byte
which causes the driver to kill it, therefore reaping the child.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/drivers/chan_user.c | 16 +++++++++++-----
 arch/um/drivers/line.c      | 13 ++++++++-----
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
index c2b83cb99aae..ed7cc830b3e7 100644
--- a/arch/um/drivers/chan_user.c
+++ b/arch/um/drivers/chan_user.c
@@ -141,7 +141,7 @@ struct winch_data {
 	int pipe_fd;
 };
 
-static int winch_thread(void *arg)
+static __noreturn int winch_thread(void *arg)
 {
 	struct winch_data *data = arg;
 	sigset_t sigs;
@@ -168,7 +168,7 @@ static int winch_thread(void *arg)
 	if (sigprocmask(SIG_SETMASK, &sigs, NULL) < 0) {
 		os_info("winch_thread : sigprocmask failed, errno = %d\n",
 			errno);
-		exit(1);
+		goto wait_kill;
 	}
 	/* In sigsuspend(), block anything else than SIGWINCH. */
 	sigdelset(&sigs, SIGWINCH);
@@ -176,19 +176,19 @@ static int winch_thread(void *arg)
 	if (setsid() < 0) {
 		os_info("winch_thread : setsid failed, errno = %d\n",
 		       errno);
-		exit(1);
+		goto wait_kill;
 	}
 
 	if (ioctl(pty_fd, TIOCSCTTY, 0) < 0) {
 		os_info("winch_thread : TIOCSCTTY failed on "
 			"fd %d err = %d\n", pty_fd, errno);
-		exit(1);
+		goto wait_kill;
 	}
 
 	if (tcsetpgrp(pty_fd, os_getpid()) < 0) {
 		os_info("winch_thread : tcsetpgrp failed on fd %d err = %d\n",
 			pty_fd, errno);
-		exit(1);
+		goto wait_kill;
 	}
 
 	/*
@@ -214,6 +214,12 @@ static int winch_thread(void *arg)
 			os_info("winch_thread : write failed, err = %d\n",
 				errno);
 	}
+
+wait_kill:
+	c = 2;
+	count = write(pipe_fd, &c, sizeof(c));
+	while (1)
+		pause();
 }
 
 static int winch_tramp(int fd, struct tty_port *port, int *fd_out,
diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 02b0befd6763..2e61899e5996 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -629,15 +629,18 @@ static irqreturn_t winch_interrupt(int irq, void *data)
 
 	if (fd != -1) {
 		err = generic_read(fd, &c, NULL);
-		if (err < 0) {
+		/* A read of 2 means the winch thread failed and has warned */
+		if (err < 0 || (err == 1 && c == 2)) {
 			if (err != -EAGAIN) {
 				winch->fd = -1;
 				list_del(&winch->list);
 				os_close_file(fd);
-				printk(KERN_ERR "winch_interrupt : "
-				       "read failed, errno = %d\n", -err);
-				printk(KERN_ERR "fd %d is losing SIGWINCH "
-				       "support\n", winch->tty_fd);
+				if (err < 0) {
+					printk(KERN_ERR "winch_interrupt : read failed, errno = %d\n",
+					       -err);
+					printk(KERN_ERR "fd %d is losing SIGWINCH support\n",
+					       winch->tty_fd);
+				}
 				INIT_WORK(&winch->work, __free_winch);
 				schedule_work(&winch->work);
 				return IRQ_HANDLED;
-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
