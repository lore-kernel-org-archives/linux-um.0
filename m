Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A013C3DA40
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 19:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NYxm6HJmMWAKJ6fAshLmO7RJHKejdCZeUmDhjTK4Zwg=; b=rtLyGHvTUWisF45XWeKyIES6hg
	KZ1/QdmNIfIjV/HVRq/RYUfVL84lulKdt9MjfUtUdeyDjbHd26Z8EHtsOlQihx82TOV6mPjvtu38D
	6XhLNC/Xz3AgIY9LfNZgIQC8AnSqnxusGBlxcsqOel5d+bNJzyy2OV4D9YCeQgEgnB2fw5vPUi3oU
	yvzxscNvP8WkpxdueEbfGpeDFB9YAQEMixB5TQMs1MOFbup7b5QqckMP3SgVtSMY6RPSHry+hhUx2
	nkTRa0EPVq92GD0Hwguuqa30NmFJytJFOPBpr/pG84KD0uVsk47pf3GIHCx+RUhKgTva9cFTr27HB
	wjft6dmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPRli-0000000EEGk-0deN;
	Thu, 04 Jul 2024 19:05:22 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPRlf-0000000EEDX-0KH5
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 19:05:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=NYxm6HJmMWAKJ6fAshLmO7RJHKejdCZeUmDhjTK4Zwg=;
	t=1720119918; x=1721329518; b=H0JcIfuzdz7sJOroc1BoalZypc4chO4TEc7rG/Hd0Hvt6Nr
	VvrabGUYulSI3PtIVQLUXbi4ziC4KqM4Z6NdHDjPrxSVYrWLMCNWlBLJn8cZhAiiqxFkvpPf/4bQJ
	62Ap9KxrLjuhBBbIA7GG9y+A/E8aOXBqnSNPMbh17C97+rh38P5SNMOlJWsTYXWNsqiZ1NZgMmXkb
	Imzwbh/0h9TOHuuIET8oCdOKjhhHY6ND+ZShTMoYEatoSJ0taG71UDu1p+8F8RAbmgUlJA6F/Auei
	9y8xxLllNRW5k7UBTtrDt8WU4VPeHEYMq/QHGFTL8puasW3wEJabUZJI7O3qD05w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sPRlc-0000000DrZs-4BvR;
	Thu, 04 Jul 2024 21:05:17 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v8 4/7] um: Limit TASK_SIZE to the addressable range
Date: Thu,  4 Jul 2024 21:05:03 +0200
Message-ID: <20240704190506.1438493-5-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704190506.1438493-1-benjamin@sipsolutions.net>
References: <20240704190506.1438493-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_120519_121018_9BE6E074 
X-CRM114-Status: GOOD (  10.28  )
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

We may have a TASK_SIZE from the host that is bigger than UML is able to
address with a three-level pagetable. Guard against that by clipping the
maximum TASK_SIZE to the maximum addressable area.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

v7: Fix integer overflow on 32 bit with 3-level page tables
---
 arch/um/kernel/um_arch.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 25cd2c6d7e95..f82dd4e854f3 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -334,11 +334,16 @@ int __init linux_main(int argc, char **argv)
 	stub_start -= PAGE_SIZE;
 	host_task_size = stub_start;
 
+	/* Limit TASK_SIZE to what is addressable by the page table */
+	task_size = host_task_size;
+	if (task_size > (unsigned long long) PTRS_PER_PGD * PGDIR_SIZE)
+		task_size = PTRS_PER_PGD * PGDIR_SIZE;
+
 	/*
 	 * TASK_SIZE needs to be PGDIR_SIZE aligned or else exit_mmap craps
 	 * out
 	 */
-	task_size = host_task_size & PGDIR_MASK;
+	task_size = task_size & PGDIR_MASK;
 
 	/* OS sanity checks that need to happen before the kernel runs */
 	os_early_checks();
-- 
2.45.2


