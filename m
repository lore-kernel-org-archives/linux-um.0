Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CIDjC-0000PL-Fk for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Oct 2004 15:05:42 -0700
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CIDjA-0002gM-Ma for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Oct 2004 15:05:42 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041014220554.0F20244BE@zion.localdomain>
Subject: [uml-devel] [patch 1/1] uml: readd linux Makefile target
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
Date: Fri, 15 Oct 2004 00:05:53 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Since people are used to doing "make linux ARCH=um" and to use "linux" as the
kernel image, make it be an hard link to vmlinux. This should hurt the less
possible the users (actually nothing) while not slowing down the build.

Acked-by: Jeff Dike <jdike@addtoit.com>

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/Makefile |   12 ++++++++++++
 1 files changed, 12 insertions(+)

diff -puN arch/um/Makefile~uml-readd-linux-target arch/um/Makefile
--- linux-2.6.9-current/arch/um/Makefile~uml-readd-linux-target	2004-10-14 22:52:47.274383552 +0200
+++ linux-2.6.9-current-paolo/arch/um/Makefile	2004-10-14 22:52:47.276383248 +0200
@@ -62,6 +62,18 @@ ifeq ($(CONFIG_MODE_SKAS), y)
 $(SYS_HEADERS) : $(ARCH_DIR)/include/skas_ptregs.h
 endif
 
+all: linux
+
+linux: vmlinux
+	$(RM) $@
+	ln $< $@
+
+define archhelp
+  echo '* linux		- Binary kernel image (./linux) - for backward'
+  echo '		   compatibility only: now you can simply run'
+  echo '		   the vmlinux binary you find in the kernel root.'
+endef
+
 prepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS) \
 	$(ARCH_DIR)/kernel/vmlinux.lds.S
 
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
