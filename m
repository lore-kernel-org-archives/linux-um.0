Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EFfLF-0003hz-Hn	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 15:02:57 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EFfLE-0004Ep-Ja
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 15:02:57 -0700
Message-Id: <200509142156.j8ELu5ZX012153@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 6/10] UML - preserve errno in error paths
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
Date: Wed, 14 Sep 2005 17:56:05 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

The poster child for this patch is the third tuntap_user hunk.  When an ioctl
fails, it properly closes the opened file descriptor and returns.  However,
the close resets errno to 0, and the 'return errno' that follows returns 0 
rather than the value that ioctl set.  This caused the caller to believe that
the device open succeeded and had opened file descriptor 0, which caused no
end of interesting behavior.

The rest of this patch is a pass through the UML sources looking for places
where errno could be reset before being passed back out.  A common culprit is
printk, which could call write, being called before errno is returned.

In some cases, where the code ends up being much smaller, I just deleted the 
printk.

There was another case where a caller of run_helper looked at errno after a
failure, rather than the return value of run_helper, which was the errno
value that it wanted.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-mm2/arch/um/drivers/mcast_user.c
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/drivers/mcast_user.c	2005-09-12 23:19:16.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/drivers/mcast_user.c	2005-09-12 23:20:10.000000000 -0400
@@ -54,7 +54,7 @@
 	struct mcast_data *pri = data;
 	struct sockaddr_in *sin = pri->mcast_addr;
 	struct ip_mreq mreq;
-	int fd = -EINVAL, yes = 1, err = -EINVAL;;
+	int fd, yes = 1, err = 0;
 
 
 	if ((sin->sin_addr.s_addr == 0) || (sin->sin_port == 0))
@@ -65,13 +65,14 @@
 	if (fd < 0){
 		printk("mcast_open : data socket failed, errno = %d\n", 
 		       errno);
-		fd = -errno;
+		err = -errno;
 		goto out;
 	}
 
 	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(yes)) < 0) {
 		printk("mcast_open: SO_REUSEADDR failed, errno = %d\n",
 			errno);
+		err = -errno;
 		goto out_close;
 	}
 
@@ -80,6 +81,7 @@
 		       sizeof(pri->ttl)) < 0) {
 		printk("mcast_open: IP_MULTICAST_TTL failed, error = %d\n",
 			errno);
+		err = -errno;
 		goto out_close;
 	}
 
@@ -87,12 +89,14 @@
 	if (setsockopt(fd, SOL_IP, IP_MULTICAST_LOOP, &yes, sizeof(yes)) < 0) {
 		printk("mcast_open: IP_MULTICAST_LOOP failed, error = %d\n",
 			errno);
+		err = -errno;
 		goto out_close;
 	}
 
 	/* bind socket to mcast address */
 	if (bind(fd, (struct sockaddr *) sin, sizeof(*sin)) < 0) {
 		printk("mcast_open : data bind failed, errno = %d\n", errno);
+		err = -errno;
 		goto out_close;
 	}		
 	
@@ -107,14 +111,15 @@
 		       "interface on the host.\n");
 		printk("eth0 should be configured in order to use the "
 		       "multicast transport.\n");
+		err = -errno;
                 goto out_close;
 	}
 
- out:
 	return fd;
 
  out_close:
         os_close_file(fd);
+ out:
         return err;
 }
 
Index: linux-2.6.13-mm2/arch/um/drivers/mconsole_user.c
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/drivers/mconsole_user.c	2005-09-12 23:19:16.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/drivers/mconsole_user.c	2005-09-12 23:20:10.000000000 -0400
@@ -173,9 +173,9 @@
 	if(notify_sock < 0){
 		notify_sock = socket(PF_UNIX, SOCK_DGRAM, 0);
 		if(notify_sock < 0){
-			printk("mconsole_notify - socket failed, errno = %d\n",
-			       errno);
 			err = -errno;
+			printk("mconsole_notify - socket failed, errno = %d\n",
+			       err);
 		}
 	}
 	unlock_notify();
@@ -198,8 +198,8 @@
 	n = sendto(notify_sock, &packet, len, 0, (struct sockaddr *) &target, 
 		   sizeof(target));
 	if(n < 0){
-		printk("mconsole_notify - sendto failed, errno = %d\n", errno);
 		err = -errno;
+		printk("mconsole_notify - sendto failed, errno = %d\n", errno);
 	}
 	return(err);
 }
