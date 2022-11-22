Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C9AC4332F
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 10:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T6MLWL34xR7fjO2C7VmvwoDkJXjj70h5j0BNIb4Ayv8=; b=tdigwXCfCdvaZI
	lsVMVAK6DekdujFleiKfVUXzmGyv6yhvtMq365AhbgITylVaFib95Rd5azyPhbsoTJSJjr/oLrD1p
	Ke7vu/AIy1l5sK9B9TcWGqLLAFrNq0GAGeZAsAklFUA1vkPa5PZLmasgyv7aVqFbLzUxpqrkGvkD+
	al+Vf8w6g7mSqjlUpq5lwlEfauCyD71oBYvNuTjGowUQ4bBIBzHgumEzbdLBFMv39uhciyOCGa2J9
	5sxHvLb7+O/rIstjd1DxTexmufw7yafpUu9P3k5cvyXSGaZ4qFUaPIefupux3YYjO2s11fOXf3thD
	vnXjwNobqicLQZ7T1g6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQF6-007fmy-7U; Tue, 22 Nov 2022 10:11:04 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQF0-007fe9-CD
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 10:11:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=BJKokeRAEKHYkeQxTGpfYpvpAWyEzK7xVP2J/oRVm0Q=;
	t=1669111855; x=1670321455; b=Q9RFhfXRKlltYd4nKv57YY1oqDuelCVpPcoqhCHSzs2B0ag
	YUYYXkkCXmPtryjBBVR1l74IeGGkI3Z7Irp48/kZ0T9uO781ns6I/ieyky8D4aYkx+dLHUrIye9pb
	P6toIUmeeLfkWahwJhZ4/s8nGZeHWuy5FQZcGC1v6jW7zeIdqHgX2Oh0ZJ20Nzt6b7vTvkO+l2nTL
	1N7L6Lcxy/M3BLGqptuPQNb9XCDnEBgLoyYR/vJvmQ9D8dY1Mbi+zFLbc9cwQP/d7v4x1igIlW7mL
	t+kUvgfaN0wN6Bc4cN/9kH85OCrzQtizm8sgVm3UdaBmAVndBtiFA8aGtoDy/aHQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1oxQEm-006IGn-2K;
	Tue, 22 Nov 2022 11:10:44 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 02/28] um: Declare fix_range_common as a static function
Date: Tue, 22 Nov 2022 11:07:33 +0100
Message-Id: <20221122100759.208290-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122100759.208290-1-benjamin@sipsolutions.net>
References: <20221122100759.208290-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_021058_493607_49403AE4 
X-CRM114-Status: UNSURE (   8.75  )
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

It is only used within the same file.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/kernel/tlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index bc38f79ca3a3..3c709e6146dc 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -314,8 +314,8 @@ static inline int update_p4d_range(pgd_t *pgd, unsigned long addr,
 	return ret;
 }
 
-void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
-		      unsigned long end_addr, int force)
+static void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
+			     unsigned long end_addr, int force)
 {
 	pgd_t *pgd;
 	struct host_vm_change hvc;
-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
