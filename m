Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HhWzM-0004Yv-Nq for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Apr 2007 13:24:20 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HhWzL-0006gO-MH
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Apr 2007 13:24:20 -0700
Date: Fri, 27 Apr 2007 16:20:53 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070427202053.GA10598@c2.user-mode-linux.org>
References: <462BACC9.7010303@nagafix.co.uk>
	<20070425204849.GA9505@c2.user-mode-linux.org>
	<462FC142.1010907@nagafix.co.uk>
	<200704261612.40356.blaisorblade@yahoo.it>
	<20070427151051.GB6019@c2.user-mode-linux.org>
	<463214E7.5080605@nagafix.co.uk>
	<20070427155024.GA8329@c2.user-mode-linux.org>
	<463224F8.6080009@nagafix.co.uk> <463228E5.6080904@nagafix.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <463228E5.6080904@nagafix.co.uk>
Subject: Re: [uml-devel] regression: pcap broken in 2.6.20.x
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 27, 2007 at 05:46:29PM +0100, Antoine Martin wrote:
> Attached.
> 
> Not sure which approach is best:
> 
> 1) this one requires a command line like:
> "vmlinux eth0=pcap,eth0,,mac=00:01:02:03:04:05"

> 2) or this one: which just assumes that the mac address is any option
> that isn't [no]promisc or [no]optimize and is 17 characters long (I
> don't see much point in doing extra checks since this is check in
> setup_ether_xx later on)

Or, how about this:

