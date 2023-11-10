Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A18C41535
	for <linux-um@archiver.kernel.org>; Fri, 10 Nov 2023 11:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dfQnyAuQ1ijJcCHT1B48scGUU4EtVgxxnYtrm0C1wXI=; b=JWEmDcCcOFBInx
	kDBC5Tpa4/khoDV+bpYfPo+pB15PxsL2KiqADKszwde2fNkU0DvFK9VKQUuj7mmfCCyZvVfIDikYD
	1QUn1HnDBmVtEpqbvy5XnitWJCkP3TgtbW3rvwZpu3OWOmZBuweeMe4LaTZV+NCXjwCJjZpS6Pw8k
	Wto3/pqYWAst/JE0PmblVFa5B5114MMwvmTkBd/3RFJZSFABVKzhWNIrBlqPIofpA0twiQ1IEOh8L
	mDXVHRn+1IT4FHFjozdF2yd+8vTc4qCqOxjTix5j7RC1xIIUYXO6NiirTlAlj1btU/kk/izNS0e72
	BpUU858N5f7Dis7g2EmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1PJH-008Lwm-1l;
	Fri, 10 Nov 2023 11:04:23 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1PJD-008LsB-20
	for linux-um@lists.infradead.org;
	Fri, 10 Nov 2023 11:04:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LCw74n8RPiWq/NfqzuRj0fguTXRAiWA77OLMqz9dhVI=;
	t=1699614259; x=1700823859; b=Sm5aAb/P3JSa2yspHLO2ob6wwvg3ShzTY+xAosA1tWgsaiF
	VPYctG0R6Pj/0u3pknHNqG8QfdH5f+qN4e0Uz20p5tuiBq2jpRTU+jV+VdI7NTRlxZWuhRor06G1j
	yjQpOuwBz2FxrppRmpXZFkOPjAG7+K2QgM0VUW0BfZ6IODsk22KMi13nJpubOdz2qFrnkkQfh/wqz
	+feBskH+UbQsVt7v7ZqZ1sxmuXULgrvbecxzL1SDyeNGGwlES7SO72dLBStwFZtoSV8ECq4wa5srK
	ezPAhiOTJcKpIuVUdnxiBkNOzvEVFlR71VS0J4vncXNpUcIAUAYcenXSK7Qv/6NQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1r1PJA-00000002xHc-1v5j;
	Fri, 10 Nov 2023 12:04:16 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v3 05/11] um: Do not use printk in SIGWINCH helper thread
Date: Fri, 10 Nov 2023 12:03:42 +0100
Message-ID: <20231110110348.1815612-6-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231110110348.1815612-1-benjamin@sipsolutions.net>
References: <20231110110348.1815612-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_030419_658959_FF739AE9 
X-CRM114-Status: GOOD (  12.59  )
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
2.41.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
