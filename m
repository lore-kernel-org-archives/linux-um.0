Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837AFC4167D
	for <linux-um@archiver.kernel.org>; Fri, 10 Nov 2023 11:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tLbkYq96c449ztnOcBnCNc/E0clBXxUC4uC9QQodetQ=; b=zyxhojBU+47qi4
	YRC8PRpvs/LTxWH92ppwM/oFA/SZJNKbsSXc31VhWrpDVK8Hikk4xWVVoBdaNyyNxUumfY5ObGLhr
	UbWbns4xrVB+1+Imq4o3O15U0KdVvgmiZtahgpQm3AN88TANxWQIPa1AgwslsuGytkijAL5Xg6ptw
	oatzokVimDHiody4TpfCC2N3mN22jW63rNNaPoXyystknx17E732qbz0z2djELFyfkVAfY1poVBxt
	M5vxKUY2lsiUeZFaf6cKqnVBvuCwzotndzRe/E16W5pL+6IX/FuH+d0mNtoo9PBb9CEWdkTpnLSEy
	sjrOuKLenQEJCP/5oOBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1PJH-008LxT-3A;
	Fri, 10 Nov 2023 11:04:23 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1PJE-008LtI-0k
	for linux-um@lists.infradead.org;
	Fri, 10 Nov 2023 11:04:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=woA2BTAPP7SMj4m7X9vChRuLJnoxacy/0022MV8IvNw=;
	t=1699614260; x=1700823860; b=B+qdaEokgeRH643uLrXuHVI1zYXNkFNyFz4oYlHsfZEzXwm
	Vvqmcv3g+ggmVWx/8Jzxa3XXpff00IZxMIqhTkFpZhKifA+p7ZsK7yovNG9K53vpFQC3yy110jrZW
	uQkbEmmYURVutMOv/HcCQ9LghrpfGhp9pdTEJXRBAunDdT2hJ44yWwVKskvKPYGnKu1Q7wyxzD/z0
	pZ4D4z+ec2z8PBi0b+FXlB+/LO2yoezTCFZuZo43z1R2DE1KBF1ClVs4Y3e6X7N1Z3jLIXvPcEXpE
	M35SfGdXnzxjJ23cxi6xrwyfOIrTO0Ip77AzE2p0YDJG7YbJGceI6pUZ/Eh5UEBQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1r1PJB-00000002xHc-166b;
	Fri, 10 Nov 2023 12:04:17 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v3 06/11] um: Reap winch thread if it fails
Date: Fri, 10 Nov 2023 12:03:43 +0100
Message-ID: <20231110110348.1815612-7-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231110110348.1815612-1-benjamin@sipsolutions.net>
References: <20231110110348.1815612-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_030420_281126_019ABDDE 
X-CRM114-Status: GOOD (  14.13  )
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
index b98545f3edb5..449d320c3f55 100644
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
2.41.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
