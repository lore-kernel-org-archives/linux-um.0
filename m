Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68875C433FE
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 10:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iSPXSBFICwj1ZxczI8MQYgjojpKQ0I2HZrTUNPRm21Y=; b=OCnETBaAG6iZet
	JcxHLDXp21pVMWFIgMbRlz21OXFqEQrxSi7ge34w6MzmWktqwuIav06tobRwP4mmfANvyrOfEpo/A
	DOJgdh2J5ZCqCCjN8rElBDvp9Klbn+N+XCvIp3EF6g+yDrEz01UQW+BNzxpjWlLR/Yrow9JKL+ruR
	aVVAaPYaUhhJ1GCGu2qulD6jFXGFYreShdbBIp88qClPwun1MYDGdGwlOJES+hIg3wrLCFZkmUdZn
	2T9erL8te3FTkapkLyXYTtTRqERRDm/dFXNw9p7CcIgVYK4EV9ZRH+cAWsvsm2CspBSAPwNeoU9+S
	CXRqYEcTgMr+GaRiy+Zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQFU-007g8a-Ao; Tue, 22 Nov 2022 10:11:28 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQF3-007feW-Fy
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 10:11:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=q3vBrqGWi2ofI9DhNMJnDnuBl39sYbcsd6mqWJjSse0=;
	t=1669111861; x=1670321461; b=HYK8xpCHt/ASxGSTWRtsPSzxGLN/++RHcQtaoX7y6lKMymK
	R88grBHfTXrsWmccMYhtrcxqsca2J151IrMAg3TxI/rPJx2ADTujPEF9VY7jzhZa7QlN7OU93BeBO
	7XvMcPAjHgvzG0C/qgopDug5wzyG/8bR6zhJAzDO8rqJcNQBR7C25dvEzqHQV820leaTgX12b8dNT
	hbapmDW2pFier4wm+zbTFCDm3hFKR1BS6Sn9jEMU2SNXMNIsCR0uq3HtLIHrAxAx9Mq7qAKUwn1Bn
	b0nve8xHQkZfJG4aVLdfCMjJAYnKK3U7VyLpblacxrUuQaPgvFZqSgoDlv2CzySQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1oxQEn-006IGn-2I;
	Tue, 22 Nov 2022 11:10:45 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 07/28] um: Do not use printk in SIGWINCH helper thread
Date: Tue, 22 Nov 2022 11:07:38 +0100
Message-Id: <20221122100759.208290-8-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122100759.208290-1-benjamin@sipsolutions.net>
References: <20221122100759.208290-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_021101_613442_710B5902 
X-CRM114-Status: GOOD (  12.36  )
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

The thread is running outside of the UML kernel scope and is a helper.
As such, printk cannot work and os_info must be used instead.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/drivers/chan_user.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
index 25727ed648b7..c2b83cb99aae 100644
--- a/arch/um/drivers/chan_user.c
+++ b/arch/um/drivers/chan_user.c
@@ -153,8 +153,8 @@ static int winch_thread(void *arg)
 	pipe_fd = data->pipe_fd;
 	count = write(pipe_fd, &c, sizeof(c));
 	if (count != sizeof(c))
-		printk(UM_KERN_ERR "winch_thread : failed to write "
-		       "synchronization byte, err = %d\n", -count);
+		os_info("winch_thread : failed to write synchronization byte, err = %d\n",
+			-count);
 
 	/*
 	 * We are not using SIG_IGN on purpose, so don't fix it as I thought to
@@ -166,28 +166,28 @@ static int winch_thread(void *arg)
 	sigfillset(&sigs);
 	/* Block all signals possible. */
 	if (sigprocmask(SIG_SETMASK, &sigs, NULL) < 0) {
-		printk(UM_KERN_ERR "winch_thread : sigprocmask failed, "
-		       "errno = %d\n", errno);
+		os_info("winch_thread : sigprocmask failed, errno = %d\n",
+			errno);
 		exit(1);
 	}
 	/* In sigsuspend(), block anything else than SIGWINCH. */
 	sigdelset(&sigs, SIGWINCH);
 
 	if (setsid() < 0) {
-		printk(UM_KERN_ERR "winch_thread : setsid failed, errno = %d\n",
+		os_info("winch_thread : setsid failed, errno = %d\n",
 		       errno);
 		exit(1);
 	}
 
 	if (ioctl(pty_fd, TIOCSCTTY, 0) < 0) {
-		printk(UM_KERN_ERR "winch_thread : TIOCSCTTY failed on "
-		       "fd %d err = %d\n", pty_fd, errno);
+		os_info("winch_thread : TIOCSCTTY failed on "
+			"fd %d err = %d\n", pty_fd, errno);
 		exit(1);
 	}
 
 	if (tcsetpgrp(pty_fd, os_getpid()) < 0) {
-		printk(UM_KERN_ERR "winch_thread : tcsetpgrp failed on "
-		       "fd %d err = %d\n", pty_fd, errno);
+		os_info("winch_thread : tcsetpgrp failed on fd %d err = %d\n",
+			pty_fd, errno);
 		exit(1);
 	}
 
@@ -199,8 +199,8 @@ static int winch_thread(void *arg)
 	 */
 	count = read(pipe_fd, &c, sizeof(c));
 	if (count != sizeof(c))
-		printk(UM_KERN_ERR "winch_thread : failed to read "
-		       "synchronization byte, err = %d\n", errno);
+		os_info("winch_thread : failed to read synchronization byte, err = %d\n",
+			errno);
 
 	while(1) {
 		/*
@@ -211,8 +211,8 @@ static int winch_thread(void *arg)
 
 		count = write(pipe_fd, &c, sizeof(c));
 		if (count != sizeof(c))
-			printk(UM_KERN_ERR "winch_thread : write failed, "
-			       "err = %d\n", errno);
+			os_info("winch_thread : write failed, err = %d\n",
+				errno);
 	}
 }
 
-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
