Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H1TCs-0005oJ-Of for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Jan 2007 11:52:26 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H1TCr-0004yj-Vp
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Jan 2007 11:52:26 -0800
Message-Id: <200701011947.l01JlDfu020776@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 01 Jan 2007 14:47:13 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 7/8] UML - port driver formatting
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

Whitespace and style fixes.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/drivers/port_kern.c |   46 +++++++++++++++++++--------------------
 arch/um/drivers/port_user.c |   51 +++++++++++++++++---------------------------
 2 files changed, 43 insertions(+), 54 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/port_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/port_kern.c	2007-01-01 13:28:27.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/port_kern.c	2007-01-01 13:29:38.000000000 -0500
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2001, 2002 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -55,9 +55,9 @@ static irqreturn_t pipe_interrupt(int ir
 	fd = os_rcv_fd(conn->socket[0], &conn->helper_pid);
 	if(fd < 0){
 		if(fd == -EAGAIN)
-			return(IRQ_NONE);
+			return IRQ_NONE;
 
-		printk(KERN_ERR "pipe_interrupt : os_rcv_fd returned %d\n", 
+		printk(KERN_ERR "pipe_interrupt : os_rcv_fd returned %d\n",
 		       -fd);
 		os_close_file(conn->fd);
 	}
@@ -68,7 +68,7 @@ static irqreturn_t pipe_interrupt(int ir
 	list_add(&conn->list, &conn->port->connections);
 
 	complete(&conn->port->done);
-	return(IRQ_HANDLED);
+	return IRQ_HANDLED;
 }
 
 #define NO_WAITER_MSG \
@@ -97,14 +97,14 @@ static int port_accept(struct port_list 
 		       "connection\n");
 		goto out_close;
 	}
-	*conn = ((struct connection) 
+	*conn = ((struct connection)
 		{ .list 	= LIST_HEAD_INIT(conn->list),
 		  .fd 		= fd,
 		  .socket  	= { socket[0], socket[1] },
 		  .telnetd_pid 	= pid,
 		  .port 	= port });
 
-	if(um_request_irq(TELNETD_IRQ, socket[0], IRQ_READ, pipe_interrupt, 
+	if(um_request_irq(TELNETD_IRQ, socket[0], IRQ_READ, pipe_interrupt,
 			  IRQF_DISABLED | IRQF_SHARED | IRQF_SAMPLE_RANDOM,
 			  "telnetd", conn)){
 		printk(KERN_ERR "port_accept : failed to get IRQ for "
@@ -117,17 +117,17 @@ static int port_accept(struct port_list 
 		printk("No one waiting for port\n");
 	}
 	list_add(&conn->list, &port->pending);
-	return(1);
+	return 1;
 
  out_free:
 	kfree(conn);
  out_close:
 	os_close_file(fd);
-	if(pid != -1) 
+	if(pid != -1)
 		os_kill_process(pid, 1);
  out:
-	return(ret);
-} 
+	return ret;
+}
 
 static DECLARE_MUTEX(ports_sem);
 static struct list_head ports = LIST_HEAD_INIT(ports);
@@ -158,8 +158,8 @@ static irqreturn_t port_interrupt(int ir
 
 	port->has_connection = 1;
 	schedule_work(&port_work);
-	return(IRQ_HANDLED);
-} 
+	return IRQ_HANDLED;
+}
 
 void *port_data(int port_num)
 {
@@ -185,14 +185,14 @@ void *port_data(int port_num)
 		       port_num, -fd);
 		goto out_free;
 	}
-	if(um_request_irq(ACCEPT_IRQ, fd, IRQ_READ, port_interrupt, 
-			  IRQF_DISABLED | IRQF_SHARED | IRQF_SAMPLE_RANDOM, "port",
-			  port)){
+	if(um_request_irq(ACCEPT_IRQ, fd, IRQ_READ, port_interrupt,
+			  IRQF_DISABLED | IRQF_SHARED | IRQF_SAMPLE_RANDOM,
+			  "port", port)){
 		printk(KERN_ERR "Failed to get IRQ for port %d\n", port_num);
 		goto out_close;
 	}
 
-	*port = ((struct port_list) 
+	*port = ((struct port_list)
 		{ .list 	 	= LIST_HEAD_INIT(port->list),
 		  .wait_count		= ATOMIC_INIT(0),
 		  .has_connection 	= 0,
@@ -222,7 +222,7 @@ void *port_data(int port_num)
 	os_close_file(fd);
  out:
 	up(&ports_sem);
-	return(dev);
+	return dev;
 }
 
 int port_wait(void *data)
@@ -232,15 +232,15 @@ int port_wait(void *data)
 	struct port_list *port = dev->port;
 	int fd;
 
-        atomic_inc(&port->wait_count);
+	atomic_inc(&port->wait_count);
 	while(1){
 		fd = -ERESTARTSYS;
-                if(wait_for_completion_interruptible(&port->done))
-                        goto out;
+		if(wait_for_completion_interruptible(&port->done))
+			goto out;
 
 		spin_lock(&port->lock);
 
-		conn = list_entry(port->connections.next, struct connection, 
+		conn = list_entry(port->connections.next, struct connection,
 				  list);
 		list_del(&conn->list);
 		spin_unlock(&port->lock);
@@ -248,12 +248,12 @@ int port_wait(void *data)
 		os_shutdown_socket(conn->socket[0], 1, 1);
 		os_close_file(conn->socket[0]);
 		os_shutdown_socket(conn->socket[1], 1, 1);
-		os_close_file(conn->socket[1]);	
+		os_close_file(conn->socket[1]);
 
 		/* This is done here because freeing an IRQ can't be done
 		 * within the IRQ handler.  So, pipe_interrupt always ups
 		 * the semaphore regardless of whether it got a successful
-		 * connection.  Then we loop here throwing out failed 
+		 * connection.  Then we loop here throwing out failed
 		 * connections until a good one is found.
 		 */
 		free_irq(TELNETD_IRQ, conn);
Index: linux-2.6.18-mm/arch/um/drivers/port_user.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/port_user.c	2007-01-01 11:32:21.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/port_user.c	2007-01-01 13:29:38.000000000 -0500
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2001 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -38,18 +38,18 @@ static void *port_init(char *str, int de
 	if(*str != ':'){
 		printk("port_init : channel type 'port' must specify a "
 		       "port number\n");
-		return(NULL);
+		return NULL;
 	}
 	str++;
 	port = strtoul(str, &end, 0);
 	if((*end != '\0') || (end == str)){
 		printk("port_init : couldn't parse port '%s'\n", str);
-		return(NULL);
+		return NULL;
 	}
 
 	kern_data = port_data(port);
 	if(kern_data == NULL)
-		return(NULL);
+		return NULL;
 
 	data = um_kmalloc(sizeof(*data));
 	if(data == NULL)
@@ -59,10 +59,10 @@ static void *port_init(char *str, int de
 				      .kernel_data 	= kern_data });
 	sprintf(data->dev, "%d", port);
 
-	return(data);
+	return data;
  err:
 	port_kern_free(kern_data);
-	return(NULL);
+	return NULL;
 }
 
 static void port_free(void *d)
@@ -83,14 +83,14 @@ static int port_open(int input, int outp
 	if((fd >= 0) && data->raw){
 		CATCH_EINTR(err = tcgetattr(fd, &data->tt));
 		if(err)
-			return(err);
+			return err;
 
 		err = raw(fd);
 		if(err)
-			return(err);
+			return err;
 	}
 	*dev_out = data->dev;
-	return(fd);
+	return fd;
 }
 
 static void port_close(int fd, void *d)
@@ -120,8 +120,8 @@ int port_listen_fd(int port)
 	int fd, err, arg;
 
 	fd = socket(PF_INET, SOCK_STREAM, 0);
-	if(fd == -1) 
-		return(-errno);
+	if(fd == -1)
+		return -errno;
 
 	arg = 1;
 	if(setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &arg, sizeof(arg)) < 0){
@@ -136,7 +136,7 @@ int port_listen_fd(int port)
 		err = -errno;
 		goto out;
 	}
-  
+
 	if(listen(fd, 1) < 0){
 		err = -errno;
 		goto out;
@@ -146,10 +146,10 @@ int port_listen_fd(int port)
 	if(err < 0)
 		goto out;
 
-	return(fd);
+	return fd;
  out:
 	os_close_file(fd);
-	return(err);
+	return err;
 }
 
 struct port_pre_exec_data {
@@ -173,13 +173,13 @@ void port_pre_exec(void *arg)
 int port_connection(int fd, int *socket, int *pid_out)
 {
 	int new, err;
-	char *argv[] = { "/usr/sbin/in.telnetd", "-L", 
+	char *argv[] = { "/usr/sbin/in.telnetd", "-L",
 			 "/usr/lib/uml/port-helper", NULL };
 	struct port_pre_exec_data data;
 
 	new = os_accept_connection(fd);
 	if(new < 0)
-		return(new);
+		return new;
 
 	err = os_pipe(socket, 0, 0);
 	if(err < 0)
@@ -190,29 +190,18 @@ int port_connection(int fd, int *socket,
 		  .pipe_fd 		= socket[1] });
 
 	err = run_helper(port_pre_exec, &data, argv, NULL);
-	if(err < 0) 
+	if(err < 0)
 		goto out_shutdown;
 
 	*pid_out = err;
-	return(new);
+	return new;
 
  out_shutdown:
 	os_shutdown_socket(socket[0], 1, 1);
 	os_close_file(socket[0]);
-	os_shutdown_socket(socket[1], 1, 1);	
+	os_shutdown_socket(socket[1], 1, 1);
 	os_close_file(socket[1]);
  out_close:
 	os_close_file(new);
-	return(err);
+	return err;
 }
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


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
