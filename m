Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C3VOU-0001yM-83 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Sep 2004 00:55:30 -0700
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123] ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C3VOQ-000417-M8 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Sep 2004 00:55:30 -0700
From: Jan Kara <jack@suse.cz>
Message-ID: <20040904075520.GA5799@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] UML compile fix
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
Date: Sat, 4 Sep 2004 09:55:23 +0200
To: user-mode-linux-devel@lists.sourceforge.net

  Hello,

  I need attached patch for UML in 2.6.8.1 with UML patch to compile.

									Honza
Signed-off-by: Jan Kara <jack@suse.cz>

--- linux/arch/um/Makefile.orig	2004-09-03 11:52:44.000000000 +0200
+++ linux/arch/um/Makefile	2004-09-03 11:52:47.000000000 +0200
@@ -15,6 +15,7 @@
 
 ifeq ($(CONFIG_DEBUG_INFO),y)
 CFLAGS := $(subst -fomit-frame-pointer,,$(CFLAGS))
+HOSTCFLAGS := $(subst -fomit-frame-pointer,,$(HOSTCFLAGS))
 endif
 
 core-y			+= $(ARCH_DIR)/kernel/		 \
--- linux/arch/um/kernel/ksyms.c.orig	2004-09-03 11:50:13.000000000 +0200
+++ linux/arch/um/kernel/ksyms.c	2004-09-03 11:54:35.000000000 +0200
@@ -87,7 +87,6 @@
 EXPORT_SYMBOL(os_create_unix_socket);
 EXPORT_SYMBOL(os_connect_socket);
 EXPORT_SYMBOL(os_accept_connection);
-EXPORT_SYMBOL(os_ioctl_generic);
 EXPORT_SYMBOL(os_rcv_fd);
 EXPORT_SYMBOL(run_helper);
 EXPORT_SYMBOL(start_thread);


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
