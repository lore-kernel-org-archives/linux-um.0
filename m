Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B9FC5B572
	for <linux-um@archiver.kernel.org>; Wed, 12 Aug 2026 14:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LlCs/u24FiK7/ArOzq0ki4b7bwIUrnC3rdD+NfSbu4k=; b=vHZvHDXPiVfljdveaGZQ0ZnHu/
	Ql/Iq3WsnDB9svHdyXM68Q2qqbfKE/hstm3ZRnYqYpdMn5TbqlHrc6cGlkA9ze8jgBIk5oAGy2N/p
	nFF/GDQnr74M+ZGLtpAlqEyV3XP24aBO3rdLviZaE9Hq32ts71f6q3Iv09eJRHng0JX54wTc98upP
	XFH3WYqV3H+9aLkrMAc4YqxA641b4tQGVZDlduGHQdx7y6DtwCraolVwITiEDjIq6n/+3+YrArsum
	XEN95We/RKyP8Zi8C8CJxV6mSz97Pi9T7i6DUj+8didL7bXAwphT3BBjfDLbz7n8NhpXXmc/y5XFG
	vMb4p50A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu9qs-0000000GNlB-0Iwz;
	Wed, 12 Aug 2026 14:22:42 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu9qq-0000000GNl3-0Ihy
	for linux-um@lists.infradead.org;
	Wed, 12 Aug 2026 14:22:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6C9AD60A92;
	Wed, 12 Aug 2026 14:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231F71F000E9;
	Wed, 12 Aug 2026 14:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786544559;
	bh=LlCs/u24FiK7/ArOzq0ki4b7bwIUrnC3rdD+NfSbu4k=;
	h=From:To:Cc:Subject:Date;
	b=lQujvENTUUDqJe395lRaNSefTBfJscqxKn7jB9DTWEdUwUAJkJpMc2lQ1++lAMltt
	 IiSSBXvYVxgbpUWEoVZn/v0oEdrLjCqYkqiTTrzBnaGP1kQjiLeSn51Z7zZa9Feobw
	 1pWCOGuq8b2R5lF0nvOxAlnb5VEWLEdvayJGZE0u0c+s4nC49cWErcvJ2oLHImUjYD
	 TBLlumfr8C/OmgxGAjq4kAUCHzFqLS7SR9szirdbSPJwYTHUuqH0AI3FEeo3K24UjR
	 WG68Hs/cwoOgyIAu9ceRd18vX+xfLxYMleGM1VxO6tIo9PIWQGlygE6r9GdVw4RKZY
	 khKq/5+jn49Jw==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wu9qm-00000000EOT-48ey;
	Wed, 12 Aug 2026 16:22:36 +0200
From: Johan Hovold <johan@kernel.org>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH RESEND] um: virtio_uml: switch to dynamic root device
Date: Wed, 12 Aug 2026 16:22:28 +0200
Message-ID: <20260812142228.55316-1-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
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

It's been over three months (and one reminder) since this series was
posted so resending.

Johan


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
2.54.0


