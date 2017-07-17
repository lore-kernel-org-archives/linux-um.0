Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1dX0DA-0007qu-DX
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Jul 2017 07:12:56 +0000
Received: from ivanoab5.miniserver.com ([78.31.111.25]
	helo=www.kot-begemot.co.uk)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1dX0D8-0003gF-3D
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Jul 2017 07:12:56 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Mon, 17 Jul 2017 07:29:09 +0100
Message-Id: <20170717062911.26576-2-anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <20170717062911.26576-1-anton.ivanov@kot-begemot.co.uk>
References: <20170717062911.26576-1-anton.ivanov@kot-begemot.co.uk>
Subject: [uml-devel] [PATCH 1/3] Epoll based IRQ controller
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

1. Removes the need to walk the IRQ/Device list to determine
who triggered the IRQ.
2. Improves scalability (up to several times performance
improvement for cases with 10s of devices).
3. Improves UML baseline IO performance for one disk + one NIC
use case by up to 10%.
4. Introduces write poll triggered IRQs.
5. Prerequisite for introducing high performance mmesg family
of functions in network IO.
6. Fixes RNG shutdown which was leaking a file descriptor

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/chan_kern.c       |  53 +----
 arch/um/drivers/line.c            |   2 +-
 arch/um/drivers/random.c          |  11 +-
 arch/um/drivers/ubd_kern.c        |   4 +-
 arch/um/include/shared/irq_user.h |  12 +-
 arch/um/include/shared/os.h       |  17 +-
 arch/um/kernel/irq.c              | 460 ++++++++++++++++++++++++--------------
 arch/um/os-Linux/irq.c            | 202 +++++++++--------
 8 files changed, 444 insertions(+), 317 deletions(-)

diff --git a/arch/um/drivers/chan_kern.c b/arch/um/drivers/chan_kern.c
index acbe6c67afba..05588f9466c7 100644
--- a/arch/um/drivers/chan_kern.c
+++ b/arch/um/drivers/chan_kern.c
@@ -171,56 +171,19 @@ int enable_chan(struct line *line)
 	return err;
 }
 
