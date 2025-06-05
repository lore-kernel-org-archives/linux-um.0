Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E0BC5AE59
	for <linux-um@archiver.kernel.org>; Thu,  5 Jun 2025 05:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r/a711glbtcVn2myrADfjGihKAcrcGeO3z0s2qIUEnM=; b=XU0Ka32vwafK0R66wzg1pwFJK/
	fgNO5WQ5l8MLInir2nSPeJAWRMc1cI2YxRkMKsIc406VplZ0r7Lm9TOGIQKqzWp/HAKblUilNkM9I
	5YsRCA3yCybG3jbJ1l4I/p1P97A5v5/AzZPyGUltSGOkTyJH7dUTsOckw/1DhvmBbVsZTilqLJSkQ
	sTkLv4xt0xilr2dft6A+0LyDZ1FkB7MXodJI3XoYZvbvvY3bM20jBcQqrvuzcLOelKKU2UnK19z5u
	FICiAZ1EwBt2XM4NXzjO5RKt1s9hivqftUuZUEdc6H3+NPQJGvN+TqNQ/XkTwTBvHKCyO04yqUmpz
	igQhyPJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uN2lx-0000000Ejkj-0C4l;
	Thu, 05 Jun 2025 05:04:13 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uN2lu-0000000EjjU-1hFK
	for linux-um@lists.infradead.org;
	Thu, 05 Jun 2025 05:04:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=r/a711glbtcVn2myrADfjGihKAcrcGeO3z0s2qIUEnM=;
	t=1749099850; x=1750309450; b=jttmn/knes2yrIHjHR2eiFlSO7wDW4s7IKs9a1J3u2X7mNu
	KL1npC+Wy9w6HJcxWI/zgv0I4KAPh8ZBIEKgw7yKJ2L/To9G5LjlaHmkusII/c7DTpFkDc5JLoyIJ
	I1vo8qm/Q6ApoFM+qSuKtGjhzl3swA+IzVqPv0EzBe4NYTNtD5JvH72O+MMdNJvyeDou9z6JZ9lnr
	zVkjnkbtDI6Wd8b0+CRZMlIygFL/a8uQTrv3484bkqXdlh73HWF1nGBmQCdyMVMx1O5JmnsIHSuwM
	cClTw+HliiHHv7PKld9QO7CxoexOZ7vU/8CCWzevgXg40QRj+MnDofJwB7pxUzcQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uN2ls-00000000rYX-2k47;
	Thu, 05 Jun 2025 07:04:08 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] um: remove "extern" from implementation of sigchld_handler
Date: Thu,  5 Jun 2025 07:03:25 +0200
Message-ID: <20250605050325.1077208-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605050325.1077208-1-benjamin@sipsolutions.net>
References: <20250605050325.1077208-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250604_220410_465753_00EF83F1 
X-CRM114-Status: UNSURE (   9.44  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin.berg@intel.com>

There is no need to mark the function as extern in the implementation.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506051226.X8r7X5aa-lkp@intel.com/
Fixes: 8420e08fe3a5 ("um: Track userspace children dying in SECCOMP mode")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/kernel/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index f1787be3983c..0dfaf96bb7da 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -691,8 +691,8 @@ void __init init_IRQ(void)
 	os_setup_epoll();
 }
 
-extern void sigchld_handler(int sig, struct siginfo *unused_si,
-			    struct uml_pt_regs *regs, void *mc)
+void sigchld_handler(int sig, struct siginfo *unused_si,
+		     struct uml_pt_regs *regs, void *mc)
 {
 	do_IRQ(SIGCHLD_IRQ, regs);
 }
-- 
2.49.0


