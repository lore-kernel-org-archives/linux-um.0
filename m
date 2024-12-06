Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86E0E77173
	for <linux-um@archiver.kernel.org>; Fri,  6 Dec 2024 14:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Al8+6dPz77xxMYRF3kXBd6wlzaissGIpQTmsi0+0vsw=; b=t2ck35NrW2Kc6SCtPcHz5jaWGI
	XeptCyuFQ2Ll8D6bySFXn2MJ0NKjgaZqQtdQniphDdsMxJu9HCsVpG0VL6/nXvOyWmE/z8ugsinkz
	Co60y6MwgcpThC83cyQsZ/605dDt+LauWuv6PuY4+HzO4cYY2H6gNInEnyEdBYKLJq5RXxxwfCgDe
	Ukf3vsd4JwlpVy7/KKToPKqS+wS/wpc2r2OV65qKAa+Ahnkk4CEPaypkxf/U1ree0iPSPDHY/8LZd
	2pzbX6C57w9nnj090PaT6umGOw6VA6Oyc7NXgdjDoQcvT3IRRxbCN37zFSVBsR+yj8CHihOl6I59t
	IL4vk+UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJZkg-00000001ubZ-1mKo;
	Fri, 06 Dec 2024 14:56:18 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJZke-00000001ubB-0cuu
	for linux-um@lists.infradead.org;
	Fri, 06 Dec 2024 14:56:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DEABB5C6E64;
	Fri,  6 Dec 2024 14:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF077C4CED1;
	Fri,  6 Dec 2024 14:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733496975;
	bh=m4I9FJrIIkmawz4VhrU1meu9Bm4w+g4f+Jhz55x0ZJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2W9lT9MU8WMVoStj7iSvEoITaSaYG4apuzy+myePcIx7yBzluL8xKIrxrfcuMpOUN
	 MEHk4Gc3JRAnphdKuJVU3DHb3cWsGK2IPSnSIdtgvTDmHMFgiueNWqmcDaMYfpxxBW
	 2d4oWrUZLKgRDTW5wN4cdAwAHsCzJ/8ukLBgB3cI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 143/676] um: Unconditionally call unflatten_device_tree()
Date: Fri,  6 Dec 2024 15:29:22 +0100
Message-ID: <20241206143658.938336026@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241206_065616_228854_6EF91E5E 
X-CRM114-Status: GOOD (  14.43  )
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Boyd <sboyd@kernel.org>

[ Upstream commit 221a819aa3ca5bbbc91ce425b3e8d9463b121d09 ]

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
Cc: linux-um@lists.infradead.org
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Link: https://lore.kernel.org/r/20240217010557.2381548-4-sboyd@kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
Stable-dep-of: b2473a359763 ("of/fdt: add dt_phys arg to early_init_dt_scan and early_init_dt_verify")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/kernel/dtb.c  | 16 ++++++++--------
 drivers/of/unittest.c |  4 ----
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/um/kernel/dtb.c b/arch/um/kernel/dtb.c
index 484141b06938f..4954188a6a090 100644
--- a/arch/um/kernel/dtb.c
+++ b/arch/um/kernel/dtb.c
@@ -16,16 +16,16 @@ void uml_dtb_init(void)
 	void *area;
 
 	area = uml_load_file(dtb, &size);
-	if (!area)
-		return;
-
-	if (!early_init_dt_scan(area)) {
-		pr_err("invalid DTB %s\n", dtb);
-		memblock_free(area, size);
-		return;
+	if (area) {
+		if (!early_init_dt_scan(area)) {
+			pr_err("invalid DTB %s\n", dtb);
+			memblock_free(area, size);
+			return;
+		}
+
+		early_init_fdt_scan_reserved_mem();
 	}
 
-	early_init_fdt_scan_reserved_mem();
 	unflatten_device_tree();
 }
 
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 4f58345b5c683..7986113adc7d3 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -4017,10 +4017,6 @@ static int __init of_unittest(void)
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
2.43.0




