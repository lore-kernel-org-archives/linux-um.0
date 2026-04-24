Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8696FE5205
	for <linux-um@archiver.kernel.org>; Fri, 24 Apr 2026 10:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=H4uVYoUgpKIkIvOZArZNMR6ZEOp/gVJeXZw7R1usUfU=; b=gwUN/VHrFffvrUnm0RxUNf8GWK
	YJKyIaINc3cTSABeYqg8KOq7Dh+M4pXJ19r4+2irLxQkZxLC4RQt9Z95JHhXs2zJxOOoyQktW/HNj
	a1nmS2xHpSm7+bt7Xv5XJgdDx9jPiGohlCzK4IGQ6eLvORTlHwz25JZCPyd1/yQejE+rcnzWMF4YT
	pFYofw86osw/njn+mzASyjzjcF0GYlEleMbt8DVW6EG/Pc8JnDrfpuz5Z12ZKEmnYrPn0RzRNY5GC
	s8ICbqIppJwb86en2MAOS5UbGbnfNE7BE0SHbfuX5Uy2/nGMPnDMan4r70DajhLif6qsIJbPg8fn/
	hWH50j2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGDoW-0000000D2fF-2jxB;
	Fri, 24 Apr 2026 10:31:12 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGDoV-0000000D2eu-0fPA
	for linux-um@lists.infradead.org;
	Fri, 24 Apr 2026 10:31:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3CF32600AE;
	Fri, 24 Apr 2026 10:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CEFC19425;
	Fri, 24 Apr 2026 10:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777026669;
	bh=0Sz5oYEFlV8HCKTpRL+w9bwfpXJkeAd+kzEzv8vJVEM=;
	h=From:To:Cc:Subject:Date:From;
	b=F9TFE92LmJt5GDphUvhyod6GtDMcnlFGAeJ2RhOID6BG7L1HSCTgdxjbsnWbNGy7V
	 AVpwy2TnChwkfotNYuD53O0gb0d/eOKM+blwzFrKZ4PSnMSiVzHL7YqI15D8cYpIpq
	 63mHXI2JFq5tAEfTh8eCCj2ssjB7atsHgOS7UB8g/Um4lNVgDgTpJ3LF5xAH3aYwDD
	 rNho+ofx4y3Dm6Fo2G9UFKfK59mX6MbaKoLc82oBoB/6Xc5FxxJOYgsXeMYtFOwsc3
	 /v8EGPP2YB5XHrt5GSP23a7Hc2b1r32+Go35bwbzas92GhFFNOJarbs9ZuJ5bUGhA/
	 Dwq2PranVzO+A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wGDoR-0000000AydH-3Ctp;
	Fri, 24 Apr 2026 12:31:07 +0200
From: Johan Hovold <johan@kernel.org>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] um: virtio_uml: switch to dynamic root device
Date: Fri, 24 Apr 2026 12:31:01 +0200
Message-ID: <20260424103101.2616338-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Driver core expects devices to be dynamically allocated and will, for
example, complain loudly when no release function has been provided.

Use __root_device_register() to allocate and register the root device
instead of open coding using a static device.

Note that root_device_register(), which also creates a link to the
module, cannot be used as the device is registered when parsing the
module parameters which happens before the module kobject has been
set up.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/um/drivers/virtio_uml.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 7425a8548141..c43afb0af47f 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -1274,14 +1274,7 @@ static void virtio_uml_remove(struct platform_device *pdev)
 
 /* Command line device list */
 
-static void vu_cmdline_release_dev(struct device *d)
-{
-}
-
-static struct device vu_cmdline_parent = {
-	.init_name = "virtio-uml-cmdline",
-	.release = vu_cmdline_release_dev,
-};
+static struct device *vu_cmdline_parent;
 
 static DEFINE_MUTEX(vu_cmdline_lock);
 static bool vu_cmdline_parent_registered;
@@ -1333,11 +1326,10 @@ static int vu_cmdline_set_device(const char *device)
 		return -EINVAL;
 
 	if (!vu_cmdline_parent_registered) {
-		err = device_register(&vu_cmdline_parent);
-		if (err) {
+		vu_cmdline_parent = __root_device_register("virtio-uml-cmdline", NULL);
+		if (IS_ERR(vu_cmdline_parent)) {
 			pr_err("Failed to register parent device!\n");
-			put_device(&vu_cmdline_parent);
-			return err;
+			return PTR_ERR(vu_cmdline_parent);
 		}
 		vu_cmdline_parent_registered = true;
 	}
@@ -1352,7 +1344,7 @@ static int vu_cmdline_set_device(const char *device)
 	pr_info("Registering device virtio-uml.%d id=%d at %s\n",
 		vu_cmdline_id, virtio_device_id, socket_path);
 
-	pdev = platform_device_register_data(&vu_cmdline_parent, "virtio-uml",
+	pdev = platform_device_register_data(vu_cmdline_parent, "virtio-uml",
 					     vu_cmdline_id++, &pdata,
 					     sizeof(pdata));
 	err = PTR_ERR_OR_ZERO(pdev);
@@ -1393,7 +1385,7 @@ static int vu_cmdline_get(char *buffer, const struct kernel_param *kp)
 
 	buffer[0] = '\0';
 	if (vu_cmdline_parent_registered)
-		device_for_each_child(&vu_cmdline_parent, buffer,
+		device_for_each_child(vu_cmdline_parent, buffer,
 				      vu_cmdline_get_device);
 	return strlen(buffer) + 1;
 }
@@ -1417,9 +1409,9 @@ static void vu_unregister_cmdline_devices(void)
 	guard(mutex)(&vu_cmdline_lock);
 
 	if (vu_cmdline_parent_registered) {
-		device_for_each_child(&vu_cmdline_parent, NULL,
+		device_for_each_child(vu_cmdline_parent, NULL,
 				      vu_unregister_cmdline_device);
-		device_unregister(&vu_cmdline_parent);
+		root_device_unregister(vu_cmdline_parent);
 		vu_cmdline_parent_registered = false;
 	}
 }
-- 
2.53.0


