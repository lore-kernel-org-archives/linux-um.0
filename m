Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ip7c2-0006lE-Qu for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Nov 2007 11:27:54 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ip7c1-00058H-VX
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Nov 2007 11:27:54 -0800
Date: Mon, 5 Nov 2007 14:27:46 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071105192746.GA8788@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 2/6] UML - SMP needs to depend on BROKEN for now
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
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

SMP still needs to depend on BROKEN for now.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/Kconfig |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6/arch/um/Kconfig
===================================================================
--- linux-2.6.orig/arch/um/Kconfig	2007-11-05 14:08:07.000000000 -0500
+++ linux-2.6/arch/um/Kconfig	2007-11-05 14:12:35.000000000 -0500
@@ -189,8 +189,7 @@ config MAGIC_SYSRQ
 config SMP
 	bool "Symmetric multi-processing support (EXPERIMENTAL)"
 	default n
-	#SMP_BROKEN is for x86_64.
-	depends on EXPERIMENTAL && (!SMP_BROKEN || (BROKEN && SMP_BROKEN))
+	depends on BROKEN
 	help
 	  This option enables UML SMP support.
 	  It is NOT related to having a real SMP box. Not directly, at least.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
