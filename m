Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FON9E-0005aA-L1 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 14:58:48 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FON9E-00059M-7h
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 14:58:48 -0800
Message-Id: <200603282300.k2SN04Gp022967@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/10] UML - Fix initcall return values
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
Date: Tue, 28 Mar 2006 18:00:04 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

A number of UML initcalls were improperly returning 1.
Also removed any nearby emacs formatting comments.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16-mm/arch/um/drivers/daemon_kern.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/drivers/daemon_kern.c	2006-03-23 16:40:20.000000000 -0500
+++ linux-2.6.16-mm/arch/um/drivers/daemon_kern.c	2006-03-28 17:11:14.000000000 -0500
@@ -95,18 +95,7 @@ static struct transport daemon_transport
 static int register_daemon(void)
 {
 	register_transport(&daemon_transport);
-	return(1);
+	return 0;
 }
 
 __initcall(register_daemon);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.16-mm/arch/um/drivers/mcast_kern.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/drivers/mcast_kern.c	2006-03-28 17:11:00.000000000 -0500
+++ linux-2.6.16-mm/arch/um/drivers/mcast_kern.c	2006-03-28 17:13:59.000000000 -0500
@@ -124,18 +124,7 @@ static struct transport mcast_transport 
 static int register_mcast(void)
 {
 	register_transport(&mcast_transport);
-	return(1);
+	return 0;
 }
 
 __initcall(register_mcast);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.16-mm/arch/um/drivers/pcap_kern.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/drivers/pcap_kern.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.16-mm/arch/um/drivers/pcap_kern.c	2006-03-28 17:11:50.000000000 -0500
@@ -106,18 +106,7 @@ static struct transport pcap_transport =
 static int register_pcap(void)
 {
 	register_transport(&pcap_transport);
-	return(1);
+	return 0;
 }
 
 __initcall(register_pcap);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.16-mm/arch/um/drivers/slip_kern.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/drivers/slip_kern.c	2006-03-23 16:40:20.000000000 -0500
+++ linux-2.6.16-mm/arch/um/drivers/slip_kern.c	2006-03-28 17:13:59.000000000 -0500
@@ -93,18 +93,7 @@ static struct transport slip_transport =
 static int register_slip(void)
 {
 	register_transport(&slip_transport);
-	return(1);
+	return 0;
 }
 
 __initcall(register_slip);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.16-mm/arch/um/drivers/slirp_kern.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/drivers/slirp_kern.c	2006-03-28 15:55:30.000000000 -0500
+++ linux-2.6.16-mm/arch/um/drivers/slirp_kern.c	2006-03-28 17:13:59.000000000 -0500
@@ -116,18 +116,7 @@ static struct transport slirp_transport 
 static int register_slirp(void)
 {
 	register_transport(&slirp_transport);
-	return(1);
+	return 0;
 }
 
 __initcall(register_slirp);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.16-mm/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/drivers/ubd_kern.c	2006-03-28 15:55:30.000000000 -0500
+++ linux-2.6.16-mm/arch/um/drivers/ubd_kern.c	2006-03-28 17:12:55.000000000 -0500
@@ -891,7 +891,7 @@ int ubd_driver_init(void){
 			     SA_INTERRUPT, "ubd", ubd_dev);
 	if(err != 0)
 		printk(KERN_ERR "um_request_irq failed - errno = %d\n", -err);
-	return(err);
+	return 0;
 }
 
 device_initcall(ubd_driver_init);
Index: linux-2.6.16-mm/arch/um/os-Linux/drivers/ethertap_kern.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/os-Linux/drivers/ethertap_kern.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.16-mm/arch/um/os-Linux/drivers/ethertap_kern.c	2006-03-28 17:13:40.000000000 -0500
@@ -102,18 +102,7 @@ static struct transport ethertap_transpo
 static int register_ethertap(void)
 {
 	register_transport(&ethertap_transport);
-	return(1);
+	return 0;
 }
 
 __initcall(register_ethertap);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.16-mm/arch/um/os-Linux/drivers/tuntap_kern.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/os-Linux/drivers/tuntap_kern.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.16-mm/arch/um/os-Linux/drivers/tuntap_kern.c	2006-03-28 17:13:57.000000000 -0500
@@ -87,18 +87,7 @@ static struct transport tuntap_transport
 static int register_tuntap(void)
 {
 	register_transport(&tuntap_transport);
-	return(1);
+	return 0;
 }
 
 __initcall(register_tuntap);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
