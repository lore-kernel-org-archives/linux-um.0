Return-Path: <geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 2/3] usb: host: Host drivers relying on DMA should depend on HAS_DMA
Date: Tue, 16 Feb 2016 16:10:58 +0100
Message-Id: <1455635459-1576-3-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1455635459-1576-1-git-send-email-geert@linux-m68k.org>
References: <1455635459-1576-1-git-send-email-geert@linux-m68k.org>
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
v2:
  - Reword one-line summary.
---
 drivers/usb/host/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 1f117c360ebbba33..573789698474ad8d 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -17,6 +17,7 @@ config USB_C67X00_HCD
 
 config USB_XHCI_HCD
 	tristate "xHCI HCD (USB 3.0) support"
+	depends on HAS_DMA
 	---help---
 	  The eXtensible Host Controller Interface (xHCI) is standard for USB 3.0
 	  "SuperSpeed" host controller hardware.
@@ -70,6 +71,7 @@ endif # USB_XHCI_HCD
 
 config USB_EHCI_HCD
 	tristate "EHCI HCD (USB 2.0) support"
+	depends on HAS_DMA
 	---help---
 	  The Enhanced Host Controller Interface (EHCI) is standard for USB 2.0
 	  "high speed" (480 Mbit/sec, 60 Mbyte/sec) host controller hardware.
@@ -361,7 +363,7 @@ config USB_ISP1362_HCD
 
 config USB_FOTG210_HCD
 	tristate "FOTG210 HCD support"
-	depends on USB
+	depends on USB && HAS_DMA
 	---help---
 	  Faraday FOTG210 is an OTG controller which can be configured as
 	  an USB2.0 host. It is designed to meet USB2.0 EHCI specification
@@ -383,6 +385,7 @@ config USB_MAX3421_HCD
 
 config USB_OHCI_HCD
 	tristate "OHCI HCD (USB 1.1) support"
+	depends on HAS_DMA
 	---help---
 	  The Open Host Controller Interface (OHCI) is a standard for accessing
 	  USB 1.1 host controller hardware.  It does more in hardware than Intel's
-- 
1.9.1


