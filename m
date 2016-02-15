Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vegard.nossum@oracle.com>) id 1aVGbW-0007xq-7n
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Feb 2016 10:42:06 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aVGbU-0002SX-Ch
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Feb 2016 10:42:06 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Mon, 15 Feb 2016 11:41:40 +0100
Message-Id: <1455532901-5852-1-git-send-email-vegard.nossum@oracle.com>
Subject: [uml-devel] [PATCH 1/2] usb: support building without CONFIG_HAS_DMA
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vegard Nossum <vegard.nossum@oracle.com>, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, James McMechan <James_McMechan@hotmail.com>, linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Martin Schwidefsky <schwidefsky@de.ibm.com>

Some platforms don't have DMA, but we should still be able to build
USB drivers for these platforms. They could still be used through
vhci_hcd, usbip_host, or maybe something like USB passthrough in UML
from a capable host.

This is admittedly ugly with the #ifdefs, but those are necessary to
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

Greg KG suggested just defining these for UML [1] but according to
Richard Weinberger this has come up before and it was decided not to
do that just for the sake of making drivers build [2].

[1]: http://www.spinics.net/lists/linux-usb/msg136306.html
[2]: http://www.spinics.net/lists/linux-usb/msg136308.html

If any of the new warnings trigger, the correct solution is almost
certainly to add a CONFIG_HAS_DMA dependency in the Kconfig menu for
the responsible driver -- that driver's functions will hopefully
appear somewhere in the stack trace.

v2: Reduce the number of #ifdefs by moving code out into helpers.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 drivers/usb/core/buffer.c |  94 ++++++++++++-----
 drivers/usb/core/hcd.c    | 257 ++++++++++++++++++++++++++++++++++------------
 include/linux/usb/hcd.h   |   6 ++
 3 files changed, 266 insertions(+), 91 deletions(-)

diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index 89f2e77..17f416d 100644
--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -44,6 +44,28 @@ void __init usb_init_pool_max(void)
 
 /* SETUP primitives */
 
+static int _hcd_buffer_create(struct usb_hcd *hcd)
+{
+#ifdef CONFIG_HAS_DMA
+	char		name[16];
+	int		i, size;
+
+	for (i = 0; i < HCD_BUFFER_POOLS; i++) {
+		size = pool_max[i];
+		if (!size)
+			continue;
+		snprintf(name, sizeof(name), "buffer-%d", size);
+		hcd->pool[i] = dma_pool_create(name, hcd->self.controller,
+				size, size, 0);
+		if (!hcd->pool[i]) {
+			hcd_buffer_destroy(hcd);
+			return -ENOMEM;
+		}
+	}
+#endif
+	return 0;
+}
+
 /**
  * hcd_buffer_create - initialize buffer pools
  * @hcd: the bus whose buffer pools are to be initialized
@@ -59,26 +81,11 @@ void __init usb_init_pool_max(void)
  */
 int hcd_buffer_create(struct usb_hcd *hcd)
 {
-	char		name[16];
-	int		i, size;
-
 	if (!hcd->self.controller->dma_mask &&
 	    !(hcd->driver->flags & HCD_LOCAL_MEM))
 		return 0;
 
-	for (i = 0; i < HCD_BUFFER_POOLS; i++) {
-		size = pool_max[i];
-		if (!size)
-			continue;
-		snprintf(name, sizeof(name), "buffer-%d", size);
-		hcd->pool[i] = dma_pool_create(name, hcd->self.controller,
-				size, size, 0);
-		if (!hcd->pool[i]) {
-			hcd_buffer_destroy(hcd);
-			return -ENOMEM;
-		}
-	}
-	return 0;
+	return _hcd_buffer_create(hcd);
 }
 
 
@@ -91,6 +98,7 @@ int hcd_buffer_create(struct usb_hcd *hcd)
  */
 void hcd_buffer_destroy(struct usb_hcd *hcd)
 {
+#ifdef CONFIG_HAS_DMA
 	int i;
 
 	for (i = 0; i < HCD_BUFFER_POOLS; i++) {
@@ -101,6 +109,7 @@ void hcd_buffer_destroy(struct usb_hcd *hcd)
 			hcd->pool[i] = NULL;
 		}
 	}
+#endif
 }
 
 
@@ -108,6 +117,27 @@ void hcd_buffer_destroy(struct usb_hcd *hcd)
  * better sharing and to leverage mm/slab.c intelligence.
  */
 
