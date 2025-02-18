Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4234EC021B0
	for <linux-um@archiver.kernel.org>; Tue, 18 Feb 2025 22:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d/qn30J1Pt31IkfVZtjOkhuWKcORs3FpveJWgKhHBKA=; b=aiHFsa9CK3X6m2kHR6JsClwKY5
	nSSew2FFKGbnNE1Z2BuMHUJJudojTAxqbaGTROLlgjHgktVuGwKqxnUSHga2B+TSfYfd2MZOLzMiO
	BZY5+HPVBJ3UYZwpwWEw+VJlzsQ/iSsRbMZN6cxA/v19l3FQ6fDZ3SICGeImmxnm6UtxQVAacaqmO
	N6y0ZmjCyrMJ9NiFyeDqmW4lhVus++heQ26OhIVU0awks6jaGpuyFYN3usDkNH/SI6m7QFxqYHKfH
	4Ypq/rocL43LGjVstExUnCpQM7kjbb7Lw0kv0dUnr+fb265xueIbJcu80hRLlHNYoLecbeuq5Y1Tk
	6/r41t0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkVo4-0000000A6cw-0fCW;
	Tue, 18 Feb 2025 22:11:08 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkUCx-00000009lsC-25Rp
	for linux-um@lists.infradead.org;
	Tue, 18 Feb 2025 20:28:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9CFB35C4B11;
	Tue, 18 Feb 2025 20:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2004DC4CEE2;
	Tue, 18 Feb 2025 20:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910522;
	bh=KOuFTaVdTfeuAgdYrAK2VdcUxIJf120BtBHOn08Zv4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eyTn5DmsFhk0kCcAB++1MF7vV6mVI4piVdCP9hV36oYgE16jgi5AKT6fv6WsVSE1I
	 hsgybHw8kkpPs/7DrfQAvqe2mQC7n9tDl+jZqSpxJAzCxSP7zWJGEOEWvp3gYSHsoE
	 V0ow9wzYvb16L450tDBhu+leZyTKvhyHyBhhCpcdaf/ttgy627uAq+ZXY1eJUJ34Cy
	 7fFY8DICL4UzG4JOuyZXuxZySdcLFMJBvCTrTzHiyXR+0FHqXiy1TJHXr+UaJ6pR2v
	 RZnvyv2vWx9LIbRm0tFig9e1hkGaf431Ka30sZTdCjzp+4rN7LZ2IThROMX0AWLSs5
	 OApnEl4VPPK5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	mst@redhat.com,
	jiri@resnulli.us,
	krzysztof.kozlowski@linaro.org,
	viro@zeniv.linux.org.uk,
	herve.codina@bootlin.com,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 11/13] um: virt-pci: don't use kmalloc()
Date: Tue, 18 Feb 2025 15:28:15 -0500
Message-Id: <20250218202819.3593598-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202819.3593598-1-sashal@kernel.org>
References: <20250218202819.3593598-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.128
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_122843_657877_255995D4 
X-CRM114-Status: GOOD (  23.74  )
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

[ Upstream commit 5b166b782d327f4b66190cc43afd3be36f2b3b7a ]

This code can be called deep in the IRQ handling, for
example, and then cannot normally use kmalloc(). Have
its own pre-allocated memory and use from there instead
so this doesn't occur. Only in the (very rare) case of
memcpy_toio() we'd still need to allocate memory.

