Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUdzK-0005H3-SS for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Nov 2004 20:33:42 -0800
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]
	helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CUdzJ-0003tU-KM
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Nov 2004 20:33:42 -0800
Message-Id: <200411180647.iAI6lSQ3008451@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Patchset to implement PTRACE_SYSEMU_SINGLESTEP 
In-Reply-To: Your message of "Mon, 15 Nov 2004 18:11:37 +0100."
	<4198E349.5070809@fujitsu-siemens.com> 
References: <419517A4.7020700@fujitsu-siemens.com>
	<200411130043.25888.blaisorblade_spam@yahoo.it>
	<4198E349.5070809@fujitsu-siemens.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Thu, 18 Nov 2004 01:47:28 -0500
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Blaisorblade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

bstroesser@fujitsu-siemens.com said:
> What happens on my system shows some other symptoms. After "Restarting
> system." UML exits without further message. I could track this down to
> a SIGIO being unblocked immediately before the execvp(). It is handled
> by sig_handler() that calls sig_handler_common_skas(). Why this exits,
> I don't know. 

Try this patch.  It adds the missing closes that you found today, plus it
makes sure that netdevices get closed down correctly.

				Jeff

Index: 2.6.9/arch/um/drivers/net_kern.c
===================================================================
--- 2.6.9.orig/arch/um/drivers/net_kern.c	2004-11-17 22:25:19.000000000 -0500
+++ 2.6.9/arch/um/drivers/net_kern.c	2004-11-17 23:18:21.000000000 -0500
@@ -126,10 +126,6 @@
 	lp->tl.data = (unsigned long) &lp->user;
 	netif_start_queue(dev);
 
-	spin_lock(&opened_lock);
-	list_add(&lp->list, &opened);
-	spin_unlock(&opened_lock);
-
 	/* clear buffer - it can happen that the host side of the interface
 	 * is full when we get here.  In this case, new data is never queued,
 	 * SIGIOs never arrive, and the net never works.
@@ -150,11 +146,10 @@
 
 	free_irq_by_irq_and_dev(dev->irq, dev);
 	free_irq(dev->irq, dev);
-	if(lp->close != NULL) (*lp->close)(lp->fd, &lp->user);
-	lp->fd = -1;
-	spin_lock(&opened_lock);
-	list_del(&lp->list);
-	spin_unlock(&opened_lock);
+	if(lp->close != NULL){
+		(*lp->close)(lp->fd, &lp->user);
+		lp->fd = -1;
+	}
 
 	spin_unlock(&lp->lock);
 	return 0;
@@ -289,7 +284,7 @@
 static spinlock_t devices_lock = SPIN_LOCK_UNLOCKED;
 static struct list_head devices = LIST_HEAD_INIT(devices);
 
-static int eth_configure(int n, void *init, char *mac,
+static int eth_configure(int n, void *init, char *mac, 
 			 struct transport *transport)
 {
 	struct uml_net *device;
@@ -397,6 +392,11 @@
 
 	if (device->have_mac)
 		set_ether_mac(dev, device->mac);
+
+	spin_lock(&opened_lock);
+	list_add(&lp->list, &opened);
+	spin_unlock(&opened_lock);
+
 	return(0);
 }
 
@@ -705,7 +705,7 @@
 static void close_devices(void)
 {
 	struct list_head *ele;
-	struct uml_net_private *lp;	
+	struct uml_net_private *lp;
 
 	list_for_each(ele, &opened){
 		lp = list_entry(ele, struct uml_net_private, list);
Index: 2.6.9/arch/um/kernel/initrd_user.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/initrd_user.c	2004-11-17 22:25:19.000000000 -0500
+++ 2.6.9/arch/um/kernel/initrd_user.c	2004-11-17 22:26:24.000000000 -0500
@@ -29,6 +29,8 @@
 		       filename, -n);
 		return(-1);
 	}
+
+	os_close_file(fd);
 	return(0);
 }
 
Index: 2.6.9/arch/um/kernel/mem_user.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/mem_user.c	2004-11-17 22:25:19.000000000 -0500
+++ 2.6.9/arch/um/kernel/mem_user.c	2004-11-17 22:26:24.000000000 -0500
@@ -101,6 +101,8 @@
 	}
 	printf("OK\n");
 	munmap(addr, UM_KERN_PAGE_SIZE);
+
+	os_close_file(fd);
 }
 
 static int have_devanon = 0;



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
