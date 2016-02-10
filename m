Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vegard.nossum@oracle.com>) id 1aTVnv-0006pB-Fy
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 14:31:39 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aTVnu-0007z1-MY
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 14:31:39 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Wed, 10 Feb 2016 15:29:56 +0100
Message-Id: <1455114596-3532-21-git-send-email-vegard.nossum@oracle.com>
In-Reply-To: <1455114596-3532-1-git-send-email-vegard.nossum@oracle.com>
References: <1455114596-3532-1-git-send-email-vegard.nossum@oracle.com>
Subject: [uml-devel] [PATCH 21/21] usb: remove HAS_IOMEM dependency from
	USB_SUPPORT
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

USB has not been usable on UML since this commit:

commit e25df1205f37c7bff3ab14fdfc8a5249f3c69c82
Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date:   Thu May 10 15:45:57 2007 +0200

    [S390] Kconfig: menus with depends on HAS_IOMEM.

    Add "depends on HAS_IOMEM" to a number of menus to make them
    disappear for s390 which does not have I/O memory.

    Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

With hopefully all USB Host Controller Drivers that need it now
depending on HAS_IOMEM, we can remove the dependency from USB_SUPPORT
itself. This makes it possible to include USB support in UML builds
again.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 drivers/usb/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 8ed451d..93ba109 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -21,7 +21,6 @@ config USB_EHCI_BIG_ENDIAN_DESC
 
 menuconfig USB_SUPPORT
 	bool "USB support"
-	depends on HAS_IOMEM
 	default y
 	---help---
 	  This option adds core support for Universal Serial Bus (USB).
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

