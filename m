Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E9q0r-0001bL-27	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2005 13:13:49 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E9q0q-0000hK-J8
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2005 13:13:49 -0700
Message-Id: <200508292007.j7TK72Or029927@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/9] UML - Mark SMP on UML/x86_64 as broken
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
Date: Mon, 29 Aug 2005 16:07:02 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

Noticed by Al Viro - SMP on x86_64 is fundamentally broken due to
UML's reuse of the host arch's percpu stuff.  This is OK on x86, but
the x86_64 pda stuff just won't work for UML.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-rc6/arch/um/Kconfig
===================================================================
--- linux-2.6.13-rc6.orig/arch/um/Kconfig	2005-08-15 12:03:07.000000000 -0400
+++ linux-2.6.13-rc6/arch/um/Kconfig	2005-08-15 14:04:23.000000000 -0400
@@ -196,7 +196,7 @@
 config SMP
 	bool "Symmetric multi-processing support (EXPERIMENTAL)"
 	default n
-	depends on MODE_TT && EXPERIMENTAL
+	depends on (MODE_TT && EXPERIMENTAL && !SMP_BROKEN) || (BROKEN && SMP_BROKEN)
 	help
 	This option enables UML SMP support.
 	It is NOT related to having a real SMP box. Not directly, at least.
Index: linux-2.6.13-rc6/arch/um/Kconfig_x86_64
===================================================================
--- linux-2.6.13-rc6.orig/arch/um/Kconfig_x86_64	2005-08-08 12:11:18.000000000 -0400
+++ linux-2.6.13-rc6/arch/um/Kconfig_x86_64	2005-08-15 14:04:27.000000000 -0400
@@ -33,3 +33,7 @@
 config ARCH_REUSE_HOST_VSYSCALL_AREA
 	bool
 	default n
+
+config SMP_BROKEN
+	bool
+	default y



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
