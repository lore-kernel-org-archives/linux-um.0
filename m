Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AKHMs-0008MV-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 13 Nov 2003 05:18:38 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AKHMs-0003db-0o
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 13 Nov 2003 05:18:38 -0800
From: Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <Pine.GSO.4.21.0311082314170.1769-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] [PATCH] default target
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 13 Nov 2003 14:18:16 +0100 (MET)
To: Jeff Dike <jdike@karaya.com>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

	Hi Jeff,

This patch sets the default build target for UML to `linux', so you can use
plain `make', like for all other architectures.

--- linux-uml-2.6.0-test9/arch/um/Makefile.orig	2003-10-22 10:41:08.000000000 +0200
+++ linux-uml-2.6.0-test9/arch/um/Makefile	2003-11-02 13:41:33.000000000 +0100
@@ -76,6 +76,8 @@
 
 LDFLAGS_vmlinux = -r
 
+all: linux
+
 vmlinux: $(ARCH_DIR)/main.o 
 
 # These aren't in Makefile-tt because they are needed in the !CONFIG_MODE_TT +

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
