Return-Path: <geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/3] usb: dwc2: USB_DWC2 should depend on HAS_DMA
Date: Mon, 15 Feb 2016 12:21:45 +0100
Message-Id: <1455535305-9508-4-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1455535305-9508-1-git-send-email-geert@linux-m68k.org>
References: <1455535305-9508-1-git-send-email-geert@linux-m68k.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vegard Nossum <vegard.nossum@oracle.com>
Cc: John Youn <johnyoun@synopsys.com>, Richard Weinberger <richard@nod.at>, James McMechan <James_McMechan@hotmail.com>, Alan Stern <stern@rowland.harvard.edu>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-usb@vger.kernel.org, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

If NO_DMA=y:

    ERROR: "usb_gadget_map_request" [drivers/usb/dwc2/dwc2.ko] undefined!
    ERROR: "usb_gadget_unmap_request" [drivers/usb/dwc2/dwc2.ko] undefined!
    ERROR: "bad_dma_ops" [drivers/usb/dwc2/dwc2.ko] undefined!

Add a dependency on HAS_DMA to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/usb/dwc2/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc2/Kconfig b/drivers/usb/dwc2/Kconfig
index fd95ba6ec317fdac..f0decc0d69b5197d 100644
--- a/drivers/usb/dwc2/Kconfig
+++ b/drivers/usb/dwc2/Kconfig
@@ -1,5 +1,6 @@
 config USB_DWC2
 	tristate "DesignWare USB2 DRD Core Support"
+	depends on HAS_DMA
 	depends on USB || USB_GADGET
 	help
 	  Say Y here if your system has a Dual Role Hi-Speed USB
-- 
1.9.1


