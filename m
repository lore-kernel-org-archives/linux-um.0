Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPWr6-0004jx-UT for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:56:04 -0800
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CPWr5-0000N9-5u for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:56:04 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20041103231716.ABAFA3636F@zion.localdomain>
Subject: [uml-devel] [patch 01/20] Uml - some comments about forcing /bin/bash
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
Date: Thu, 04 Nov 2004 00:17:15 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org, blaisorblade_spam@yahoo.it


Changes a comment about forcing /bin/bash as shell for the UML Makefile.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/um/Makefile~uml-need-bash arch/um/Makefile
--- vanilla-linux-2.6.9/arch/um/Makefile~uml-need-bash	2004-11-03 23:44:35.055230912 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/Makefile	2004-11-03 23:44:35.057230608 +0100
@@ -5,7 +5,8 @@
 
 ARCH_DIR = arch/um
 OS := $(shell uname -s)
-#We require it or things break.
+# We require bash because the vmlinux link and loader script cpp use bash
+# features.
 SHELL := /bin/bash
 
 filechk_gen_header = $<
_


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
