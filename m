Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vegard.nossum@oracle.com>) id 1aTVna-0003gh-U3
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 14:31:18 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aTVna-0007xz-1A
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 14:31:18 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Wed, 10 Feb 2016 15:29:45 +0100
Message-Id: <1455114596-3532-10-git-send-email-vegard.nossum@oracle.com>
In-Reply-To: <1455114596-3532-1-git-send-email-vegard.nossum@oracle.com>
References: <1455114596-3532-1-git-send-email-vegard.nossum@oracle.com>
Subject: [uml-devel] [PATCH 10/21] usb: add HAS_IOMEM dependency to
	USB_EHCI_HCD
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

drivers/built-in.o: In function `ehci_platform_probe':
/home/vegard/linux/drivers/usb/host/ehci-platform.c:282: undefined reference to `devm_ioremap_resource'
drivers/built-in.o: In function `oxu_drv_probe':
/home/vegard/linux/drivers/usb/host/oxu210hp-hcd.c:3821: undefined reference to `devm_ioremap_resource'
drivers/built-in.o: In function `isp1362_probe':
/home/vegard/linux/drivers/usb/host/isp1362-hcd.c:2668: undefined reference to `devm_ioremap_resource'

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 drivers/usb/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 96221c4..4c2e38a 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -72,6 +72,7 @@ endif # USB_XHCI_HCD
 
 config USB_EHCI_HCD
 	tristate "EHCI HCD (USB 2.0) support"
+	depends on HAS_IOMEM
 	---help---
 	  The Enhanced Host Controller Interface (EHCI) is standard for USB 2.0
 	  "high speed" (480 Mbit/sec, 60 Mbyte/sec) host controller hardware.
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

