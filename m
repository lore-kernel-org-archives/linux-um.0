Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vegard.nossum@oracle.com>) id 1aTVnd-0002pp-QL
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 14:31:21 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aTVnc-0005f3-NN
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 14:31:21 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Wed, 10 Feb 2016 15:29:46 +0100
Message-Id: <1455114596-3532-11-git-send-email-vegard.nossum@oracle.com>
In-Reply-To: <1455114596-3532-1-git-send-email-vegard.nossum@oracle.com>
References: <1455114596-3532-1-git-send-email-vegard.nossum@oracle.com>
Subject: [uml-devel] [PATCH 11/21] usb: add HAS_IOMEM dependency to
	USB_XHCI_HCD
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

drivers/built-in.o: In function `xhci_plat_probe':
/home/vegard/linux/drivers/usb/host/xhci-plat.c:160: undefined reference to `devm_ioremap_resource'

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 drivers/usb/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 4c2e38a..90cb8d5 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -18,6 +18,7 @@ config USB_C67X00_HCD
 
 config USB_XHCI_HCD
 	tristate "xHCI HCD (USB 3.0) support"
+	depends on HAS_IOMEM
 	---help---
 	  The eXtensible Host Controller Interface (xHCI) is standard for USB 3.0
 	  "SuperSpeed" host controller hardware.
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

