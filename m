Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00302C47422
	for <linux-um@archiver.kernel.org>; Fri, 12 Jan 2024 20:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4c9mWF8YgLblEXtBZS6u3l9ZtMToZFmO6GDr8hlYfo8=; b=SPRcze/wLozh4FyMwAFp524SFG
	VxXOlkOqaMgOKYqKYNjKpjBc/YvNCUI7HMAKaCwQje9nDquDsK8U7bT4+PID+33mQBuvN7u2/e6JL
	F4Sal/lPePu+Q3vStBUtfdxru7NoBmIJfek8P+gL/K1BsiygxF9l0fQ94gzAoF3Dyvoz3eMYiYkI8
	5NVmzHya/Ruc8bzEeayqKZDopp31vG+M8UzxgwZKdhNXZumQGLiqbZBynDIlBuLJ+Wrf6gSlo3smK
	Dl3LjdhHKBEhFVXJw6R0zVE8Ec40mqyU1P8oN61tNRcTO3FQcGV4wzktHkYgHF8ir4Ok8mgn3/cvO
	GBaXZRDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rONov-003twh-1v;
	Fri, 12 Jan 2024 20:08:01 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rONoo-003tr6-2L;
	Fri, 12 Jan 2024 20:07:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 44A7761E47;
	Fri, 12 Jan 2024 20:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA086C43394;
	Fri, 12 Jan 2024 20:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705090074;
	bh=1E4tLOV0ALY1Bfj9SzYihrCA2jRIId2N3gEBgK6iS+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OYIwB3Kd1lvLubS58Ch++gSwaNSb/vqhoixvSQvAvgqJG87S3gmJYw5VUSlzDs3f5
	 csFg+vxWUSoiXPtNVuFSumlD4MkFRIRWVQQvyJHKayKu/EFkQOrj++jZToUtobBNP0
	 +a6lIT2voVAlju/kYLtDzryGwEZQ1405vmmM1W72JkVpv11hygoOYl+3eaBb67Uo8Z
	 fgWZ5l39gqdPbykAVXITXpN2i2VUar5SMcArxxcXvSr7KPRGwOQkaOsf0FcM7oOit/
	 erSbIKrTVskKhMLrpWa6vgs3lAwIGQT3eFSn4oFjYtkdg8+ls0eBLzSmYOMruWNCnu
	 TwQLUeGiY9tGQ==
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
Subject: [PATCH 3/6] of: Always unflatten in unflatten_and_copy_device_tree()
Date: Fri, 12 Jan 2024 12:07:46 -0800
Message-ID: <20240112200750.4062441-4-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
In-Reply-To: <20240112200750.4062441-1-sboyd@kernel.org>
References: <20240112200750.4062441-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240112_120754_802390_93C94A46 
X-CRM114-Status: GOOD (  11.23  )
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
index bf502ba8da95..b488ad86d456 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1318,6 +1318,21 @@ bool __init early_init_dt_scan(void *params)
 	return true;
 }
 
+static void __init copy_device_tree(void)
+{
+	int size;
+	void *dt;
+
+	size = fdt_totalsize(initial_boot_params);
+	dt = early_init_dt_alloc_memory_arch(size,
+					     roundup_pow_of_two(FDT_V17_SIZE));
+
+	if (dt) {
+		memcpy(dt, initial_boot_params, size);
+		initial_boot_params = dt;
+	}
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
+		copy_device_tree();
 
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


