Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD60C5AD49
	for <linux-um@archiver.kernel.org>; Fri,  6 Jun 2025 12:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3G0BmNlPvVLNdPlS2ctxve+0tRTx5a9nRFGHZlKj1c4=; b=Q07m2K+5zvPF/WiaqOS4hMX1Xc
	YFnj0idr4vbK/jU4NZWvmhPBltOQmVGtUpyYlyN2AG7imKWuBj3bXMtD2virOiiy5e76pf9RGz4dd
	jntbZoJS45Wg2MhzSBVhHUN23YuAryZOyEHDS4n8JlwQPTFLDa1oBgSWBUv62Wpvj8XeicYFHa1zu
	1bTtdnYrASctQ24RQzse9PQfmz4nM3zc9yGN046cTXW3y5dDWzaHV+1JIWRpBQ33rrU/DAiekPZQr
	yBFPE2/tmgkZ3NCBJaGQjfGsCLrXqDNDOJ/ZlLOz/aisqj2WAgfjP4Mc/zD5YTPMlIZGFwaR6IWjj
	amlJnXgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNWRO-00000000H0A-1rZC;
	Fri, 06 Jun 2025 12:44:58 +0000
Received: from out0-201.mail.aliyun.com ([140.205.0.201])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNWRK-00000000Gnw-0rjN
	for linux-um@lists.infradead.org;
	Fri, 06 Jun 2025 12:44:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1749213886; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=3G0BmNlPvVLNdPlS2ctxve+0tRTx5a9nRFGHZlKj1c4=;
	b=uWanMp41u5lBmuoi6bPPVvxB+79j3w0qWGtemJK/ReoxoivE3KEgO/U15hrfrqsBWizjsiqaGpJlQjG6PqgKz42ymym0M2PBa6aQDBnqnwsz/nG3M4PjfeTZllEJWSZgfvLjJl4vFENcfp0ExAqbbRKft7gmLH0uhmBOVZz/stw=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.dD3Yx0w_1749213883 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Jun 2025 20:44:44 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 3/4] um: vfio: Prevent duplicate device assignments
Date: Fri, 06 Jun 2025 20:44:27 +0800
Message-Id: <20250606124428.148164-4-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250606124428.148164-1-tiwei.btw@antgroup.com>
References: <20250606124428.148164-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250606_054454_478591_D2772DAB 
X-CRM114-Status: UNSURE (   7.50  )
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

Ensure devices are assigned only once. Reject subsequent requests
for duplicate assignments.

Fixes: a0e2cb6a9063 ("um: Add VFIO-based virtual PCI driver")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/vfio_kern.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/um/drivers/vfio_kern.c b/arch/um/drivers/vfio_kern.c
index b51fc9888ae1..13b971a2bd43 100644
--- a/arch/um/drivers/vfio_kern.c
+++ b/arch/um/drivers/vfio_kern.c
@@ -570,6 +570,17 @@ static void uml_vfio_release_device(struct uml_vfio_device *dev)
 	kfree(dev);
 }
 
+static struct uml_vfio_device *uml_vfio_find_device(const char *device)
+{
+	struct uml_vfio_device *dev;
+
+	list_for_each_entry(dev, &uml_vfio_devices, list) {
+		if (!strcmp(dev->name, device))
+			return dev;
+	}
+	return NULL;
+}
+
 static int uml_vfio_cmdline_set(const char *device, const struct kernel_param *kp)
 {
 	struct uml_vfio_device *dev;
@@ -582,6 +593,9 @@ static int uml_vfio_cmdline_set(const char *device, const struct kernel_param *k
 		uml_vfio_container.fd = fd;
 	}
 
+	if (uml_vfio_find_device(device))
+		return -EEXIST;
+
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
-- 
2.34.1


