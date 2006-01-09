Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EvnYL-0000mo-MT for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Jan 2006 19:18:37 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EvnYK-0004Cd-6P
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Jan 2006 19:18:37 -0800
Message-Id: <200601090410.k094Auss001185@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/6] UML - Update Kconfig help
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
Date: Sun, 08 Jan 2006 23:10:56 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

The MODE_TT help was a little outdated.  This updates it in light of the
existence of skas0 mode.
It's also turned off by default since it is mostly obsoleted by skas0 mode.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/Kconfig
===================================================================
--- linux-2.6.15-mm.orig/arch/um/Kconfig	2006-01-06 21:05:23.000000000 -0500
+++ linux-2.6.15-mm/arch/um/Kconfig	2006-01-06 23:34:46.000000000 -0500
@@ -35,12 +35,12 @@ menu "UML-specific options"
 
 config MODE_TT
 	bool "Tracing thread support"
-	default y
+	default n
 	help
 	This option controls whether tracing thread support is compiled
-	into UML.  Normally, this should be set to Y.  If you intend to
-	use only skas mode (and the host has the skas patch applied to it),
-	then it is OK to say N here.
+	into UML.  This option is largely obsolete, given that skas0 provides
+	skas security and performance without needing to patch the host.
+	It is safe to say 'N' here.
 
 config STATIC_LINK
 	bool "Force a static link"



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