Index: linux-2.6.13-mm2/arch/um/drivers/pty.c
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/drivers/pty.c	2005-09-12 23:19:16.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/drivers/pty.c	2005-09-12 23:20:10.000000000 -0400
@@ -43,8 +43,9 @@
 
 	fd = get_pty();
 	if(fd < 0){
+		err = -errno;
 		printk("open_pts : Failed to open pts\n");
-		return(-errno);
+		return err;
 	}
 	if(data->raw){
 		CATCH_EINTR(err = tcgetattr(fd, &data->tt));
Index: linux-2.6.13-mm2/arch/um/drivers/xterm.c
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/drivers/xterm.c	2005-09-12 23:19:16.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/drivers/xterm.c	2005-09-12 23:20:10.000000000 -0400
@@ -110,13 +110,15 @@
 
 	fd = mkstemp(file);
 	if(fd < 0){
+		err = -errno;
 		printk("xterm_open : mkstemp failed, errno = %d\n", errno);
-		return(-errno);
+		return err;
 	}
 
 	if(unlink(file)){
+		err = -errno;
 		printk("xterm_open : unlink failed, errno = %d\n", errno);
-		return(-errno);
+		return err;
 	}
 	os_close_file(fd);
 
Index: linux-2.6.13-mm2/arch/um/kernel/helper.c
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/kernel/helper.c	2005-09-12 23:19:16.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/kernel/helper.c	2005-09-12 23:20:10.000000000 -0400
@@ -85,8 +85,8 @@
 	data.fd = fds[1];
 	pid = clone(helper_child, (void *) sp, CLONE_VM | SIGCHLD, &data);
 	if(pid < 0){
-		printk("run_helper : clone failed, errno = %d\n", errno);
 		ret = -errno;
+		printk("run_helper : clone failed, errno = %d\n", errno);
 		goto out_close;
 	}
 
@@ -122,7 +122,7 @@
 		      unsigned long *stack_out, int stack_order)
 {
 	unsigned long stack, sp;
-	int pid, status;
+	int pid, status, err;
 
 	stack = alloc_stack(stack_order, um_in_interrupt());
 	if(stack == 0) return(-ENOMEM);
@@ -130,16 +130,18 @@
 	sp = stack + (page_size() << stack_order) - sizeof(void *);
 	pid = clone(proc, (void *) sp, flags | SIGCHLD, arg);
 	if(pid < 0){
+		err = -errno;
 		printk("run_helper_thread : clone failed, errno = %d\n", 
 		       errno);
-		return(-errno);
+		return err;
 	}
 	if(stack_out == NULL){
 		CATCH_EINTR(pid = waitpid(pid, &status, 0));
 		if(pid < 0){
+			err = -errno;
 			printk("run_helper_thread - wait failed, errno = %d\n",
 			       errno);
-			pid = -errno;
+			pid = err;
 		}
 		if(!WIFEXITED(status) || (WEXITSTATUS(status) != 0))
 			printk("run_helper_thread - thread returned status "
@@ -156,8 +158,8 @@
 
 	CATCH_EINTR(ret = waitpid(pid, NULL, WNOHANG));
 	if(ret < 0){
+		ret = -errno;
 		printk("helper_wait : waitpid failed, errno = %d\n", errno);
-		return(-errno);
 	}
 	return(ret);
 }
Index: linux-2.6.13-mm2/arch/um/kernel/user_util.c
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/kernel/user_util.c	2005-09-11 21:05:32.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/kernel/user_util.c	2005-09-12 23:20:10.000000000 -0400
@@ -109,18 +109,14 @@
 	int err;
 
 	CATCH_EINTR(err = tcgetattr(fd, &tt));
-	if (err < 0) {
-			printk("tcgetattr failed, errno = %d\n", errno);
-		return(-errno);
-	}
+	if(err < 0)
+		return -errno;
 
 	cfmakeraw(&tt);
 
  	CATCH_EINTR(err = tcsetattr(fd, TCSADRAIN, &tt));
-	if (err < 0) {
-			printk("tcsetattr failed, errno = %d\n", errno);
-		return(-errno);
-	}
+	if(err < 0)
+		return -errno;
 
 	/* XXX tcsetattr could have applied only some changes
 	 * (and cfmakeraw() is a set of changes) */
Index: linux-2.6.13-mm2/arch/um/os-Linux/aio.c
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/os-Linux/aio.c	2005-09-12 23:20:10.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/os-Linux/aio.c	2005-09-12 23:20:10.000000000 -0400
@@ -313,15 +313,16 @@
         int err;
 
         if(io_setup(256, &ctx)){
+		err = -errno;
                 printk("aio_thread failed to initialize context, err = %d\n",
                        errno);
-                return -errno;
+                return err;
         }
 
         err = run_helper_thread(aio_thread, NULL,
                                 CLONE_FILES | CLONE_VM | SIGCHLD, &stack, 0);
         if(err < 0)
-                return -errno;
+                return err;
 
         aio_pid = err;
 
Index: linux-2.6.13-mm2/arch/um/os-Linux/drivers/tuntap_user.c
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/os-Linux/drivers/tuntap_user.c	2005-09-12 23:19:16.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/os-Linux/drivers/tuntap_user.c	2005-09-12 23:20:10.000000000 -0400
@@ -75,7 +75,7 @@
 	struct msghdr msg;
 	struct cmsghdr *cmsg;
 	struct iovec iov;
-	int pid, n;
+	int pid, n, err;
 
 	sprintf(version_buf, "%d", UML_NET_VERSION);
 
@@ -105,9 +105,10 @@
 	n = recvmsg(me, &msg, 0);
 	*used_out = n;
 	if(n < 0){
+		err = -errno;
 		printk("tuntap_open_tramp : recvmsg failed - errno = %d\n", 
 		       errno);
-		return(-errno);
+		return err;
 	}
 	CATCH_EINTR(waitpid(pid, NULL, 0));
 
@@ -147,9 +148,10 @@
 		ifr.ifr_flags = IFF_TAP | IFF_NO_PI;
 		strlcpy(ifr.ifr_name, pri->dev_name, sizeof(ifr.ifr_name));
 		if(ioctl(pri->fd, TUNSETIFF, (void *) &ifr) < 0){
+			err = -errno;
 			printk("TUNSETIFF failed, errno = %d\n", errno);
 			os_close_file(pri->fd);
-			return(-errno);
+			return err;
 		}
 	}
 	else {
Index: linux-2.6.13-mm2/arch/um/os-Linux/file.c
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/os-Linux/file.c	2005-09-12 23:19:16.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/os-Linux/file.c	2005-09-12 23:20:10.000000000 -0400
@@ -119,15 +119,11 @@
 
 int os_new_tty_pgrp(int fd, int pid)
 {
-	if(ioctl(fd, TIOCSCTTY, 0) < 0){
-		printk("TIOCSCTTY failed, errno = %d\n", errno);
-		return(-errno);
-	}
+	if(ioctl(fd, TIOCSCTTY, 0) < 0)
+		return -errno;
 
-	if(tcsetpgrp(fd, pid) < 0){
-		printk("tcsetpgrp failed, errno = %d\n", errno);
-		return(-errno);
-	}
+	if(tcsetpgrp(fd, pid) < 0)
+		return -errno;
 
 	return(0);
 }
@@ -146,18 +142,12 @@
 	int disc, sencap;
 
 	disc = N_SLIP;
-	if(ioctl(fd, TIOCSETD, &disc) < 0){
-		printk("Failed to set slip line discipline - "
-		       "errno = %d\n", errno);
-		return(-errno);
-	}
+	if(ioctl(fd, TIOCSETD, &disc) < 0)
+		return -errno;
 
 	sencap = 0;
-	if(ioctl(fd, SIOCSIFENCAP, &sencap) < 0){
-		printk("Failed to set slip encapsulation - "
-		       "errno = %d\n", errno);
-		return(-errno);
-	}
+	if(ioctl(fd, SIOCSIFENCAP, &sencap) < 0)
+		return -errno;
 
 	return(0);
 }
@@ -180,22 +170,15 @@
 	int flags;
 
 	flags = fcntl(master, F_GETFL);
-	if(flags < 0) {
-		printk("fcntl F_GETFL failed, errno = %d\n", errno);
-		return(-errno);
-	}
+	if(flags < 0)
+		return errno;
 
 	if((fcntl(master, F_SETFL, flags | O_NONBLOCK | O_ASYNC) < 0) ||
-	   (fcntl(master, F_SETOWN, os_getpid()) < 0)){
-		printk("fcntl F_SETFL or F_SETOWN failed, errno = %d\n",
-		       errno);
-		return(-errno);
-	}
+	   (fcntl(master, F_SETOWN, os_getpid()) < 0))
+		return -errno;
 
