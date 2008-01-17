Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFcTq-000120-0H for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:01 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFcTp-0001a6-5U
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:40:57 -0800
Date: Thu, 17 Jan 2008 16:40:41 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080117214041.GA6717@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 7/20] UML - Add back CONFIG_HZ
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
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, "H. Peter Anvin" <hpa@zytor.com>

avoid-overflows-in-kernel-timec.patch makes CONFIG_HZ necessary for a
successful build.  UML lacks a definition, so this patch adds one.  It
also changes the hard-wired definition of HZ to CONFIG_HZ.

Note: this patch is a good idea even in the absence of hpa's time
fixes.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/Kconfig        |    4 ++++
 include/asm-um/param.h |    2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

Index: linux-2.6.22/arch/um/Kconfig
===================================================================
--- linux-2.6.22.orig/arch/um/Kconfig	2008-01-01 17:32:04.000000000 -0500
+++ linux-2.6.22/arch/um/Kconfig	2008-01-02 11:16:44.000000000 -0500
@@ -68,6 +68,10 @@ config IRQ_RELEASE_METHOD
 	bool
 	default y
 
+config HZ
+	int
+	default 100
+
 menu "UML-specific options"
 
 config STATIC_LINK
Index: linux-2.6.22/include/asm-um/param.h
===================================================================
--- linux-2.6.22.orig/include/asm-um/param.h	2007-07-08 19:32:17.000000000 -0400
+++ linux-2.6.22/include/asm-um/param.h	2008-01-02 11:18:44.000000000 -0500
@@ -10,7 +10,7 @@
 #define MAXHOSTNAMELEN  64      /* max length of hostname */
 
 #ifdef __KERNEL__
-#define HZ 100
+#define HZ CONFIG_HZ
 #define USER_HZ	100	   /* .. some user interfaces are in "ticks" */
 #define CLOCKS_PER_SEC (USER_HZ)  /* frequency at which times() counts */
 #endif

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
