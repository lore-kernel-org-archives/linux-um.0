Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AwThv-0004UK-Od for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Feb 2004 14:10:15 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1AwTKD-0001Up-KH
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Feb 2004 13:45:45 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20040226212946.GA5208@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [patch] makefile cleanup
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
Date: Thu, 26 Feb 2004 22:29:46 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: uml devel <user-mode-linux-devel@lists.sourceforge.net>

  Hi,

Neat trick to get rid of some symlinks, stolen from the x86-64 makefiles ;)

  Gerd

--- linux-2.6.3/arch/um/sys-i386/Makefile.sym	2004-02-26 21:55:23.014975595 +0100
+++ linux-2.6.3/arch/um/sys-i386/Makefile	2004-02-26 21:59:55.961970104 +0100
@@ -7,24 +7,11 @@
 USER_OBJS := bugs.o ptrace_user.o sigcontext.o fault.o
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
-SYMLINKS = semaphore.c highmem.c module.c
-SYMLINKS := $(foreach f,$(SYMLINKS),$(src)/$f)
-
-clean-files := $(SYMLINKS)
-
-semaphore.c-dir = kernel
-highmem.c-dir = mm
-module.c-dir = kernel
-
-define make_link
-	-rm -f $1
-	ln -sf $(TOPDIR)/arch/i386/$($(notdir $1)-dir)/$(notdir $1) $1
-endef
+semaphore-y = ../../i386/kernel/semaphore.o
+highmem-y = ../../i386/mm/highmem.o
+module-y = ../../i386/kernel/module.o
 
 $(USER_OBJS) : %.o: %.c
 	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
 
-$(SYMLINKS): 
-	$(call make_link,$@)
-
 subdir- := util


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
