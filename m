Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDpgi-007UqM-EQ
 for linux-um@lists.infradead.org; Wed, 11 Aug 2021 14:58:41 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 1/2] um: virt-pci: don't do DMA from stack
Date: Wed, 11 Aug 2021 16:58:25 +0200
Message-Id: <20210811165826.f814c3ae4fca.I33fd41809c2c0413f19e292a26c0c0dff4b3d301@changeid>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

When enabling VMAP_STACK, SG helpers immediately complained
that we were doing DMA from stack. Use per-CPU variables to
avoid that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/virt-pci.c | 104 +++++++++++++++++++++++++++----------
 1 file changed, 78 insertions(+), 26 deletions(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index 70c17de16662..c08066633023 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -56,6 +56,13 @@ static unsigned long um_pci_msi_used[BITS_TO_LONGS(MAX_MSI_VECTORS)];
 
 #define UM_VIRT_PCI_MAXDELAY 40000
 
+struct um_pci_message_buffer {
+	struct virtio_pcidev_msg hdr;
+	u8 data[8];
+};
+
+static struct um_pci_message_buffer __percpu *um_pci_msg_bufs;
+
 static int um_pci_send_cmd(struct um_pci_device *dev,
 			   struct virtio_pcidev_msg *cmd,
 			   unsigned int cmd_size,
@@ -68,11 +75,12 @@ static int um_pci_send_cmd(struct um_pci_device *dev,
 		[1] = extra ? &extra_sg : &in_sg,
 		[2] = extra ? &in_sg : NULL,
 	};
+	struct um_pci_message_buffer *buf;
 	int delay_count = 0;
 	int ret, len;
 	bool posted;
 
-	if (WARN_ON(cmd_size < sizeof(*cmd)))
+	if (WARN_ON(cmd_size < sizeof(*cmd) || cmd_size > sizeof(*buf)))
 		return -EINVAL;
 
 	switch (cmd->op) {
@@ -88,6 +96,9 @@ static int um_pci_send_cmd(struct um_pci_device *dev,
 		break;
 	}
 
+	buf = get_cpu_var(um_pci_msg_bufs);
+	memcpy(buf, cmd, cmd_size);
+
 	if (posted) {
 		u8 *ncmd = kmalloc(cmd_size + extra_size, GFP_ATOMIC);
 
@@ -102,7 +113,10 @@ static int um_pci_send_cmd(struct um_pci_device *dev,
 		} else {
 			/* try without allocating memory */
 			posted = false;
+			cmd = (void *)buf;
 		}
+	} else {
+		cmd = (void *)buf;
 	}
 
 	sg_init_one(&out_sg, cmd, cmd_size);
@@ -118,11 +132,12 @@ static int um_pci_send_cmd(struct um_pci_device *dev,
 				posted ? cmd : HANDLE_NO_FREE(cmd),
 				GFP_ATOMIC);
 	if (ret)
-		return ret;
+		goto out;
 
 	if (posted) {
 		virtqueue_kick(dev->cmd_vq);
-		return 0;
+		ret = 0;
+		goto out;
 	}
 
 	/* kick and poll for getting a response on the queue */
@@ -148,6 +163,8 @@ static int um_pci_send_cmd(struct um_pci_device *dev,
 	}
 	clear_bit(UM_PCI_STAT_WAITING, &dev->status);
 
+out:
+	put_cpu_var(um_pci_msg_bufs);
 	return ret;
 }
 
@@ -161,12 +178,17 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
 		.size = size,
 		.addr = offset,
 	};
-	/* maximum size - we may only use parts of it */
-	u8 data[8];
+	/* buf->data is maximum size - we may only use parts of it */
+	struct um_pci_message_buffer *buf;
+	u8 *data;
+	unsigned long ret = ~0ULL;
 
 	if (!dev)
 		return ~0ULL;
 
+	buf = get_cpu_var(um_pci_msg_bufs);
+	data = buf->data;
+
 	memset(data, 0xff, sizeof(data));
 
 	switch (size) {
@@ -179,27 +201,34 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
 		break;
 	default:
 		WARN(1, "invalid config space read size %d\n", size);
-		return ~0ULL;
+		goto out;
 	}
 
-	if (um_pci_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0,
-			    data, sizeof(data)))
-		return ~0ULL;
+	if (um_pci_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, data, 8))
+		goto out;
 
 	switch (size) {
 	case 1:
-		return data[0];
+		ret = data[0];
+		break;
 	case 2:
-		return le16_to_cpup((void *)data);
+		ret = le16_to_cpup((void *)data);
+		break;
 	case 4:
-		return le32_to_cpup((void *)data);
+		ret = le32_to_cpup((void *)data);
+		break;
 #ifdef CONFIG_64BIT
 	case 8:
-		return le64_to_cpup((void *)data);
+		ret = le64_to_cpup((void *)data);
+		break;
 #endif
 	default:
-		return ~0ULL;
+		break;
 	}
