Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BYAuf-00043J-8R for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jun 2004 14:47:13 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BYAue-0007oA-Kn for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jun 2004 14:47:12 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Message-Id: <200406091229.43740.blaisorblade_spam@yahoo.it>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ZFvxA6YWQCe84Rc"
Subject: [uml-devel] [PATCH][TRIVIAL] Make help support + config option for
	LEGACY_PTYS
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
Date: Wed, 9 Jun 2004 13:15:37 +0200
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@bytesex.org>



--Boundary-00=_ZFvxA6YWQCe84Rc
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The first patch makes "make help ARCH=um" work. I think it should go in *now*.

The second adds the LEGACY_PTY support. Without it, with late 2.6 kernels 
/dev/ptyxx won't work. In fact, with those kernels, root_fs_toms does not 
work, because it's "unable to allocate TTY pair". And removes the dead option 
"UNIX98_PTY_COUNT" (just commented out for now).

By the way: don't you think that the SCSI configuration is *useless* for UML, 
and that we should try to include the standard Kconfig files, after adding 
"if !USERMODE" to some config options inside them?
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



--Boundary-00=_ZFvxA6YWQCe84Rc
Content-Type: text/x-diff;
  charset="us-ascii";
  name="MakeHelp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="MakeHelp.patch"

--- ./arch/um/Makefile.makeHelp	2004-05-12 18:02:35.000000000 +0200
+++ ./arch/um/Makefile	2004-05-12 19:10:52.000000000 +0200
@@ -207,3 +207,9 @@
 	$(Q)$(MAKE) $(build)=$@
 
 export SUBARCH USER_CFLAGS OS 
+
+all: linux
+
+define archhelp
+  echo  '* linux	- Binary kernel image (./linux)'
+endef

--Boundary-00=_ZFvxA6YWQCe84Rc
Content-Type: text/x-diff; charset="us-ascii";
	name="LegacyTerminalSupport.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="LegacyTerminalSupport.patch"

--- ./arch/um/Kconfig_char.Terminals	2003-12-20 17:20:02.000000000 +0100
+++ ./arch/um/Kconfig_char	2004-06-09 12:19:37.000000000 +0200
@@ -108,11 +108,60 @@
 
 config UNIX98_PTYS
 	bool "Unix98 PTY support"
-
-config UNIX98_PTY_COUNT
-	int "Maximum number of Unix98 PTYs in use (0-2048)"
-	depends on UNIX98_PTYS
+	---help---
+	  A pseudo terminal (PTY) is a software device consisting of two
+	  halves: a master and a slave. The slave device behaves identical to
+	  a physical terminal; the master device is used by a process to
+	  read data from and write data to the slave, thereby emulating a
+	  terminal. Typical programs for the master side are telnet servers
+	  and xterms.
+
+	  Linux has traditionally used the BSD-like names /dev/ptyxx for
+	  masters and /dev/ttyxx for slaves of pseudo terminals. This scheme
+	  has a number of problems. The GNU C library glibc 2.1 and later,
+	  however, supports the Unix98 naming standard: in order to acquire a
+	  pseudo terminal, a process opens /dev/ptmx; the number of the pseudo
+	  terminal is then made available to the process and the pseudo
+	  terminal slave can be accessed as /dev/pts/<number>. What was
+	  traditionally /dev/ttyp2 will then be /dev/pts/2, for example.
+
+	  All modern Linux systems use the Unix98 ptys.  Say Y unless
+	  you're on an embedded system and want to conserve memory.
+
+config LEGACY_PTYS
+	bool "Legacy (BSD) PTY support"
+	default y
+	---help---
+	  A pseudo terminal (PTY) is a software device consisting of two
+	  halves: a master and a slave. The slave device behaves identical to
+	  a physical terminal; the master device is used by a process to
+	  read data from and write data to the slave, thereby emulating a
+	  terminal. Typical programs for the master side are telnet servers
+	  and xterms.
+
+	  Linux has traditionally used the BSD-like names /dev/ptyxx
+	  for masters and /dev/ttyxx for slaves of pseudo
+	  terminals. This scheme has a number of problems, including
+	  security.  This option enables these legacy devices; on most
+	  systems, it is safe to say N.
+
+
+config LEGACY_PTY_COUNT
+	int "Maximum number of legacy PTY in use"
+	depends on LEGACY_PTYS
 	default "256"
+	---help---
+	  The maximum number of legacy PTYs that can be used at any one time.
+	  The default is 256, and should be more than enough.  Embedded
+	  systems may want to reduce this to save memory.
+
+	  When not in use, each legacy PTY occupies 12 bytes on 32-bit
+	  architectures and 24 bytes on 64-bit architectures.
+
+#config UNIX98_PTY_COUNT
+#	int "Maximum number of Unix98 PTYs in use (0-2048)"
+#	depends on UNIX98_PTYS
+#	default "256"
 
 config WATCHDOG
 	bool "Watchdog Timer Support"

--Boundary-00=_ZFvxA6YWQCe84Rc--



-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