-/* Items are added in IRQ context, when free_irq can't be called, and
- * removed in process context, when it can.
- * This handles interrupt sources which disappear, and which need to
- * be permanently disabled.  This is discovered in IRQ context, but
- * the freeing of the IRQ must be done later.
- */
-static DEFINE_SPINLOCK(irqs_to_free_lock);
-static LIST_HEAD(irqs_to_free);
-
-void free_irqs(void)
-{
-	struct chan *chan;
-	LIST_HEAD(list);
-	struct list_head *ele;
-	unsigned long flags;
-
-	spin_lock_irqsave(&irqs_to_free_lock, flags);
-	list_splice_init(&irqs_to_free, &list);
-	spin_unlock_irqrestore(&irqs_to_free_lock, flags);
-
-	list_for_each(ele, &list) {
-		chan = list_entry(ele, struct chan, free_list);
-
-		if (chan->input && chan->enabled)
-			um_free_irq(chan->line->driver->read_irq, chan);
-		if (chan->output && chan->enabled)
-			um_free_irq(chan->line->driver->write_irq, chan);
-		chan->enabled = 0;
-	}
-}
-
 static void close_one_chan(struct chan *chan, int delay_free_irq)
 {
-	unsigned long flags;
-
 	if (!chan->opened)
 		return;
 
-	if (delay_free_irq) {
-		spin_lock_irqsave(&irqs_to_free_lock, flags);
-		list_add(&chan->free_list, &irqs_to_free);
-		spin_unlock_irqrestore(&irqs_to_free_lock, flags);
-	}
-	else {
-		if (chan->input && chan->enabled)
-			um_free_irq(chan->line->driver->read_irq, chan);
-		if (chan->output && chan->enabled)
-			um_free_irq(chan->line->driver->write_irq, chan);
-		chan->enabled = 0;
-	}
+    /* we can safely call free now - it will be marked
+     *  as free and freed once the IRQ stopped processing
+     */
+	if (chan->input && chan->enabled)
+		um_free_irq(chan->line->driver->read_irq, chan);
+	if (chan->output && chan->enabled)
+		um_free_irq(chan->line->driver->write_irq, chan);
+	chan->enabled = 0;
 	if (chan->ops->close != NULL)
 		(*chan->ops->close)(chan->fd, chan->data);
 
diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 366e57f5e8d6..8d80b27502e6 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -284,7 +284,7 @@ int line_setup_irq(int fd, int input, int output, struct line *line, void *data)
 	if (err)
 		return err;
 	if (output)
-		err = um_request_irq(driver->write_irq, fd, IRQ_WRITE,
+		err = um_request_irq(driver->write_irq, fd, IRQ_NONE,
 				     line_write_interrupt, IRQF_SHARED,
 				     driver->write_irq_name, data);
 	return err;
diff --git a/arch/um/drivers/random.c b/arch/um/drivers/random.c
index 37c51a6be690..f0a222b19e5f 100644
--- a/arch/um/drivers/random.c
+++ b/arch/um/drivers/random.c
@@ -13,6 +13,7 @@
 #include <linux/miscdevice.h>
 #include <linux/delay.h>
 #include <linux/uaccess.h>
+#include <init.h>
 #include <irq_kern.h>
 #include <os.h>
 
@@ -154,14 +155,22 @@ static int __init rng_init (void)
 /*
  * rng_cleanup - shutdown RNG module
  */
-static void __exit rng_cleanup (void)
+
+static void cleanup(void)
 {
+	free_irq_by_fd(random_fd);
+	os_close_file(random_fd);
+}
+
+static void __exit rng_cleanup (void)
+{	
 	os_close_file(random_fd);
 	misc_deregister (&rng_miscdev);
 }
 
 module_init (rng_init);
 module_exit (rng_cleanup);
+__uml_exitcall(cleanup);
 
 MODULE_DESCRIPTION("UML Host Random Number Generator (RNG) driver");
 MODULE_LICENSE("GPL");
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 85410279beab..9c3e1c1133c4 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1587,11 +1587,11 @@ int io_thread(void *arg)
 
 		do {
 			res = os_write_file(kernel_fd, ((char *) io_req_buffer) + written, n);
-			if (res > 0) {
+			if (res >= 0) {
 				written += res;
 			} else {
 				if (res != -EAGAIN) {
-					printk("io_thread - read failed, fd = %d, "
+					printk("io_thread - write failed, fd = %d, "
 					       "err = %d\n", kernel_fd, -n);
 				}
 			}
diff --git a/arch/um/include/shared/irq_user.h b/arch/um/include/shared/irq_user.h
index df5633053957..a7a6120f19d5 100644
--- a/arch/um/include/shared/irq_user.h
+++ b/arch/um/include/shared/irq_user.h
@@ -7,6 +7,7 @@
 #define __IRQ_USER_H__
 
 #include <sysdep/ptrace.h>
+#include <stdbool.h>
 
 struct irq_fd {
 	struct irq_fd *next;
@@ -15,10 +16,17 @@ struct irq_fd {
 	int type;
 	int irq;
 	int events;
-	int current_events;
+	bool active;
+	bool pending;
+	bool purge;
 };
 
-enum { IRQ_READ, IRQ_WRITE };
+#define IRQ_READ  0
+#define IRQ_WRITE 1
+#define IRQ_NONE 2
+#define MAX_IRQ_TYPE (IRQ_NONE + 1)
+
+
 
 struct siginfo;
 extern void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index de5d572225f3..757ebc7f595f 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -286,15 +286,16 @@ extern void halt_skas(void);
 extern void reboot_skas(void);
 
 /* irq.c */
-extern int os_waiting_for_events(struct irq_fd *active_fds);
-extern int os_create_pollfd(int fd, int events, void *tmp_pfd, int size_tmpfds);
-extern void os_free_irq_by_cb(int (*test)(struct irq_fd *, void *), void *arg,
-		struct irq_fd *active_fds, struct irq_fd ***last_irq_ptr2);
-extern void os_free_irq_later(struct irq_fd *active_fds,
-		int irq, void *dev_id);
-extern int os_get_pollfd(int i);
-extern void os_set_pollfd(int i, int fd);
+extern int os_waiting_for_events_epoll(void);
+extern void *os_epoll_get_data_pointer(int index);
+extern int os_epoll_triggered(int index, int events);
+extern int os_event_mask(int irq_type);
+extern int os_setup_epoll(void);
+extern int os_add_epoll_fd(int events, int fd, void *data);
+extern int os_mod_epoll_fd(int events, int fd, void *data);
+extern int os_del_epoll_fd(int fd);
 extern void os_set_ioignore(void);
+extern void os_close_epoll_fd(void);
 
 /* sigio.c */
 extern int add_sigio_fd(int fd);
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 23cb9350d47e..980148d56537 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -1,4 +1,6 @@
 /*
+ * Copyright (C) 2017 - Cambridge Greys Ltd
+ * Copyright (C) 2011 - 2014 Cisco Systems Inc
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Licensed under the GPL
  * Derived (i.e. mostly copied) from arch/i386/kernel/irq.c:
@@ -16,243 +18,361 @@
 #include <as-layout.h>
 #include <kern_util.h>
 #include <os.h>
+#include <irq_user.h>
 
-/*
- * This list is accessed under irq_lock, except in sigio_handler,
- * where it is safe from being modified.  IRQ handlers won't change it -
- * if an IRQ source has vanished, it will be freed by free_irqs just
- * before returning from sigio_handler.  That will process a separate
- * list of irqs to free, with its own locking, coming back here to
- * remove list elements, taking the irq_lock to do so.
+
+/* When epoll triggers we do not know why it did so
+ * we can also have different IRQs for read and write.
+ * This is why we keep a small irq_fd array for each fd -
+ * one entry per IRQ type
  */
-static struct irq_fd *active_fds = NULL;
-static struct irq_fd **last_irq_ptr = &active_fds;
 
-extern void free_irqs(void);
+struct irq_entry {
+	struct irq_entry *next;
+	int fd;
+	struct irq_fd *irq_array[MAX_IRQ_TYPE + 1];
+};
+
+static struct irq_entry *active_fds;
+
+static DEFINE_SPINLOCK(irq_lock);
+
+static void irq_io_loop(struct irq_fd *irq, struct uml_pt_regs *regs)
+{
+/*
+ * irq->active guards against reentry
+ * irq->pending accumulates pending requests
+ * if pending is raised the irq_handler is re-run
+ * until pending is cleared
+ */
+	if (irq->active) {
+		irq->active = false;
+		do {
+			irq->pending = false;
+			do_IRQ(irq->irq, regs);
+		} while (irq->pending && (!irq->purge));
+		if (!irq->purge)
+			irq->active = true;
+	} else {
+		irq->pending = true;
+	}
+}
 
 void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 {
-	struct irq_fd *irq_fd;
-	int n;
+	struct irq_entry *irq_entry;
+	struct irq_fd *irq;
+
+	int n, i, j;
 
 	while (1) {
-		n = os_waiting_for_events(active_fds);
+		/* This is now lockless - epoll keeps back-referencesto the irqs
+		 * which have trigger it so there is no need to walk the irq
+		 * list and lock it every time. We avoid locking by turning off
+		 * IO for a specific fd by executing os_del_epoll_fd(fd) before
+		 * we do any changes to the actual data structures
+		 */
+		n = os_waiting_for_events_epoll();
+
 		if (n <= 0) {
 			if (n == -EINTR)
 				continue;
-			else break;
+			else
+				break;
 		}
 
-		for (irq_fd = active_fds; irq_fd != NULL;
-		     irq_fd = irq_fd->next) {
-			if (irq_fd->current_events != 0) {
-				irq_fd->current_events = 0;
-				do_IRQ(irq_fd->irq, regs);
+		for (i = 0; i < n ; i++) {
+			/* Epoll back reference is the entry with 3 irq_fd
+			 * leaves - one for each irq type.
+			 */
+			irq_entry = (struct irq_entry *)
+				os_epoll_get_data_pointer(i);
+			for (j = 0; j < MAX_IRQ_TYPE ; j++) {
+				irq = irq_entry->irq_array[j];
+				if (irq == NULL)
+					continue;
+				if (os_epoll_triggered(i, irq->events) > 0)
+					irq_io_loop(irq, regs);
+				if (irq->purge) {
+					irq_entry->irq_array[j] = NULL;
+					kfree(irq);
+				}
 			}
 		}
 	}
+}
+
+static int assign_epoll_events_to_irq(struct irq_entry *irq_entry)
+{
+	int i;
+	int events = 0;
+	struct irq_fd *irq;
 
-	free_irqs();
+	for (i = 0; i < MAX_IRQ_TYPE ; i++) {
+		irq = irq_entry->irq_array[i];
+		if (irq != NULL)
+			events = irq->events | events;
+	}
+	if (events > 0) {
+	/* os_add_epoll will call os_mod_epoll if this already exists */
+		return os_add_epoll_fd(events, irq_entry->fd, irq_entry);
+	}
+	/* No events - delete */
+	return os_del_epoll_fd(irq_entry->fd);
 }
 
-static DEFINE_SPINLOCK(irq_lock);
+
 
 static int activate_fd(int irq, int fd, int type, void *dev_id)
 {
-	struct pollfd *tmp_pfd;
-	struct irq_fd *new_fd, *irq_fd;
+	struct irq_fd *new_fd;
+	struct irq_entry *irq_entry;
+	int i, err, events;
 	unsigned long flags;
-	int events, err, n;
 
 	err = os_set_fd_async(fd);
 	if (err < 0)
 		goto out;
 
-	err = -ENOMEM;
-	new_fd = kmalloc(sizeof(struct irq_fd), GFP_KERNEL);
-	if (new_fd == NULL)
-		goto out;
+	spin_lock_irqsave(&irq_lock, flags);
 
-	if (type == IRQ_READ)
-		events = UM_POLLIN | UM_POLLPRI;
-	else events = UM_POLLOUT;
-	*new_fd = ((struct irq_fd) { .next  		= NULL,
-				     .id 		= dev_id,
-				     .fd 		= fd,
-				     .type 		= type,
-				     .irq 		= irq,
-				     .events 		= events,
-				     .current_events 	= 0 } );
+	/* Check if we have an entry for this fd */
 
 	err = -EBUSY;
-	spin_lock_irqsave(&irq_lock, flags);
-	for (irq_fd = active_fds; irq_fd != NULL; irq_fd = irq_fd->next) {
-		if ((irq_fd->fd == fd) && (irq_fd->type == type)) {
-			printk(KERN_ERR "Registering fd %d twice\n", fd);
-			printk(KERN_ERR "Irqs : %d, %d\n", irq_fd->irq, irq);
-			printk(KERN_ERR "Ids : 0x%p, 0x%p\n", irq_fd->id,
-			       dev_id);
+	for (irq_entry = active_fds;
+		irq_entry != NULL; irq_entry = irq_entry->next) {
+		if (irq_entry->fd == fd)
+			break;
+	}
+
+	if (irq_entry == NULL) {
+		/* This needs to be atomic as it may be called from an
+		 * IRQ context.
+		 */
+		irq_entry = kmalloc(sizeof(struct irq_entry), GFP_ATOMIC);
+		if (irq_entry == NULL) {
+			printk(KERN_ERR
+				"Failed to allocate new IRQ entry\n");
 			goto out_unlock;
 		}
+		irq_entry->fd = fd;
+		for (i = 0; i < MAX_IRQ_TYPE; i++)
+			irq_entry->irq_array[i] = NULL;
+		irq_entry->next = active_fds;
+		active_fds = irq_entry;
 	}
 
-	if (type == IRQ_WRITE)
-		fd = -1;
-
-	tmp_pfd = NULL;
-	n = 0;
+	/* Check if we are trying to re-register an interrupt for a
+	 * particular fd
+	 */
 
-	while (1) {
-		n = os_create_pollfd(fd, events, tmp_pfd, n);
-		if (n == 0)
-			break;
+	if (irq_entry->irq_array[type] != NULL) {
+		printk(KERN_ERR
+			"Trying to reregister IRQ %d FD %d TYPE %d ID %p\n",
+			irq, fd, type, dev_id
+		);
+		goto out_unlock;
+	} else {
+		/* New entry for this fd */
+
+		err = -ENOMEM;
+		new_fd = kmalloc(sizeof(struct irq_fd), GFP_ATOMIC);
+		if (new_fd == NULL)
+			goto out_unlock;
 
-		/*
-		 * n > 0
-		 * It means we couldn't put new pollfd to current pollfds
-		 * and tmp_fds is NULL or too small for new pollfds array.
-		 * Needed size is equal to n as minimum.
-		 *
-		 * Here we have to drop the lock in order to call
-		 * kmalloc, which might sleep.
-		 * If something else came in and changed the pollfds array
-		 * so we will not be able to put new pollfd struct to pollfds
-		 * then we free the buffer tmp_fds and try again.
+		events = os_event_mask(type);
+
+		*new_fd = ((struct irq_fd) {
+			.id		= dev_id,
+			.irq		= irq,
+			.type		= type,
+			.events		= events,
+			.active		= true,
+			.pending	= false,
+			.purge		= false
+		});
+		/* Turn off any IO on this fd - allows us to
+		 * avoid locking the IRQ loop
 		 */
-		spin_unlock_irqrestore(&irq_lock, flags);
-		kfree(tmp_pfd);
-
-		tmp_pfd = kmalloc(n, GFP_KERNEL);
-		if (tmp_pfd == NULL)
-			goto out_kfree;
-
-		spin_lock_irqsave(&irq_lock, flags);
+		os_del_epoll_fd(irq_entry->fd);
+		irq_entry->irq_array[type] = new_fd;
 	}
 
-	*last_irq_ptr = new_fd;
-	last_irq_ptr = &new_fd->next;
-
+	/* Turn back IO on with the correct (new) IO event mask */
+	assign_epoll_events_to_irq(irq_entry);
 	spin_unlock_irqrestore(&irq_lock, flags);
-
-	/*
-	 * This calls activate_fd, so it has to be outside the critical
-	 * section.
-	 */
-	maybe_sigio_broken(fd, (type == IRQ_READ));
+	maybe_sigio_broken(fd, (type != IRQ_NONE));
 
 	return 0;
-
- out_unlock:
+out_unlock:
 	spin_unlock_irqrestore(&irq_lock, flags);
- out_kfree:
-	kfree(new_fd);
- out:
+out:
 	return err;
 }
 
-static void free_irq_by_cb(int (*test)(struct irq_fd *, void *), void *arg)
+/*
+ * Walk the IRQ list and dispose of any unused entries.
+ * Should be done under irq_lock.
+ */
+
+static void garbage_collect_irq_entries(void)
 {
-	unsigned long flags;
+	int i;
+	bool reap;
+	struct irq_entry *walk;
+	struct irq_entry *previous = NULL;
+	struct irq_entry *to_free;
 
-	spin_lock_irqsave(&irq_lock, flags);
-	os_free_irq_by_cb(test, arg, active_fds, &last_irq_ptr);
-	spin_unlock_irqrestore(&irq_lock, flags);
+	if (active_fds == NULL)
+		return;
+	walk = active_fds;
+	while (walk != NULL) {
+		reap = true;
+		for (i = 0; i < MAX_IRQ_TYPE ; i++) {
+			if (walk->irq_array[i] != NULL) {
+				reap = false;
+				break;
+			}
+		}
+		if (reap) {
+			if (previous == NULL)
+				active_fds = walk->next;
+			else
+				previous->next = walk->next;
+			to_free = walk;
+		} else {
+			to_free = NULL;
+		}
+		walk = walk->next;
+		if (to_free != NULL)
+			kfree(to_free);
+	}
 }
 
-struct irq_and_dev {
-	int irq;
-	void *dev;
-};
+/*
+ * Walk the IRQ list and get the descriptor for our FD
+ */
 
-static int same_irq_and_dev(struct irq_fd *irq, void *d)
+static struct irq_entry *get_irq_entry_by_fd(int fd)
 {
-	struct irq_and_dev *data = d;
+	struct irq_entry *walk = active_fds;
 
-	return ((irq->irq == data->irq) && (irq->id == data->dev));
+	while (walk != NULL) {
+		if (walk->fd == fd)
+			return walk;
+		walk = walk->next;
+	}
+	return NULL;
 }
 
-static void free_irq_by_irq_and_dev(unsigned int irq, void *dev)
-{
-	struct irq_and_dev data = ((struct irq_and_dev) { .irq  = irq,
-							  .dev  = dev });
 
-	free_irq_by_cb(same_irq_and_dev, &data);
-}
+/*
+ * Walk the IRQ list and dispose of an entry for a specific
+ * device, fd and number. Note - if sharing an IRQ for read
+ * and writefor the same FD it will be disposed in either case.
+ * If this behaviour is undesirable use different IRQ ids.
+ */
 
-static int same_fd(struct irq_fd *irq, void *fd)
-{
-	return (irq->fd == *((int *)fd));
-}
+#define IGNORE_IRQ 1
+#define IGNORE_DEV (1<<1)
 
-void free_irq_by_fd(int fd)
+static void do_free_by_irq_and_dev(
+	struct irq_entry *irq_entry,
+	unsigned int irq,
+	void *dev,
+	int flags
+)
 {
-	free_irq_by_cb(same_fd, &fd);
+	int i;
+	struct irq_fd *to_free;
+
+	for (i = 0; i < MAX_IRQ_TYPE ; i++) {
+		if (irq_entry->irq_array[i] != NULL) {
+			if (
+			((flags & IGNORE_IRQ) ||
+				(irq_entry->irq_array[i]->irq == irq)) &&
+			((flags & IGNORE_DEV) ||
+				(irq_entry->irq_array[i]->id == dev))
+			) {
+				/* Turn off any IO on this fd - allows us to
+				 * avoid locking the IRQ loop
+				 */
+				os_del_epoll_fd(irq_entry->fd);
+				to_free = irq_entry->irq_array[i];
+				irq_entry->irq_array[i] = NULL;
+				assign_epoll_events_to_irq(irq_entry);
+				if (to_free->active)
+					to_free->purge = true;
+				else
+					kfree(to_free);
+			}
+		}
+	}
 }
 
-/* Must be called with irq_lock held */
-static struct irq_fd *find_irq_by_fd(int fd, int irqnum, int *index_out)
+void free_irq_by_fd(int fd)
 {
-	struct irq_fd *irq;
-	int i = 0;
-	int fdi;
+	struct irq_entry *to_free;
+	unsigned long flags;
 
-	for (irq = active_fds; irq != NULL; irq = irq->next) {
-		if ((irq->fd == fd) && (irq->irq == irqnum))
-			break;
-		i++;
-	}
-	if (irq == NULL) {
-		printk(KERN_ERR "find_irq_by_fd doesn't have descriptor %d\n",
-		       fd);
-		goto out;
-	}
-	fdi = os_get_pollfd(i);
-	if ((fdi != -1) && (fdi != fd)) {
-		printk(KERN_ERR "find_irq_by_fd - mismatch between active_fds "
-		       "and pollfds, fd %d vs %d, need %d\n", irq->fd,
-		       fdi, fd);
-		irq = NULL;
-		goto out;
+	spin_lock_irqsave(&irq_lock, flags);
+	to_free = get_irq_entry_by_fd(fd);
+	if (to_free != NULL) {
+		do_free_by_irq_and_dev(
+			to_free,
+			-1,
+			NULL,
+			IGNORE_IRQ | IGNORE_DEV
+		);
 	}
-	*index_out = i;
- out:
-	return irq;
+	garbage_collect_irq_entries();
+	spin_unlock_irqrestore(&irq_lock, flags);
 }
 
-void reactivate_fd(int fd, int irqnum)
+static void free_irq_by_irq_and_dev(unsigned int irq, void *dev)
 {
-	struct irq_fd *irq;
+	struct irq_entry *to_free;
 	unsigned long flags;
-	int i;
 
 	spin_lock_irqsave(&irq_lock, flags);
-	irq = find_irq_by_fd(fd, irqnum, &i);
-	if (irq == NULL) {
-		spin_unlock_irqrestore(&irq_lock, flags);
-		return;
+	to_free = active_fds;
+	while (to_free != NULL) {
+		do_free_by_irq_and_dev(
+			to_free,
+			irq,
+			dev,
+			0
+		);
+		to_free = to_free->next;
 	}
-	os_set_pollfd(i, irq->fd);
+	garbage_collect_irq_entries();
 	spin_unlock_irqrestore(&irq_lock, flags);
+}
 
-	add_sigio_fd(fd);
+
+void reactivate_fd(int fd, int irqnum)
+{
+	/** NOP - we do auto-EOI now **/
 }
 
 void deactivate_fd(int fd, int irqnum)
 {
-	struct irq_fd *irq;
+	struct irq_entry *to_free;
 	unsigned long flags;
-	int i;
 
+	os_del_epoll_fd(fd);
 	spin_lock_irqsave(&irq_lock, flags);
-	irq = find_irq_by_fd(fd, irqnum, &i);
-	if (irq == NULL) {
-		spin_unlock_irqrestore(&irq_lock, flags);
-		return;
+	to_free = get_irq_entry_by_fd(fd);
+	if (to_free != NULL) {
+		do_free_by_irq_and_dev(
+			to_free,
+			irqnum,
+			NULL,
+			IGNORE_DEV
+		);
 	}
-
-	os_set_pollfd(i, -1);
+	garbage_collect_irq_entries();
 	spin_unlock_irqrestore(&irq_lock, flags);
-
 	ignore_sigio_fd(fd);
 }
 EXPORT_SYMBOL(deactivate_fd);
@@ -265,17 +385,28 @@ EXPORT_SYMBOL(deactivate_fd);
  */
 int deactivate_all_fds(void)
 {
-	struct irq_fd *irq;
-	int err;
+	unsigned long flags;
+	struct irq_entry *to_free;
 
-	for (irq = active_fds; irq != NULL; irq = irq->next) {
-		err = os_clear_fd_async(irq->fd);
-		if (err)
-			return err;
-	}
-	/* If there is a signal already queued, after unblocking ignore it */
+	spin_lock_irqsave(&irq_lock, flags);
+	/* Stop IO. The IRQ loop has no lock so this is our
+	 * only way of making sure we are safe to dispose
+	 * of all IRQ handlers
+	 */
 	os_set_ioignore();
-
+	to_free = active_fds;
+	while (to_free != NULL) {
+		do_free_by_irq_and_dev(
+			to_free,
+			-1,
+			NULL,
+			IGNORE_IRQ | IGNORE_DEV
+		);
+		to_free = to_free->next;
+	}
+	garbage_collect_irq_entries();
+	spin_unlock_irqrestore(&irq_lock, flags);
+	os_close_epoll_fd();
 	return 0;
 }
 
@@ -353,8 +484,11 @@ void __init init_IRQ(void)
 
 	irq_set_chip_and_handler(TIMER_IRQ, &SIGVTALRM_irq_type, handle_edge_irq);
 
+
 	for (i = 1; i < NR_IRQS; i++)
 		irq_set_chip_and_handler(i, &normal_irq_type, handle_edge_irq);
+	/* Initialize EPOLL Loop */
+	os_setup_epoll();
 }
 
 /*
diff --git a/arch/um/os-Linux/irq.c b/arch/um/os-Linux/irq.c
index b9afb74b79ad..365823010346 100644
--- a/arch/um/os-Linux/irq.c
+++ b/arch/um/os-Linux/irq.c
@@ -1,135 +1,147 @@
 /*
+ * Copyright (C) 2017 - Cambridge Greys Ltd
+ * Copyright (C) 2011 - 2014 Cisco Systems Inc
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Licensed under the GPL
  */
 
 #include <stdlib.h>
 #include <errno.h>
-#include <poll.h>
+#include <sys/epoll.h>
 #include <signal.h>
 #include <string.h>
 #include <irq_user.h>
 #include <os.h>
 #include <um_malloc.h>
 
+/* Epoll support */
+
+static int epollfd = -1;
+
+#define MAX_EPOLL_EVENTS 64
+
+static struct epoll_event epoll_events[MAX_EPOLL_EVENTS];
+
+/* Helper to return an Epoll data pointer from an epoll event structure.
+ * We need to keep this one on the userspace side to keep includes separate
+ */
+
+void *os_epoll_get_data_pointer(int index)
+{
+	return epoll_events[index].data.ptr;
+}
+
+/* Helper to compare events versus the events in the epoll structure.
+ * Same as above - needs to be on the userspace side
+ */
+
+
+int os_epoll_triggered(int index, int events)
+{
+	return epoll_events[index].events & events;
+}
+/* Helper to set the event mask.
+ * The event mask is opaque to the kernel side, because it does not have
+ * access to the right includes/defines for EPOLL constants.
+ */
+
+int os_event_mask(int irq_type)
+{
+	if (irq_type == IRQ_READ)
+		return EPOLLIN | EPOLLPRI;
+	if (irq_type == IRQ_WRITE)
+		return EPOLLOUT;
+	return 0;
+}
+
 /*
- * Locked by irq_lock in arch/um/kernel/irq.c.  Changed by os_create_pollfd
- * and os_free_irq_by_cb, which are called under irq_lock.
+ * Initial Epoll Setup
  */
-static struct pollfd *pollfds = NULL;
-static int pollfds_num = 0;
-static int pollfds_size = 0;
+int os_setup_epoll(void)
+{
+	epollfd = epoll_create(MAX_EPOLL_EVENTS);
+	return epollfd;
+}
 
-int os_waiting_for_events(struct irq_fd *active_fds)
+/*
+ * Helper to run the actual epoll_wait
+ */
+int os_waiting_for_events_epoll(void)
 {
-	struct irq_fd *irq_fd;
-	int i, n, err;
+	int n, err;
 
-	n = poll(pollfds, pollfds_num, 0);
+	n = epoll_wait(epollfd,
+		(struct epoll_event *) &epoll_events, MAX_EPOLL_EVENTS, 0);
 	if (n < 0) {
 		err = -errno;
 		if (errno != EINTR)
-			printk(UM_KERN_ERR "os_waiting_for_events:"
-			       " poll returned %d, errno = %d\n", n, errno);
+			printk(
+				UM_KERN_ERR "os_waiting_for_events:"
+				" epoll returned %d, error = %s\n", n,
+				strerror(errno)
+			);
 		return err;
 	}
-
-	if (n == 0)
-		return 0;
-
-	irq_fd = active_fds;
-
-	for (i = 0; i < pollfds_num; i++) {
-		if (pollfds[i].revents != 0) {
-			irq_fd->current_events = pollfds[i].revents;
-			pollfds[i].fd = -1;
-		}
-		irq_fd = irq_fd->next;
-	}
 	return n;
 }
 
-int os_create_pollfd(int fd, int events, void *tmp_pfd, int size_tmpfds)
-{
-	if (pollfds_num == pollfds_size) {
-		if (size_tmpfds <= pollfds_size * sizeof(pollfds[0])) {
-			/* return min size needed for new pollfds area */
-			return (pollfds_size + 1) * sizeof(pollfds[0]);
-		}
-
-		if (pollfds != NULL) {
-			memcpy(tmp_pfd, pollfds,
-			       sizeof(pollfds[0]) * pollfds_size);
-			/* remove old pollfds */
-			kfree(pollfds);
-		}
-		pollfds = tmp_pfd;
-		pollfds_size++;
-	} else
-		kfree(tmp_pfd);	/* remove not used tmp_pfd */
-
-	pollfds[pollfds_num] = ((struct pollfd) { .fd		= fd,
-						  .events	= events,
-						  .revents	= 0 });
-	pollfds_num++;
-
-	return 0;
-}
 
-void os_free_irq_by_cb(int (*test)(struct irq_fd *, void *), void *arg,
-		struct irq_fd *active_fds, struct irq_fd ***last_irq_ptr2)
+/*
+ * Helper to add a fd to epoll
+ */
+int os_add_epoll_fd(int events, int fd, void *data)
 {
-	struct irq_fd **prev;
-	int i = 0;
-
-	prev = &active_fds;
-	while (*prev != NULL) {
-		if ((*test)(*prev, arg)) {
-			struct irq_fd *old_fd = *prev;
-			if ((pollfds[i].fd != -1) &&
-			    (pollfds[i].fd != (*prev)->fd)) {
-				printk(UM_KERN_ERR "os_free_irq_by_cb - "
-				       "mismatch between active_fds and "
-				       "pollfds, fd %d vs %d\n",
-				       (*prev)->fd, pollfds[i].fd);
-				goto out;
-			}
-
-			pollfds_num--;
-
-			/*
-			 * This moves the *whole* array after pollfds[i]
-			 * (though it doesn't spot as such)!
-			 */
-			memmove(&pollfds[i], &pollfds[i + 1],
-			       (pollfds_num - i) * sizeof(pollfds[0]));
-			if (*last_irq_ptr2 == &old_fd->next)
-				*last_irq_ptr2 = prev;
-
-			*prev = (*prev)->next;
-			if (old_fd->type == IRQ_WRITE)
-				ignore_sigio_fd(old_fd->fd);
-			kfree(old_fd);
-			continue;
-		}
-		prev = &(*prev)->next;
-		i++;
-	}
- out:
-	return;
+	struct epoll_event event;
+	int result;
+
+	event.data.ptr = data;
+	event.events = events | EPOLLET;
+	result = epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &event);
+	if ((result) && (errno == EEXIST))
+		result = os_mod_epoll_fd(events, fd, data);
+	if (result)
+		printk("epollctl add err fd %d, %s\n", fd, strerror(errno));
+	return result;
 }
 
-int os_get_pollfd(int i)
+/*
+ * Helper to mod the fd event mask and/or data backreference
+ */
+int os_mod_epoll_fd(int events, int fd, void *data)
 {
-	return pollfds[i].fd;
+	struct epoll_event event;
+	int result;
+
+	event.data.ptr = data;
+	event.events = events;
+	result = epoll_ctl(epollfd, EPOLL_CTL_MOD, fd, &event);
+	if (result)
+		printk(UM_KERN_ERR
+			"epollctl mod err fd %d, %s\n", fd, strerror(errno));
+	return result;
 }
 
-void os_set_pollfd(int i, int fd)
+/*
+ * Helper to delete the epoll fd
+ */
+int os_del_epoll_fd(int fd)
 {
-	pollfds[i].fd = fd;
+	struct epoll_event event;
+	int result;
+	/* This is quiet as we use this as IO ON/OFF - so it is often
+	 * invoked on a non-existent fd
+	 */
+	result = epoll_ctl(epollfd, EPOLL_CTL_DEL, fd, &event);
+	return result;
 }
 
 void os_set_ioignore(void)
 {
 	signal(SIGIO, SIG_IGN);
 }
+
+void os_close_epoll_fd(void)
+{
+	/* Needed so we do not leak an fd when rebooting */
+	os_close_file(epollfd);
+}
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

