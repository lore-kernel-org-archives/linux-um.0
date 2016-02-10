Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vegard.nossum@oracle.com>) id 1aTVnu-00026C-VI
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 14:31:38 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aTVnr-0008FD-OM
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 14:31:38 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Wed, 10 Feb 2016 15:29:55 +0100
Message-Id: <1455114596-3532-20-git-send-email-vegard.nossum@oracle.com>
In-Reply-To: <1455114596-3532-1-git-send-email-vegard.nossum@oracle.com>
References: <1455114596-3532-1-git-send-email-vegard.nossum@oracle.com>
Subject: [uml-devel] [PATCH 20/21] usb: support building without
	CONFIG_HAS_DMA
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, James McMechan <James_McMechan@hotmail.com>, Vegard Nossum <vegard.nossum@oracle.com>

Some platforms don't have DMA, but we should still be able to build
USB drivers for these platforms. They could still be used through
vhci_hcd, usbip_host, or maybe something like USB passthrough in UML
from a capable host.

This is admittedly ugly with all the #ifdefs, but it is necessary to
get around linker errors like these:

drivers/built-in.o: In function `dma_unmap_sg_attrs':
include/linux/dma-mapping.h:183: undefined reference to `bad_dma_ops'
drivers/built-in.o: In function `dma_unmap_single_attrs':
include/linux/dma-mapping.h:148: undefined reference to `bad_dma_ops'
drivers/built-in.o: In function `dma_map_sg_attrs':
include/linux/dma-mapping.h:168: undefined reference to `bad_dma_ops'
drivers/built-in.o: In function `dma_map_page':
include/linux/dma-mapping.h:196: undefined reference to `bad_dma_ops'
drivers/built-in.o: In function `dma_mapping_error':
include/linux/dma-mapping.h:430: undefined reference to `bad_dma_ops'
drivers/built-in.o:include/linux/dma-mapping.h:131: more undefined references to `bad_dma_ops' follow

If any of the new warnings trigger, the correct solution is almost
certainly to add a CONFIG_HAS_DMA dependency in the Kconfig menu for
the responsible driver.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 drivers/usb/core/buffer.c | 17 +++++++++++++++++
 drivers/usb/core/hcd.c    | 45 +++++++++++++++++++++++++++++++++++++++------
 include/linux/usb/hcd.h   |  8 ++++++++
 3 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index 89f2e77..427b131 100644
--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -59,13 +59,16 @@ void __init usb_init_pool_max(void)
  */
 int hcd_buffer_create(struct usb_hcd *hcd)
 {
+#ifdef CONFIG_HAS_DMA
 	char		name[16];
 	int		i, size;
+#endif
 
 	if (!hcd->self.controller->dma_mask &&
 	    !(hcd->driver->flags & HCD_LOCAL_MEM))
 		return 0;
 
+#ifdef CONFIG_HAS_DMA
 	for (i = 0; i < HCD_BUFFER_POOLS; i++) {
 		size = pool_max[i];
 		if (!size)
@@ -78,6 +81,7 @@ int hcd_buffer_create(struct usb_hcd *hcd)
 			return -ENOMEM;
 		}
 	}
+#endif
 	return 0;
 }
 
@@ -91,6 +95,7 @@ int hcd_buffer_create(struct usb_hcd *hcd)
  */
 void hcd_buffer_destroy(struct usb_hcd *hcd)
 {
+#ifdef CONFIG_HAS_DMA
 	int i;
 
 	for (i = 0; i < HCD_BUFFER_POOLS; i++) {
@@ -101,6 +106,7 @@ void hcd_buffer_destroy(struct usb_hcd *hcd)
 			hcd->pool[i] = NULL;
 		}
 	}
+#endif
 }
 
 
@@ -116,7 +122,9 @@ void *hcd_buffer_alloc(
 )
 {
 	struct usb_hcd		*hcd = bus_to_hcd(bus);
+#ifdef CONFIG_HAS_DMA
 	int			i;
+#endif
 
 	/* some USB hosts just use PIO */
 	if (!bus->controller->dma_mask &&
@@ -125,11 +133,16 @@ void *hcd_buffer_alloc(
 		return kmalloc(size, mem_flags);
 	}
 
+#ifdef CONFIG_HAS_DMA
 	for (i = 0; i < HCD_BUFFER_POOLS; i++) {
 		if (size <= pool_max[i])
 			return dma_pool_alloc(hcd->pool[i], mem_flags, dma);
 	}
 	return dma_alloc_coherent(hcd->self.controller, size, dma, mem_flags);
+#else
+	WARN_ON_NO_DMA();
+	return NULL;
+#endif
 }
 
 void hcd_buffer_free(
@@ -140,7 +153,9 @@ void hcd_buffer_free(
 )
 {
 	struct usb_hcd		*hcd = bus_to_hcd(bus);
+#ifdef CONFIG_HAS_DMA
 	int			i;
+#endif
 
 	if (!addr)
 		return;
@@ -151,6 +166,7 @@ void hcd_buffer_free(
 		return;
 	}
 
+#ifdef CONFIG_HAS_DMA
 	for (i = 0; i < HCD_BUFFER_POOLS; i++) {
 		if (size <= pool_max[i]) {
 			dma_pool_free(hcd->pool[i], addr, dma);
@@ -158,4 +174,5 @@ void hcd_buffer_free(
 		}
 	}
 	dma_free_coherent(hcd->self.controller, size, addr, dma);
+#endif
 }
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index df0e3b9..1eb214d 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1408,12 +1408,15 @@ static void hcd_free_coherent(struct usb_bus *bus, dma_addr_t *dma_handle,
 
 void usb_hcd_unmap_urb_setup_for_dma(struct usb_hcd *hcd, struct urb *urb)
 {
-	if (urb->transfer_flags & URB_SETUP_MAP_SINGLE)
+	if (urb->transfer_flags & URB_SETUP_MAP_SINGLE) {
+#ifdef CONFIG_HAS_DMA
 		dma_unmap_single(hcd->self.controller,
 				urb->setup_dma,
 				sizeof(struct usb_ctrlrequest),
 				DMA_TO_DEVICE);
-	else if (urb->transfer_flags & URB_SETUP_MAP_LOCAL)
+#endif
+		WARN_ON_NO_DMA();
+	} else if (urb->transfer_flags & URB_SETUP_MAP_LOCAL)
 		hcd_free_coherent(urb->dev->bus,
 				&urb->setup_dma,
 				(void **) &urb->setup_packet,
@@ -1440,27 +1443,37 @@ void usb_hcd_unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
 	usb_hcd_unmap_urb_setup_for_dma(hcd, urb);
 
 	dir = usb_urb_dir_in(urb) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
-	if (urb->transfer_flags & URB_DMA_MAP_SG)
+	if (urb->transfer_flags & URB_DMA_MAP_SG) {
+#ifdef CONFIG_HAS_DMA
 		dma_unmap_sg(hcd->self.controller,
 				urb->sg,
 				urb->num_sgs,
 				dir);
-	else if (urb->transfer_flags & URB_DMA_MAP_PAGE)
+#endif
+		WARN_ON_NO_DMA();
+	} else if (urb->transfer_flags & URB_DMA_MAP_PAGE) {
+#ifdef CONFIG_HAS_DMA
 		dma_unmap_page(hcd->self.controller,
 				urb->transfer_dma,
 				urb->transfer_buffer_length,
 				dir);
-	else if (urb->transfer_flags & URB_DMA_MAP_SINGLE)
+#endif
+		WARN_ON_NO_DMA();
+	} else if (urb->transfer_flags & URB_DMA_MAP_SINGLE) {
+#ifdef CONFIG_HAS_DMA
 		dma_unmap_single(hcd->self.controller,
 				urb->transfer_dma,
 				urb->transfer_buffer_length,
 				dir);
-	else if (urb->transfer_flags & URB_MAP_LOCAL)
+#endif
+		WARN_ON_NO_DMA();
+	} else if (urb->transfer_flags & URB_MAP_LOCAL) {
 		hcd_free_coherent(urb->dev->bus,
 				&urb->transfer_dma,
 				&urb->transfer_buffer,
 				urb->transfer_buffer_length,
 				dir);
+	}
 
 	/* Make it safe to call this routine more than once */
 	urb->transfer_flags &= ~(URB_DMA_MAP_SG | URB_DMA_MAP_PAGE |
@@ -1493,6 +1506,7 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 		if (hcd->self.uses_pio_for_control)
 			return ret;
 		if (hcd->self.uses_dma) {
+#ifdef CONFIG_HAS_DMA
 			urb->setup_dma = dma_map_single(
 					hcd->self.controller,
 					urb->setup_packet,
@@ -1502,6 +1516,10 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 						urb->setup_dma))
 				return -EAGAIN;
 			urb->transfer_flags |= URB_SETUP_MAP_SINGLE;
+#else
+			WARN_ON_NO_DMA();
+			return -EINVAL;
+#endif
 		} else if (hcd->driver->flags & HCD_LOCAL_MEM) {
 			ret = hcd_alloc_coherent(
 					urb->dev->bus, mem_flags,
@@ -1520,6 +1538,7 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 	    && !(urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP)) {
 		if (hcd->self.uses_dma) {
 			if (urb->num_sgs) {
+#ifdef CONFIG_HAS_DMA
 				int n;
 
 				/* We don't support sg for isoc transfers ! */
@@ -1541,7 +1560,12 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 				if (n != urb->num_sgs)
 					urb->transfer_flags |=
 							URB_DMA_SG_COMBINED;
+#else
+				WARN_ON_NO_DMA();
+				ret = -EINVAL;
+#endif
 			} else if (urb->sg) {
+#ifdef CONFIG_HAS_DMA
 				struct scatterlist *sg = urb->sg;
 				urb->transfer_dma = dma_map_page(
 						hcd->self.controller,
@@ -1554,10 +1578,15 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 					ret = -EAGAIN;
 				else
 					urb->transfer_flags |= URB_DMA_MAP_PAGE;
+#else
+				WARN_ON_NO_DMA();
+				ret = -EINVAL;
+#endif
 			} else if (is_vmalloc_addr(urb->transfer_buffer)) {
 				WARN_ONCE(1, "transfer buffer not dma capable\n");
 				ret = -EAGAIN;
 			} else {
+#ifdef CONFIG_HAS_DMA
 				urb->transfer_dma = dma_map_single(
 						hcd->self.controller,
 						urb->transfer_buffer,
@@ -1568,6 +1597,10 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 					ret = -EAGAIN;
 				else
 					urb->transfer_flags |= URB_DMA_MAP_SINGLE;
+#else
+				WARN_ON_NO_DMA();
+				ret = -EINVAL;
+#endif
 			}
 		} else if (hcd->driver->flags & HCD_LOCAL_MEM) {
 			ret = hcd_alloc_coherent(
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 4dcf844..51b816a 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -409,6 +409,14 @@ static inline bool hcd_periodic_completion_in_progress(struct usb_hcd *hcd,
 	return hcd->high_prio_bh.completing_ep == ep;
 }
 
+#ifdef CONFIG_HAS_DMA
+#define WARN_ON_NO_DMA() do { } while (0)
+#else
+/* If this ever triggers, the correct fix is almost certainly
+ * to add a CONFIG_HAS_DMA dependency in the Kconfig for that driver. */
+#define WARN_ON_NO_DMA() WARN_ONCE(1, "HCD driver tried to use DMA memory")
+#endif
+
 extern int usb_hcd_link_urb_to_ep(struct usb_hcd *hcd, struct urb *urb);
 extern int usb_hcd_check_unlink_urb(struct usb_hcd *hcd, struct urb *urb,
 		int status);
-- 
1.9.1


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

