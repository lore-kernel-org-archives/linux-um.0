Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JgKcJ-0002Cv-Nf for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Mar 2008 07:04:08 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JgKcH-0007IR-Ib
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Mar 2008 07:04:07 -0700
Date: Mon, 31 Mar 2008 10:03:44 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080331140344.GB6540@c2.user-mode-linux.org>
References: <20080317153800.GA4450@mailshack.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080317153800.GA4450@mailshack.com>
Subject: Re: [uml-devel] [PATCH] uml compile fixes
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Alexander van Heukelum <heukelum@mailshack.com>
Cc: heukelum@fastmail.fm, user-mode-linux-devel@lists.sourceforge.net

On Mon, Mar 17, 2008 at 04:38:00PM +0100, Alexander van Heukelum wrote:
> CONFIG_SLOB=y

> Please review/comment (or create a better patch for this yourself!).

Try the one below - it's a bit larger, but perhaps cleaner and more
future-proof.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

Index: linux-2.6.22/arch/um/drivers/chan_user.c
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/chan_user.c	2008-03-31 10:01:02.000000000 -0400
+++ linux-2.6.22/arch/um/drivers/chan_user.c	2008-03-31 10:01:19.000000000 -0400
@@ -11,6 +11,7 @@
 #include <termios.h>
 #include <sys/ioctl.h>
 #include "chan_user.h"
+#include "kern_constants.h"
 #include "os.h"
 #include "um_malloc.h"
 #include "user.h"
Index: linux-2.6.22/arch/um/drivers/cow_sys.h
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/cow_sys.h	2008-03-31 10:01:02.000000000 -0400
+++ linux-2.6.22/arch/um/drivers/cow_sys.h	2008-03-31 10:01:19.000000000 -0400
@@ -8,7 +8,7 @@
 
 static inline void *cow_malloc(int size)
 {
-	return kmalloc(size, UM_GFP_KERNEL);
+	return uml_kmalloc(size, UM_GFP_KERNEL);
 }
 
 static inline void cow_free(void *ptr)
