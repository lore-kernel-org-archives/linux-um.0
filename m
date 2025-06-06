Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C10C61CE8
	for <linux-um@archiver.kernel.org>; Fri,  6 Jun 2025 12:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rcby1U3Etar7tt9YDG8w6QOvjrwfnwKzYPJ8kQYuhRU=; b=VVANkEpEQzOgXI/gdWFxPut6kF
	1qgVjq34sNPUqMmFUhoE/1XBUSE0b5BKvw5/yhfh4xhoql8JEoHRe6dG3vu4e7tXhAyAnzzjm9d9H
	I2vK1pUzmSTonYwC4Wf2jMlpg+nvcFM+EPv4+rU9Tlq7y3X4fAQde02DLjGZ7hfeYnT9LaDMLRUHu
	M7QexZsUjGWpFKhIyuQQDI8DocdLRDxBB4HS/QMXBKCwuM4js/ti/7Tlc9pNav7DZS4GIASH+GvRj
	5G8p89mlazf5jL6wPe29ipJe04l3h9i99K6c18VmtWpyVkmd5KQ/5FMNl0X2vKz3UacPmGRn3e9/Y
	9ZlvNTNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNWRN-00000000Gz4-1CcO;
	Fri, 06 Jun 2025 12:44:57 +0000
Received: from out0-206.mail.aliyun.com ([140.205.0.206])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNWRJ-00000000Go1-3z5q
	for linux-um@lists.infradead.org;
	Fri, 06 Jun 2025 12:44:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1749213887; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Rcby1U3Etar7tt9YDG8w6QOvjrwfnwKzYPJ8kQYuhRU=;
	b=nAkkgTPPHaO0q6xmrK2+wS/c/KLfC2V5Pb7iAyPwa088I2UjyaY0FvYVqILtmqnsaWa+nmFreW6wWwTe9VZKrFqWdB/2woXOaooWHlAeCt18KjZVVXCiXeEoRbbKrqNvWHeEOxUdJs9PfcxJ7ruEILr9stA81nN5sYJMZIixlv0=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.dD3Yx0u_1749213883 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Jun 2025 20:44:43 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 2/4] um: virtio_pcidev: Rename UM_PCI_STAT_WAITING
Date: Fri, 06 Jun 2025 20:44:26 +0800
Message-Id: <20250606124428.148164-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250606124428.148164-1-tiwei.btw@antgroup.com>
References: <20250606124428.148164-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250606_054454_480703_3ACCE272 
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

Rename it to VIRTIO_PCIDEV_STAT_WAITING to make the code slightly
more consistent. It was missed when refactoring virtio_pcidev into
a separate module.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/virtio_pcidev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/virtio_pcidev.c b/arch/um/drivers/virtio_pcidev.c
index 3c4c4c928fdd..e9e23cc3f357 100644
--- a/arch/um/drivers/virtio_pcidev.c
+++ b/arch/um/drivers/virtio_pcidev.c
@@ -42,7 +42,7 @@ struct virtio_pcidev_device {
 	void *extra_ptrs[VIRTIO_PCIDEV_WRITE_BUFS + 1];
 	DECLARE_BITMAP(used_bufs, VIRTIO_PCIDEV_WRITE_BUFS);
 
-#define UM_PCI_STAT_WAITING	0
+#define VIRTIO_PCIDEV_STAT_WAITING	0
 	unsigned long status;
 
 	bool platform;
@@ -172,7 +172,7 @@ static int virtio_pcidev_send_cmd(struct virtio_pcidev_device *dev,
 	}
 
 	/* kick and poll for getting a response on the queue */
-	set_bit(UM_PCI_STAT_WAITING, &dev->status);
+	set_bit(VIRTIO_PCIDEV_STAT_WAITING, &dev->status);
 	virtqueue_kick(dev->cmd_vq);
 	ret = 0;
 
@@ -193,7 +193,7 @@ static int virtio_pcidev_send_cmd(struct virtio_pcidev_device *dev,
 		}
 		udelay(1);
 	}
-	clear_bit(UM_PCI_STAT_WAITING, &dev->status);
+	clear_bit(VIRTIO_PCIDEV_STAT_WAITING, &dev->status);
 
 	if (bounce_out)
 		memcpy(out, buf->data, out_size);
@@ -439,7 +439,7 @@ static void virtio_pcidev_cmd_vq_cb(struct virtqueue *vq)
 	void *cmd;
 	int len;
 
-	if (test_bit(UM_PCI_STAT_WAITING, &dev->status))
+	if (test_bit(VIRTIO_PCIDEV_STAT_WAITING, &dev->status))
 		return;
 
 	while ((cmd = virtqueue_get_buf(vq, &len)))
-- 
2.34.1


