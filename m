Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eazi3-0004gA-5P for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 10:02:39 -0800
Received: from host20-103.pool873.interbusiness.it ([87.3.103.20]
	helo=zion.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Eazi2-0001yx-9V for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 10:02:39 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051112180711.20133.68166.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 1/9] Kbuild: index asm-$(SUBARCH) headers for UML
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
Date: Sat, 12 Nov 2005 19:07:12 +0100
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

In Uml, many definitions are borrowed from underlying subarch headers
(with #include <asm/arch/stuff.h>). And it has become annoying to keep switching
tag files all time, so by default index the underlying subarch headers too. Btw,
it adds negligible space to the tags file (less than 1M surely, IIRC it was
around 500k over 40M).

Finally, preserve the ALLSOURCE_ARCHS command line option (I hope) - if it is
set, it is used for headers too as before. But check my construct please, I
didn't test this.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 Makefile |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 6d1f727..d1b6773 100644
--- a/Makefile
+++ b/Makefile
@@ -1192,6 +1192,17 @@ else
 __srctree = $(srctree)/
 endif
 
+ifeq ($(ALLSOURCE_ARCHS),)
+ifeq ($(ARCH),um)
+ALLINCLUDE_ARCHS := $(ARCH) $(SUBARCH)
+else
+ALLINCLUDE_ARCHS := $(ARCH)
+endif
+else
+#Allow user to specify only ALLSOURCE_PATHS on the command line, keeping existing behaviour.
+ALLINCLUDE_ARCHS := $(ALLSOURCE_ARCHS)
+endif
+
 ALLSOURCE_ARCHS := $(ARCH)
 
 define all-sources
@@ -1207,7 +1218,7 @@ define all-sources
 	  find $(__srctree)include $(RCS_FIND_IGNORE) \
 	       \( -name config -o -name 'asm-*' \) -prune \
 	       -o -name '*.[chS]' -print; \
-	  for ARCH in $(ALLSOURCE_ARCHS) ; do \
+	  for ARCH in $(ALLINCLUDE_ARCHS) ; do \
 	       find $(__srctree)include/asm-$${ARCH} $(RCS_FIND_IGNORE) \
 	            -name '*.[chS]' -print; \
 	  done ; \



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
