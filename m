Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9As1-0000mu-7s for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 15:45:41 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D9As0-0006vb-Is for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 15:45:41 -0800
Message-Id: <200503100216.j2A2G6DN015238@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 5/9] UML - change semaphores to completions
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
Date: Wed, 09 Mar 2005 21:16:06 -0500
To: torvalds@osdl.org
Cc: simlo@phys.au.dk, akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Esben Nielsen <simlo at phys au dk>

One of the problems was use of direct architecture specific semaphores
(which doesn't work under PREEMPT_REALTIME) and in places where a quick
(maybe too quick) look at the code told me that completions ought to be
used. Therefore I changed two semaphores to completions which compiled
fine. I have tried the change on 2.6.11-rc2, and it seemed to work, but I
have not tested it heavily.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/drivers/port_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/port_kern.c	2005-03-08 20:17:34.000000000 -0500
+++ linux-2.6.11/arch/um/drivers/port_kern.c	2005-03-08 22:16:48.000000000 -0500
@@ -25,7 +25,7 @@
 	struct list_head list;
 	atomic_t wait_count;
 	int has_connection;
-	struct semaphore sem;
+	struct completion done;
 	int port;
 	int fd;
 	spinlock_t lock;
@@ -68,7 +68,7 @@
 	conn->fd = fd;
 	list_add(&conn->list, &conn->port->connections);
 
-	up(&conn->port->sem);
+	complete(&conn->port->done);
 	return(IRQ_HANDLED);
 }
 
@@ -197,13 +197,14 @@
 		{ .list 	 	= LIST_HEAD_INIT(port->list),
 		  .wait_count		= ATOMIC_INIT(0),
 		  .has_connection 	= 0,
-		  .sem 			= __SEMAPHORE_INITIALIZER(port->sem, 
-								  0),
 		  .lock 		= SPIN_LOCK_UNLOCKED,
 		  .port 	 	= port_num,
 		  .fd  			= fd,
 		  .pending 		= LIST_HEAD_INIT(port->pending),
 		  .connections 		= LIST_HEAD_INIT(port->connections) });
+
+	init_completion(&port->done), 
+
 	list_add(&port->list, &ports);
 
  found:
@@ -237,7 +238,7 @@
         atomic_inc(&port->wait_count);
 	while(1){
 		fd = -ERESTARTSYS;
-		if(down_interruptible(&port->sem))
+                if(wait_for_completion_interruptible(&port->done))
                         goto out;
 
 		spin_lock(&port->lock);
@@ -308,14 +309,3 @@
 }
 
 __uml_exitcall(free_port);
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
Index: linux-2.6.11/arch/um/drivers/xterm_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/xterm_kern.c	2005-03-08 20:17:34.000000000 -0500
+++ linux-2.6.11/arch/um/drivers/xterm_kern.c	2005-03-08 22:16:48.000000000 -0500
@@ -16,7 +16,7 @@
 #include "xterm.h"
 
 struct xterm_wait {
-	struct semaphore sem;
+	struct completion ready;
 	int fd;
 	int pid;
 	int new_fd;
@@ -32,7 +32,7 @@
 		return(IRQ_NONE);
 
 	xterm->new_fd = fd;
-	up(&xterm->sem);
+	complete(&xterm->ready);
 	return(IRQ_HANDLED);
 }
 
@@ -49,10 +49,10 @@
 
 	/* This is a locked semaphore... */
 	*data = ((struct xterm_wait) 
-		{ .sem  	= __SEMAPHORE_INITIALIZER(data->sem, 0),
-		  .fd 		= socket,
+		{ .fd 		= socket,
 		  .pid 		= -1,
 		  .new_fd 	= -1 });
+	init_completion(&data->ready);
 
 	err = um_request_irq(XTERM_IRQ, socket, IRQ_READ, xterm_interrupt, 
 			     SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM, 
@@ -68,7 +68,7 @@
 	 *
 	 * XXX Note, if the xterm doesn't work for some reason (eg. DISPLAY
 	 * isn't set) this will hang... */
-	down(&data->sem);
+	wait_for_completion(&data->ready);
 
 	free_irq_by_irq_and_dev(XTERM_IRQ, data);
 	free_irq(XTERM_IRQ, data);



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
