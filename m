Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHANd-0002gD-UM for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:19:05 -0700
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CHANb-0000IC-RI for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:19:05 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041012001745.11E3B8686@zion.localdomain>
Subject: [uml-devel] [patch 01/10] uml: Set cflags before including arch
	Makefile
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
Date: Tue, 12 Oct 2004 02:17:44 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


If arch/$(ARCH)/Makefile is included before adding -O2 (and the rest) to
CFLAGS, I must duplicate the addition of it to USER_CFLAGS for UML.
So let's fix this.
Also, the below code is useless, since if CONFIG_DEBUG_INFO is y, then
CONFIG_FRAME_POINTER is always y.

ifeq ($(CONFIG_DEBUG_INFO),y)
CFLAGS := $(subst -fomit-frame-pointer,,$(CFLAGS))
endif


Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/Makefile |   21 ---------------------
 1 files changed, 21 deletions(-)

diff -puN arch/um/Makefile~uml-Set_cflags_before_arch_Makefile arch/um/Makefile
--- linux-2.6.9-current/arch/um/Makefile~uml-Set_cflags_before_arch_Makefile	2004-10-12 01:06:01.579248144 +0200
+++ linux-2.6.9-current-paolo/arch/um/Makefile	2004-10-12 01:06:01.582247688 +0200
@@ -13,10 +13,6 @@ OS := $(shell uname -s)
 # EXTRAVERSION...
 MODLIB := $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
 
-ifeq ($(CONFIG_DEBUG_INFO),y)
-CFLAGS := $(subst -fomit-frame-pointer,,$(CFLAGS))
-endif
-
 core-y			+= $(ARCH_DIR)/kernel/		 \
 			   $(ARCH_DIR)/drivers/          \
 			   $(ARCH_DIR)/sys-$(SUBARCH)/
@@ -135,23 +131,6 @@ USER_CFLAGS := $(patsubst -D__KERNEL__,,
 # To get a definition of F_SETSIG
 USER_CFLAGS += -D_GNU_SOURCE
 
-# From main Makefile, these options are set after including the ARCH makefile.
-# So copy them here.
-
-ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
-USER_CFLAGS		+= -Os
-else
-USER_CFLAGS		+= -O2
-endif
-
-ifndef CONFIG_FRAME_POINTER
-USER_CFLAGS		+= -fomit-frame-pointer
-endif
-
-ifdef CONFIG_DEBUG_INFO
-USER_CFLAGS		+= -g
-endif
-
 CLEAN_FILES += linux x.i gmon.out $(ARCH_DIR)/uml.lds \
 	$(ARCH_DIR)/dyn_link.ld.s $(ARCH_DIR)/include/uml-config.h \
 	$(GEN_HEADERS)
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
