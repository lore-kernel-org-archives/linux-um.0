Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FFBCA1000
	for <linux-um@archiver.kernel.org>; Wed, 27 Aug 2025 20:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=prJFTRV6aEluy++/g+Xzgr4e95zWjm1BtN9ti9sIpMg=; b=sxIh0Kg08PwhGnet4RGanf3I4h
	s7urPW7WxxBd7I+5KaRts+GhPd+W9V3Qonju+vYQzBUgPYhNFHtYaTzh2IrYWrUg8OiPz7oxPqdHB
	aSAXL05tCXg6hx4b5/9Jb+/wrfBk4cFh0Sfrp7+aEO046+RauYEvXjgkP9g2/ho7R08OaiSNHrmp5
	OnO070LIV8b+qHdLR7rmpSt65iq8J4MaQbs1rGIn1maj+gps/D511M2QNJp+Xia8nWOZBbuCVb4iN
	syXSFNfn2hXSddtIxYhElN+OGbbG0weRduVUP3rtGBZUVWw1PlvOTDF/IVc90kbmp7z7FjKEnlSgV
	iL9+FA9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urMh4-0000000GkAI-3dI5;
	Wed, 27 Aug 2025 20:24:30 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urLvp-0000000GctI-1CVt
	for linux-um@lists.infradead.org;
	Wed, 27 Aug 2025 19:35:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=prJFTRV6aEluy++/g+Xzgr4e95zWjm1BtN9ti9sIpMg=; t=1756323340; x=1757532940; 
	b=Y2VGJ/Hjqe6+H4EkBeHFeSJOCwhPKjnhkwBiQJ50eNp0JRgagUxb7CHuBzJZZ1FO51gdMpNrOvE
	Kjtha9eDk/2q1LxGj3ZvtxPwBf17LEj9noV0piqOpgzKSss2ejaQn3YIIlfgzZsZPkp5P4uu7H8jz
	GM+luwPwAU5EN5HovVezg35AAqc8xD9nNt50LqPn5mi8KDNqvNgx2N5nFo269PbxFp5Gfvk3m8Qfg
	D/a/MsTAGMRk5lmT/SCE7PjEa8wFkxI6qc0SmeUIPCQNz+dLQ63+5bn+4Xmba+GPsXMPidYEpPwUG
	eWtARnvlGPRu9Pp9MKtpdFhm6/D5rgd3pVaw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1urLvl-000000060jt-35yX;
	Wed, 27 Aug 2025 21:35:37 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] um: virtio-pci: implement .shutdown()
Date: Wed, 27 Aug 2025 21:35:35 +0200
Message-ID: <20250827213534.f32fb9855088.I9052dffe235981e93254830eba73542ae37eea42@changeid>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250827_123541_351917_27CA9E45 
X-CRM114-Status: UNSURE (   9.62  )
X-CRM114-Notice: Please train this message.
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

From: Johannes Berg <johannes.berg@intel.com>

We don't want queues stopped since the shutdown can still
be doing things with PCI devices, so implement .shutdown()
to avoid the generic virtio shutdown.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
I already wrote this ~2.5 months ago but seem to have totally
forgotten ...
---
 arch/um/drivers/virtio_pcidev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/um/drivers/virtio_pcidev.c b/arch/um/drivers/virtio_pcidev.c
index e9e23cc3f357..f9b4b6f7582c 100644
--- a/arch/um/drivers/virtio_pcidev.c
+++ b/arch/um/drivers/virtio_pcidev.c
@@ -598,6 +598,11 @@ static void virtio_pcidev_virtio_remove(struct virtio_device *vdev)
 	kfree(dev);
 }
 
+static void virtio_pcidev_virtio_shutdown(struct virtio_device *vdev)
+{
+	/* nothing to do, we just don't want queue shutdown */
+}
+
 static struct virtio_device_id id_table[] = {
 	{ CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID, VIRTIO_DEV_ANY_ID },
 	{ 0 },
@@ -609,6 +614,7 @@ static struct virtio_driver virtio_pcidev_virtio_driver = {
 	.id_table = id_table,
 	.probe = virtio_pcidev_virtio_probe,
 	.remove = virtio_pcidev_virtio_remove,
+	.shutdown = virtio_pcidev_virtio_shutdown,
 };
 
 static int __init virtio_pcidev_init(void)
-- 
2.51.0


