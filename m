Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JpSAK-0003lj-7H for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Apr 2008 10:56:56 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JpSA5-0000vG-6S
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Apr 2008 10:56:45 -0700
Date: Fri, 25 Apr 2008 13:56:16 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080425175616.GA11202@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 16/19] UML - Fix CONFIG_RAW dependencies
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
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>

From: Robert P. J. Day <rpjday@crashcourse.ca>

Add the BLOCK dependency for RAW_DRIVER, to match what's in
drivers/char/Kconfig.  Also, while we're there, update the alleged
obsolesence of RAW_DRIVER since it doesn't seem to be going away any
time soon.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/Kconfig.char |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.22/arch/um/Kconfig.char
===================================================================
--- linux-2.6.22.orig/arch/um/Kconfig.char	2008-02-20 11:23:30.000000000 -0500
+++ linux-2.6.22/arch/um/Kconfig.char	2008-03-07 11:57:18.000000000 -0500
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

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
