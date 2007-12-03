Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IzKkg-0003id-Cw for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Dec 2007 15:31:02 -0800
Received: from wa-out-1112.google.com ([209.85.146.179])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IzKke-0002lN-L2
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Dec 2007 15:31:02 -0800
Received: by wa-out-1112.google.com with SMTP id k22so6101102waf
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 03 Dec 2007 15:31:00 -0800 (PST)
Message-ID: <ea9232d10712031530v2e8ff2e9k323b51ede7d87e1f@mail.gmail.com>
Date: Tue, 4 Dec 2007 00:30:59 +0100
From: "Karol Swietlicki" <magotari@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] uml: Fix NET appearing twice in Kconfig.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

This patch fixes the repetition of the NET symbol. It was once in UML
specific options and once in networking. I removed the first
occurrence, as it makes more sense to me to keep it only in
networking.

Compile and run tested.

Karol Swietlicki

Signed-off-by: Karol Swietlicki <magotari@gmail.com>
---
diff -rupN linux-2.6.24-rc3-mm2.orig/arch/um/Kconfig
linux-2.6.24-rc3-mm2/arch/um/Kconfig
--- linux-2.6.24-rc3-mm2.orig/arch/um/Kconfig	2007-12-03
22:43:52.000000000 +0100
+++ linux-2.6.24-rc3-mm2/arch/um/Kconfig	2007-12-03 22:46:08.000000000 +0100
@@ -95,23 +95,6 @@ config LD_SCRIPT_DYN
 	default y
 	depends on !LD_SCRIPT_STATIC

-config NET
-	bool "Networking support"
-	help
-	  Unless you really know what you are doing, you should say Y here.
-	  The reason is that some programs need kernel networking support even
-	  when running on a stand-alone machine that isn't connected to any
-	  other computer. If you are upgrading from an older kernel, you
-	  should consider updating your networking tools too because changes
-	  in the kernel and the tools often go hand in hand. The tools are
-	  contained in the package net-tools, the location and version number
-	  of which are given in <file:Documentation/Changes>.
-
-	  For a general introduction to Linux networking, it is highly
-	  recommended to read the NET-HOWTO, available from
-	  <http://www.tldp.org/docs.html#howto>.
-
-
  source "fs/Kconfig.binfmt"

  config HOSTFS

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
