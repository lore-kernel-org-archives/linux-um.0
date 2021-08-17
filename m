Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mG1PK-002tEx-Rc
 for linux-um@lists.infradead.org; Tue, 17 Aug 2021 15:53:47 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: virt-pci: fix uapi documentation
Date: Tue, 17 Aug 2021 17:53:29 +0200
Message-Id: <20210817175329.690c43fd70fc.I72e658bf03a3642f6cf6b5b413671e761bd83d74@changeid>
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
Cc: Johannes Berg <johannes.berg@intel.com>, Bjorn Helgaas <helgaas@kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

The identifier names in the documentation here didn't match
the real ones, and the reserved was missing. Fix that.

Reported-by: Bjorn Helgaas <helgaas@kernel.org>
Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/uapi/linux/virtio_pcidev.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/virtio_pcidev.h b/include/uapi/linux/virtio_pcidev.h
index 89daa88bcfef..668b07ce515b 100644
--- a/include/uapi/linux/virtio_pcidev.h
+++ b/include/uapi/linux/virtio_pcidev.h
@@ -9,13 +9,14 @@
 
 /**
  * enum virtio_pcidev_ops - virtual PCI device operations
+ * @VIRTIO_PCIDEV_OP_RESERVED: reserved to catch errors
  * @VIRTIO_PCIDEV_OP_CFG_READ: read config space, size is 1, 2, 4 or 8;
  *	the @data field should be filled in by the device (in little endian).
  * @VIRTIO_PCIDEV_OP_CFG_WRITE: write config space, size is 1, 2, 4 or 8;
  *	the @data field contains the data to write (in little endian).
- * @VIRTIO_PCIDEV_OP_BAR_READ: read BAR mem/pio, size can be variable;
+ * @VIRTIO_PCIDEV_OP_MMIO_READ: read BAR mem/pio, size can be variable;
  *	the @data field should be filled in by the device (in little endian).
- * @VIRTIO_PCIDEV_OP_BAR_WRITE: write BAR mem/pio, size can be variable;
+ * @VIRTIO_PCIDEV_OP_MMIO_WRITE: write BAR mem/pio, size can be variable;
  *	the @data field contains the data to write (in little endian).
  * @VIRTIO_PCIDEV_OP_MMIO_MEMSET: memset MMIO, size is variable but
  *	the @data field only has one byte (unlike @VIRTIO_PCIDEV_OP_MMIO_WRITE)
-- 
2.31.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

