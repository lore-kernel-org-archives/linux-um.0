Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IKCH2-0000s1-KR for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Aug 2007 05:10:24 -0700
Received: from ug-out-1314.google.com ([66.249.92.175])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IKCGy-0000vs-Ax
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Aug 2007 05:10:24 -0700
Received: by ug-out-1314.google.com with SMTP id m2so582536uge
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 12 Aug 2007 05:10:19 -0700 (PDT)
Date: Sun, 12 Aug 2007 14:10:19 +0200
From: Luca Bigliardi <shammash@artha.org>
Message-ID: <20070812121019.GL23105@pintsize>
References: <20070725143227.GO5115@pintsize>
	<20070725160700.GA7607@c2.user-mode-linux.org>
	<200708121254.10137.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <200708121254.10137.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [RFC PATCH] vde network backend
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 12, 2007 at 12:54 PM, Blaisorblade wrote:

> Hmm - I know I'm a bit too late, but that should be "if (blah) {", with a 
> space after if (or after for, or after while (blah) { ).

Thank you, I'm attaching a new patch with proper changes.


luca

-- 
Beware of programmers who carry screwdrivers.
                        -- Leonard Brandwein

http://shammash.homelinux.org/ - http://www.artha.org/ - http://www.yue.it/

--45Z9DzgjV8m4Oswq
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="uml_vdetransport-03.patch"

--- linux-2.6.23-rc1_ORIG/arch/um/Kconfig.net	2007-07-25 19:13:08.000000000 +0200
+++ linux-2.6.23-rc1/arch/um/Kconfig.net	2007-07-25 19:30:38.000000000 +0200
@@ -108,6 +108,28 @@ config UML_NET_DAEMON
         more than one without conflict.  If you don't need UML networking,
         say N.
 
+config UML_NET_VDE
+	bool "VDE transport"
+	depends on UML_NET
+	help
+	This User-Mode Linux network transport allows one or more running
+	UMLs on a single host to communicate with each other and also
+	with the rest of the world using Virtual Distributed Ethernet,
+	an improved fork of uml_switch.
+
+	You must have libvdeplug installed in order to build the vde
+	transport into UML.
+
+	To use this form of networking, you will need to run vde_switch
+	on the host.
+
+	For more information, see <http://wiki.virtualsquare.org/>
+	That site has a good overview of what VDE is and also examples
+	of the UML command line to use to enable VDE networking.
+
+	If you need UML networking with VDE,
+	say Y.
+
 config UML_NET_MCAST
 	bool "Multicast transport"
 	depends on UML_NET
--- linux-2.6.23-rc1_ORIG/arch/um/drivers/Makefile	2007-07-25 19:13:08.000000000 +0200
+++ linux-2.6.23-rc1/arch/um/drivers/Makefile	2007-07-25 19:30:37.000000000 +0200
@@ -18,11 +18,16 @@ port-objs := port_kern.o port_user.o
 harddog-objs := harddog_kern.o harddog_user.o
 
 LDFLAGS_pcap.o := -r $(shell $(CC) $(CFLAGS) -print-file-name=libpcap.a)
+LDFLAGS_vde.o := -r $(shell $(CC) $(CFLAGS) -print-file-name=libvdeplug.a)
 
-targets := pcap_kern.o pcap_user.o
+targets := pcap_kern.o pcap_user.o vde_kern.o vde_user.o
 
 $(obj)/pcap.o: $(obj)/pcap_kern.o $(obj)/pcap_user.o
 	$(LD) -r -dp -o $@ $^ $(LDFLAGS) $(LDFLAGS_pcap.o)
+
+$(obj)/vde.o: $(obj)/vde_kern.o $(obj)/vde_user.o
+	$(LD) -r -dp -o $@ $^ $(LDFLAGS) $(LDFLAGS_vde.o)
+
 #XXX: The call below does not work because the flags are added before the
 # object name, so nothing from the library gets linked.
 #$(call if_changed,ld)
@@ -37,6 +42,7 @@ obj-$(CONFIG_STDERR_CONSOLE) += stderr_c
 obj-$(CONFIG_UML_NET_SLIP) += slip.o slip_common.o
 obj-$(CONFIG_UML_NET_SLIRP) += slirp.o slip_common.o
 obj-$(CONFIG_UML_NET_DAEMON) += daemon.o 
+obj-$(CONFIG_UML_NET_VDE) += vde.o 
 obj-$(CONFIG_UML_NET_MCAST) += mcast.o 
 obj-$(CONFIG_UML_NET_PCAP) += pcap.o
 obj-$(CONFIG_UML_NET) += net.o 
@@ -54,6 +60,6 @@ obj-$(CONFIG_BLK_DEV_COW_COMMON) += cow_
 obj-$(CONFIG_UML_RANDOM) += random.o
 
 # pcap_user.o must be added explicitly.
-USER_OBJS := fd.o null.o pty.o tty.o xterm.o slip_common.o pcap_user.o
+USER_OBJS := fd.o null.o pty.o tty.o xterm.o slip_common.o pcap_user.o vde_user.o
 
 include arch/um/scripts/Makefile.rules
--- linux-2.6.23-rc1_ORIG/arch/um/drivers/vde.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.23-rc1/arch/um/drivers/vde.h	2007-07-25 19:30:37.000000000 +0200
@@ -0,0 +1,27 @@
+/* 
+ * Copyright (C) 2007 Luca Bigliardi (shammash@artha.org).
+ * Licensed under the GPL.
+ */
+
+struct vde_data {
+	char *vde_switch;
+	char *descr;
+	void *args;
+	void *conn;
+	void *dev;
+};
+
+struct vde_init {
+	char *vde_switch;
+	char *descr;
+	int port;
+	char *group;
+	int mode;
+};
+
+extern const struct net_user_info vde_user_info;
+
+extern void vde_init_libstuff(struct vde_data *vpri, struct vde_init *init);
+
+extern int vde_user_read(void *conn, void *buf, int len);
+extern int vde_user_write(void *conn, void *buf, int len);
--- linux-2.6.23-rc1_ORIG/arch/um/drivers/vde_kern.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.23-rc1/arch/um/drivers/vde_kern.c	2007-07-25 19:30:37.000000000 +0200
@@ -0,0 +1,138 @@
+/*
+ * Copyright (C) 2007 Luca Bigliardi (shammash@artha.org).
+ * Licensed under the GPL.
+ *
+ * Transport usage:
+ *  ethN=vde,<vde_switch>,<mac addr>,<port>,<group>,<mode>,<description>
+ *
+ */
+
+#include "linux/kernel.h"
+#include "linux/init.h"
+#include "linux/netdevice.h"
+#include "linux/etherdevice.h"
+#include "net_kern.h"
+#include "net_user.h"
+#include "vde.h"
+
+static void vde_init(struct net_device *dev, void *data)
+{
+	struct vde_init *init = data;
+	struct uml_net_private *pri;
+	struct vde_data *vpri;
+	
+	pri = dev->priv;
+	vpri = (struct vde_data *) pri->user;
+
+	vpri->vde_switch = init->vde_switch;
+	vpri->descr = init->descr ? init->descr : "UML vde_transport";
+	vpri->args = NULL;
+	vpri->conn = NULL;
+	vpri->dev = dev;
+
+	printk(KERN_INFO "vde backend - %s, ", vpri->vde_switch ?
+				vpri->vde_switch : "(default socket)");
+
+	vde_init_libstuff(vpri, init);
+
+	printk(KERN_INFO "\n");
+}
+
+static int vde_read(int fd, struct sk_buff **skb, struct uml_net_private *lp)
+{
+	struct vde_data *pri = (struct vde_data *) &lp->user;
+
+	if (pri->conn != NULL) {
+		*skb = ether_adjust_skb(*skb, ETH_HEADER_OTHER);
+		if (*skb == NULL)
+			return -ENOMEM;
+
+		return vde_user_read(pri->conn, skb_mac_header(*skb),
+					(*skb)->dev->mtu + ETH_HEADER_OTHER);
+	}
+
+	printk(KERN_ERR "vde_read - we have no VDECONN to read from");
+	return -EBADF;
+}
+
+static int vde_write(int fd, struct sk_buff **skb, struct uml_net_private *lp)
+{
+	struct vde_data *pri = (struct vde_data *) &lp->user;
+
+	if (pri->conn != NULL)
+		return vde_user_write((void *)pri->conn, (*skb)->data,
+					(*skb)->len);
+
+	printk(KERN_ERR "vde_write - we have no VDECONN to write to");
+	return -EBADF;
+}
+
+static const struct net_kern_info vde_kern_info = {
+	.init			= vde_init,
+	.protocol		= eth_protocol,
+	.read			= vde_read,
+	.write			= vde_write,
+};
+
+static int vde_setup(char *str, char **mac_out, void *data)
+{
+	struct vde_init *init = data;
+	char *remain, *port_str = NULL, *mode_str = NULL, *last;
+
+	*init = ((struct vde_init)
+		{ .vde_switch		= NULL,
+		  .descr		= NULL,
+		  .port			= 0,
+		  .group		= NULL,
+		  .mode			= 0 });
+
+	remain = split_if_spec(str, &init->vde_switch, mac_out, &port_str,
+				&init->group, &mode_str, &init->descr, NULL);
+
+	if (remain != NULL)
+		printk(KERN_WARNING "vde_setup - Ignoring extra data :"
+					"'%s'\n", remain);
+
+	if (port_str != NULL) {
+		init->port = simple_strtoul(port_str, &last, 10);
+		if ((*last != '\0') || (last == port_str)) {
+			printk(KERN_ERR "vde_setup - Bad port : '%s'\n",
+						port_str);
+			return 0;
+		}
+	}
+	
+	if (mode_str != NULL) {
+		init->mode = simple_strtoul(mode_str, &last, 8);
+		if ((*last != '\0') || (last == mode_str)) {
+			printk(KERN_ERR "vde_setup - Bad mode : '%s'\n",
+						mode_str);
+			return 0;
+		}
+	}
+
+	printk(KERN_INFO "Configured vde device: %s\n", init->vde_switch ?
+				init->vde_switch : "(default socket)"); 
+
+	return 1;
+}
+
+static struct transport vde_transport = {
+	.list 		= LIST_HEAD_INIT(vde_transport.list),
+	.name 		= "vde",
+	.setup  	= vde_setup,
+	.user 		= &vde_user_info,
+	.kern 		= &vde_kern_info,
+	.private_size 	= sizeof(struct vde_data),
+	.setup_size 	= sizeof(struct vde_init),
+};
+
+static int register_vde(void)
+{
+	register_transport(&vde_transport);
+	return 0;
+}
+
+late_initcall(register_vde);
--- linux-2.6.23-rc1_ORIG/arch/um/drivers/vde_user.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.23-rc1/arch/um/drivers/vde_user.c	2007-07-25 19:30:37.000000000 +0200
@@ -0,0 +1,136 @@
+/*
+ * Copyright (C) 2007 Luca Bigliardi (shammash@artha.org).
+ * Licensed under the GPL.
+ */
+
+#include <errno.h>
+#include <unistd.h>
+#include <libvdeplug.h>
+#include "net_user.h"
+#include "kern_util.h"
+#include "kern_constants.h"
+#include "user.h"
+#include "os.h"
+#include "um_malloc.h"
+#include "vde.h"
+
+#define MAX_PACKET (ETH_MAX_PACKET + ETH_HEADER_OTHER)
+
+static int vde_user_init(void *data, void *dev)
+{
+	struct vde_data *pri = data;
+	VDECONN *conn = NULL;
+	int err = -EINVAL;
+
+	pri->dev = dev;
+
+	conn = vde_open(pri->vde_switch, pri->descr, pri->args);
+	
+	if (conn == NULL) {
+		err = -errno;
+		printk(UM_KERN_ERR "vde_user_init: vde_open failed, "
+					"errno = %d\n", errno);
+		return err;
+	}
+
+	printk(UM_KERN_INFO "vde backend - connection opened\n");
+
+	pri->conn = conn;
+
+	return 0;
+}
+
+static int vde_user_open(void *data)
+{
+	struct vde_data *pri = data;
+
+	if (pri->conn != NULL)
+		return vde_datafd(pri->conn);
+	
+	printk(UM_KERN_WARNING "vde_open - we have no VDECONN to open");
+	return -EINVAL;
+}
+
+static void vde_remove(void *data)
+{
+	struct vde_data *pri = data;
+
+	if (pri->conn != NULL) {
+		printk(UM_KERN_INFO "vde backend - closing connection\n");
+		vde_close(pri->conn);
+		pri->conn = NULL;
+		kfree(pri->args);
+		pri->args = NULL;
+		return;
+	}
+
+	printk(UM_KERN_WARNING "vde_remove - we have no VDECONN to remove");
+}
+
+static int vde_set_mtu(int mtu, void *data)
+{
+	return mtu;
+}
+
+const struct net_user_info vde_user_info = {
+	.init		= vde_user_init,
+	.open		= vde_user_open,
+	.close	 	= NULL,
+	.remove	 	= vde_remove,
+	.set_mtu	= vde_set_mtu,
+	.add_address	= NULL,
+	.delete_address = NULL,
+	.max_packet	= MAX_PACKET - ETH_HEADER_OTHER
+};
+
+void vde_init_libstuff(struct vde_data *vpri, struct vde_init *init)
+{
+	struct vde_open_args *args;
+
+	vpri->args = kmalloc(sizeof(struct vde_open_args), UM_GFP_KERNEL);
+	if (vpri->args == NULL) {
+		printk(UM_KERN_ERR "\nvde_init_libstuff - vde_open_args"
+					"allocation failed");
+		return;
+	}
+
+	args = (struct vde_open_args *)vpri->args;
+
+	args->port = init->port;
+	args->group = init->group;
+	args->mode = init->mode ? init->mode : 0700;
+
+	args->port ?  printk(UM_KERN_INFO "port %d", args->port) :
+				printk(UM_KERN_INFO "undefined port");
+}
+
+int vde_user_read(void *conn, void *buf, int len) 
+{
+	VDECONN *vconn = (VDECONN *) conn;
+	int rv;
+
+	if (vconn == NULL)
+		return 0;
+
+	rv = vde_recv(vconn, buf, len, 0);
+	if (rv < 0) {
+		if (errno == EAGAIN)
+			return 0;
+		return -errno;
+	}
+	else if (rv == 0)
+		return -ENOTCONN;
+
+	return rv;
+}
+
+int vde_user_write(void *conn, void *buf, int len)
+{
+	VDECONN *vconn = (VDECONN *) conn;
+
+	if (vconn == NULL)
+		return 0;
+
+	return vde_send(vconn, buf, len, 0);
+}
+

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--45Z9DzgjV8m4Oswq--

