Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DWEyZ-0005VF-Ix	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 May 2005 07:47:47 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DWEyX-0000ZM-Nr	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 May 2005 07:47:47 -0700
Message-ID: <42836C88.6030106@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050708070907030600090008"
Subject: [uml-devel] Wrong ordering of IP addresses
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
Date: Thu, 12 May 2005 16:47:36 +0200
To: user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Jeff Dike <jdike@addtoit.com>

This is a multi-part message in MIME format.
--------------050708070907030600090008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

UML's networking diesn't work on bigendian s390.
IP addresses taken from ifa->ifa_address or ifa->ifa_mask
are swapped.

The appended patch fixes this, it is shortly tested on s390
and i386.

	Bodo


--------------050708070907030600090008
Content-Type: text/x-diff;
 name="fix-net-ordering.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-net-ordering.patch"


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

ifa->ifa_address and ifa->ifa_mask are defined as __u32,
but used as if they were char[4].
Network code uses htons() to convert it.
So UML's method to access these fields is wrong for bigendians
(e.g. s390)
I replaced bytewise copying by memcpy(), maybe even that might
be removed, if ifa->ifa_address/mask may be used immediately.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---


diff -puN arch/um/drivers/net_kern.c~fix-net-ordering arch/um/drivers/net_kern.c
--- linux-2.6.12-rc4/arch/um/drivers/net_kern.c~fix-net-ordering	2005-05-11 15:07:20.000000000 +0200
+++ linux-2.6.12-rc4-root/arch/um/drivers/net_kern.c	2005-05-11 15:28:43.000000000 +0200
@@ -95,7 +95,6 @@ irqreturn_t uml_net_interrupt(int irq, v
 static int uml_net_open(struct net_device *dev)
 {
 	struct uml_net_private *lp = dev->priv;
-	char addr[sizeof("255.255.255.255\0")];
 	int err;
 
 	spin_lock(&lp->lock);
@@ -106,7 +105,7 @@ static int uml_net_open(struct net_devic
 	}
 
 	if(!lp->have_mac){
- 		dev_ip_addr(dev, addr, &lp->mac[2]);
+ 		dev_ip_addr(dev, &lp->mac[2]);
  		set_ether_mac(dev, lp->mac);
 	}
 
@@ -653,8 +652,6 @@ static int uml_inetaddr_event(struct not
 			      void *ptr)
 {
 	struct in_ifaddr *ifa = ptr;
-	u32 addr = ifa->ifa_address;
-	u32 netmask = ifa->ifa_mask;
 	struct net_device *dev = ifa->ifa_dev->dev;
 	struct uml_net_private *lp;
 	void (*proc)(unsigned char *, unsigned char *, void *);
@@ -674,14 +671,8 @@ static int uml_inetaddr_event(struct not
 		break;
 	}
 	if(proc != NULL){
-		addr_buf[0] = addr & 0xff;
-		addr_buf[1] = (addr >> 8) & 0xff;
-		addr_buf[2] = (addr >> 16) & 0xff;
-		addr_buf[3] = addr >> 24;
-		netmask_buf[0] = netmask & 0xff;
-		netmask_buf[1] = (netmask >> 8) & 0xff;
-		netmask_buf[2] = (netmask >> 16) & 0xff;
-		netmask_buf[3] = netmask >> 24;
+		memcpy(addr_buf, &ifa->ifa_address, sizeof(addr_buf));
+		memcpy(netmask_buf, &ifa->ifa_mask, sizeof(netmask_buf));
 		(*proc)(addr_buf, netmask_buf, &lp->user);
 	}
 	return(NOTIFY_DONE);
@@ -763,27 +754,18 @@ int setup_etheraddr(char *str, unsigned 
 	return(1);
 }
 
-void dev_ip_addr(void *d, char *buf, char *bin_buf)
+void dev_ip_addr(void *d, unsigned char *bin_buf)
 {
 	struct net_device *dev = d;
 	struct in_device *ip = dev->ip_ptr;
 	struct in_ifaddr *in;
-	u32 addr;
 
 	if((ip == NULL) || ((in = ip->ifa_list) == NULL)){
 		printk(KERN_WARNING "dev_ip_addr - device not assigned an "
 		       "IP address\n");
 		return;
 	}
-	addr = in->ifa_address;
-	sprintf(buf, "%d.%d.%d.%d", addr & 0xff, (addr >> 8) & 0xff, 
-		(addr >> 16) & 0xff, addr >> 24);
-	if(bin_buf){
-		bin_buf[0] = addr & 0xff;
-		bin_buf[1] = (addr >> 8) & 0xff;
-		bin_buf[2] = (addr >> 16) & 0xff;
-		bin_buf[3] = addr >> 24;
-	}
+	memcpy(bin_buf, &in->ifa_address, sizeof(in->ifa_address));
 }
 
 void set_ether_mac(void *d, unsigned char *addr)
@@ -818,14 +800,8 @@ void iter_addresses(void *d, void (*cb)(
 	if(ip == NULL) return;
 	in = ip->ifa_list;
 	while(in != NULL){
-		address[0] = in->ifa_address & 0xff;
-		address[1] = (in->ifa_address >> 8) & 0xff;
-		address[2] = (in->ifa_address >> 16) & 0xff;
-		address[3] = in->ifa_address >> 24;
-		netmask[0] = in->ifa_mask & 0xff;
-		netmask[1] = (in->ifa_mask >> 8) & 0xff;
-		netmask[2] = (in->ifa_mask >> 16) & 0xff;
-		netmask[3] = in->ifa_mask >> 24;
+		memcpy(address, &in->ifa_address, sizeof(address));
+		memcpy(netmask, &in->ifa_mask, sizeof(netmask));
 		(*cb)(address, netmask, arg);
 		in = in->ifa_next;
 	}
diff -puN arch/um/include/net_user.h~fix-net-ordering arch/um/include/net_user.h
--- linux-2.6.12-rc4/arch/um/include/net_user.h~fix-net-ordering	2005-05-11 15:27:01.000000000 +0200
+++ linux-2.6.12-rc4-root/arch/um/include/net_user.h	2005-05-11 15:27:41.000000000 +0200
@@ -25,7 +25,7 @@ struct net_user_info {
 };
 
 extern void ether_user_init(void *data, void *dev);
-extern void dev_ip_addr(void *d, char *buf, char *bin_buf);
+extern void dev_ip_addr(void *d, unsigned char *bin_buf);
 extern void set_ether_mac(void *d, unsigned char *addr);
 extern void iter_addresses(void *d, void (*cb)(unsigned char *, 
 					       unsigned char *, void *), 
_

--------------050708070907030600090008--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
