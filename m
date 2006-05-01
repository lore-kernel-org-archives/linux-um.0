Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FacMU-0007Rv-TR for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 May 2006 10:39:06 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FacMT-0006lH-Eq
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 May 2006 10:39:06 -0700
Message-Id: <200605011639.k41GdkGV004644@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH] UML - uml-makefile-nicer uses SYMLINK incorrectly
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
Date: Mon, 01 May 2006 12:39:46 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Blaisorblade's uml-makefile-nicer makes a V=0 build say SYMLINK where what's
happening is really a LINK.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/Makefile
===================================================================
--- linux-2.6.16.orig/arch/um/Makefile	2006-05-01 13:23:13.000000000 -0400
+++ linux-2.6.16/arch/um/Makefile	2006-05-01 13:28:47.000000000 -0400
@@ -96,7 +96,7 @@ PHONY += linux
 all: linux
 
 linux: vmlinux
-	@echo '  SYMLINK $@'
+	@echo '  LINK $@'
 	$(Q)ln -f $< $@
 
 define archhelp



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