+
+out:
+	put_cpu_var(um_pci_msg_bufs);
+	return ret;
 }
 
 static void um_pci_cfgspace_write(void *priv, unsigned int offset, int size,
@@ -272,8 +301,13 @@ static void um_pci_bar_copy_from(void *priv, void *buffer,
 static unsigned long um_pci_bar_read(void *priv, unsigned int offset,
 				     int size)
 {
-	/* maximum size - we may only use parts of it */
-	u8 data[8];
+	/* buf->data is maximum size - we may only use parts of it */
+	struct um_pci_message_buffer *buf;
+	u8 *data;
+	unsigned long ret = ~0ULL;
+
+	buf = get_cpu_var(um_pci_msg_bufs);
+	data = buf->data;
 
 	switch (size) {
 	case 1:
@@ -285,25 +319,33 @@ static unsigned long um_pci_bar_read(void *priv, unsigned int offset,
 		break;
 	default:
 		WARN(1, "invalid config space read size %d\n", size);
-		return ~0ULL;
+		goto out;
 	}
 
 	um_pci_bar_copy_from(priv, data, offset, size);
 
 	switch (size) {
 	case 1:
-		return data[0];
+		ret = data[0];
+		break;
 	case 2:
-		return le16_to_cpup((void *)data);
+		ret = le16_to_cpup((void *)data);
+		break;
 	case 4:
-		return le32_to_cpup((void *)data);
+		ret = le32_to_cpup((void *)data);
+		break;
 #ifdef CONFIG_64BIT
 	case 8:
-		return le64_to_cpup((void *)data);
+		ret = le64_to_cpup((void *)data);
+		break;
 #endif
 	default:
-		return ~0ULL;
+		break;
 	}
+
+out:
+	put_cpu_var(um_pci_msg_bufs);
+	return ret;
 }
 
 static void um_pci_bar_copy_to(void *priv, unsigned int offset,
@@ -823,10 +865,16 @@ static int um_pci_init(void)
 		 "No virtio device ID configured for PCI - no PCI support\n"))
 		return 0;
 
-	bridge = pci_alloc_host_bridge(0);
-	if (!bridge)
+	um_pci_msg_bufs = alloc_percpu(struct um_pci_message_buffer);
+	if (!um_pci_msg_bufs)
 		return -ENOMEM;
 
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge) {
+		err = -ENOMEM;
+		goto free;
+	}
+
 	um_pci_fwnode = irq_domain_alloc_named_fwnode("um-pci");
 	if (!um_pci_fwnode) {
 		err = -ENOMEM;
@@ -878,8 +926,11 @@ static int um_pci_init(void)
 		irq_domain_remove(um_pci_inner_domain);
 	if (um_pci_fwnode)
 		irq_domain_free_fwnode(um_pci_fwnode);
-	pci_free_resource_list(&bridge->windows);
-	pci_free_host_bridge(bridge);
+	if (bridge) {
+		pci_free_resource_list(&bridge->windows);
+		pci_free_host_bridge(bridge);
+	}
+	free_percpu(um_pci_msg_bufs);
 	return err;
 }
 module_init(um_pci_init);
@@ -891,5 +942,6 @@ static void um_pci_exit(void)
 	irq_domain_remove(um_pci_inner_domain);
 	pci_free_resource_list(&bridge->windows);
 	pci_free_host_bridge(bridge);
+	free_percpu(um_pci_msg_bufs);
 }
 module_exit(um_pci_exit);
-- 
2.31.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

