Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYGCU-0007bM-LB	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 21:30:30 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DYGCU-0008Ul-51
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 21:30:30 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1DYGCS-0000n7-AR	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 21:30:29 -0700
Message-Id: <200505180420.j4I4KMMS017317@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/9] UML - multicast driver cleanup
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
Date: Wed, 18 May 2005 00:20:22 -0400
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Byte-swapping of the port and IP address passed in to the multicast driver
by the user used to happen in different places, which was a bug in itself.  
The port also was swapped before being printk-ed, which led to a misleading
message.  This patch moves the port swapping to the same place as the IP 
address swapping.
It also cleans up the error paths of mcast_open.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/drivers/mcast_kern.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/drivers/mcast_kern.c	2005-05-17 18:02:25.000000000 -0400
+++ linux-2.6.12-rc/arch/um/drivers/mcast_kern.c	2005-05-17 18:07:03.000000000 -0400
@@ -73,7 +73,6 @@ int mcast_setup(char *str, char **mac_ou
 	struct mcast_init *init = data;
 	char *port_str = NULL, *ttl_str = NULL, *remain;
 	char *last;
-	int n;
 
 	*init = ((struct mcast_init)
 		{ .addr 	= "239.192.168.1",
@@ -89,13 +88,12 @@ int mcast_setup(char *str, char **mac_ou
 	}
 	
 	if(port_str != NULL){
-		n = simple_strtoul(port_str, &last, 10);
+		init->port = simple_strtoul(port_str, &last, 10);
 		if((*last != '\0') || (last == port_str)){
 			printk(KERN_ERR "mcast_setup - Bad port : '%s'\n", 
 			       port_str);
 			return(0);
 		}
-		init->port = htons(n);
 	}
 
 	if(ttl_str != NULL){
Index: linux-2.6.12-rc/arch/um/drivers/mcast_user.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/drivers/mcast_user.c	2005-05-17 18:02:25.000000000 -0400
+++ linux-2.6.12-rc/arch/um/drivers/mcast_user.c	2005-05-17 18:07:10.000000000 -0400
@@ -38,7 +38,7 @@ static struct sockaddr_in *new_addr(char
 	}
 	sin->sin_family = AF_INET;
 	sin->sin_addr.s_addr = in_aton(addr);
-	sin->sin_port = port;
+	sin->sin_port = htons(port);
 	return(sin);
 }
 
@@ -55,28 +55,25 @@ static int mcast_open(void *data)
 	struct mcast_data *pri = data;
 	struct sockaddr_in *sin = pri->mcast_addr;
 	struct ip_mreq mreq;
-	int fd, yes = 1;
+	int fd = -EINVAL, yes = 1, err = -EINVAL;;
 
 
-	if ((sin->sin_addr.s_addr == 0) || (sin->sin_port == 0)) {
-		fd = -EINVAL;
+	if ((sin->sin_addr.s_addr == 0) || (sin->sin_port == 0))
 		goto out;
-	}
 
 	fd = socket(AF_INET, SOCK_DGRAM, 0);
+
 	if (fd < 0){
 		printk("mcast_open : data socket failed, errno = %d\n", 
 		       errno);
-		fd = -ENOMEM;
+		fd = -errno;
 		goto out;
 	}
 
 	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(yes)) < 0) {
 		printk("mcast_open: SO_REUSEADDR failed, errno = %d\n",
 			errno);
-		os_close_file(fd);
-		fd = -EINVAL;
-		goto out;
+		goto out_close;
 	}
 
 	/* set ttl according to config */
@@ -84,26 +81,20 @@ static int mcast_open(void *data)
 		       sizeof(pri->ttl)) < 0) {
 		printk("mcast_open: IP_MULTICAST_TTL failed, error = %d\n",
 			errno);
-		os_close_file(fd);
-		fd = -EINVAL;
-		goto out;
+		goto out_close;
 	}
 
 	/* set LOOP, so data does get fed back to local sockets */
 	if (setsockopt(fd, SOL_IP, IP_MULTICAST_LOOP, &yes, sizeof(yes)) < 0) {
 		printk("mcast_open: IP_MULTICAST_LOOP failed, error = %d\n",
 			errno);
-		os_close_file(fd);
-		fd = -EINVAL;
-		goto out;
+		goto out_close;
 	}
 
 	/* bind socket to mcast address */
 	if (bind(fd, (struct sockaddr *) sin, sizeof(*sin)) < 0) {
 		printk("mcast_open : data bind failed, errno = %d\n", errno);
-		os_close_file(fd);
-		fd = -EINVAL;
-		goto out;
+		goto out_close;
 	}		
 	
 	/* subscribe to the multicast group */
@@ -117,12 +108,15 @@ static int mcast_open(void *data)
 		       "interface on the host.\n");
 		printk("eth0 should be configured in order to use the "
 		       "multicast transport.\n");
-		os_close_file(fd);
-		fd = -EINVAL;
+                goto out_close;
 	}
 
  out:
-	return(fd);
+	return fd;
+
+ out_close:
+        os_close_file(fd);
+        return err;
 }
 
 static void mcast_close(int fd, void *data)
@@ -164,14 +158,3 @@ struct net_user_info mcast_user_info = {
 	.delete_address = NULL,
 	.max_packet	= MAX_PACKET - ETH_HEADER_OTHER
 };
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
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
