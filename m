Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4Ncj-0006jB-NM for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Sep 2004 10:49:49 -0700
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C4Nch-0003ak-Oy for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Sep 2004 10:49:48 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20040906173524.EE034B977@zion.localdomain>
Subject: [uml-devel] [patch 1/1] uml: no extraversion in arch/um/Makefile for
	mainline
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
Date: Mon, 06 Sep 2004 19:35:24 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Extraversion in arch/um/Makefile is not needed in mainline, but just for
separate patches; also, they should set it in the main Makefile, not elsewhere
(Jeff Garzik has just complained).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/Makefile |    9 ---------
 1 files changed, 9 deletions(-)

diff -puN arch/um/Makefile~uml-no-extraversion-in-mainline arch/um/Makefile
--- uml-linux-2.6.8.1/arch/um/Makefile~uml-no-extraversion-in-mainline	2004-09-06 19:23:08.400492544 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/Makefile	2004-09-06 19:24:05.342835992 +0200
@@ -10,13 +10,6 @@ SHELL := /bin/bash
 
 filechk_gen_header = $<
 
-# Recalculate MODLIB to reflect the EXTRAVERSION changes (via KERNELRELEASE)
-# The way the toplevel Makefile is written EXTRAVERSION is not supposed
-# to be changed outside the toplevel Makefile, but recalculating MODLIB is
-# a sufficient workaround until we no longer need architecture dependent
-# EXTRAVERSION...
-MODLIB := $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
-
 core-y			+= $(ARCH_DIR)/kernel/		\
 			   $(ARCH_DIR)/drivers/		\
 			   $(ARCH_DIR)/sys-$(SUBARCH)/
@@ -44,8 +37,6 @@ SYS_DIR		:= $(ARCH_DIR)/include/sysdep-$
 include $(ARCH_DIR)/Makefile-$(SUBARCH)
 include $(ARCH_DIR)/Makefile-os-$(OS)
 
-EXTRAVERSION := $(EXTRAVERSION)-1um
-
 # -Derrno=kernel_errno - This turns all kernel references to errno into
 # kernel_errno to separate them from the libc errno.  This allows -fno-common
 # in CFLAGS.  Otherwise, it would cause ld to complain about the two different
_


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