Index: linux-2.6.22/arch/um/drivers/daemon_user.c
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/daemon_user.c	2008-03-31 10:01:02.000000000 -0400
+++ linux-2.6.22/arch/um/drivers/daemon_user.c	2008-03-31 10:01:19.000000000 -0400
@@ -35,7 +35,7 @@ static struct sockaddr_un *new_addr(void
 {
 	struct sockaddr_un *sun;
 
-	sun = kmalloc(sizeof(struct sockaddr_un), UM_GFP_KERNEL);
+	sun = uml_kmalloc(sizeof(struct sockaddr_un), UM_GFP_KERNEL);
 	if (sun == NULL) {
 		printk(UM_KERN_ERR "new_addr: allocation of sockaddr_un "
 		       "failed\n");
@@ -84,7 +84,7 @@ static int connect_to_switch(struct daem
 		goto out_close;
 	}
 
-	sun = kmalloc(sizeof(struct sockaddr_un), UM_GFP_KERNEL);
+	sun = uml_kmalloc(sizeof(struct sockaddr_un), UM_GFP_KERNEL);
 	if (sun == NULL) {
 		printk(UM_KERN_ERR "new_addr: allocation of sockaddr_un "
 		       "failed\n");
Index: linux-2.6.22/arch/um/drivers/fd.c
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/fd.c	2008-03-31 10:01:02.000000000 -0400
+++ linux-2.6.22/arch/um/drivers/fd.c	2008-03-31 10:01:19.000000000 -0400
@@ -40,7 +40,7 @@ static void *fd_init(char *str, int devi
 		return NULL;
 	}
 
-	data = kmalloc(sizeof(*data), UM_GFP_KERNEL);
+	data = uml_kmalloc(sizeof(*data), UM_GFP_KERNEL);
 	if (data == NULL)
 		return NULL;
 
Index: linux-2.6.22/arch/um/drivers/mcast_user.c
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/mcast_user.c	2008-03-31 10:01:02.000000000 -0400
+++ linux-2.6.22/arch/um/drivers/mcast_user.c	2008-03-31 10:01:19.000000000 -0400
@@ -15,6 +15,7 @@
 #include <unistd.h>
 #include <errno.h>
 #include <netinet/in.h>
+#include "kern_constants.h"
 #include "mcast.h"
 #include "net_user.h"
 #include "um_malloc.h"
@@ -24,7 +25,7 @@ static struct sockaddr_in *new_addr(char
 {
 	struct sockaddr_in *sin;
 
-	sin = kmalloc(sizeof(struct sockaddr_in), UM_GFP_KERNEL);
+	sin = uml_kmalloc(sizeof(struct sockaddr_in), UM_GFP_KERNEL);
 	if (sin == NULL) {
 		printk(UM_KERN_ERR "new_addr: allocation of sockaddr_in "
 		       "failed\n");
Index: linux-2.6.22/arch/um/drivers/net_user.c
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/net_user.c	2008-03-31 10:01:02.000000000 -0400
+++ linux-2.6.22/arch/um/drivers/net_user.c	2008-03-31 10:01:19.000000000 -0400
@@ -222,7 +222,7 @@ static void change(char *dev, char *what
 		netmask[2], netmask[3]);
 
 	output_len = UM_KERN_PAGE_SIZE;
-	output = kmalloc(output_len, UM_GFP_KERNEL);
+	output = uml_kmalloc(output_len, UM_GFP_KERNEL);
 	if (output == NULL)
 		printk(UM_KERN_ERR "change : failed to allocate output "
 		       "buffer\n");
Index: linux-2.6.22/arch/um/drivers/port_user.c
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/port_user.c	2008-03-31 10:01:02.000000000 -0400
+++ linux-2.6.22/arch/um/drivers/port_user.c	2008-03-31 10:01:19.000000000 -0400
@@ -47,7 +47,7 @@ static void *port_init(char *str, int de
 	if (kern_data == NULL)
 		return NULL;
 
-	data = kmalloc(sizeof(*data), UM_GFP_KERNEL);
+	data = uml_kmalloc(sizeof(*data), UM_GFP_KERNEL);
 	if (data == NULL)
 		goto err;
 
Index: linux-2.6.22/arch/um/drivers/pty.c
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/pty.c	2008-03-31 10:01:02.000000000 -0400
+++ linux-2.6.22/arch/um/drivers/pty.c	2008-03-31 10:01:19.000000000 -0400
@@ -29,7 +29,7 @@ static void *pty_chan_init(char *str, in
 {
 	struct pty_chan *data;
 
-	data = kmalloc(sizeof(*data), UM_GFP_KERNEL);
+	data = uml_kmalloc(sizeof(*data), UM_GFP_KERNEL);
 	if (data == NULL)
 		return NULL;
 
Index: linux-2.6.22/arch/um/drivers/slip_user.c
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/slip_user.c	2008-03-31 10:01:02.000000000 -0400
+++ linux-2.6.22/arch/um/drivers/slip_user.c	2008-03-31 10:01:19.000000000 -0400
@@ -96,7 +96,7 @@ static int slip_tramp(char **argv, int f
 	pid = err;
 
 	output_len = UM_KERN_PAGE_SIZE;
-	output = kmalloc(output_len, UM_GFP_KERNEL);
+	output = uml_kmalloc(output_len, UM_GFP_KERNEL);
 	if (output == NULL) {
 		printk(UM_KERN_ERR "slip_tramp : failed to allocate output "
 		       "buffer\n");
Index: linux-2.6.22/arch/um/drivers/tty.c
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/tty.c	2008-03-31 10:01:02.000000000 -0400
+++ linux-2.6.22/arch/um/drivers/tty.c	2008-03-31 10:01:19.000000000 -0400
@@ -29,7 +29,7 @@ static void *tty_chan_init(char *str, in
 	}
 	str++;
 
-	data = kmalloc(sizeof(*data), UM_GFP_KERNEL);
+	data = uml_kmalloc(sizeof(*data), UM_GFP_KERNEL);
 	if (data == NULL)
 		return NULL;
 	*data = ((struct tty_chan) { .dev 	= str,
Index: linux-2.6.22/arch/um/drivers/xterm.c
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/xterm.c	2008-03-31 10:01:02.000000000 -0400
+++ linux-2.6.22/arch/um/drivers/xterm.c	2008-03-31 10:01:19.000000000 -0400
@@ -30,7 +30,7 @@ static void *xterm_init(char *str, int d
 {
 	struct xterm_chan *data;
 
-	data = kmalloc(sizeof(*data), UM_GFP_KERNEL);
+	data = uml_kmalloc(sizeof(*data), UM_GFP_KERNEL);
 	if (data == NULL)
 		return NULL;
 	*data = ((struct xterm_chan) { .pid 		= -1,
Index: linux-2.6.22/arch/um/include/um_malloc.h
===================================================================
--- linux-2.6.22.orig/arch/um/include/um_malloc.h	2008-03-31 10:01:02.000000000 -0400
+++ linux-2.6.22/arch/um/include/um_malloc.h	2008-03-31 10:01:19.000000000 -0400
@@ -8,15 +8,12 @@
 
 #include "kern_constants.h"
 
-extern void *__kmalloc(int size, int flags);
-static inline void *kmalloc(int size, int flags)
-{
-	return __kmalloc(size, flags);
-}
-
+extern void *uml_kmalloc(int size, int flags);
 extern void kfree(const void *ptr);
 
 extern void *vmalloc(unsigned long size);
 extern void vfree(void *ptr);
 
 #endif /* __UM_MALLOC_H__ */
+
+
Index: linux-2.6.22/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/mem.c	2008-03-31 10:01:02.000000000 -0400
+++ linux-2.6.22/arch/um/kernel/mem.c	2008-03-31 10:01:19.000000000 -0400
@@ -375,3 +375,8 @@ pmd_t *pmd_alloc_one(struct mm_struct *m
 	return pmd;
 }
 #endif
+
+void *uml_kmalloc(int size, int flags)
+{
+	return kmalloc(size, flags);
+}
Index: linux-2.6.22/arch/um/os-Linux/drivers/ethertap_user.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/drivers/ethertap_user.c	2008-03-31 10:01:02.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/drivers/ethertap_user.c	2008-03-31 10:01:19.000000000 -0400
@@ -52,7 +52,7 @@ static void etap_change(int op, unsigned
 		return;
 	}
 
-	output = kmalloc(UM_KERN_PAGE_SIZE, UM_GFP_KERNEL);
+	output = uml_kmalloc(UM_KERN_PAGE_SIZE, UM_GFP_KERNEL);
 	if (output == NULL)
 		printk(UM_KERN_ERR "etap_change : Failed to allocate output "
 		       "buffer\n");
@@ -165,7 +165,7 @@ static int etap_open(void *data)
 	err = etap_tramp(pri->dev_name, pri->gate_addr, control_fds[0],
 			 control_fds[1], data_fds[0], data_fds[1]);
 	output_len = UM_KERN_PAGE_SIZE;
-	output = kmalloc(output_len, UM_GFP_KERNEL);
+	output = uml_kmalloc(output_len, UM_GFP_KERNEL);
 	read_output(control_fds[0], output, output_len);
 
 	if (output == NULL)
Index: linux-2.6.22/arch/um/os-Linux/helper.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/helper.c	2008-03-31 10:01:02.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/helper.c	2008-03-31 10:01:19.000000000 -0400
@@ -70,8 +70,8 @@ int run_helper(void (*pre_exec)(void *),
 	data.pre_data = pre_data;
 	data.argv = argv;
 	data.fd = fds[1];
-	data.buf = __cant_sleep() ? kmalloc(PATH_MAX, UM_GFP_ATOMIC) :
-					kmalloc(PATH_MAX, UM_GFP_KERNEL);
+	data.buf = __cant_sleep() ? uml_kmalloc(PATH_MAX, UM_GFP_ATOMIC) :
+					uml_kmalloc(PATH_MAX, UM_GFP_KERNEL);
 	pid = clone(helper_child, (void *) sp, CLONE_VM, &data);
 	if (pid < 0) {
 		ret = -errno;
Index: linux-2.6.22/arch/um/os-Linux/main.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/main.c	2008-03-31 10:01:02.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/main.c	2008-03-31 10:01:19.000000000 -0400
@@ -199,7 +199,7 @@ void *__wrap_malloc(int size)
 		return __real_malloc(size);
 	else if (size <= UM_KERN_PAGE_SIZE)
 		/* finding contiguous pages can be hard*/
-		ret = kmalloc(size, UM_GFP_KERNEL);
+		ret = uml_kmalloc(size, UM_GFP_KERNEL);
 	else ret = vmalloc(size);
 
 	/*
Index: linux-2.6.22/arch/um/os-Linux/sigio.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/sigio.c	2008-03-31 10:01:02.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/sigio.c	2008-03-31 10:02:05.000000000 -0400
@@ -109,7 +109,7 @@ static int need_poll(struct pollfds *pol
 	if (n <= polls->size)
 		return 0;
 
-	new = kmalloc(n * sizeof(struct pollfd), UM_GFP_ATOMIC);
+	new = uml_kmalloc(n * sizeof(struct pollfd), UM_GFP_ATOMIC);
 	if (new == NULL) {
 		printk(UM_KERN_ERR "need_poll : failed to allocate new "
 		       "pollfds\n");
@@ -243,7 +243,7 @@ static struct pollfd *setup_initial_poll
 {
 	struct pollfd *p;
 
-	p = kmalloc(sizeof(struct pollfd), UM_GFP_KERNEL);
+	p = uml_kmalloc(sizeof(struct pollfd), UM_GFP_KERNEL);
 	if (p == NULL) {
 		printk(UM_KERN_ERR "setup_initial_poll : failed to allocate "
 		       "poll\n");

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
