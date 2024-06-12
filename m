Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D8AC2BA12
	for <linux-um@archiver.kernel.org>; Wed, 12 Jun 2024 14:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mVdDozQhgLCHWTGkIS279cpqPxFfjKVFZDQpKU4sKrQ=; b=ZAclZIHHTmUvS3CDb1g9F4dHE3
	35J+tCmARzRKKj9/Rp8u36vLN/XcW4lEeBLeV70Lo0nTF15SgXRNe72ZWQKUAYO0o/HlRgEyP+blH
	pXCeEhM7MNNyGL5C3rZ8QCr4A8xnsj2gZ/gMVa14mR/DVyJBym+XsUgF3geHVg6yMFvi0CHGIta/L
	m5MayCYOahjLQ0n14e2jBF36uZjAW8+JPYs9YrzQ1hnXAXASTtVDc2rzPsSb0uoElkBYBpo7B78YV
	jYgepgJ7rP4sbAGSeDVIYwFSUq/oMxZp1d6XU5aqS/09S3LpxSu2U7SXSFNsQM654TnYOrZ/Fw29j
	AjmZRN6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHOgq-0000000CtdV-1WLj;
	Wed, 12 Jun 2024 14:11:04 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHOgn-0000000CtaI-0X29
	for linux-um@lists.infradead.org;
	Wed, 12 Jun 2024 14:11:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mVdDozQhgLCHWTGkIS279cpqPxFfjKVFZDQpKU4sKrQ=;
	t=1718201460; x=1719411060; b=ap2XLmCwdGiXbEvjrYUFUO9UKn/HAGTmULnAKiai8w0TZj2
	S+Ql8u6cq3BacgEBrnKJTsM+iLRCB8ZwHrMQwoTw4ZWXXo0hE2cG8kkJDDRXUEerwFTwCA99TFuYu
	2jVyyvd9FLt/CWQDVmm6KoMaKcALdi9VKp0EFswuxUctAYapLuBuzNtgVP0Vl2mne6W84KiaDOjO+
	kcnGFQ1+dsYkTpC6MDxse9FgxOUUIFXOVWncT12+uMQvEvOqZkg9RM9fp3D9ZEe6qcUrDOzfQJzo7
	l+XjazFREVC/zhWuuc3KXdwsVtOv5phDdG+vYH/NiY1yCV+eSWmreFng6n1hKEvg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sHOgk-0000000AN5N-2D3n;
	Wed, 12 Jun 2024 16:10:59 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 2/5] um: Limit TASK_SIZE to the addressable range
Date: Wed, 12 Jun 2024 16:10:44 +0200
Message-ID: <20240612141047.1633303-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240612141047.1633303-1-benjamin@sipsolutions.net>
References: <20240612141047.1633303-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_071101_481252_977A85F5 
X-CRM114-Status: GOOD (  10.16  )
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


