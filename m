Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbTHu-0006Pe-9p	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 18:05:22 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DbTHr-0006sd-At	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 18:05:21 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050527003926.1FD861AEE92@zion.home.lan>
Subject: [uml-devel] [patch 1/1] [RFC] uml: add and use generic
	hw_controller_type->release
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
Date: Fri, 27 May 2005 02:39:26 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, cw@f00f.org, mingo@redhat.com


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Chris Wedgwood <cw@f00f.org>
CC: Ingo Molnar <mingo@redhat.com>

Currently UML must explicitly call the UML-specific free_irq_by_irq_and_dev()
for each free_irq call it's done.

This is needed because ->shutdown and/or ->disable are only called when the
last "action" for that irq is removed.

Instead, for UML shared IRQs (UML IRQs are very often, if not always, shared),
for each dev_id some setup is done, which must be cleared on the release of
that fd. For instance, for each open console a new instance (i.e. new dev_id)
of the same IRQ is requested().

Exactly, a fd is stored in an array (pollfds), which is after read by a host
thread and passed to poll(). Each event registered by poll() triggers an
interrupt. So, for each free_irq() we must remove the corresponding host fd
from the table, which we do via this -release() method.

In this patch we add an appropriate hook for this, and remove all uses of it
by pointing the hook to the said procedure; this is safe to do since the said
procedure.

Also some cosmetic improvements are included.

This is heavily based on some work by Chris Wedgwood, which however didn't get
the patch merged for something I'd call a "misunderstanding" (the need for
this patch wasn't cleanly explained, thus adding the generic hook was felt as
undesirable).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/drivers/line.c       |    2 --
 linux-2.6.git-paolo/arch/um/drivers/net_kern.c   |    1 -
 linux-2.6.git-paolo/arch/um/drivers/port_kern.c  |    1 -
 linux-2.6.git-paolo/arch/um/drivers/xterm_kern.c |    1 -
 linux-2.6.git-paolo/arch/um/kernel/irq.c         |   11 +++++++----
 linux-2.6.git-paolo/arch/um/kernel/irq_user.c    |    2 --
 linux-2.6.git-paolo/include/linux/irq.h          |    1 +
 linux-2.6.git-paolo/kernel/irq/manage.c          |    4 ++++
 8 files changed, 12 insertions(+), 11 deletions(-)