Link: https://patch.msgid.link/20250110125550.32479-6-johannes@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/virt-pci.c | 198 +++++++++++++++++++------------------
 1 file changed, 102 insertions(+), 96 deletions(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index 5472b1a0a0398..c9a150029be2c 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -24,8 +24,10 @@
 #define MAX_IRQ_MSG_SIZE (sizeof(struct virtio_pcidev_msg) + sizeof(u32))
 #define NUM_IRQ_MSGS	10
 
-#define HANDLE_NO_FREE(ptr) ((void *)((unsigned long)(ptr) | 1))
-#define HANDLE_IS_NO_FREE(ptr) ((unsigned long)(ptr) & 1)
+struct um_pci_message_buffer {
+	struct virtio_pcidev_msg hdr;
+	u8 data[8];
+};
 
 struct um_pci_device {
 	struct virtio_device *vdev;
@@ -35,6 +37,11 @@ struct um_pci_device {
 
 	struct virtqueue *cmd_vq, *irq_vq;
 
+#define UM_PCI_WRITE_BUFS	20
+	struct um_pci_message_buffer bufs[UM_PCI_WRITE_BUFS + 1];
+	void *extra_ptrs[UM_PCI_WRITE_BUFS + 1];
+	DECLARE_BITMAP(used_bufs, UM_PCI_WRITE_BUFS);
+
 #define UM_PCI_STAT_WAITING	0
 	unsigned long status;
 
@@ -56,12 +63,40 @@ static unsigned long um_pci_msi_used[BITS_TO_LONGS(MAX_MSI_VECTORS)];
 
 #define UM_VIRT_PCI_MAXDELAY 40000
 
-struct um_pci_message_buffer {
-	struct virtio_pcidev_msg hdr;
-	u8 data[8];
-};
+static int um_pci_get_buf(struct um_pci_device *dev, bool *posted)
+{
+	int i;
+
+	for (i = 0; i < UM_PCI_WRITE_BUFS; i++) {
+		if (!test_and_set_bit(i, dev->used_bufs))
+			return i;
+	}
 
-static struct um_pci_message_buffer __percpu *um_pci_msg_bufs;
+	*posted = false;
+	return UM_PCI_WRITE_BUFS;
+}
+
+static void um_pci_free_buf(struct um_pci_device *dev, void *buf)
+{
+	int i;
+
+	if (buf == &dev->bufs[UM_PCI_WRITE_BUFS]) {
+		kfree(dev->extra_ptrs[UM_PCI_WRITE_BUFS]);
+		dev->extra_ptrs[UM_PCI_WRITE_BUFS] = NULL;
+		return;
+	}
+
+	for (i = 0; i < UM_PCI_WRITE_BUFS; i++) {
+		if (buf == &dev->bufs[i]) {
+			kfree(dev->extra_ptrs[i]);
+			dev->extra_ptrs[i] = NULL;
+			WARN_ON(!test_and_clear_bit(i, dev->used_bufs));
+			return;
+		}
+	}
+
+	WARN_ON(1);
+}
 
 static int um_pci_send_cmd(struct um_pci_device *dev,
 			   struct virtio_pcidev_msg *cmd,
@@ -77,7 +112,9 @@ static int um_pci_send_cmd(struct um_pci_device *dev,
 	};
 	struct um_pci_message_buffer *buf;
 	int delay_count = 0;
+	bool bounce_out;
 	int ret, len;
+	int buf_idx;
 	bool posted;
 
 	if (WARN_ON(cmd_size < sizeof(*cmd) || cmd_size > sizeof(*buf)))
@@ -96,26 +133,28 @@ static int um_pci_send_cmd(struct um_pci_device *dev,
 		break;
 	}
 
-	buf = get_cpu_var(um_pci_msg_bufs);
-	if (buf)
-		memcpy(buf, cmd, cmd_size);
+	bounce_out = !posted && cmd_size <= sizeof(*cmd) &&
+		     out && out_size <= sizeof(buf->data);
 
-	if (posted) {
-		u8 *ncmd = kmalloc(cmd_size + extra_size, GFP_ATOMIC);
-
-		if (ncmd) {
-			memcpy(ncmd, cmd, cmd_size);
-			if (extra)
-				memcpy(ncmd + cmd_size, extra, extra_size);
-			cmd = (void *)ncmd;
-			cmd_size += extra_size;
-			extra = NULL;
-			extra_size = 0;
-		} else {
-			/* try without allocating memory */
-			posted = false;
-			cmd = (void *)buf;
+	buf_idx = um_pci_get_buf(dev, &posted);
+	buf = &dev->bufs[buf_idx];
+	memcpy(buf, cmd, cmd_size);
+
+	if (posted && extra && extra_size > sizeof(buf) - cmd_size) {
+		dev->extra_ptrs[buf_idx] = kmemdup(extra, extra_size,
+						   GFP_ATOMIC);
+
+		if (!dev->extra_ptrs[buf_idx]) {
+			um_pci_free_buf(dev, buf);
+			return -ENOMEM;
 		}
+		extra = dev->extra_ptrs[buf_idx];
+	} else if (extra && extra_size <= sizeof(buf) - cmd_size) {
+		memcpy((u8 *)buf + cmd_size, extra, extra_size);
+		cmd_size += extra_size;
+		extra_size = 0;
+		extra = NULL;
+		cmd = (void *)buf;
 	} else {
 		cmd = (void *)buf;
 	}
@@ -123,39 +162,40 @@ static int um_pci_send_cmd(struct um_pci_device *dev,
 	sg_init_one(&out_sg, cmd, cmd_size);
 	if (extra)
 		sg_init_one(&extra_sg, extra, extra_size);
-	if (out)
+	/* allow stack for small buffers */
+	if (bounce_out)
+		sg_init_one(&in_sg, buf->data, out_size);
+	else if (out)
 		sg_init_one(&in_sg, out, out_size);
 
 	/* add to internal virtio queue */
 	ret = virtqueue_add_sgs(dev->cmd_vq, sgs_list,
 				extra ? 2 : 1,
 				out ? 1 : 0,
-				posted ? cmd : HANDLE_NO_FREE(cmd),
-				GFP_ATOMIC);
+				cmd, GFP_ATOMIC);
 	if (ret) {
-		if (posted)
-			kfree(cmd);
-		goto out;
+		um_pci_free_buf(dev, buf);
+		return ret;
 	}
 
 	if (posted) {
 		virtqueue_kick(dev->cmd_vq);
-		ret = 0;
-		goto out;
+		return 0;
 	}
 
 	/* kick and poll for getting a response on the queue */
 	set_bit(UM_PCI_STAT_WAITING, &dev->status);
 	virtqueue_kick(dev->cmd_vq);
+	ret = 0;
 
 	while (1) {
 		void *completed = virtqueue_get_buf(dev->cmd_vq, &len);
 
-		if (completed == HANDLE_NO_FREE(cmd))
+		if (completed == buf)
 			break;
 
-		if (completed && !HANDLE_IS_NO_FREE(completed))
-			kfree(completed);
+		if (completed)
+			um_pci_free_buf(dev, completed);
 
 		if (WARN_ONCE(virtqueue_is_broken(dev->cmd_vq) ||
 			      ++delay_count > UM_VIRT_PCI_MAXDELAY,
@@ -167,8 +207,11 @@ static int um_pci_send_cmd(struct um_pci_device *dev,
 	}
 	clear_bit(UM_PCI_STAT_WAITING, &dev->status);
 
-out:
-	put_cpu_var(um_pci_msg_bufs);
+	if (bounce_out)
+		memcpy(out, buf->data, out_size);
+
+	um_pci_free_buf(dev, buf);
+
 	return ret;
 }
 
@@ -182,20 +225,13 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
 		.size = size,
 		.addr = offset,
 	};
-	/* buf->data is maximum size - we may only use parts of it */
-	struct um_pci_message_buffer *buf;
-	u8 *data;
-	unsigned long ret = ULONG_MAX;
-	size_t bytes = sizeof(buf->data);
+	/* max 8, we might not use it all */
+	u8 data[8];
 
 	if (!dev)
 		return ULONG_MAX;
 
-	buf = get_cpu_var(um_pci_msg_bufs);
-	data = buf->data;
-
-	if (buf)
-		memset(data, 0xff, bytes);
+	memset(data, 0xff, sizeof(data));
 
 	switch (size) {
 	case 1:
@@ -207,34 +243,26 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
 		break;
 	default:
 		WARN(1, "invalid config space read size %d\n", size);
-		goto out;
+		return ULONG_MAX;
 	}
 
-	if (um_pci_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, data, bytes))
-		goto out;
+	if (um_pci_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, data, size))
+		return ULONG_MAX;
 
 	switch (size) {
 	case 1:
-		ret = data[0];
-		break;
+		return data[0];
 	case 2:
-		ret = le16_to_cpup((void *)data);
-		break;
+		return le16_to_cpup((void *)data);
 	case 4:
-		ret = le32_to_cpup((void *)data);
-		break;
+		return le32_to_cpup((void *)data);
 #ifdef CONFIG_64BIT
 	case 8:
-		ret = le64_to_cpup((void *)data);
-		break;
+		return le64_to_cpup((void *)data);
 #endif
 	default:
-		break;
+		return ULONG_MAX;
 	}
-
-out:
-	put_cpu_var(um_pci_msg_bufs);
-	return ret;
 }
 
 static void um_pci_cfgspace_write(void *priv, unsigned int offset, int size,
@@ -307,13 +335,8 @@ static void um_pci_bar_copy_from(void *priv, void *buffer,
 static unsigned long um_pci_bar_read(void *priv, unsigned int offset,
 				     int size)
 {
-	/* buf->data is maximum size - we may only use parts of it */
-	struct um_pci_message_buffer *buf;
-	u8 *data;
-	unsigned long ret = ULONG_MAX;
-
-	buf = get_cpu_var(um_pci_msg_bufs);
-	data = buf->data;
+	/* 8 is maximum size - we may only use parts of it */
+	u8 data[8];
 
 	switch (size) {
 	case 1:
@@ -325,33 +348,25 @@ static unsigned long um_pci_bar_read(void *priv, unsigned int offset,
 		break;
 	default:
 		WARN(1, "invalid config space read size %d\n", size);
-		goto out;
+		return ULONG_MAX;
 	}
 
 	um_pci_bar_copy_from(priv, data, offset, size);
 
 	switch (size) {
 	case 1:
-		ret = data[0];
-		break;
+		return data[0];
 	case 2:
-		ret = le16_to_cpup((void *)data);
-		break;
+		return le16_to_cpup((void *)data);
 	case 4:
-		ret = le32_to_cpup((void *)data);
-		break;
+		return le32_to_cpup((void *)data);
 #ifdef CONFIG_64BIT
 	case 8:
-		ret = le64_to_cpup((void *)data);
-		break;
+		return le64_to_cpup((void *)data);
 #endif
 	default:
-		break;
+		return ULONG_MAX;
 	}
-
-out:
-	put_cpu_var(um_pci_msg_bufs);
-	return ret;
 }
 
 static void um_pci_bar_copy_to(void *priv, unsigned int offset,
@@ -515,11 +530,8 @@ static void um_pci_cmd_vq_cb(struct virtqueue *vq)
 	if (test_bit(UM_PCI_STAT_WAITING, &dev->status))
 		return;
 
-	while ((cmd = virtqueue_get_buf(vq, &len))) {
-		if (WARN_ON(HANDLE_IS_NO_FREE(cmd)))
-			continue;
-		kfree(cmd);
-	}
+	while ((cmd = virtqueue_get_buf(vq, &len)))
+		um_pci_free_buf(dev, cmd);
 }
 
 static void um_pci_irq_vq_cb(struct virtqueue *vq)
@@ -887,10 +899,6 @@ static int __init um_pci_init(void)
 		 "No virtio device ID configured for PCI - no PCI support\n"))
 		return 0;
 
-	um_pci_msg_bufs = alloc_percpu(struct um_pci_message_buffer);
-	if (!um_pci_msg_bufs)
-		return -ENOMEM;
-
 	bridge = pci_alloc_host_bridge(0);
 	if (!bridge) {
 		err = -ENOMEM;
@@ -952,7 +960,6 @@ static int __init um_pci_init(void)
 		pci_free_resource_list(&bridge->windows);
 		pci_free_host_bridge(bridge);
 	}
-	free_percpu(um_pci_msg_bufs);
 	return err;
 }
 module_init(um_pci_init);
@@ -964,6 +971,5 @@ static void __exit um_pci_exit(void)
 	irq_domain_remove(um_pci_inner_domain);
 	pci_free_resource_list(&bridge->windows);
 	pci_free_host_bridge(bridge);
-	free_percpu(um_pci_msg_bufs);
 }
 module_exit(um_pci_exit);
-- 
2.39.5


