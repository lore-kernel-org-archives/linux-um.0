Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYr8L-0003IF-4Z
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 23 Dec 2003 10:19:53 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYr8K-000417-Id
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 23 Dec 2003 10:19:52 -0800
From: Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <Pine.GSO.4.58.0312231727190.1495@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] CONFIG_HW_CONSOLE
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 23 Dec 2003 19:19:43 +0100 (MET)
To: Jeff Dike <jdike@addtoit.com>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

	Hi Jeff,

I think there are 4 reasons for applying this patch:
  - CONFIG_UM does not exist
  - drivers/char/Kconfig is not used for UML
  - VT is not set for UML anyway
  - The kernel doesn't link if you do set VT and HW_CONSOLE is not set

--- linux-uml-2.6.0-test9-1/drivers/char/Kconfig.orig	2003-10-25 21:44:08.000000000 +0200
+++ linux-uml-2.6.0-test9-1/drivers/char/Kconfig	2003-12-23 17:22:44.000000000 +0100
@@ -59,7 +59,7 @@

 config HW_CONSOLE
 	bool
-	depends on VT && !S390 && !UM
+	depends on VT && !S390
 	default y

 config SERIAL_NONSTANDARD


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
