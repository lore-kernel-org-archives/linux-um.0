Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H0RQy-0002xc-SG for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Dec 2006 15:46:44 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H0RQy-0007h0-3R
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Dec 2006 15:46:44 -0800
Message-Id: <200612292341.kBTNfWu0005554@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Fri, 29 Dec 2006 18:41:32 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 6/6] UML - Network driver whitespace and style
	fixes
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

Some whitespace and coding style cleanups in the network driver code.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

--
 arch/um/drivers/net_kern.c |   29 +++++++++++++++--------------
 arch/um/include/net_kern.h |    6 +++---
 2 files changed, 18 insertions(+), 17 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/net_kern.c	2006-12-29 17:42:37.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/net_kern.c	2006-12-29 18:18:48.000000000 -0500
@@ -108,7 +108,7 @@ irqreturn_t uml_net_interrupt(int irq, v
 
 out:
 	spin_unlock(&lp->lock);
-	return(IRQ_HANDLED);
+	return IRQ_HANDLED;
 }
 
 static int uml_net_open(struct net_device *dev)
@@ -239,7 +239,7 @@ static int uml_net_set_mac(struct net_de
 	set_ether_mac(dev, hwaddr->sa_data);
 	spin_unlock_irq(&lp->lock);
 
-	return(0);
+	return 0;
 }
 
 static int uml_net_change_mtu(struct net_device *dev, int new_mtu)
@@ -460,7 +460,7 @@ static struct uml_net *find_device(int n
 	device = NULL;
  out:
 	spin_unlock(&devices_lock);
-	return(device);
+	return device;
 }
 
 static int eth_parse(char *str, int *index_out, char **str_out,
@@ -511,23 +511,23 @@ static int check_transport(struct transp
 
 	len = strlen(transport->name);
 	if(strncmp(eth, transport->name, len))
-		return(0);
+		return 0;
 
 	eth += len;
 	if(*eth == ',')
 		eth++;
 	else if(*eth != '\0')
-		return(0);
+		return 0;
 
 	*init_out = kmalloc(transport->setup_size, GFP_KERNEL);
 	if(*init_out == NULL)
-		return(1);
+		return 1;
 
 	if(!transport->setup(eth, mac_out, *init_out)){
 		kfree(*init_out);
 		*init_out = NULL;
 	}
-	return(1);
+	return 1;
 }
 
 void register_transport(struct transport *new)
@@ -572,9 +572,9 @@ static int eth_setup_common(char *str, i
 			eth_configure(index, init, mac, transport);
 			kfree(init);
 		}
-		return(1);
+		return 1;
 	}
-	return(0);
+	return 0;
 }
 
 static int eth_setup(char *str)
@@ -678,7 +678,7 @@ static int net_remove(int n, char **erro
 	dev = device->dev;
 	lp = dev->priv;
 	if(lp->fd > 0)
-                return -EBUSY;
+		return -EBUSY;
 	if(lp->remove != NULL) (*lp->remove)(&lp->user);
 	unregister_netdev(dev);
 	platform_device_unregister(&device->pdev);
@@ -693,7 +693,7 @@ static struct mc_device net_mc = {
 	.name		= "eth",
 	.config		= net_config,
 	.get_config	= NULL,
-        .id		= net_id,
+	.id		= net_id,
 	.remove		= net_remove,
 };
 
@@ -706,7 +706,8 @@ static int uml_inetaddr_event(struct not
 	void (*proc)(unsigned char *, unsigned char *, void *);
 	unsigned char addr_buf[4], netmask_buf[4];
 
-	if(dev->open != uml_net_open) return(NOTIFY_DONE);
+	if(dev->open != uml_net_open)
+		return NOTIFY_DONE;
 
 	lp = dev->priv;
 
@@ -724,7 +725,7 @@ static int uml_inetaddr_event(struct not
 		memcpy(netmask_buf, &ifa->ifa_mask, sizeof(netmask_buf));
 		(*proc)(addr_buf, netmask_buf, &lp->user);
 	}
-	return(NOTIFY_DONE);
+	return NOTIFY_DONE;
 }
 
 struct notifier_block uml_inetaddr_notifier = {
@@ -834,7 +835,7 @@ void *get_output_buffer(int *len_out)
 	ret = (void *) __get_free_pages(GFP_KERNEL, 0);
 	if(ret) *len_out = PAGE_SIZE;
 	else *len_out = 0;
-	return(ret);
+	return ret;
 }
 
 void free_output_buffer(void *buffer)
Index: linux-2.6.18-mm/arch/um/include/net_kern.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/net_kern.h	2006-12-29 17:42:37.000000000 -0500
+++ linux-2.6.18-mm/arch/um/include/net_kern.h	2006-12-29 18:19:07.000000000 -0500
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -36,7 +36,7 @@ struct uml_net_private {
 	void (*remove)(void *);
 	int (*read)(int, struct sk_buff **skb, struct uml_net_private *);
 	int (*write)(int, struct sk_buff **skb, struct uml_net_private *);
-	
+
 	void (*add_address)(unsigned char *, unsigned char *, void *);
 	void (*delete_address)(unsigned char *, unsigned char *, void *);
 	int (*set_mtu)(int mtu, void *);
@@ -63,7 +63,7 @@ struct transport {
 extern struct net_device *ether_init(int);
 extern unsigned short ether_protocol(struct sk_buff *);
 extern struct sk_buff *ether_adjust_skb(struct sk_buff *skb, int extra);
-extern int tap_setup_common(char *str, char *type, char **dev_name, 
+extern int tap_setup_common(char *str, char *type, char **dev_name,
 			    char **mac_out, char **gate_addr);
 extern void register_transport(struct transport *new);
 extern unsigned short eth_protocol(struct sk_buff *skb);


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
