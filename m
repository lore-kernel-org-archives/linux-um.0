Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B6Art-0002cy-BD for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Mar 2004 08:04:37 -0800
Received: from mx15.sac.fedex.com ([199.81.195.17])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1B6Ars-00062h-M4
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Mar 2004 08:04:36 -0800
Received: from inet04.prod.fedex.com (inet04.prod.fedex.com [199.81.10.44])
	by mx15.sac.fedex.com (8.12.9p2/8.12.9) with ESMTP id i2OG4JGd086479
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 24 Mar 2004 10:04:19 -0600 (CST)
	(envelope-from jeff98@silk.corp.fedex.com)
Received: from entpm11.apac.fedex.com (entpm11.apac.fedex.com [155.161.92.11])
	by inet04.prod.fedex.com (8.12.11/8.12.11) with ESMTP id
	i2OG4HfF006409 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 24 Mar 2004 10:04:18 -0600 (CST)
Received: from pppz2 (pppz2 [155.161.201.182] (may be forged))
	by silk.corp.fedex.com (8.11.4/8.11.4) with ESMTP id i2OG2q030581
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 25 Mar 2004 00:02:52 +0800
From: Jeff Chua <jeff98@silk.corp.fedex.com>
Message-ID: <Pine.LNX.4.58.0403242358410.4205@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] [PATCH] patch for linux-2.6.5-rc2
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
Date: Thu, 25 Mar 2004 00:04:29 +0800 (SGT)
To: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>


Try this for linux-2.6.5-rc2

	cd /usr/src/linux
	bzip2 -d -c uml-patch-2.6.4-1.bz2 | patch -p1
	bzip2 -d -c 00-2.6.2-v1-host-SKAS2.patch.bz2 | patch -p1

	cd /usr/src/linux; find . | cpio -pdum /usr/src/uml
	cd /usr/src/uml
	patchx -R 00-2.6.2-v1-host-SKAS2.patch.bz2
	patch -p0 <_the_attached_patch_below_


Works for me using stock 2.6.5-rc2 kernel with reiser4.


Thanks,
Jeff


--- arch/um/Makefile-i386.org	Wed Mar 24 23:53:44 2004
+++ arch/um/Makefile-i386	Tue Mar 23 22:28:58 2004
@@ -30,7 +30,7 @@
 $(SYS_DIR)/thread.h: $(SYS_UTIL_DIR)/mk_thread
 	$(call filechk,$@)

-$(SYS_UTIL_DIR)/mk_sc: scripts/fixdep include/config/MARKER FORCE ;
+$(SYS_UTIL_DIR)/mk_sc: scripts/basic/fixdep include/config/MARKER FORCE ;
 	$(Q)$(MAKE) $(build)=$(SYS_UTIL_DIR) $@

 $(SYS_UTIL_DIR)/mk_thread: $(ARCH_SYMLINKS) $(GEN_HEADERS) sys_prepare FORCE ;
--- ./arch/um/kernel/Makefile.org	Wed Mar 24 23:55:39 2004
+++ ./arch/um/kernel/Makefile	Tue Mar 23 22:20:55 2004
@@ -38,7 +38,7 @@
 $(USER_OBJS) : %.o: %.c
 	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<

-QUOTE = 'my $$config=`cat $(TOPDIR)/.config`; $$config =~ s/"/\\"/g ; $$config =~ s/\n/\\n"\n"/g ; while(<STDIN>) { $$_ =~ s/CONFIG/$$config/; print $$_ }'
+QUOTE = 'my $$config=`cat $(TOPDIR)/.config`; $$config =~ s/"/\\"/g ; $$config =~ s/\\n/\\\n"\\n"/g ; while(<STDIN>) { $$_ =~ s/CONFIG/$$config/; print $$_ }'

 $(obj)/config.o : $(obj)/config.c

--- arch/um/kernel/skas/process.c.org	Wed Mar 24 23:56:27 2004
+++ arch/um/kernel/skas/process.c	Tue Mar 23 22:20:22 2004
@@ -24,6 +24,7 @@
 #include "sysdep/sigcontext.h"
 #include "os.h"
 #include "proc_mm.h"
+#define __SKAS_PTRACE_H
 #include "skas_ptrace.h"
 #include "chan_user.h"
 #include "signal_user.h"
--- arch/um/kernel/process.c.org	Wed Mar 24 23:57:25 2004
+++ arch/um/kernel/process.c	Tue Mar 23 22:20:27 2004
@@ -37,6 +37,7 @@
 #include "mode.h"
 #ifdef UML_CONFIG_MODE_SKAS
 #include "skas.h"
+#define __SKAS_PTRACE_H
 #include "skas_ptrace.h"
 #endif



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
