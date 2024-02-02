Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D909CC4828E
	for <linux-um@archiver.kernel.org>; Fri,  2 Feb 2024 20:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=txjo7axD3IOMj2sG8qZ7bqcXfpbTutPS/3Sn6RhFLnE=; b=Ux8mS9h1ZOkwIf4qUQsaciKiFB
	PmO9Oc3+iW5LKGnIE/VOH5KVbD50H+P07mqbsItrdllPzMBuhyhIarz/jb7Fw4GEdnxntxR39laDn
	fHtUfamq3xCs5QqTsjZqiAXZU6RSx1++j9ErrOUZDuRbLdONER5ahlBvpnqKjDN7koOGNs4d+IHn1
	WHXmlIYjaVpK+ikTbl4dKD9jimMWtmDFfY9Ym+mn6nv5D1IIJ5cbBK1wHqkZN6R7JtSJISQB0xRM4
	rCBLeTlBkf4sUqLYNOvkA/ITGDMrSx6rwoqzIfoqmleTVVROLvo3tpcPt3zf3PAHcF9/PY9IPpnoG
	eku5ARtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVzi3-0000000DIY0-1tjm;
	Fri, 02 Feb 2024 20:00:23 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVzgx-0000000DI2e-1tuA;
	Fri, 02 Feb 2024 19:59:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 08421CE2E2A;
	Fri,  2 Feb 2024 19:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BC6C433A6;
	Fri,  2 Feb 2024 19:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706903952;
	bh=Qt8ricOYsTKcXJqQzKSKsHiM2MHdHGBlaBkQ7xeVb1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lolArgXVyTaONkcJ5g+Q0I74VOq82JrEMP+bi1sJfx15lGiKzZRLSxhR7HPZQO9o+
	 Vk7IRVNvNklfw0NMszumwTcFm9jgJBwhoUs6umQ55RBhjMrFu52cy4n/gJ4BbpE2HX
	 lIg2PWCeBkrRkSrM123IFh1gZLL78hdg113f6j5P9rjYmbPOyEBq9F+7wne+BJLnAP
	 8ntDegcw+g3r3b7BJaeyLoqw7DvIKZXgU+luSg2rfc6tqGJZNT2rjuMRYmox0btctH
	 Bx9iZO9QAEpH+NXjlocxZnEWB2f7RqplqHjGB7yVg/0KTomqx4izsjaFh3vB/qkVbN
	 8btpvM4BTB31w==
From: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v3 1/7] of: Always unflatten in unflatten_and_copy_device_tree()
Date: Fri,  2 Feb 2024 11:59:02 -0800
Message-ID: <20240202195909.3458162-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240202195909.3458162-1-sboyd@kernel.org>
References: <20240202195909.3458162-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240202_115915_810034_8FFE7113 
X-CRM114-Status: GOOD (  11.81  )
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

We want to populate an empty DT whenever CONFIG_OF is enabled so that
overlays can be applied and the DT unit tests can be run. Make
unflatten_and_copy_device_tree() stop printing a warning if the
'initial_boot_params' pointer is NULL. Instead, simply copy the dtb if
there is one and then unflatten it. If there isn't a DT to copy, then
the call to unflatten_device_tree() is largely a no-op, so nothing
really changes here.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/of/fdt.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index bf502ba8da95..dfeba8b8ce94 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1318,6 +1318,21 @@ bool __init early_init_dt_scan(void *params)
 	return true;
 }
 
+static void *__init copy_device_tree(void *fdt)
+{
+	int size;
+	void *dt;
+
+	size = fdt_totalsize(fdt);
+	dt = early_init_dt_alloc_memory_arch(size,
+					     roundup_pow_of_two(FDT_V17_SIZE));
+
+	if (dt)
+		memcpy(dt, fdt, size);
+
+	return dt;
+}
+
 /**
  * unflatten_device_tree - create tree of device_nodes from flat blob
  *
@@ -1350,22 +1365,9 @@ void __init unflatten_device_tree(void)
  */
 void __init unflatten_and_copy_device_tree(void)
 {
-	int size;
-	void *dt;
+	if (initial_boot_params)
+		initial_boot_params = copy_device_tree(initial_boot_params);
 
-	if (!initial_boot_params) {
-		pr_warn("No valid device tree found, continuing without\n");
-		return;
-	}
-
-	size = fdt_totalsize(initial_boot_params);
-	dt = early_init_dt_alloc_memory_arch(size,
-					     roundup_pow_of_two(FDT_V17_SIZE));
-
-	if (dt) {
-		memcpy(dt, initial_boot_params, size);
-		initial_boot_params = dt;
-	}
 	unflatten_device_tree();
 }
 
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


