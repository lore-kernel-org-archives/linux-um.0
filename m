Return-Path: <geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3] usb: host: Host drivers relying on DMA should depend on HAS_DMA
Date: Sun, 21 Feb 2016 22:48:47 +0100
Message-Id: <1456091327-13169-1-git-send-email-geert@linux-m68k.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vegard Nossum <vegard.nossum@oracle.com>
Cc: John Youn <johnyoun@synopsys.com>, Richard Weinberger <richard@nod.at>, James McMechan <James_McMechan@hotmail.com>, Alan Stern <stern@rowland.harvard.edu>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-usb@vger.kernel.org, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

If NO_DMA=y:

    ERROR: "bad_dma_ops" [drivers/usb/host/xhci-plat-hcd.ko] undefined!
    ERROR: "bad_dma_ops" [drivers/usb/host/xhci-mtk.ko] undefined!
    ERROR: "dma_pool_destroy" [drivers/usb/host/xhci-hcd.ko] undefined!
    ERROR: "bad_dma_ops" [drivers/usb/host/xhci-hcd.ko] undefined!
    ERROR: "dma_pool_free" [drivers/usb/host/xhci-hcd.ko] undefined!
    ERROR: "dma_pool_alloc" [drivers/usb/host/xhci-hcd.ko] undefined!
    ERROR: "dma_pool_create" [drivers/usb/host/xhci-hcd.ko] undefined!
    ERROR: "bad_dma_ops" [drivers/usb/host/ohci-platform.ko] undefined!
    ERROR: "dma_pool_destroy" [drivers/usb/host/ohci-hcd.ko] undefined!
    ERROR: "bad_dma_ops" [drivers/usb/host/ohci-hcd.ko] undefined!
    ERROR: "dma_pool_free" [drivers/usb/host/ohci-hcd.ko] undefined!
    ERROR: "dma_pool_alloc" [drivers/usb/host/ohci-hcd.ko] undefined!
    ERROR: "dma_pool_create" [drivers/usb/host/ohci-hcd.ko] undefined!
    ERROR: "dma_pool_create" [drivers/usb/host/fotg210-hcd.ko] undefined!
    ERROR: "bad_dma_ops" [drivers/usb/host/fotg210-hcd.ko] undefined!
    ERROR: "dma_pool_destroy" [drivers/usb/host/fotg210-hcd.ko] undefined!
    ERROR: "dma_pool_alloc" [drivers/usb/host/fotg210-hcd.ko] undefined!
    ERROR: "dma_pool_free" [drivers/usb/host/fotg210-hcd.ko] undefined!
    ERROR: "bad_dma_ops" [drivers/usb/host/ehci-platform.ko] undefined!
    ERROR: "dma_pool_destroy" [drivers/usb/host/ehci-hcd.ko] undefined!
    ERROR: "bad_dma_ops" [drivers/usb/host/ehci-hcd.ko] undefined!
    ERROR: "dma_pool_free" [drivers/usb/host/ehci-hcd.ko] undefined!
    ERROR: "dma_pool_alloc" [drivers/usb/host/ehci-hcd.ko] undefined!
    ERROR: "dma_pool_create" [drivers/usb/host/ehci-hcd.ko] undefined!

Add dependencies on HAS_DMA to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v3:
  - Rebased against usb-next of usb.git,

v2:
  - Reword one-line summary.
---
 drivers/usb/host/Kconfig | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 438dcf6289b08f82..81bb7d471f4eb51b 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -18,7 +18,7 @@ config USB_C67X00_HCD
 
 config USB_XHCI_HCD
 	tristate "xHCI HCD (USB 3.0) support"
-	depends on HAS_IOMEM
+	depends on HAS_DMA && HAS_IOMEM
 	---help---
 	  The eXtensible Host Controller Interface (xHCI) is standard for USB 3.0
 	  "SuperSpeed" host controller hardware.
@@ -73,7 +73,7 @@ endif # USB_XHCI_HCD
 
 config USB_EHCI_HCD
 	tristate "EHCI HCD (USB 2.0) support"
-	depends on HAS_IOMEM
+	depends on HAS_DMA && HAS_IOMEM
 	---help---
 	  The Enhanced Host Controller Interface (EHCI) is standard for USB 2.0
 	  "high speed" (480 Mbit/sec, 60 Mbyte/sec) host controller hardware.
@@ -368,8 +368,7 @@ config USB_ISP1362_HCD
 
 config USB_FOTG210_HCD
 	tristate "FOTG210 HCD support"
-	depends on USB
-	depends on HAS_IOMEM
+	depends on USB && HAS_DMA && HAS_IOMEM
 	---help---
 	  Faraday FOTG210 is an OTG controller which can be configured as
 	  an USB2.0 host. It is designed to meet USB2.0 EHCI specification
@@ -391,7 +390,7 @@ config USB_MAX3421_HCD
 
 config USB_OHCI_HCD
 	tristate "OHCI HCD (USB 1.1) support"
-	depends on HAS_IOMEM
+	depends on HAS_DMA && HAS_IOMEM
 	---help---
 	  The Open Host Controller Interface (OHCI) is a standard for accessing
 	  USB 1.1 host controller hardware.  It does more in hardware than Intel's
-- 
1.9.1