+static void *_hcd_buffer_alloc(
+	struct usb_hcd		*hcd,
+	size_t			size,
+	gfp_t			mem_flags,
+	dma_addr_t		*dma
+)
+{
+#ifdef CONFIG_HAS_DMA
+	int			i;
+
+	for (i = 0; i < HCD_BUFFER_POOLS; i++) {
+		if (size <= pool_max[i])
+			return dma_pool_alloc(hcd->pool[i], mem_flags, dma);
+	}
+	return dma_alloc_coherent(hcd->self.controller, size, dma, mem_flags);
+#else
+	WARN_ON_NO_DMA();
+	return NULL;
+#endif
+}
+
 void *hcd_buffer_alloc(
 	struct usb_bus		*bus,
 	size_t			size,
@@ -116,7 +146,6 @@ void *hcd_buffer_alloc(
 )
 {
 	struct usb_hcd		*hcd = bus_to_hcd(bus);
-	int			i;
 
 	/* some USB hosts just use PIO */
 	if (!bus->controller->dma_mask &&
@@ -125,11 +154,27 @@ void *hcd_buffer_alloc(
 		return kmalloc(size, mem_flags);
 	}
 
+	return _hcd_buffer_alloc(hcd, size, mem_flags, dma);
+}
+
+static void _hcd_buffer_free(
+	struct usb_hcd		*hcd,
+	size_t			size,
+	void			*addr,
+	dma_addr_t		dma
+)
+{
+#ifdef CONFIG_HAS_DMA
+	int			i;
+
 	for (i = 0; i < HCD_BUFFER_POOLS; i++) {
-		if (size <= pool_max[i])
-			return dma_pool_alloc(hcd->pool[i], mem_flags, dma);
+		if (size <= pool_max[i]) {
+			dma_pool_free(hcd->pool[i], addr, dma);
+			return;
+		}
 	}
-	return dma_alloc_coherent(hcd->self.controller, size, dma, mem_flags);
+	dma_free_coherent(hcd->self.controller, size, addr, dma);
+#endif
 }
 
 void hcd_buffer_free(
@@ -140,7 +185,6 @@ void hcd_buffer_free(
 )
 {
 	struct usb_hcd		*hcd = bus_to_hcd(bus);
-	int			i;
 
 	if (!addr)
 		return;
@@ -151,11 +195,5 @@ void hcd_buffer_free(
 		return;
 	}
 
-	for (i = 0; i < HCD_BUFFER_POOLS; i++) {
-		if (size <= pool_max[i]) {
-			dma_pool_free(hcd->pool[i], addr, dma);
-			return;
-		}
-	}
-	dma_free_coherent(hcd->self.controller, size, addr, dma);
+	_hcd_buffer_free(hcd, size, addr, dma);
 }
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index df0e3b9..157592c 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1406,13 +1406,76 @@ static void hcd_free_coherent(struct usb_bus *bus, dma_addr_t *dma_handle,
 	*dma_handle = 0;
 }
 
+#ifdef CONFIG_HAS_DMA
+static void _usb_hcd_unmap_urb_setup_for_dma_single(struct usb_hcd *hcd,
+						    struct urb *urb)
+{
+	dma_unmap_single(hcd->self.controller,
+			urb->setup_dma,
+			sizeof(struct usb_ctrlrequest),
+			DMA_TO_DEVICE);
+}
+
+static void _usb_hcd_unmap_urb_for_dma_sg(struct usb_hcd *hcd,
+					  struct urb *urb,
+					  enum dma_data_direction dir)
+{
+	dma_unmap_sg(hcd->self.controller,
+			urb->sg,
+			urb->num_sgs,
+			dir);
+}
+
+static void _usb_hcd_unmap_urb_for_dma_page(struct usb_hcd *hcd,
+					    struct urb *urb,
+					    enum dma_data_direction dir)
+{
+	dma_unmap_page(hcd->self.controller,
+			urb->transfer_dma,
+			urb->transfer_buffer_length,
+			dir);
+}
+
+static void _usb_hcd_unmap_urb_for_dma_single(struct usb_hcd *hcd,
+					      struct urb *urb,
+					      enum dma_data_direction dir)
+{
+	dma_unmap_single(hcd->self.controller,
+			urb->transfer_dma,
+			urb->transfer_buffer_length,
+			dir);
+}
+
+#else /* !CONFIG_HAS_DMA */
+
+static void _usb_hcd_unmap_urb_setup_for_dma_single(struct usb_hcd *hcd,
+						    struct urb *urb)
+{
+}
+
+static void _usb_hcd_unmap_urb_for_dma_sg(struct usb_hcd *hcd,
+					  struct urb *urb,
+					  enum dma_data_direction dir)
+{
+}
+
+static void _usb_hcd_unmap_urb_for_dma_page(struct usb_hcd *hcd,
+					    struct urb *urb,
+					    enum dma_data_direction dir)
+{
+}
+
+static void _usb_hcd_unmap_urb_for_dma_single(struct usb_hcd *hcd,
+					      struct urb *urb,
+					      enum dma_data_direction dir)
+{
+}
+#endif
+
 void usb_hcd_unmap_urb_setup_for_dma(struct usb_hcd *hcd, struct urb *urb)
 {
 	if (urb->transfer_flags & URB_SETUP_MAP_SINGLE)
-		dma_unmap_single(hcd->self.controller,
-				urb->setup_dma,
-				sizeof(struct usb_ctrlrequest),
-				DMA_TO_DEVICE);
+		_usb_hcd_unmap_urb_setup_for_dma_single(hcd, urb);
 	else if (urb->transfer_flags & URB_SETUP_MAP_LOCAL)
 		hcd_free_coherent(urb->dev->bus,
 				&urb->setup_dma,
@@ -1441,20 +1504,11 @@ void usb_hcd_unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
 
 	dir = usb_urb_dir_in(urb) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
 	if (urb->transfer_flags & URB_DMA_MAP_SG)
-		dma_unmap_sg(hcd->self.controller,
-				urb->sg,
-				urb->num_sgs,
-				dir);
+		_usb_hcd_unmap_urb_for_dma_sg(hcd, urb, dir);
 	else if (urb->transfer_flags & URB_DMA_MAP_PAGE)
-		dma_unmap_page(hcd->self.controller,
-				urb->transfer_dma,
-				urb->transfer_buffer_length,
-				dir);
+		_usb_hcd_unmap_urb_for_dma_page(hcd, urb, dir);
 	else if (urb->transfer_flags & URB_DMA_MAP_SINGLE)
-		dma_unmap_single(hcd->self.controller,
-				urb->transfer_dma,
-				urb->transfer_buffer_length,
-				dir);
+		_usb_hcd_unmap_urb_for_dma_single(hcd, urb, dir);
 	else if (urb->transfer_flags & URB_MAP_LOCAL)
 		hcd_free_coherent(urb->dev->bus,
 				&urb->transfer_dma,
@@ -1477,6 +1531,124 @@ static int map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 		return usb_hcd_map_urb_for_dma(hcd, urb, mem_flags);
 }
 
+#ifdef CONFIG_HAS_DMA
+static int _usb_hcd_map_urb_setup_for_dma_single(struct usb_hcd *hcd,
+						 struct urb *urb)
+{
+	int ret = 0;
+
+	urb->setup_dma = dma_map_single(
+			hcd->self.controller,
+			urb->setup_packet,
+			sizeof(struct usb_ctrlrequest),
+			DMA_TO_DEVICE);
+	if (dma_mapping_error(hcd->self.controller,
+				urb->setup_dma))
+		ret = -EAGAIN;
+	else
+		urb->transfer_flags |= URB_SETUP_MAP_SINGLE;
+
+	return ret;
+}
+
+static int _usb_hcd_map_urb_for_dma_sg(struct usb_hcd *hcd, struct urb *urb,
+				       enum dma_data_direction dir)
+{
+	int ret = 0;
+	int n;
+
+	n = dma_map_sg(
+			hcd->self.controller,
+			urb->sg,
+			urb->num_sgs,
+			dir);
+	if (n <= 0)
+		ret = -EAGAIN;
+	else
+		urb->transfer_flags |= URB_DMA_MAP_SG;
+
+	urb->num_mapped_sgs = n;
+	if (n != urb->num_sgs)
+		urb->transfer_flags |=
+				URB_DMA_SG_COMBINED;
+
+	return ret;
+}
+
+static int _usb_hcd_map_urb_for_dma_page(struct usb_hcd *hcd, struct urb *urb,
+					 enum dma_data_direction dir)
+{
+	int ret = 0;
+	struct scatterlist *sg = urb->sg;
+
+	urb->transfer_dma = dma_map_page(
+			hcd->self.controller,
+			sg_page(sg),
+			sg->offset,
+			urb->transfer_buffer_length,
+			dir);
+	if (dma_mapping_error(hcd->self.controller,
+			urb->transfer_dma))
+		ret = -EAGAIN;
+	else
+		urb->transfer_flags |= URB_DMA_MAP_PAGE;
+
+	return ret;
+}
+
+static int _usb_hcd_map_urb_for_dma_single(struct usb_hcd *hcd,
+					   struct urb *urb,
+					   enum dma_data_direction dir)
+{
+	int ret = 0;
+
+	urb->transfer_dma = dma_map_single(
+		hcd->self.controller,
+		urb->transfer_buffer,
+		urb->transfer_buffer_length,
+		dir);
+	if (dma_mapping_error(hcd->self.controller,
+			urb->transfer_dma))
+		ret = -EAGAIN;
+	else
+		urb->transfer_flags |= URB_DMA_MAP_SINGLE;
+
+	return ret;
+}
+
+
+#else /* !CONFIG_HAS_DMA */
+
+static int _usb_hcd_map_urb_setup_for_dma_single(struct usb_hcd *hcd,
+						 struct urb *urb)
+{
+	WARN_ON_NO_DMA();
+	return -EINVAL;
+}
+
+static int _usb_hcd_map_urb_for_dma_sg(struct usb_hcd *hcd, struct urb *urb,
+				       enum dma_data_direction dir)
+{
+	WARN_ON_NO_DMA();
+	return -EINVAL;
+}
+
+static int _usb_hcd_map_urb_for_dma_page(struct usb_hcd *hcd, struct urb *urb,
+					 enum dma_data_direction dir)
+{
+	WARN_ON_NO_DMA();
+	return -EINVAL;
+}
+
+static int _usb_hcd_map_urb_for_dma_single(struct usb_hcd *hcd,
+					   struct urb *urb,
+					   enum dma_data_direction dir)
+{
+	WARN_ON_NO_DMA();
+	return -EINVAL;
+}
+#endif
+
 int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 			    gfp_t mem_flags)
 {
@@ -1493,15 +1665,9 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 		if (hcd->self.uses_pio_for_control)
 			return ret;
 		if (hcd->self.uses_dma) {
-			urb->setup_dma = dma_map_single(
-					hcd->self.controller,
-					urb->setup_packet,
-					sizeof(struct usb_ctrlrequest),
-					DMA_TO_DEVICE);
-			if (dma_mapping_error(hcd->self.controller,
-						urb->setup_dma))
-				return -EAGAIN;
-			urb->transfer_flags |= URB_SETUP_MAP_SINGLE;
+			ret = _usb_hcd_map_urb_setup_for_dma_single(hcd, urb);
+			if (ret)
+				return ret;
 		} else if (hcd->driver->flags & HCD_LOCAL_MEM) {
 			ret = hcd_alloc_coherent(
 					urb->dev->bus, mem_flags,
@@ -1520,54 +1686,19 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 	    && !(urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP)) {
 		if (hcd->self.uses_dma) {
 			if (urb->num_sgs) {
-				int n;
-
 				/* We don't support sg for isoc transfers ! */
 				if (usb_endpoint_xfer_isoc(&urb->ep->desc)) {
 					WARN_ON(1);
 					return -EINVAL;
 				}
-
-				n = dma_map_sg(
-						hcd->self.controller,
-						urb->sg,
-						urb->num_sgs,
-						dir);
-				if (n <= 0)
-					ret = -EAGAIN;
-				else
-					urb->transfer_flags |= URB_DMA_MAP_SG;
-				urb->num_mapped_sgs = n;
-				if (n != urb->num_sgs)
-					urb->transfer_flags |=
-							URB_DMA_SG_COMBINED;
+				ret = _usb_hcd_map_urb_for_dma_sg(hcd, urb, dir);
 			} else if (urb->sg) {
-				struct scatterlist *sg = urb->sg;
-				urb->transfer_dma = dma_map_page(
-						hcd->self.controller,
-						sg_page(sg),
-						sg->offset,
-						urb->transfer_buffer_length,
-						dir);
-				if (dma_mapping_error(hcd->self.controller,
-						urb->transfer_dma))
-					ret = -EAGAIN;
-				else
-					urb->transfer_flags |= URB_DMA_MAP_PAGE;
+				ret = _usb_hcd_map_urb_for_dma_page(hcd, urb, dir);
 			} else if (is_vmalloc_addr(urb->transfer_buffer)) {
 				WARN_ONCE(1, "transfer buffer not dma capable\n");
 				ret = -EAGAIN;
 			} else {
-				urb->transfer_dma = dma_map_single(
-						hcd->self.controller,
-						urb->transfer_buffer,
-						urb->transfer_buffer_length,
-						dir);
-				if (dma_mapping_error(hcd->self.controller,
-						urb->transfer_dma))
-					ret = -EAGAIN;
-				else
-					urb->transfer_flags |= URB_DMA_MAP_SINGLE;
+				ret = _usb_hcd_map_urb_for_dma_single(hcd, urb, dir);
 			}
 		} else if (hcd->driver->flags & HCD_LOCAL_MEM) {
 			ret = hcd_alloc_coherent(
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 4dcf844..1e90e59 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -409,6 +409,12 @@ static inline bool hcd_periodic_completion_in_progress(struct usb_hcd *hcd,
 	return hcd->high_prio_bh.completing_ep == ep;
 }
 
+#ifndef CONFIG_HAS_DMA
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

