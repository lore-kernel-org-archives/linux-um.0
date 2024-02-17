Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A663C48BF6
	for <linux-um@archiver.kernel.org>; Sat, 17 Feb 2024 01:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fu8ZVXP+jo7D5EaQ1/47p5cYa+9qDZG+rGOe1sBHnWk=; b=CM9SOxcFnx5XJe7fIv3OpUvPb5
	XzTktL3eNb68PFcaIprN4gJ8v8iIwhLI49O2GMoN7lO7Ne9AgqtBPLhfxTvIlONm4SlC0Wwg8fJja
	Og6L58efa5fRx/2aNQ7oe7cCJ/7Nf/N0419DIWHw6VaFyR1Q7f9mGi37y0SQHEz2isuR2mkMV+WtD
	mPKtu/bd9uCzdDCP80vE2uAFG3Ni+/L8hkj8uVsXs27MWkgsgUS09iQnsWACHZfYMA0a6B1IN4IN9
	z4Nq+d2TQCOd7qdSizNmDlh0ojHCcwGhni8bgdVQTJy+oOWK3N7oUX18Xy5jBwKJtFDA/V/6b1KFw
	DSwWyBlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb9A3-00000004M7J-0nCg;
	Sat, 17 Feb 2024 01:06:35 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb99X-00000004Lhw-4Alz;
	Sat, 17 Feb 2024 01:06:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E9D85CE2DB3;
	Sat, 17 Feb 2024 01:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAC4C32789;
	Sat, 17 Feb 2024 01:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708131960;
	bh=bAiFEbT58TXbP+zf0tFWIGODmRi8LJ7psP4/tHXmMrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nWHPrdK51ANKmmUE3NqJATrEVu6sf4ZIcdhvGIb1FIOmfGEAlBBUzElIK3HXYvtau
	 HM8OPq8HMxmE9tV8EHUsdjlUrBVacmJLtTFqEgDvSIkYu//JsuZnSiCygfMUAUP5p2
	 WzURYNN7LTNRzRNRTMPM9s9UNIbyHCFzBjQQSta0mjCFfUeA2MLNLYbltHu4sA/nRK
	 xAhmAwqIQ5hcPyyiybY2EYhSeBudz+h/5mDdVenucdfsF+wgwIZur9UXrCkkKGQ4EE
	 8ioWUb7gB4t06y/Xgd2WQLhkZe9z3EacufoevPtfc57OygRYn0npOjK9jtlF4dknIo
	 FNcCYQOdi1FQw==
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
Subject: [PATCH v4 3/7] um: Unconditionally call unflatten_device_tree()
Date: Fri, 16 Feb 2024 17:05:52 -0800
Message-ID: <20240217010557.2381548-4-sboyd@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240217010557.2381548-1-sboyd@kernel.org>
References: <20240217010557.2381548-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240216_170604_410536_0D373DE4 
X-CRM114-Status: GOOD (  13.27  )
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
index cfd60e35a899..891752a20a5f 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -4087,10 +4087,6 @@ static int __init of_unittest(void)
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


