Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHANf-0002ga-3d for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:19:07 -0700
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CHANb-0000IE-VC for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:19:06 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041012001747.64A76868B@zion.localdomain>
Subject: [uml-devel] [patch 02/10] uml: force using /bin/bash for building
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
Date: Tue, 12 Oct 2004 02:17:47 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


This forces make to use bash rather than whatever /bin/sh is linked to.
Without this, since there are some bash extensions used in the build and when
/bin/sh isn't bash, then the build fails without a clear error message.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/Makefile |    2 ++
 1 files changed, 2 insertions(+)

diff -puN arch/um/Makefile~uml-force-bash arch/um/Makefile
--- linux-2.6.9-current/arch/um/Makefile~uml-force-bash	2004-10-12 01:06:02.860053432 +0200
+++ linux-2.6.9-current-paolo/arch/um/Makefile	2004-10-12 01:06:02.863052976 +0200
@@ -5,6 +5,8 @@
 
 ARCH_DIR = arch/um
 OS := $(shell uname -s)
+#We require it or things break.
+SHELL := /bin/bash
 
 # Recalculate MODLIB to reflect the EXTRAVERSION changes (via KERNELRELEASE)
 # The way the toplevel Makefile is written EXTRAVERSION is not supposed
_


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