diff -puN kernel/irq/manage.c~uml-gen-irq-release kernel/irq/manage.c
--- linux-2.6.git/kernel/irq/manage.c~uml-gen-irq-release	2005-05-25 01:15:46.000000000 +0200
+++ linux-2.6.git-paolo/kernel/irq/manage.c	2005-05-25 01:15:46.000000000 +0200
@@ -255,6 +255,10 @@ void free_irq(unsigned int irq, void *de
 
 			/* Found it - now remove it from the list of entries */
 			*pp = action->next;
+
+			if (desc->handler->release)
+				desc->handler->release(irq, dev_id);
+
 			if (!desc->action) {
 				desc->status |= IRQ_DISABLED;
 				if (desc->handler->shutdown)
diff -puN include/linux/irq.h~uml-gen-irq-release include/linux/irq.h
--- linux-2.6.git/include/linux/irq.h~uml-gen-irq-release	2005-05-25 01:15:46.000000000 +0200
+++ linux-2.6.git-paolo/include/linux/irq.h	2005-05-25 01:15:46.000000000 +0200
@@ -47,6 +47,7 @@ struct hw_interrupt_type {
 	void (*ack)(unsigned int irq);
 	void (*end)(unsigned int irq);
 	void (*set_affinity)(unsigned int irq, cpumask_t dest);
+	void (*release)(unsigned int irq, void *dev_id);
 };
 
 typedef struct hw_interrupt_type  hw_irq_controller;
diff -puN arch/um/kernel/irq_user.c~uml-gen-irq-release arch/um/kernel/irq_user.c
--- linux-2.6.git/arch/um/kernel/irq_user.c~uml-gen-irq-release	2005-05-25 01:15:46.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/irq_user.c	2005-05-25 01:15:46.000000000 +0200
@@ -85,8 +85,6 @@ void sigio_handler(int sig, union uml_pt
 				next = irq_fd->next;
 				if(irq_fd->freed){
 					free_irq(irq_fd->irq, irq_fd->id);
-					free_irq_by_irq_and_dev(irq_fd->irq,
-								irq_fd->id);
 				}
 			}
 		}
diff -puN arch/um/drivers/net_kern.c~uml-gen-irq-release arch/um/drivers/net_kern.c
--- linux-2.6.git/arch/um/drivers/net_kern.c~uml-gen-irq-release	2005-05-25 01:15:46.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/drivers/net_kern.c	2005-05-25 01:15:46.000000000 +0200
@@ -146,7 +146,6 @@ static int uml_net_close(struct net_devi
 	netif_stop_queue(dev);
 	spin_lock(&lp->lock);
 
-	free_irq_by_irq_and_dev(dev->irq, dev);
 	free_irq(dev->irq, dev);
 	if(lp->close != NULL)
 		(*lp->close)(lp->fd, &lp->user);
diff -puN arch/um/drivers/xterm_kern.c~uml-gen-irq-release arch/um/drivers/xterm_kern.c
--- linux-2.6.git/arch/um/drivers/xterm_kern.c~uml-gen-irq-release	2005-05-25 01:15:46.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/drivers/xterm_kern.c	2005-05-25 01:15:46.000000000 +0200
@@ -69,7 +69,6 @@ int xterm_fd(int socket, int *pid_out)
 	 * isn't set) this will hang... */
 	wait_for_completion(&data->ready);
 
-	free_irq_by_irq_and_dev(XTERM_IRQ, data);
 	free_irq(XTERM_IRQ, data);
 
 	ret = data->new_fd;
diff -puN arch/um/drivers/port_kern.c~uml-gen-irq-release arch/um/drivers/port_kern.c
--- linux-2.6.git/arch/um/drivers/port_kern.c~uml-gen-irq-release	2005-05-25 01:15:46.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/drivers/port_kern.c	2005-05-25 01:15:46.000000000 +0200
@@ -257,7 +257,6 @@ int port_wait(void *data)
 		 * connection.  Then we loop here throwing out failed 
 		 * connections until a good one is found.
 		 */
-		free_irq_by_irq_and_dev(TELNETD_IRQ, conn);
 		free_irq(TELNETD_IRQ, conn);
 
 		if(conn->fd >= 0) break;
diff -puN arch/um/drivers/line.c~uml-gen-irq-release arch/um/drivers/line.c
--- linux-2.6.git/arch/um/drivers/line.c~uml-gen-irq-release	2005-05-25 01:15:46.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/drivers/line.c	2005-05-25 01:15:46.000000000 +0200
@@ -406,14 +406,12 @@ void line_disable(struct tty_struct *tty
 	if(line->driver->read_irq == current_irq)
 		free_irq_later(line->driver->read_irq, tty);
 	else {
-		free_irq_by_irq_and_dev(line->driver->read_irq, tty);
 		free_irq(line->driver->read_irq, tty);
 	}
 
 	if(line->driver->write_irq == current_irq)
 		free_irq_later(line->driver->write_irq, tty);
 	else {
-		free_irq_by_irq_and_dev(line->driver->write_irq, tty);
 		free_irq(line->driver->write_irq, tty);
 	}
 
diff -puN arch/um/include/irq_user.h~uml-gen-irq-release arch/um/include/irq_user.h
diff -puN arch/um/kernel/irq.c~uml-gen-irq-release arch/um/kernel/irq.c
--- linux-2.6.git/arch/um/kernel/irq.c~uml-gen-irq-release	2005-05-25 01:15:46.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/irq.c	2005-05-25 01:15:46.000000000 +0200
@@ -124,14 +124,16 @@ void irq_unlock(unsigned long flags)
 	spin_unlock_irqrestore(&irq_spinlock, flags);
 }
 
-/*  presently hw_interrupt_type must define (startup || enable) &&
- *  disable && end */
+/* hw_interrupt_type must define (startup || enable) &&
+ * (shutdown || disable) && end */
 static void dummy(unsigned int irq)
 {
 }
 
-static struct hw_interrupt_type SIGIO_irq_type = {
+/* This is used for everything else than the timer. */
+static struct hw_interrupt_type normal_irq_type = {
 	.typename = "SIGIO",
+	.release = free_irq_by_irq_and_dev,
 	.disable = dummy,
 	.enable = dummy,
 	.ack = dummy,
@@ -140,6 +142,7 @@ static struct hw_interrupt_type SIGIO_ir
 
 static struct hw_interrupt_type SIGVTALRM_irq_type = {
 	.typename = "SIGVTALRM",
+	.release = free_irq_by_irq_and_dev,
 	.shutdown = dummy, /* never called */
 	.disable = dummy,
 	.enable = dummy,
@@ -160,7 +163,7 @@ void __init init_IRQ(void)
 		irq_desc[i].status = IRQ_DISABLED;
 		irq_desc[i].action = NULL;
 		irq_desc[i].depth = 1;
-		irq_desc[i].handler = &SIGIO_irq_type;
+		irq_desc[i].handler = &normal_irq_type;
 		enable_irq(i);
 	}
 }
_


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
