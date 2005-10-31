Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EWQdG-0007UA-1B	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Oct 2005 19:46:50 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EWQdF-0007IM-OY
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Oct 2005 19:46:50 -0800
Message-Id: <200510310439.j9V4dimX000883@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 10/10] UML - Make tt mode-dependent options depend
	on MODE_TT
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
Date: Sun, 30 Oct 2005 23:39:44 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This makes some of the tt-specific options actually depend on
CONFIG_MODE_TT.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.14/arch/um/Kconfig
===================================================================
--- linux-2.6.14.orig/arch/um/Kconfig	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.14/arch/um/Kconfig	2005-10-30 19:29:28.000000000 -0500
@@ -63,6 +63,30 @@ config STATIC_LINK
 	chroot, and you disable CONFIG_MODE_TT, you probably want to say Y
 	here.
 
+config HOST_2G_2G
+	bool "2G/2G host address space split"
+	default n
+	depends on MODE_TT
+	help
+	This is needed when the host on which you run has a 2G/2G memory
+	split, instead of the customary 3G/1G.
+
+	Note that to enable such a host
+	configuration, which makes sense only in some cases, you need special
+	host patches.
+
+	So, if you do not know what to do here, say 'N'.
+
+config KERNEL_HALF_GIGS
+	int "Kernel address space size (in .5G units)"
+	default "1"
+	depends on MODE_TT
+	help
+        This determines the amount of address space that UML will allocate for
+        its own, measured in half Gigabyte units.  The default is 1.
+        Change this only if you need to boot UML with an unusually large amount
+        of physical memory.
+
 config MODE_SKAS
 	bool "Separate Kernel Address Space support"
 	default y
@@ -180,19 +204,6 @@ config MAGIC_SYSRQ
 	The keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
 	unless you really know what this hack does.
 
-config HOST_2G_2G
-	bool "2G/2G host address space split"
-	default n
-	help
-	This is needed when the host on which you run has a 2G/2G memory
-	split, instead of the customary 3G/1G.
-
-	Note that to enable such a host
-	configuration, which makes sense only in some cases, you need special
-	host patches.
-
-	So, if you do not know what to do here, say 'N'.
-
 config SMP
 	bool "Symmetric multi-processing support (EXPERIMENTAL)"
 	default n
@@ -239,15 +250,6 @@ config NEST_LEVEL
         set to the host's CONFIG_NEST_LEVEL + CONFIG_KERNEL_HALF_GIGS.
         Only change this if you are running nested UMLs.
 
-config KERNEL_HALF_GIGS
-	int "Kernel address space size (in .5G units)"
-	default "1"
-	help
-        This determines the amount of address space that UML will allocate for
-        its own, measured in half Gigabyte units.  The default is 1.
-        Change this only if you need to boot UML with an unusually large amount
-        of physical memory.
-
 config HIGHMEM
 	bool "Highmem support"
 	depends on !64BIT



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