-	if((fcntl(slave, F_SETFL, flags | O_NONBLOCK) < 0)){
-		printk("fcntl F_SETFL failed, errno = %d\n", errno);
-		return(-errno);
-	}
+	if((fcntl(slave, F_SETFL, flags | O_NONBLOCK) < 0))
+		return -errno;
 
 	return(0);
 }
@@ -255,7 +238,7 @@
 
 int os_open_file(char *file, struct openflags flags, int mode)
 {
-	int fd, f = 0;
+	int fd, err, f = 0;
 
 	if(flags.r && flags.w) f = O_RDWR;
 	else if(flags.r) f = O_RDONLY;
@@ -272,8 +255,9 @@
 		return(-errno);
 
 	if(flags.cl && fcntl(fd, F_SETFD, 1)){
+		err = -errno;
 		os_close_file(fd);
-		return(-errno);
+		return err;
 	}
 
 	return(fd);
@@ -383,9 +367,9 @@
 			return(fd);
 		}
 		if(ioctl(fd, BLKGETSIZE, &blocks) < 0){
+			err = -errno;
 			printk("Couldn't get the block size of \"%s\", "
 			       "errno = %d\n", file, errno);
-			err = -errno;
 			os_close_file(fd);
 			return(err);
 		}
@@ -473,11 +457,14 @@
 
 int os_set_fd_async(int fd, int owner)
 {
+	int err;
+
 	/* XXX This should do F_GETFL first */
 	if(fcntl(fd, F_SETFL, O_ASYNC | O_NONBLOCK) < 0){
+		err = -errno;
 		printk("os_set_fd_async : failed to set O_ASYNC and "
 		       "O_NONBLOCK on fd # %d, errno = %d\n", fd, errno);
-		return(-errno);
+		return err;
 	}
 #ifdef notdef
 	if(fcntl(fd, F_SETFD, 1) < 0){
@@ -488,10 +475,11 @@
 
 	if((fcntl(fd, F_SETSIG, SIGIO) < 0) ||
 	   (fcntl(fd, F_SETOWN, owner) < 0)){
+		err = -errno;
 		printk("os_set_fd_async : Failed to fcntl F_SETOWN "
 		       "(or F_SETSIG) fd %d to pid %d, errno = %d\n", fd, 
 		       owner, errno);
-		return(-errno);
+		return err;
 	}
 
 	return(0);
@@ -516,11 +504,9 @@
 	if(blocking) flags &= ~O_NONBLOCK;
 	else flags |= O_NONBLOCK;
 
-	if(fcntl(fd, F_SETFL, flags) < 0){
-		printk("Failed to change blocking on fd # %d, errno = %d\n",
-		       fd, errno);
-		return(-errno);
-	}
+	if(fcntl(fd, F_SETFL, flags) < 0)
+		return -errno;
+
 	return(0);
 }
 
@@ -609,11 +595,8 @@
 	int sock, err;
 
 	sock = socket(PF_UNIX, SOCK_DGRAM, 0);
-	if (sock < 0){
-		printk("create_unix_socket - socket failed, errno = %d\n",
-		       errno);
-		return(-errno);
-	}
+	if(sock < 0)		     
+		return -errno;
 
 	if(close_on_exec) {
 		err = os_set_exec_close(sock, 1);
@@ -628,11 +611,8 @@
 	snprintf(addr.sun_path, len, "%s", file);
 
 	err = bind(sock, (struct sockaddr *) &addr, sizeof(addr));
-	if (err < 0){
-		printk("create_listening_socket at '%s' - bind failed, "
-		       "errno = %d\n", file, errno);
-		return(-errno);
-	}
+	if(err < 0)
+		return -errno;
 
 	return(sock);
 }



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
