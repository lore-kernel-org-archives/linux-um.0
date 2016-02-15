Return-Path: <geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/3] usb: core: Allow compilation on platforms where NO_DMA=y
Date: Mon, 15 Feb 2016 12:21:43 +0100
Message-Id: <1455535305-9508-2-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1455535305-9508-1-git-send-email-geert@linux-m68k.org>
References: <1455535305-9508-1-git-send-email-geert@linux-m68k.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vegard Nossum <vegard.nossum@oracle.com>
Cc: John Youn <johnyoun@synopsys.com>, Richard Weinberger <richard@nod.at>, James McMechan <James_McMechan@hotmail.com>, Alan Stern <stern@rowland.harvard.edu>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-usb@vger.kernel.org, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

If NO_DMA=y:

    ERROR: "dma_pool_destroy" [drivers/usb/core/usbcore.ko] undefined!
    ERROR: "bad_dma_ops" [drivers/usb/core/usbcore.ko] undefined!
    ERROR: "dma_pool_free" [drivers/usb/core/usbcore.ko] undefined!
    ERROR: "dma_pool_alloc" [drivers/usb/core/usbcore.ko] undefined!
    ERROR: "dma_pool_create" [drivers/usb/core/usbcore.ko] undefined!

Add a few checks for CONFIG_HAS_DMA to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/usb/core/buffer.c | 18 ++++++++++++------
 drivers/usb/core/hcd.c    | 14 ++++++++++----
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index 89f2e7765093955b..2741566ee4f25849 100644
--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -62,8 +62,9 @@ int hcd_buffer_create(struct usb_hcd *hcd)
 	char		name[16];
 	int		i, size;
 
-	if (!hcd->self.controller->dma_mask &&
-	    !(hcd->driver->flags & HCD_LOCAL_MEM))
+	if (!IS_ENABLED(CONFIG_HAS_DMA) ||
+	    (!hcd->self.controller->dma_mask &&
+	     !(hcd->driver->flags & HCD_LOCAL_MEM)))
 		return 0;
 
 	for (i = 0; i < HCD_BUFFER_POOLS; i++) {
@@ -93,6 +94,9 @@ void hcd_buffer_destroy(struct usb_hcd *hcd)
 {
 	int i;
 
+	if (!IS_ENABLED(CONFIG_HAS_DMA))
+		return;
+
 	for (i = 0; i < HCD_BUFFER_POOLS; i++) {
 		struct dma_pool *pool = hcd->pool[i];
 
@@ -119,8 +123,9 @@ void *hcd_buffer_alloc(
 	int			i;
 
 	/* some USB hosts just use PIO */
-	if (!bus->controller->dma_mask &&
-	    !(hcd->driver->flags & HCD_LOCAL_MEM)) {
+	if (!IS_ENABLED(CONFIG_HAS_DMA) ||
+	    (!bus->controller->dma_mask &&
+	     !(hcd->driver->flags & HCD_LOCAL_MEM))) {
 		*dma = ~(dma_addr_t) 0;
 		return kmalloc(size, mem_flags);
 	}
@@ -145,8 +150,9 @@ void hcd_buffer_free(
 	if (!addr)
 		return;
 
-	if (!bus->controller->dma_mask &&
-	    !(hcd->driver->flags & HCD_LOCAL_MEM)) {
+	if (!IS_ENABLED(CONFIG_HAS_DMA) ||
+	    (!bus->controller->dma_mask &&
+	     !(hcd->driver->flags & HCD_LOCAL_MEM))) {
 		kfree(addr);
 		return;
 	}
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index df0e3b92533a745f..f6caa7ba6f05655b 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1408,12 +1408,15 @@ static void hcd_free_coherent(struct usb_bus *bus, dma_addr_t *dma_handle,
 
 void usb_hcd_unmap_urb_setup_for_dma(struct usb_hcd *hcd, struct urb *urb)
 {
+#ifdef CONFIG_HAS_DMA
 	if (urb->transfer_flags & URB_SETUP_MAP_SINGLE)
 		dma_unmap_single(hcd->self.controller,
 				urb->setup_dma,
 				sizeof(struct usb_ctrlrequest),
 				DMA_TO_DEVICE);
-	else if (urb->transfer_flags & URB_SETUP_MAP_LOCAL)
+	else
+#endif /* CONFIG_HAS_DMA */
+	if (urb->transfer_flags & URB_SETUP_MAP_LOCAL)
 		hcd_free_coherent(urb->dev->bus,
 				&urb->setup_dma,
 				(void **) &urb->setup_packet,
@@ -1440,6 +1443,7 @@ void usb_hcd_unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
 	usb_hcd_unmap_urb_setup_for_dma(hcd, urb);
 
 	dir = usb_urb_dir_in(urb) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+#ifdef CONFIG_HAS_DMA
 	if (urb->transfer_flags & URB_DMA_MAP_SG)
 		dma_unmap_sg(hcd->self.controller,
 				urb->sg,
@@ -1455,7 +1459,9 @@ void usb_hcd_unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
 				urb->transfer_dma,
 				urb->transfer_buffer_length,
 				dir);
-	else if (urb->transfer_flags & URB_MAP_LOCAL)
+	else
+#endif /* CONFIG_HAS_DMA */
+	if (urb->transfer_flags & URB_MAP_LOCAL)
 		hcd_free_coherent(urb->dev->bus,
 				&urb->transfer_dma,
 				&urb->transfer_buffer,
@@ -1492,7 +1498,7 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 	if (usb_endpoint_xfer_control(&urb->ep->desc)) {
 		if (hcd->self.uses_pio_for_control)
 			return ret;
-		if (hcd->self.uses_dma) {
+		if (IS_ENABLED(CONFIG_HAS_DMA) && hcd->self.uses_dma) {
 			urb->setup_dma = dma_map_single(
 					hcd->self.controller,
 					urb->setup_packet,
@@ -1518,7 +1524,7 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 	dir = usb_urb_dir_in(urb) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
 	if (urb->transfer_buffer_length != 0
 	    && !(urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP)) {
-		if (hcd->self.uses_dma) {
+		if (IS_ENABLED(CONFIG_HAS_DMA) && hcd->self.uses_dma) {
 			if (urb->num_sgs) {
 				int n;
 
-- 
1.9.1


