Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GrN2l-0001fe-Vt for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Dec 2006 15:16:20 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GrN2l-0005Pg-Cn
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Dec 2006 15:16:15 -0800
Message-Id: <200612042312.kB4NCNiN024571@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 04 Dec 2006 18:12:23 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/4] UML - Use get_random_bytes after random
	pool is seeded
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

When the UML network driver generates random MACs for its devices, it was
possible for a number of UMLs to get the same MACs because the ethernet 
initialization was done before the random pool was properly seeded.

This patch moves the initialization later so that it gets better randomness.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/drivers/daemon_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/daemon_kern.c	2006-11-24 14:29:57.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/daemon_kern.c	2006-12-04 12:08:52.000000000 -0500
@@ -98,4 +98,4 @@ static int register_daemon(void)
 	return 0;
 }
 
-__initcall(register_daemon);
+late_initcall(register_daemon);
Index: linux-2.6.18-mm/arch/um/drivers/mcast_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/mcast_kern.c	2006-11-24 14:29:57.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/mcast_kern.c	2006-12-04 12:08:52.000000000 -0500
@@ -127,4 +127,4 @@ static int register_mcast(void)
 	return 0;
 }
 
-__initcall(register_mcast);
+late_initcall(register_mcast);
Index: linux-2.6.18-mm/arch/um/drivers/pcap_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/pcap_kern.c	2006-11-24 14:29:57.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/pcap_kern.c	2006-12-04 12:08:52.000000000 -0500
@@ -109,4 +109,4 @@ static int register_pcap(void)
 	return 0;
 }
 
-__initcall(register_pcap);
+late_initcall(register_pcap);
Index: linux-2.6.18-mm/arch/um/drivers/slip_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/slip_kern.c	2006-11-27 18:55:16.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/slip_kern.c	2006-12-04 12:08:52.000000000 -0500
@@ -95,4 +95,4 @@ static int register_slip(void)
 	return 0;
 }
 
-__initcall(register_slip);
+late_initcall(register_slip);
Index: linux-2.6.18-mm/arch/um/drivers/slirp_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/slirp_kern.c	2006-11-27 18:55:16.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/slirp_kern.c	2006-12-04 12:08:52.000000000 -0500
@@ -119,4 +119,4 @@ static int register_slirp(void)
 	return 0;
 }
 
-__initcall(register_slirp);
+late_initcall(register_slirp);
Index: linux-2.6.18-mm/arch/um/os-Linux/drivers/ethertap_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/drivers/ethertap_kern.c	2006-11-27 18:55:16.000000000 -0500
+++ linux-2.6.18-mm/arch/um/os-Linux/drivers/ethertap_kern.c	2006-12-04 12:08:52.000000000 -0500
@@ -105,4 +105,4 @@ static int register_ethertap(void)
 	return 0;
 }
 
-__initcall(register_ethertap);
+late_initcall(register_ethertap);
Index: linux-2.6.18-mm/arch/um/os-Linux/drivers/tuntap_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/drivers/tuntap_kern.c	2006-11-27 18:55:16.000000000 -0500
+++ linux-2.6.18-mm/arch/um/os-Linux/drivers/tuntap_kern.c	2006-12-04 12:08:52.000000000 -0500
@@ -90,4 +90,4 @@ static int register_tuntap(void)
 	return 0;
 }
 
-__initcall(register_tuntap);
+late_initcall(register_tuntap);


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
