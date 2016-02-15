Return-Path: <geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/3] usb: Allow compilation on platforms where NO_DMA=y
Date: Mon, 15 Feb 2016 12:21:42 +0100
Message-Id: <1455535305-9508-1-git-send-email-geert@linux-m68k.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vegard Nossum <vegard.nossum@oracle.com>
Cc: John Youn <johnyoun@synopsys.com>, Richard Weinberger <richard@nod.at>, James McMechan <James_McMechan@hotmail.com>, Alan Stern <stern@rowland.harvard.edu>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-usb@vger.kernel.org, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This patch series allows to compile USB on platforms where NO_DMA=y.
I've been using it for quite a while to make allmodconfig/allyesconfig
build for m68k/sun3.

Thanks for your comments!

Geert Uytterhoeven (3):
  usb: core: Allow compilation on platforms where NO_DMA=y
  usb: host: Some host drivers should depend on HAS_DMA
  usb: dwc2: USB_DWC2 should depend on HAS_DMA

 drivers/usb/core/buffer.c | 18 ++++++++++++------
 drivers/usb/core/hcd.c    | 14 ++++++++++----
 drivers/usb/dwc2/Kconfig  |  1 +
 drivers/usb/host/Kconfig  |  5 ++++-
 4 files changed, 27 insertions(+), 11 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

