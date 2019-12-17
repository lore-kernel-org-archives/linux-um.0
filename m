Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ih9nI-0002bT-6Y
 for linux-um@lists.infradead.org; Tue, 17 Dec 2019 10:09:34 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH v4 7/9] um: Remove ethertap driver and remaining legacy
 tap/ethertap code
Date: Tue, 17 Dec 2019 10:09:11 +0000
Message-Id: <20191217100913.3422-7-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20191217100913.3422-1-anton.ivanov@cambridgegreys.com>
References: <20191217100913.3422-1-anton.ivanov@cambridgegreys.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: richard@nod.at, brendanhiggins@google.com, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Ethertap is no longer present in the host kernels and tap has been
migrated to the vector IO backend.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/Kconfig                  |  26 ---
 arch/um/drivers/net_user.c               |  31 ---
 arch/um/include/shared/net_kern.h        |   2 -
 arch/um/include/shared/net_user.h        |   3 -
 arch/um/os-Linux/Makefile                |   2 +-
 arch/um/os-Linux/drivers/Makefile        |  11 -
 arch/um/os-Linux/drivers/etap.h          |  21 --
 arch/um/os-Linux/drivers/ethertap_kern.c | 100 ---------
 arch/um/os-Linux/drivers/ethertap_user.c | 248 -----------------------
 9 files changed, 1 insertion(+), 443 deletions(-)
 delete mode 100644 arch/um/os-Linux/drivers/Makefile
 delete mode 100644 arch/um/os-Linux/drivers/etap.h
 delete mode 100644 arch/um/os-Linux/drivers/ethertap_kern.c
 delete mode 100644 arch/um/os-Linux/drivers/ethertap_user.c

diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index d8e59bf08d63..7362ac9953fc 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -146,32 +146,6 @@ config UML_NET
 	  enable at least one of the following transport options to actually
 	  make use of UML networking.
 
-config UML_NET_ETHERTAP
-	bool "Ethertap transport"
-	depends on UML_NET
-	help
-	  The Ethertap User-Mode Linux network transport allows a single
-	  running UML to exchange packets with its host over one of the
-	  host's Ethertap devices, such as /dev/tap0.  Additional running
-	  UMLs can use additional Ethertap devices, one per running UML.
-	  While the UML believes it's on a (multi-device, broadcast) virtual
-	  Ethernet network, it's in fact communicating over a point-to-point
-	  link with the host.
-
-	  To use this, your host kernel must have support for Ethertap
-	  devices.  Also, if your host kernel is 2.4.x, it must have
-	  CONFIG_NETLINK_DEV configured as Y or M.
-
-	  For more information, see
-	  <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
-	  has examples of the UML command line to use to enable Ethertap
-	  networking.
-
-	  If you'd like to set up an IP network with the host and/or the
-	  outside world, say Y to this, the Daemon Transport and/or the
-	  Slip Transport.  You'll need at least one of them, but may choose
-	  more than one without conflict.  If you don't need UML networking,
-	  say N.
 
 config UML_NET_TUNTAP
 	bool "TUN/TAP transport"
diff --git a/arch/um/drivers/net_user.c b/arch/um/drivers/net_user.c
index 4c9576452ab0..4e231240fa25 100644
--- a/arch/um/drivers/net_user.c
+++ b/arch/um/drivers/net_user.c
@@ -15,37 +15,6 @@
 #include <os.h>
 #include <um_malloc.h>
 
