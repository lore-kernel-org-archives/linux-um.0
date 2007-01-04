Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H2XiI-0007mq-WF for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Jan 2007 10:53:19 -0800
Received: from mailout.stusta.mhn.de ([141.84.69.5])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1H2XiI-0001j6-8y
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Jan 2007 10:53:18 -0800
Date: Thu, 4 Jan 2007 19:53:07 +0100
From: Adrian Bunk <bunk@stusta.de>
Message-ID: <20070104185307.GE20714@stusta.de>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [2.6 patch] remove duplicate MMAPPER Kconfig option
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@karaya.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This option is already in arch/um/Kconfig.char

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.20-rc2-mm1/drivers/block/Kconfig.old	2007-01-04 17:43:51.000000000 +0100
+++ linux-2.6.20-rc2-mm1/drivers/block/Kconfig	2007-01-04 17:44:19.000000000 +0100
@@ -236,23 +236,6 @@
 	bool
 	default BLK_DEV_UBD
 
-config MMAPPER
-	tristate "Example IO memory driver (BROKEN)"
-	depends on UML && BROKEN
-	---help---
-          The User-Mode Linux port can provide support for IO Memory
-          emulation with this option.  This allows a host file to be
-          specified as an I/O region on the kernel command line. That file
-          will be mapped into UML's kernel address space where a driver can
-          locate it and do whatever it wants with the memory, including
-          providing an interface to it for UML processes to use.
-
-          For more information, see
-          <http://user-mode-linux.sourceforge.net/iomem.html>.
-
-          If you'd like to be able to provide a simulated IO port space for
-          User-Mode Linux processes, say Y.  If unsure, say N.
-
 config BLK_DEV_LOOP
 	tristate "Loopback device support"
 	---help---


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
