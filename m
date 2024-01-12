Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433FEC47DA6
	for <linux-um@archiver.kernel.org>; Fri, 12 Jan 2024 20:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aq0wQCSGkYOTPQQZka2W9Tc3A/BNjaFDxorl+wK66v4=; b=Jq6wR9X1kI1/T0L27YGaDR54ja
	7eI8uXG5YiCRYBN896AJA4nDgwGXaNrlpT1zo2TauzUEHpLZnVf3ukNKROMpgddSXPXQ3jIG+HrvG
	D/l3o0EZucqlL2Mqst1mXVGwb/pDBfpafAypn+7Va/aj1dNAT02OQXX+rkaNzbrlSIZh5n9on84Pq
	GzZIE2AF8DtsS8aAWiUeUWBgy5PLrWRwf8ZAYVM5hMBP24J+DljvjCP0l7obrryaZ7gsg7FTlT1UB
	mVMysTD8KRvv7uqnFQa2c4qYKjdktc/kVay34HN7chs3BGadFUv6+NAWKezQ9Eo+x7Up2h2mkYcIl
	S8GUfPbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rONoz-003u19-2X;
	Fri, 12 Jan 2024 20:08:05 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rONor-003tr7-2E;
	Fri, 12 Jan 2024 20:07:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 39A07B82392;
	Fri, 12 Jan 2024 20:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A051C433F1;
	Fri, 12 Jan 2024 20:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705090073;
	bh=hCAh9IJVjneFBmTI7MeY6517yfTJZxfzJ8kdqiP/+uU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pRzydyiSZaxydESQIgXX2hw/cVf7vyTmc+xuEwiwVlBKiyC2tWa8CvkSI8366MFYw
	 8SzWqLo/pkbptr5j5vAKr1z56Kk90vCACYI2PXj0ALa/bFf37lUixPzL04HSU6sU1C
	 wqG2KjQY0pkoij12aFDltAVLeOZoCOwV99KVi/iKkJCnMGAdVUh4Fi0rOELKnCx7uD
	 zAPLrjY6IzzNwVDG6Cs2gLMOIbsRQ4lfJrSkmxdEIpkF3Voe/+O2nWVrOTj03f+Fd2
	 qqrH++GNGcPFVa0oA8uzRTQgGRCHot6WZuRYR27/BoCvUWvV2N6obF523XhCQr7yHN
	 aOfp871SxcCxw==
From: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 2/6] um: Unconditionally call unflatten_device_tree()
Date: Fri, 12 Jan 2024 12:07:45 -0800
Message-ID: <20240112200750.4062441-3-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
In-Reply-To: <20240112200750.4062441-1-sboyd@kernel.org>
References: <20240112200750.4062441-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240112_120757_893677_932F72FF 
X-CRM114-Status: GOOD (  13.57  )
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

Call this function unconditionally so that we can populate an empty DTB
on platforms that don't boot with a command line provided DTB.  There's
no harm in calling unflatten_device_tree() unconditionally. If there
isn't a valid initial_boot_params dtb then unflatten_device_tree()
returns early.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: <linux-um@lists.infradead.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/um/kernel/dtb.c  | 14 +++++++-------
 drivers/of/unittest.c |  4 ----
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/um/kernel/dtb.c b/arch/um/kernel/dtb.c
index 484141b06938..4954188a6a09 100644
--- a/arch/um/kernel/dtb.c
+++ b/arch/um/kernel/dtb.c
@@ -16,16 +16,16 @@ void uml_dtb_init(void)
 	void *area;
 
 	area = uml_load_file(dtb, &size);
-	if (!area)
-		return;
+	if (area) {
+		if (!early_init_dt_scan(area)) {
+			pr_err("invalid DTB %s\n", dtb);
+			memblock_free(area, size);
+			return;
+		}
 
-	if (!early_init_dt_scan(area)) {
-		pr_err("invalid DTB %s\n", dtb);
-		memblock_free(area, size);
-		return;
+		early_init_fdt_scan_reserved_mem();
 	}
 
-	early_init_fdt_scan_reserved_mem();
 	unflatten_device_tree();
 }
 
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index e9e90e96600e..a8b27dd16ecf 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -4075,10 +4075,6 @@ static int __init of_unittest(void)
 	add_taint(TAINT_TEST, LOCKDEP_STILL_OK);
 
 	/* adding data for unittest */
-
-	if (IS_ENABLED(CONFIG_UML))
-		unittest_unflatten_overlay_base();
-
 	res = unittest_data_add();
 	if (res)
 		return res;
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


