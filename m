Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E76C27C7B
	for <linux-um@archiver.kernel.org>; Wed, 12 Jun 2024 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mVdDozQhgLCHWTGkIS279cpqPxFfjKVFZDQpKU4sKrQ=; b=srJ/bKJQC5SGThIM48xj6z1jLl
	OkrEnGgso5XJ2KOopTrxitxXHVY1y0bEUyy9NJV5mFUgIpkMj1sFWX0xt8hoBZEL+OEmwo833z0lg
	oUdsAEA9zuTvdeMT/htdsq4iKJZjGrTsVSoqcn5xSohyXzmN3Nny8fz+YEUZoTu0UXQIfY3E+wHtm
	BQyHIZcSFues131pUBKqU0mnlZTIIBWShss5h/i5RfN2NU2zIENsWJQabN6nLI1CZhL957j1nXUJP
	zzIXJhdhs0oDWKLj4aGeLUlLLaclDjAwif8GAFZCAgx1aT81JW/3rgTc2a8CGIq1B3GvBwlQCUct2
	zwVLBXwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHR2f-0000000DPvX-2S8t;
	Wed, 12 Jun 2024 16:41:45 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHR2a-0000000DPsW-0FfE
	for linux-um@lists.infradead.org;
	Wed, 12 Jun 2024 16:41:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mVdDozQhgLCHWTGkIS279cpqPxFfjKVFZDQpKU4sKrQ=;
	t=1718210499; x=1719420099; b=x4OhydiYL+JCFZTUOxM5XgoyqHeB5PZ9dPMQ/3TTARtJw+J
	vfOn9Qc9XCi6g8FbYlVfIXE0HCQbEfocgeksvqBcswoW1Zjz+RZam+t6Mi9fFLwHUJ3A+9HGzXeBL
	mlPO3bQpyaZz+rTx0HjM3I/h+sPHAIMj3SnjibWFqrovaIdGPvZ4cpw8DVYoM/sM6X9oyvZ2l++LX
	15Qpnl8ZdvmOTyypyNeQpjJa41X/VROdjWBZoowJB3mRDiNnaJzpe1DeLiR7xEpeKyEw6EB/x01pw
	9/bUpskkn1azZTEqLcM9cpmomDJ7J0sw0mFrv7A/yXMtT58k478cyTGyD1G4rSTg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sHR2X-0000000AUQy-2brp;
	Wed, 12 Jun 2024 18:41:38 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v4 2/5] um: Limit TASK_SIZE to the addressable range
Date: Wed, 12 Jun 2024 18:41:05 +0200
Message-ID: <20240612164108.1742106-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240612164108.1742106-1-benjamin@sipsolutions.net>
References: <20240612164108.1742106-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_094140_144075_16390F45 
X-CRM114-Status: GOOD (  10.06  )
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
 arch/um/kernel/um_arch.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 0d8b1a73cd5b..5ab1a92b6bf7 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -337,11 +337,16 @@ int __init linux_main(int argc, char **argv)
 	stub_start -= PAGE_SIZE;
 	host_task_size = stub_start;
 
+	/* Limit TASK_SIZE to what is addressable by the page table */
+	task_size = host_task_size;
+	if (task_size > PTRS_PER_PGD * PGDIR_SIZE)
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
2.45.1