-int tap_open_common(void *dev, char *gate_addr)
-{
-	int tap_addr[4];
-
-	if (gate_addr == NULL)
-		return 0;
-	if (sscanf(gate_addr, "%d.%d.%d.%d", &tap_addr[0],
-		  &tap_addr[1], &tap_addr[2], &tap_addr[3]) != 4) {
-		printk(UM_KERN_ERR "Invalid tap IP address - '%s'\n",
-		       gate_addr);
-		return -EINVAL;
-	}
-	return 0;
-}
-
-void tap_check_ips(char *gate_addr, unsigned char *eth_addr)
-{
-	int tap_addr[4];
-
-	if ((gate_addr != NULL) &&
-	    (sscanf(gate_addr, "%d.%d.%d.%d", &tap_addr[0],
-		    &tap_addr[1], &tap_addr[2], &tap_addr[3]) == 4) &&
-	    (eth_addr[0] == tap_addr[0]) &&
-	    (eth_addr[1] == tap_addr[1]) &&
-	    (eth_addr[2] == tap_addr[2]) &&
-	    (eth_addr[3] == tap_addr[3])) {
-		printk(UM_KERN_ERR "The tap IP address and the UML eth IP "
-		       "address must be different\n");
-	}
-}
-
 /* Do reliable error handling as this fails frequently enough. */
 void read_output(int fd, char *output, int len)
 {
diff --git a/arch/um/include/shared/net_kern.h b/arch/um/include/shared/net_kern.h
index f9389a2ec2d8..0ef1021d1a7e 100644
--- a/arch/um/include/shared/net_kern.h
+++ b/arch/um/include/shared/net_kern.h
@@ -61,8 +61,6 @@ struct transport {
 
 extern struct net_device *ether_init(int);
 extern unsigned short ether_protocol(struct sk_buff *);
-extern int tap_setup_common(char *str, char *type, char **dev_name,
-			    char **mac_out, char **gate_addr);
 extern void register_transport(struct transport *new);
 extern unsigned short eth_protocol(struct sk_buff *skb);
 extern void uml_net_setup_etheraddr(struct net_device *dev, char *str);
diff --git a/arch/um/include/shared/net_user.h b/arch/um/include/shared/net_user.h
index b523e469256c..22fd80e55bd0 100644
--- a/arch/um/include/shared/net_user.h
+++ b/arch/um/include/shared/net_user.h
@@ -32,9 +32,6 @@ extern void iter_addresses(void *d, void (*cb)(unsigned char *,
 extern void *get_output_buffer(int *len_out);
 extern void free_output_buffer(void *buffer);
 
-extern int tap_open_common(void *dev, char *gate_addr);
-extern void tap_check_ips(char *gate_addr, unsigned char *eth_addr);
-
 extern void read_output(int fd, char *output_out, int len);
 
 extern int net_read(int fd, void *buf, int len);
diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index 839915b8c31c..5847b6f8551d 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -8,7 +8,7 @@ KCOV_INSTRUMENT                := n
 
 obj-y = execvp.o file.o helper.o irq.o main.o mem.o process.o \
 	registers.o sigio.o signal.o start_up.o time.o tty.o \
-	umid.o user_syms.o util.o drivers/ skas/
+	umid.o user_syms.o util.o skas/
 
 obj-$(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA) += elf_aux.o
 
diff --git a/arch/um/os-Linux/drivers/Makefile b/arch/um/os-Linux/drivers/Makefile
deleted file mode 100644
index 924c42641170..000000000000
--- a/arch/um/os-Linux/drivers/Makefile
+++ /dev/null
@@ -1,11 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# 
-# Copyright (C) 2000, 2002 Jeff Dike (jdike@karaya.com)
-#
-
-ethertap-objs := ethertap_kern.o ethertap_user.o
-
-obj-y = 
-obj-$(CONFIG_UML_NET_ETHERTAP) += ethertap.o
-
-include arch/um/scripts/Makefile.rules
diff --git a/arch/um/os-Linux/drivers/etap.h b/arch/um/os-Linux/drivers/etap.h
deleted file mode 100644
index a475259f90e1..000000000000
--- a/arch/um/os-Linux/drivers/etap.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* 
- * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- */
-
-#ifndef __DRIVERS_ETAP_H
-#define __DRIVERS_ETAP_H
-
-#include <net_user.h>
-
-struct ethertap_data {
-	char *dev_name;
-	char *gate_addr;
-	int data_fd;
-	int control_fd;
-	void *dev;
-};
-
-extern const struct net_user_info ethertap_user_info;
-
-#endif
diff --git a/arch/um/os-Linux/drivers/ethertap_kern.c b/arch/um/os-Linux/drivers/ethertap_kern.c
deleted file mode 100644
index 3182e759d8de..000000000000
--- a/arch/um/os-Linux/drivers/ethertap_kern.c
+++ /dev/null
@@ -1,100 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and
- * James Leu (jleu@mindspring.net).
- * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Copyright (C) 2001 by various other people who didn't put their name here.
- */
-
-#include <linux/init.h>
-#include <linux/netdevice.h>
-#include "etap.h"
-#include <net_kern.h>
-
-struct ethertap_init {
-	char *dev_name;
-	char *gate_addr;
-};
-
-static void etap_init(struct net_device *dev, void *data)
-{
-	struct uml_net_private *pri;
-	struct ethertap_data *epri;
-	struct ethertap_init *init = data;
-
-	pri = netdev_priv(dev);
-	epri = (struct ethertap_data *) pri->user;
-	epri->dev_name = init->dev_name;
-	epri->gate_addr = init->gate_addr;
-	epri->data_fd = -1;
-	epri->control_fd = -1;
-	epri->dev = dev;
-
-	printk(KERN_INFO "ethertap backend - %s", epri->dev_name);
-	if (epri->gate_addr != NULL)
-		printk(KERN_CONT ", IP = %s", epri->gate_addr);
-	printk(KERN_CONT "\n");
-}
-
-static int etap_read(int fd, struct sk_buff *skb, struct uml_net_private *lp)
-{
-	int len;
-
-	len = net_recvfrom(fd, skb_mac_header(skb),
-			   skb->dev->mtu + 2 + ETH_HEADER_ETHERTAP);
-	if (len <= 0)
-		return(len);
-
-	skb_pull(skb, 2);
-	len -= 2;
-	return len;
-}
-
-static int etap_write(int fd, struct sk_buff *skb, struct uml_net_private *lp)
-{
-	skb_push(skb, 2);
-	return net_send(fd, skb->data, skb->len);
-}
-
-const struct net_kern_info ethertap_kern_info = {
-	.init			= etap_init,
-	.protocol		= eth_protocol,
-	.read			= etap_read,
-	.write 			= etap_write,
-};
-
-int ethertap_setup(char *str, char **mac_out, void *data)
-{
-	struct ethertap_init *init = data;
-
-	*init = ((struct ethertap_init)
-		{ .dev_name 	= NULL,
-		  .gate_addr 	= NULL });
-	if (tap_setup_common(str, "ethertap", &init->dev_name, mac_out,
-			    &init->gate_addr))
-		return 0;
-	if (init->dev_name == NULL) {
-		printk(KERN_ERR "ethertap_setup : Missing tap device name\n");
-		return 0;
-	}
-
-	return 1;
-}
-
-static struct transport ethertap_transport = {
-	.list 		= LIST_HEAD_INIT(ethertap_transport.list),
-	.name 		= "ethertap",
-	.setup  	= ethertap_setup,
-	.user 		= &ethertap_user_info,
-	.kern 		= &ethertap_kern_info,
-	.private_size 	= sizeof(struct ethertap_data),
-	.setup_size 	= sizeof(struct ethertap_init),
-};
-
-static int register_ethertap(void)
-{
-	register_transport(&ethertap_transport);
-	return 0;
-}
-
-late_initcall(register_ethertap);
diff --git a/arch/um/os-Linux/drivers/ethertap_user.c b/arch/um/os-Linux/drivers/ethertap_user.c
deleted file mode 100644
index 9483021d86dd..000000000000
--- a/arch/um/os-Linux/drivers/ethertap_user.c
+++ /dev/null
@@ -1,248 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and
- * James Leu (jleu@mindspring.net).
- * Copyright (C) 2001 by various other people who didn't put their name here.
- */
-
-#include <stdio.h>
-#include <unistd.h>
-#include <errno.h>
-#include <string.h>
-#include <sys/socket.h>
-#include <sys/wait.h>
-#include "etap.h"
-#include <os.h>
-#include <net_user.h>
-#include <um_malloc.h>
-
-#define MAX_PACKET ETH_MAX_PACKET
-
-static int etap_user_init(void *data, void *dev)
-{
-	struct ethertap_data *pri = data;
-
-	pri->dev = dev;
-	return 0;
-}
-
-struct addr_change {
-	enum { ADD_ADDR, DEL_ADDR } what;
-	unsigned char addr[4];
-	unsigned char netmask[4];
-};
-
-static void etap_change(int op, unsigned char *addr, unsigned char *netmask,
-			int fd)
-{
-	struct addr_change change;
-	char *output;
-	int n;
-
-	change.what = op;
-	memcpy(change.addr, addr, sizeof(change.addr));
-	memcpy(change.netmask, netmask, sizeof(change.netmask));
-	CATCH_EINTR(n = write(fd, &change, sizeof(change)));
-	if (n != sizeof(change)) {
-		printk(UM_KERN_ERR "etap_change - request failed, err = %d\n",
-		       errno);
-		return;
-	}
-
-	output = uml_kmalloc(UM_KERN_PAGE_SIZE, UM_GFP_KERNEL);
-	if (output == NULL)
-		printk(UM_KERN_ERR "etap_change : Failed to allocate output "
-		       "buffer\n");
-	read_output(fd, output, UM_KERN_PAGE_SIZE);
-	if (output != NULL) {
-		printk("%s", output);
-		kfree(output);
-	}
-}
-
-static void etap_open_addr(unsigned char *addr, unsigned char *netmask,
-			   void *arg)
-{
-	etap_change(ADD_ADDR, addr, netmask, *((int *) arg));
-}
-
-static void etap_close_addr(unsigned char *addr, unsigned char *netmask,
-			    void *arg)
-{
-	etap_change(DEL_ADDR, addr, netmask, *((int *) arg));
-}
-
-struct etap_pre_exec_data {
-	int control_remote;
-	int control_me;
-	int data_me;
-};
-
-static void etap_pre_exec(void *arg)
-{
-	struct etap_pre_exec_data *data = arg;
-
-	dup2(data->control_remote, 1);
-	close(data->data_me);
-	close(data->control_me);
-}
-
-static int etap_tramp(char *dev, char *gate, int control_me,
-		      int control_remote, int data_me, int data_remote)
-{
-	struct etap_pre_exec_data pe_data;
-	int pid, err, n;
-	char version_buf[sizeof("nnnnn\0")];
-	char data_fd_buf[sizeof("nnnnnn\0")];
-	char gate_buf[sizeof("nnn.nnn.nnn.nnn\0")];
-	char *setup_args[] = { "uml_net", version_buf, "ethertap", dev,
-			       data_fd_buf, gate_buf, NULL };
-	char *nosetup_args[] = { "uml_net", version_buf, "ethertap",
-				 dev, data_fd_buf, NULL };
-	char **args, c;
-
-	sprintf(data_fd_buf, "%d", data_remote);
-	sprintf(version_buf, "%d", UML_NET_VERSION);
-	if (gate != NULL) {
-		strncpy(gate_buf, gate, 15);
-		args = setup_args;
-	}
-	else args = nosetup_args;
-
-	err = 0;
-	pe_data.control_remote = control_remote;
-	pe_data.control_me = control_me;
-	pe_data.data_me = data_me;
-	pid = run_helper(etap_pre_exec, &pe_data, args);
-
-	if (pid < 0)
-		err = pid;
-	close(data_remote);
-	close(control_remote);
-	CATCH_EINTR(n = read(control_me, &c, sizeof(c)));
-	if (n != sizeof(c)) {
-		err = -errno;
-		printk(UM_KERN_ERR "etap_tramp : read of status failed, "
-		       "err = %d\n", -err);
-		return err;
-	}
-	if (c != 1) {
-		printk(UM_KERN_ERR "etap_tramp : uml_net failed\n");
-		err = helper_wait(pid);
-	}
-	return err;
-}
-
-static int etap_open(void *data)
-{
-	struct ethertap_data *pri = data;
-	char *output;
-	int data_fds[2], control_fds[2], err, output_len;
-
-	err = tap_open_common(pri->dev, pri->gate_addr);
-	if (err)
-		return err;
-
-	err = socketpair(AF_UNIX, SOCK_DGRAM, 0, data_fds);
-	if (err) {
-		err = -errno;
-		printk(UM_KERN_ERR "etap_open - data socketpair failed - "
-		       "err = %d\n", errno);
-		return err;
-	}
-
-	err = socketpair(AF_UNIX, SOCK_STREAM, 0, control_fds);
-	if (err) {
-		err = -errno;
-		printk(UM_KERN_ERR "etap_open - control socketpair failed - "
-		       "err = %d\n", errno);
-		goto out_close_data;
-	}
-
-	err = etap_tramp(pri->dev_name, pri->gate_addr, control_fds[0],
-			 control_fds[1], data_fds[0], data_fds[1]);
-	output_len = UM_KERN_PAGE_SIZE;
-	output = uml_kmalloc(output_len, UM_GFP_KERNEL);
-	read_output(control_fds[0], output, output_len);
-
-	if (output == NULL)
-		printk(UM_KERN_ERR "etap_open : failed to allocate output "
-		       "buffer\n");
-	else {
-		printk("%s", output);
-		kfree(output);
-	}
-
-	if (err < 0) {
-		printk(UM_KERN_ERR "etap_tramp failed - err = %d\n", -err);
-		goto out_close_control;
-	}
-
-	pri->data_fd = data_fds[0];
-	pri->control_fd = control_fds[0];
-	iter_addresses(pri->dev, etap_open_addr, &pri->control_fd);
-	return data_fds[0];
-
-out_close_control:
-	close(control_fds[0]);
-	close(control_fds[1]);
-out_close_data:
-	close(data_fds[0]);
-	close(data_fds[1]);
-	return err;
-}
-
-static void etap_close(int fd, void *data)
-{
-	struct ethertap_data *pri = data;
-
-	iter_addresses(pri->dev, etap_close_addr, &pri->control_fd);
-	close(fd);
-
-	if (shutdown(pri->data_fd, SHUT_RDWR) < 0)
-		printk(UM_KERN_ERR "etap_close - shutdown data socket failed, "
-		       "errno = %d\n", errno);
-
-	if (shutdown(pri->control_fd, SHUT_RDWR) < 0)
-		printk(UM_KERN_ERR "etap_close - shutdown control socket "
-		       "failed, errno = %d\n", errno);
-
-	close(pri->data_fd);
-	pri->data_fd = -1;
-	close(pri->control_fd);
-	pri->control_fd = -1;
-}
-
-static void etap_add_addr(unsigned char *addr, unsigned char *netmask,
-			  void *data)
-{
-	struct ethertap_data *pri = data;
-
-	tap_check_ips(pri->gate_addr, addr);
-	if (pri->control_fd == -1)
-		return;
-	etap_open_addr(addr, netmask, &pri->control_fd);
-}
-
-static void etap_del_addr(unsigned char *addr, unsigned char *netmask,
-			  void *data)
-{
-	struct ethertap_data *pri = data;
-
-	if (pri->control_fd == -1)
-		return;
-
-	etap_close_addr(addr, netmask, &pri->control_fd);
-}
-
-const struct net_user_info ethertap_user_info = {
-	.init		= etap_user_init,
-	.open		= etap_open,
-	.close	 	= etap_close,
-	.remove	 	= NULL,
-	.add_address	= etap_add_addr,
-	.delete_address = etap_del_addr,
-	.mtu		= ETH_MAX_PACKET,
-	.max_packet	= ETH_MAX_PACKET + ETH_HEADER_ETHERTAP,
-};
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

