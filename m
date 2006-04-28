Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZWKO-0002fX-JT for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 10:00:24 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FZWKO-0002Kc-2G
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 10:00:24 -0700
Message-Id: <200604281601.k3SG17Nl007522@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/6] UML - skas0 support for 2G/2G hosts
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
Date: Fri, 28 Apr 2006 12:01:07 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Joris van Rantwijk <jvrantwijk@xs4all.nl>

From: Joris van Rantwijk <jvrantwijk@xs4all.nl>

A quick hack to allow skas0 mode to run on 2G/2G hosts.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/Kconfig.i386
===================================================================
--- linux-2.6.16.orig/arch/um/Kconfig.i386	2006-04-26 11:30:35.000000000 -0400
+++ linux-2.6.16/arch/um/Kconfig.i386	2006-04-26 11:39:54.000000000 -0400
@@ -16,6 +16,19 @@ config SEMAPHORE_SLEEPERS
 	bool
 	default y
 
+config HOST_2G_2G
+	bool "2G/2G host address space split"
+	default n
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
 config TOP_ADDR
  	hex
  	default 0xc0000000 if !HOST_2G_2G
@@ -35,11 +48,13 @@ config 3_LEVEL_PGTABLES
 
 config STUB_CODE
 	hex
-	default 0xbfffe000
+	default 0xbfffe000 if !HOST_2G_2G
+	default 0x7fffe000 if HOST_2G_2G
 
 config STUB_DATA
 	hex
-	default 0xbffff000
+	default 0xbffff000 if !HOST_2G_2G
+	default 0x7ffff000 if HOST_2G_2G
 
 config STUB_START
 	hex
Index: linux-2.6.16/arch/um/Kconfig
===================================================================
--- linux-2.6.16.orig/arch/um/Kconfig	2006-04-25 12:00:49.000000000 -0400
+++ linux-2.6.16/arch/um/Kconfig	2006-04-26 11:39:40.000000000 -0400
@@ -57,20 +57,6 @@ config STATIC_LINK
 	chroot, and you disable CONFIG_MODE_TT, you probably want to say Y
 	here.
 
-config HOST_2G_2G
-	bool "2G/2G host address space split"
-	default n
-	depends on MODE_TT
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
 config KERNEL_HALF_GIGS
 	int "Kernel address space size (in .5G units)"
 	default "1"



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
