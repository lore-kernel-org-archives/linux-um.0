Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHANk-0002hw-Sn for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:19:12 -0700
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CHANi-0007ZU-H9 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:19:12 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041012001749.C0D03868D@zion.localdomain>
Subject: [uml-devel] [patch 03/10] uml: no extraversion in arch/um/Makefile
	for mainline
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
Date: Tue, 12 Oct 2004 02:17:49 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Extraversion in arch/um/Makefile is not needed in mainline, but just for
separate patches; also, they should set it in the main Makefile, not elsewhere
(Jeff Garzik has just complained). Also remove the dependency from version.h
on arch/um/Makefile: it was added because arch/um/Makefile could change the
kernel version number.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/Makefile |    9 ---------
 1 files changed, 9 deletions(-)

diff -puN arch/um/Makefile~uml-no-extraversion-in-mainline arch/um/Makefile
--- linux-2.6.9-current/arch/um/Makefile~uml-no-extraversion-in-mainline	2004-10-12 00:39:57.768983440 +0200
+++ linux-2.6.9-current-paolo/arch/um/Makefile	2004-10-12 00:40:11.263931896 +0200
@@ -8,13 +8,6 @@ OS := $(shell uname -s)
 #We require it or things break.
 SHELL := /bin/bash
 
-# Recalculate MODLIB to reflect the EXTRAVERSION changes (via KERNELRELEASE)
-# The way the toplevel Makefile is written EXTRAVERSION is not supposed
-# to be changed outside the toplevel Makefile, but recalculating MODLIB is
-# a sufficient workaround until we no longer need architecture dependent
-# EXTRAVERSION...
-MODLIB := $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
-
 core-y			+= $(ARCH_DIR)/kernel/		 \
 			   $(ARCH_DIR)/drivers/          \
 			   $(ARCH_DIR)/sys-$(SUBARCH)/
@@ -73,8 +66,6 @@ ifeq ($(CONFIG_MODE_SKAS), y)
 $(SYS_HEADERS) : $(TOPDIR)/$(ARCH_DIR)/include/skas_ptregs.h
 endif
 
-include/linux/version.h: arch/$(ARCH)/Makefile
-
 $(ARCH_DIR)/vmlinux.lds.S :
 	touch $@
 
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