Index: linux-2.6.21-mm/arch/um/drivers/pcap_kern.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/pcap_kern.c	2007-04-27 16:15:41.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/pcap_kern.c	2007-04-27 16:15:57.000000000 -0400
@@ -70,7 +70,7 @@ int pcap_setup(char *str, char **mac_out
 		  .filter 	= NULL });
 
 	remain = split_if_spec(str, &host_if, &init->filter,
-			       &options[0], &options[1], NULL);
+			       &options[0], &options[1], mac_out, NULL);
 	if(remain != NULL){
 		printk(KERN_ERR "pcap_setup - Extra garbage on "
 		       "specification : '%s'\n", remain);

You end up using it like so:

eth0=pcap,eth0,tcp,,,2:1:2:3:4:5

You need to toss in some commas so the MAC doesn't get mistaken for a
pcap option.  If you have violent objections to this, we can make this
work with your 'mac=blah' thing.  I like it because it's more
consistent with how everything else specifies MACs.

Attached are a couple other patches I did in order to fix all the bugs
I encountered in making this work.  You may need them in order for the
above to apply cleanly.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=use-free

Index: linux-2.6.21-mm/arch/um/drivers/pcap_kern.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/pcap_kern.c	2007-04-27 13:16:49.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/pcap_kern.c	2007-04-27 16:20:57.000000000 -0400
@@ -31,19 +31,21 @@ void pcap_init(struct net_device *dev, v
 	ppri->filter = init->filter;
 }
 
-static int pcap_read(int fd, struct sk_buff **skb, 
+static int pcap_read(int fd, struct sk_buff **skb,
 		       struct uml_net_private *lp)
 {
 	*skb = ether_adjust_skb(*skb, ETH_HEADER_OTHER);
-	if(*skb == NULL) return(-ENOMEM);
-	return(pcap_user_read(fd, skb_mac_header(*skb),
+	if(*skb == NULL)
+		return -ENOMEM;
+
+	return pcap_user_read(fd, skb_mac_header(*skb),
 			      (*skb)->dev->mtu + ETH_HEADER_OTHER,
-			      (struct pcap_data *) &lp->user));
+			      (struct pcap_data *) &lp->user);
 }
 
 static int pcap_write(int fd, struct sk_buff **skb, struct uml_net_private *lp)
 {
-	return(-EPERM);
+	return -EPERM;
 }
 
 static const struct net_kern_info pcap_kern_info = {
@@ -65,12 +67,12 @@ int pcap_setup(char *str, char **mac_out
 		  .optimize 	= 0,
 		  .filter 	= NULL });
 
-	remain = split_if_spec(str, &host_if, &init->filter, 
+	remain = split_if_spec(str, &host_if, &init->filter,
 			       &options[0], &options[1], NULL);
 	if(remain != NULL){
 		printk(KERN_ERR "pcap_setup - Extra garbage on "
 		       "specification : '%s'\n", remain);
-		return(0);
+		return 0;
 	}
 
 	if(host_if != NULL)
@@ -87,10 +89,13 @@ int pcap_setup(char *str, char **mac_out
 			init->optimize = 1;
 		else if(!strcmp(options[i], "nooptimize"))
 			init->optimize = 0;
-		else printk("pcap_setup : bad option - '%s'\n", options[i]);
+		else {
+			printk("pcap_setup : bad option - '%s'\n", options[i]);
+			return 0;
+		}
 	}
 
-	return(1);
+	return 1;
 }
 
 static struct transport pcap_transport = {
Index: linux-2.6.21-mm/arch/um/include/user.h
===================================================================
--- linux-2.6.21-mm.orig/arch/um/include/user.h	2007-04-26 17:33:01.000000000 -0400
+++ linux-2.6.21-mm/arch/um/include/user.h	2007-04-27 14:21:35.000000000 -0400
@@ -27,5 +27,6 @@ extern int in_aton(char *str);
 extern int open_gdb_chan(void);
 extern size_t strlcpy(char *, const char *, size_t);
 extern size_t strlcat(char *, const char *, size_t);
+extern int reserved_address(void *addr);
 
 #endif
Index: linux-2.6.21-mm/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/um_arch.c	2007-04-26 17:41:21.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/um_arch.c	2007-04-27 14:30:36.000000000 -0400
@@ -500,6 +500,13 @@ void __init check_bugs(void)
 	os_check_bugs();
 }
 
+int reserved_address(void *addr)
+{
+	struct page *page = virt_to_page(addr);
+
+	return(PageReserved(page));
+}
+
 void apply_alternatives(struct alt_instr *start, struct alt_instr *end)
 {
 }
Index: linux-2.6.21-mm/arch/um/os-Linux/main.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/main.c	2007-04-26 17:41:10.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/main.c	2007-04-27 14:30:31.000000000 -0400
@@ -266,6 +266,8 @@ void __wrap_free(void *ptr)
 	/* We need to know how the allocation happened, so it can be correctly
 	 * freed.  This is done by seeing what region of memory the pointer is
 	 * in -
+	 *	in a reserved page - free, assume the pointer was
+	 *	    acquired with malloc, since it couldn't have been kmalloced.
 	 * 	physical memory - kmalloc/kfree
 	 *	kernel virtual memory - vmalloc/vfree
 	 * 	anywhere else - malloc/free
@@ -281,7 +283,9 @@ void __wrap_free(void *ptr)
 	 * there is a possibility for memory leaks.
 	 */
 
-	if((addr >= uml_physmem) && (addr < high_physmem)){
+	if(kmalloc_ok && reserved_address(ptr))
+		__real_free(ptr);
+	else if((addr >= uml_physmem) && (addr < high_physmem)){
 		if(CAN_KMALLOC())
 			kfree(ptr);
 	}

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=pcap-tidying

Index: linux-2.6.21-mm/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/net_kern.c	2007-04-27 16:14:48.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/net_kern.c	2007-04-27 16:20:53.000000000 -0400
@@ -316,12 +316,14 @@ static void setup_etheraddr(char *str, u
 	}
 	if (!is_local_ether_addr(addr)) {
 		printk(KERN_WARNING
-		       "Warning: attempt to assign a globally valid ethernet address to a "
-		       "device\n");
-		printk(KERN_WARNING "You should better enable the 2nd rightmost bit "
-		      "in the first byte of the MAC, i.e. "
-		      "%02x:%02x:%02x:%02x:%02x:%02x\n",
-		      addr[0] | 0x02, addr[1], addr[2], addr[3], addr[4], addr[5]);
+		       "Warning: attempt to assign a globally valid ethernet "
+		       "address to a device\n");
+		printk(KERN_WARNING "You should better enable the 2nd "
+		       "rightmost bit in the first byte of the MAC,\n");
+		printk(KERN_WARNING "i.e. %02x:%02x:%02x:%02x:%02x:%02x\n",
+		       addr[0] | 0x02, addr[1], addr[2], addr[3], addr[4],
+		       addr[5]);
+		goto random;
 	}
 	return;
 
@@ -478,6 +480,7 @@ out_undo_user_init:
 		(*transport->user->remove)(&lp->user);
 out_unregister:
 	platform_device_unregister(&device->pdev);
+	return; /* platform_device_unregister frees dev and device */
 out_free_netdev:
 	free_netdev(dev);
 out_free_device:
Index: linux-2.6.21-mm/arch/um/drivers/pcap_kern.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/pcap_kern.c	2007-04-27 16:14:48.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/pcap_kern.c	2007-04-27 16:20:53.000000000 -0400
@@ -29,6 +29,8 @@ void pcap_init(struct net_device *dev, v
 	ppri->promisc = init->promisc;
 	ppri->optimize = init->optimize;
 	ppri->filter = init->filter;
+
+	printk("pcap backend, host interface %s\n", ppri->host_if);
 }
 
 static int pcap_read(int fd, struct sk_buff **skb,
Index: linux-2.6.21-mm/arch/um/drivers/pcap_user.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/pcap_user.c	2007-04-27 16:14:48.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/pcap_user.c	2007-04-27 16:20:53.000000000 -0400
@@ -13,6 +13,7 @@
 #include "pcap_user.h"
 #include "user.h"
 #include "um_malloc.h"
+#include "kern_constants.h"
 
 #define MAX_PACKET (ETH_MAX_PACKET + ETH_HEADER_OTHER)
 
@@ -26,8 +27,8 @@ static int pcap_user_init(void *data, vo
 
 	p = pcap_open_live(pri->host_if, MAX_PACKET, pri->promisc, 0, errors);
 	if(p == NULL){
-		printk("pcap_user_init : pcap_open_live failed - '%s'\n", 
-		       errors);
+		printk(UM_KERN_ERR "pcap_user_init : pcap_open_live failed - "
+		       "'%s'\n", errors);
 		return -EINVAL;
 	}
 
@@ -48,13 +49,13 @@ static int pcap_open(void *data)
 	if(pri->filter != NULL){
 		err = dev_netmask(pri->dev, &netmask);
 		if(err < 0){
-			printk("pcap_open : dev_netmask failed\n");
+			printk(UM_KERN_ERR "pcap_open : dev_netmask failed\n");
 			return -EIO;
 		}
 
 		pri->compiled = um_kmalloc(sizeof(struct bpf_program));
 		if(pri->compiled == NULL){
-			printk("pcap_open : kmalloc failed\n");
+			printk(UM_KERN_ERR "pcap_open : kmalloc failed\n");
 			return -ENOMEM;
 		}
 
@@ -62,15 +63,15 @@ static int pcap_open(void *data)
 				   (struct bpf_program *) pri->compiled, 
 				   pri->filter, pri->optimize, netmask);
 		if(err < 0){
-			printk("pcap_open : pcap_compile failed - '%s'\n", 
-			       pcap_geterr(pri->pcap));
+			printk(UM_KERN_ERR "pcap_open : pcap_compile failed - "
+			       "'%s'\n", pcap_geterr(pri->pcap));
 			return -EIO;
 		}
 
 		err = pcap_setfilter(pri->pcap, pri->compiled);
 		if(err < 0){
-			printk("pcap_open : pcap_setfilter failed - '%s'\n", 
-			       pcap_geterr(pri->pcap));
+			printk(UM_KERN_ERR "pcap_open : pcap_setfilter "
+			       "failed - '%s'\n", pcap_geterr(pri->pcap));
 			return -EIO;
 		}
 	}
@@ -85,7 +86,8 @@ static void pcap_remove(void *data)
 	if(pri->compiled != NULL)
 		pcap_freecode(pri->compiled);
 
-	pcap_close(pri->pcap);
+	if(pri->pcap != NULL)
+		pcap_close(pri->pcap);
 }
 
 struct pcap_handler_data {
@@ -114,7 +116,8 @@ int pcap_user_read(int fd, void *buffer,
 
 	n = pcap_dispatch(pri->pcap, 1, handler, (u_char *) &hdata);
 	if(n < 0){
-		printk("pcap_dispatch failed - %s\n", pcap_geterr(pri->pcap));
+		printk(UM_KERN_ERR "pcap_dispatch failed - %s\n",
+		       pcap_geterr(pri->pcap));
 		return -EIO;
 	}
 	else if(n == 0) 

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--jRHKVT23PllUwdXP
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--jRHKVT23PllUwdXP--

