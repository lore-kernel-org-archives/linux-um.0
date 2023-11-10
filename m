Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC33C05022
	for <linux-um@archiver.kernel.org>; Fri, 10 Nov 2023 11:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qi1TE8jTBE94St1XOTMsKQFTzqa/lP9zn38ymPrsrBI=; b=XvYt9nhDalNnGr
	FzzLm84TT6KLHwurL+qkdIIpz0mdVRlJJF0EiAiZUsvs5FkRjf9/XqhN86xVIOTBW8YmVxKy2dV8H
	+LnmJ14Gq/wEWdSgoJL6B5SpTuBwL96Sr2Ys9FOx90hohINrYJIvUSOKihy5YbsiVKEMYIE57MwOw
	JoPYOUI7vDsoMxMOGd471d6rqYovrEhazMI4sqzz6Sz1VzOf8AvwQm6zJvDJOopF7/jFnk4MZscXN
	8J3tj1VQNK9dz4VBWvjhc0kamrtqypai7UM27dDCaPsL1Zo6i0wreluzSZtbazDviKHLo/HJtQpXX
	vgZ9w8VdZS0IXNg6xWhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1PJJ-008LzH-0x;
	Fri, 10 Nov 2023 11:04:25 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1PJF-008LuS-2n
	for linux-um@lists.infradead.org;
	Fri, 10 Nov 2023 11:04:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GXgmy9ulqQI8/ZdTq66uLGbRnKSrNcOv3LyY7ioFOP8=;
	t=1699614261; x=1700823861; b=L46ZyBoLZOpMdz3mQICWm3IprCmIfG3vXqRMPedAmaxdrYy
	646Avso7HREuesigIBoNeLrD83GcITLEQKPCfudUkydqpdJJ3hZ0V9N5+BR1x1e5o3LxntqC1QmX6
	yQ3UbTlBahkhu2TRURT/thUS5l0itO03YplwovFuXn/DNP6iVnifZFJru8QgJ93dcZrNz+J04RsiI
	ASZeySibCoHUk8pHveex+eCMsuYqBenhIMSLtFgQWGbbSSUEO70+TP+dZhoWXQu0vFictBPieSEnF
	0AhiyZ8MTcYqIDjD5e15bINj7BXVqpynW8UYOZP/CnbaovA4f0DqxZaW9DS9ocLA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1r1PJC-00000002xHc-0CEx;
	Fri, 10 Nov 2023 12:04:18 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v3 07/11] um: Do not use printk in userspace trampoline
Date: Fri, 10 Nov 2023 12:03:44 +0100
Message-ID: <20231110110348.1815612-8-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231110110348.1815612-1-benjamin@sipsolutions.net>
References: <20231110110348.1815612-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_030421_937594_9B8F3E04 
X-CRM114-Status: UNSURE (   9.83  )
X-CRM114-Notice: Please train this message.
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

The trampoline is running in a cloned process. It is not safe to use
printk for error printing there.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/os-Linux/skas/process.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index ed20cefb2963..1f5c3f2523d1 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -221,8 +221,8 @@ static int userspace_tramp(void *stack)
 	addr = mmap64((void *) STUB_CODE, UM_KERN_PAGE_SIZE,
 		      PROT_EXEC, MAP_FIXED | MAP_PRIVATE, fd, offset);
 	if (addr == MAP_FAILED) {
-		printk(UM_KERN_ERR "mapping mmap stub at 0x%lx failed, errno = %d\n",
-		       STUB_CODE, errno);
+		os_info("mapping mmap stub at 0x%lx failed, errno = %d\n",
+			STUB_CODE, errno);
 		exit(1);
 	}
 
@@ -231,8 +231,8 @@ static int userspace_tramp(void *stack)
 		    STUB_DATA_PAGES * UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
 		    MAP_FIXED | MAP_SHARED, fd, offset);
 	if (addr == MAP_FAILED) {
-		printk(UM_KERN_ERR "mapping segfault stack at 0x%lx failed, errno = %d\n",
-		       STUB_DATA, errno);
+		os_info("mapping segfault stack at 0x%lx failed, errno = %d\n",
+			STUB_DATA, errno);
 		exit(1);
 	}
 
@@ -242,8 +242,8 @@ static int userspace_tramp(void *stack)
 	sa.sa_sigaction = (void *) segv_handler;
 	sa.sa_restorer = NULL;
 	if (sigaction(SIGSEGV, &sa, NULL) < 0) {
-		printk(UM_KERN_ERR "%s - setting SIGSEGV handler failed - errno = %d\n",
-		       __func__, errno);
+		os_info("%s - setting SIGSEGV handler failed - errno = %d\n",
+			__func__, errno);
 		exit(1);
 	}
 
-- 
2.41.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
