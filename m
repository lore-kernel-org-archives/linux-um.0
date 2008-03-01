Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JVQbo-0006ts-1C for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 01 Mar 2008 04:14:32 -0800
Received: from astoria.ccjclearline.com ([64.235.106.9])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JVQbl-000684-G0
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 01 Mar 2008 04:14:31 -0800
Date: Sat, 1 Mar 2008 07:14:19 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Message-ID: <alpine.LFD.1.00.0803010711200.5500@AU52T-1.iHotel.ca>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH] USER-MODE LINUX: Add BLOCK dependency for
	RAW_DRIVER.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@karaya.com>


Add the BLOCK dependency for RAW_DRIVER, to match what's in
drivers/char/Kconfig.  Also, while we're there, update the alleged
obsolesence of RAW_DRIVER since it doesn't seem to be going away any
time soon.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---
diff --git a/arch/um/Kconfig.char b/arch/um/Kconfig.char
index 3a4b396..1b238eb 100644
--- a/arch/um/Kconfig.char
+++ b/arch/um/Kconfig.char
@@ -145,14 +145,14 @@ config LEGACY_PTYS
 	  systems, it is safe to say N.

 config RAW_DRIVER
-        tristate "RAW driver (/dev/raw/rawN) (OBSOLETE)"
+        tristate "RAW driver (/dev/raw/rawN)"
+	depends on BLOCK
         help
           The raw driver permits block devices to be bound to /dev/raw/rawN.
           Once bound, I/O against /dev/raw/rawN uses efficient zero-copy I/O.
           See the raw(8) manpage for more details.

-          The raw driver is deprecated and will be removed soon.
-          Applications should simply open the device (eg /dev/hda1)
+          Applications should preferably open the device (eg /dev/hda1)
           with the O_DIRECT flag.

 config MAX_RAW_DEVS
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry:
    Have classroom, will lecture.

http://crashcourse.ca                          Waterloo, Ontario, CANADA
========================================================================

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
