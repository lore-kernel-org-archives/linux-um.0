Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FUlnP-0002N0-Ry for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 15 Apr 2006 07:30:43 -0700
Received: from mailout.stusta.mhn.de ([141.84.69.5])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FUlnP-0005xS-7m
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 15 Apr 2006 07:30:43 -0700
From: Adrian Bunk <bunk@stusta.de>
Message-ID: <20060415143036.GI15022@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [RFC: 2.6 patch] fix the INIT_ENV_ARG_LIMIT dependencies
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 15 Apr 2006 16:30:36 +0200
To: jdike@karaya.com
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Jean-Luc Leger <reiga@dspnet.fr.eu.org>

This patch fixes the INIT_ENV_ARG_LIMIT dependencies to what seems to 
have been intended.

Spotted by Jean-Luc Leger.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc1-mm2-full/init/Kconfig.old	2006-04-15 16:26:46.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/init/Kconfig	2006-04-15 16:27:12.000000000 +0200
@@ -46,8 +46,8 @@
 
 config INIT_ENV_ARG_LIMIT
 	int
-	default 32 if !USERMODE
-	default 128 if USERMODE
+	default 32 if !UML
+	default 128 if UML
 	help
 	  Maximum of each of the number of arguments and environment
 	  variables passed to init from the kernel command line.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
