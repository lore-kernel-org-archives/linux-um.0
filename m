Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1XNGy7-0007Tf-7c
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Aug 2014 07:51:35 +0000
Received: from ivanoab3.miniserver.com ([89.200.143.206])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XNGy5-00007C-2k
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Aug 2014 07:51:35 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Fri, 29 Aug 2014 08:05:06 +0100
Message-Id: <1409295915-130538-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
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
Subject: [uml-devel] [PATCH 01/10] Epoll based interrupt controller
To: user-mode-linux-devel@lists.sourceforge.net

From: Anton Ivanov <antivano@cisco.com>

1. Minimum kernel 2.5.99
2. No "walk the list" lookups for received IRQs - immediate identification
of the correct handler to invoke
3. Full set of IRQ semantics - edge, level, read, write
    3.1. Write is now a *REAL* write - so if you (ab)use the
    write to signify NONE (as in line.c) you will hang!!!
    3.2. Read is fully backward compatible
4. Otherwise mostly compatible with original poll() based controller
5. Provides significant performance improvement (up to 10x times for
large device numbers) ands lays the groundwork for the network and
timer improvements to follow

Signed-off-by: Anton Ivanov <antivano@cisco.com>
---
 arch/um/drivers/line.c            |    3 +-
 arch/um/include/shared/irq_user.h |   19 +-
 arch/um/include/shared/os.h       |   13 +-
 arch/um/kernel/irq.c              |  456 +++++++++++++++++++++++++------------
 arch/um/os-Linux/irq.c            |  145 +++++-------
 5 files changed, 392 insertions(+), 244 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 8035145..6c4511f 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -1,4 +1,5 @@
 /*
+ * Copyright (C) 2012 - 2014 Cisco Systems
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Licensed under the GPL
  */
@@ -283,7 +284,7 @@ int line_setup_irq(int fd, int input, int output, struct line *line, void *data)
 	if (err)
 		return err;
 	if (output)
-		err = um_request_irq(driver->write_irq, fd, IRQ_WRITE,
+		err = um_request_irq(driver->write_irq, fd, IRQ_NONE,
 				     line_write_interrupt, IRQF_SHARED,
 				     driver->write_irq_name, data);
 	return err;
diff --git a/arch/um/include/shared/irq_user.h b/arch/um/include/shared/irq_user.h
index df56330..8d6eaff 100644
--- a/arch/um/include/shared/irq_user.h
+++ b/arch/um/include/shared/irq_user.h
@@ -1,4 +1,5 @@
 /*
+ * Copyright (C) 2012 - 2014 Cisco Systems
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Licensed under the GPL
  */
@@ -9,16 +10,18 @@
 #include <sysdep/ptrace.h>
 
 struct irq_fd {
-	struct irq_fd *next;
-	void *id;
-	int fd;
-	int type;
-	int irq;
-	int events;
-	int current_events;
+        struct irq_fd *next;
+        struct irq_fd *leaf;
+        void *id;
+        int fd;
+        int type;
+        int irq;
+        int events;
 };
 
-enum { IRQ_READ, IRQ_WRITE };
+#define IRQ_NONE 0
+#define IRQ_READ  1
+#define IRQ_WRITE 2 
 
 struct siginfo;
 extern void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 021104d..17b4e9f 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -1,4 +1,5 @@
 /*
+ * Copyright (C) 2012 - 2014 Cisco Systems
  * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Licensed under the GPL
  */
@@ -276,15 +277,17 @@ extern void halt_skas(void);
 extern void reboot_skas(void);
 
 /* irq.c */
-extern int os_waiting_for_events(struct irq_fd *active_fds);
-extern int os_create_pollfd(int fd, int events, void *tmp_pfd, int size_tmpfds);
+
+extern int os_setup_epoll(int maxevents);
+extern int os_waiting_for_events_epoll(void *kernel_events, int maxevents);
+extern int os_add_epoll_fd (int events, int fd, void * data);
+extern int os_mod_epoll_fd (int events, int fd, void * data);
+extern int os_del_epoll_fd (int fd);
+
 extern void os_free_irq_by_cb(int (*test)(struct irq_fd *, void *), void *arg,
 		struct irq_fd *active_fds, struct irq_fd ***last_irq_ptr2);
 extern void os_free_irq_later(struct irq_fd *active_fds,
 		int irq, void *dev_id);
-extern int os_get_pollfd(int i);
-extern void os_set_pollfd(int i, int fd);
-extern void os_set_ioignore(void);
 
 /* sigio.c */
 extern int add_sigio_fd(int fd);
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 1d8505b..5d7ee49e 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -1,4 +1,5 @@
 /*
+ * Copyright (C) 2012 - 2014 Cisco Systems
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Licensed under the GPL
  * Derived (i.e. mostly copied) from arch/i386/kernel/irq.c:
@@ -18,6 +19,61 @@
 #include <os.h>
 
 /*
+*	We are on the "kernel side" so we cannot pick up the sys/epoll.h 
+*	So we lift out of it the applicable key definitions.
+*/
+
+
+enum EPOLL_EVENTS
+  {
+	EPOLLIN = 0x001,
+#define EPOLLIN EPOLLIN
+	EPOLLPRI = 0x002,
+#define EPOLLPRI EPOLLPRI
+	EPOLLOUT = 0x004,
+#define EPOLLOUT EPOLLOUT
+	EPOLLRDNORM = 0x040,
+#define EPOLLRDNORM EPOLLRDNORM
+	EPOLLRDBAND = 0x080,
+#define EPOLLRDBAND EPOLLRDBAND
+	EPOLLWRNORM = 0x100,
+#define EPOLLWRNORM EPOLLWRNORM
+	EPOLLWRBAND = 0x200,
+#define EPOLLWRBAND EPOLLWRBAND
+	EPOLLMSG = 0x400,
+#define EPOLLMSG EPOLLMSG
+	EPOLLERR = 0x008,
+#define EPOLLERR EPOLLERR
+	EPOLLHUP = 0x010,
+#define EPOLLHUP EPOLLHUP
+	EPOLLRDHUP = 0x2000,
+#define EPOLLRDHUP EPOLLRDHUP
+	EPOLLONESHOT = (1 << 30),
+#define EPOLLONESHOT EPOLLONESHOT
+	EPOLLET = (1 << 31)
+#define EPOLLET EPOLLET
+  };
+
+
+typedef union epoll_data
+{
+	void *ptr;
+	int fd;
+	uint32_t u32;
+	uint64_t u64;
+} epoll_data_t;
+
+struct epoll_event
+{
+	uint32_t events;	/* Epoll events */
+	epoll_data_t data;	/* User data variable */
+} __attribute__ ((__packed__));
+
+#define MAX_EPOLL_EVENTS 16
+
+static struct epoll_event epoll_events[MAX_EPOLL_EVENTS];
+
+/*
  * This list is accessed under irq_lock, except in sigio_handler,
  * where it is safe from being modified.  IRQ handlers won't change it -
  * if an IRQ source has vanished, it will be freed by free_irqs just
@@ -26,46 +82,98 @@
  * remove list elements, taking the irq_lock to do so.
  */
 static struct irq_fd *active_fds = NULL;
-static struct irq_fd **last_irq_ptr = &active_fds;
 
 extern void free_irqs(void);
 
+/*
+ the in_epoll_loop is not static on purpose - we will use this to
+ determine if we can do delayed queue flushes in devices. The idea is -
+ if we read 32 packets at a time using recvmmsg we need an
+ indication that we will be reading more so no point to send now
+ and flush the queue only once we are done with it
+*/
+
+DEFINE_SPINLOCK(uml_sigio_lock);
+
+int in_epoll_loop = 0;
+
+static DEFINE_SPINLOCK(irq_lock);
+static DEFINE_SPINLOCK(event_loop);
+
 void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 {
 	struct irq_fd *irq_fd;
-	int n;
+	unsigned long flags;
+
+	int n, i;
 
 	if (smp_sigio_handler())
 		return;
 
 	while (1) {
-		n = os_waiting_for_events(active_fds);
+		spin_lock_irqsave(&uml_sigio_lock, flags);
+		in_epoll_loop = 1;
+		n = os_waiting_for_events_epoll(
+			&epoll_events, MAX_EPOLL_EVENTS
+		);
 		if (n <= 0) {
-			if (n == -EINTR)
-				continue;
-			else break;
+			in_epoll_loop = 0;
+			spin_unlock_irqrestore(&uml_sigio_lock, flags);
+			break;
 		}
-
-		for (irq_fd = active_fds; irq_fd != NULL;
-		     irq_fd = irq_fd->next) {
-			if (irq_fd->current_events != 0) {
-				irq_fd->current_events = 0;
-				do_IRQ(irq_fd->irq, regs);
+		for (i = 0; i < n ; i++) {
+			for (
+				irq_fd = (struct irq_fd *)
+					epoll_events[i].data.ptr;
+				irq_fd != NULL;
+				irq_fd = irq_fd->leaf) {
+				if (epoll_events[i].events & irq_fd->events) {
+					do_IRQ(irq_fd->irq, regs);
+				}
 			}
 		}
+		in_epoll_loop = 0;
+		spin_unlock_irqrestore(&uml_sigio_lock, flags);
 	}
 
+	/* This needs a better way - it slows down the event loop */
+
 	free_irqs();
 }
-
-static DEFINE_SPINLOCK(irq_lock);
+#define TRUNK_FORMAT "trunk %d\tfd %03d, events %03x, dev %p\n"
+#define LEAF_FORMAT "leaf %d\tfd %03d, events %03x, dev %p\n"
+
+static void dump_interrupt_map (void) {
+	struct irq_fd * irq, *leaf ;
+	printk("MAP:\n");
+	for (irq  = active_fds; irq != NULL; irq = irq->next) {
+		printk(
+			TRUNK_FORMAT,
+			irq->irq, irq->fd, irq->events, irq->id
+		);
+		if (irq->leaf) {
+			for (	
+				leaf = irq->leaf;
+				leaf != NULL;
+				leaf = leaf->leaf
+			) {
+				printk(
+					LEAF_FORMAT,
+					leaf->irq,
+					leaf->fd,
+					leaf->events,
+					leaf->id
+				);
+			}
+		}
+	}
+}
 
 static int activate_fd(int irq, int fd, int type, void *dev_id)
 {
-	struct pollfd *tmp_pfd;
-	struct irq_fd *new_fd, *irq_fd;
+	struct irq_fd *new_fd, *irq_fd, *leaf ;
 	unsigned long flags;
-	int events, err, n;
+	int events = 0, acc_events = 0, err, n, skip = 0;
 
 	err = os_set_fd_async(fd);
 	if (err < 0)
@@ -76,64 +184,56 @@ static int activate_fd(int irq, int fd, int type, void *dev_id)
 	if (new_fd == NULL)
 		goto out;
 
-	if (type == IRQ_READ)
-		events = UM_POLLIN | UM_POLLPRI;
-	else events = UM_POLLOUT;
+	if (type & IRQ_READ)
+		events |= EPOLLIN | EPOLLPRI;
+	if (type & IRQ_WRITE)
+		events |= EPOLLOUT;
+
 	*new_fd = ((struct irq_fd) { .next  		= NULL,
-				     .id 		= dev_id,
-				     .fd 		= fd,
-				     .type 		= type,
-				     .irq 		= irq,
-				     .events 		= events,
-				     .current_events 	= 0 } );
+					 .leaf		= NULL,
+					 .id 		= dev_id,
+					 .fd 		= fd,
+					 .type 		= type,
+					 .irq 		= irq,
+					 .events 		= events });
 
 	err = -EBUSY;
 	spin_lock_irqsave(&irq_lock, flags);
+
 	for (irq_fd = active_fds; irq_fd != NULL; irq_fd = irq_fd->next) {
-		if ((irq_fd->fd == fd) && (irq_fd->type == type)) {
-			printk(KERN_ERR "Registering fd %d twice\n", fd);
-			printk(KERN_ERR "Irqs : %d, %d\n", irq_fd->irq, irq);
-			printk(KERN_ERR "Ids : 0x%p, 0x%p\n", irq_fd->id,
-			       dev_id);
-			goto out_unlock;
+		if (irq_fd->fd == fd) {
+		for (leaf = irq_fd; leaf != NULL; leaf = leaf->leaf) {
+			if (leaf->type == type) {
+				printk("Irqs : %d, %d\n", leaf->irq, irq);
+				printk("Ids : 0x%p, 0x%p\n", leaf->id, dev_id);
+				goto out_unlock;
+			}
+			acc_events |= leaf->events;
+		}
+		/* we insert it one-off-the-head - easiest
+		   we also pass our "head" as the pointer to mod
+		   so it walks correctly
+		*/
+		skip = 1;
+		new_fd->leaf = irq_fd->leaf;
+		irq_fd->leaf = new_fd;
+			if ((new_fd->events | acc_events) != acc_events) {
+				n = os_mod_epoll_fd(new_fd->events | acc_events, fd, irq_fd);
+			}
 		}
 	}
-
-	if (type == IRQ_WRITE)
-		fd = -1;
-
-	tmp_pfd = NULL;
-	n = 0;
-
-	while (1) {
-		n = os_create_pollfd(fd, events, tmp_pfd, n);
-		if (n == 0)
-			break;
-
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
-		 */
-		spin_unlock_irqrestore(&irq_lock, flags);
-		kfree(tmp_pfd);
-
-		tmp_pfd = kmalloc(n, GFP_KERNEL);
-		if (tmp_pfd == NULL)
-			goto out_kfree;
-
-		spin_lock_irqsave(&irq_lock, flags);
+	if (! skip) {
+		/* proper IRQ registration */
+		new_fd->next = active_fds;
+		active_fds = new_fd;
+
+		if (new_fd->type != IRQ_NONE ) {	
+			n = os_add_epoll_fd(new_fd->events, fd, new_fd);
+		} else {
+			n = 0;
+		}
 	}
-
-	*last_irq_ptr = new_fd;
-	last_irq_ptr = &new_fd->next;
+	
 
 	spin_unlock_irqrestore(&irq_lock, flags);
 
@@ -141,122 +241,199 @@ static int activate_fd(int irq, int fd, int type, void *dev_id)
 	 * This calls activate_fd, so it has to be outside the critical
 	 * section.
 	 */
-	maybe_sigio_broken(fd, (type == IRQ_READ));
+
+	maybe_sigio_broken(fd, (type != IRQ_NONE));
 
 	return 0;
 
  out_unlock:
 	spin_unlock_irqrestore(&irq_lock, flags);
- out_kfree:
 	kfree(new_fd);
  out:
 	return err;
 }
 
-static void free_irq_by_cb(int (*test)(struct irq_fd *, void *), void *arg)
+/* Must be called with irq_lock held */
+static struct irq_fd *find_irq_chain_by_fd(int fd)
 {
-	unsigned long flags;
+	struct irq_fd *irq;
 
-	spin_lock_irqsave(&irq_lock, flags);
-	os_free_irq_by_cb(test, arg, active_fds, &last_irq_ptr);
-	spin_unlock_irqrestore(&irq_lock, flags);
+	for (irq = active_fds; irq != NULL; irq = irq->next) {
+		if (irq->fd == fd) {
+		return irq;
+		}
+	}
+	if (irq == NULL) {
+		printk(KERN_ERR
+			"find_irq_chain_by_fd doesn't have descriptor %d\n",
+			   fd);
+		dump_interrupt_map();
+	}
+	return irq;
 }
 
-struct irq_and_dev {
-	int irq;
-	void *dev;
-};
-
-static int same_irq_and_dev(struct irq_fd *irq, void *d)
+static struct irq_fd *find_irq_by_fd(int fd, int irqnum)
 {
-	struct irq_and_dev *data = d;
+	struct irq_fd *irq;
 
-	return ((irq->irq == data->irq) && (irq->id == data->dev));
+	for (irq = find_irq_chain_by_fd(fd); irq != NULL; irq = irq->leaf) {
+		if (irq->irq == irqnum)	return irq;
+	}
+	if (irq == NULL) {
+		printk(KERN_ERR "find_irq_by_fd doesn't have descriptor %d\n",
+			   fd);
+		dump_interrupt_map();
+	}
+	return irq;
 }
 
-static void free_irq_by_irq_and_dev(unsigned int irq, void *dev)
-{
-	struct irq_and_dev data = ((struct irq_and_dev) { .irq  = irq,
-							  .dev  = dev });
-
-	free_irq_by_cb(same_irq_and_dev, &data);
+static void free_leaf_irq_by_irq_and_dev(unsigned int irq, void *dev, struct irq_fd * prev) {
+	/* this is called out of free_irq_by_irq_and_dev with a held lock */
+	struct irq_fd *leaf;
+	if (prev != NULL) {
+		leaf = prev->leaf;
+	} else {
+		return;
+	}
+	while (leaf != NULL) {
+		if ((leaf->irq == irq) && (leaf->id == dev)) {
+			if (leaf->events) {
+				os_del_epoll_fd(leaf->fd);
+			}
+			prev->leaf = leaf->leaf;
+			kfree(leaf);
+		} else {
+			prev = leaf;
+		}
+		leaf = prev->leaf;
+	}
 }
 
-static int same_fd(struct irq_fd *irq, void *fd)
+static int do_free_irq_by_irq_and_dev(unsigned int irq, void *dev)
 {
-	return (irq->fd == *((int *)fd));
-}
+	unsigned long flags;
+	struct irq_fd *prev, * trunk;
+	spin_lock_irqsave(&irq_lock, flags);
 
-void free_irq_by_fd(int fd)
-{
-	free_irq_by_cb(same_fd, &fd);
-}
+	trunk = active_fds;
+	prev = NULL;
 
-/* Must be called with irq_lock held */
-static struct irq_fd *find_irq_by_fd(int fd, int irqnum, int *index_out)
-{
-	struct irq_fd *irq;
-	int i = 0;
-	int fdi;
+	while (trunk != NULL) {
+		
+		/* walk the branch and free irq descriptor if on branch */
 
-	for (irq = active_fds; irq != NULL; irq = irq->next) {
-		if ((irq->fd == fd) && (irq->irq == irqnum))
-			break;
-		i++;
+		if (trunk->leaf != NULL) {
+			free_leaf_irq_by_irq_and_dev(irq, dev, trunk);
+		}
+
+		if ((trunk->irq == irq) && (trunk->id == dev)) {
+			/* delete irq descriptor off trunk */
+			if (trunk->leaf != NULL) {
+				/* leaf non-null, attach instead of
+				   freed irq descriptor
+				 */
+				if (prev != NULL) {
+					prev->next = trunk->leaf;
+				} else {
+					active_fds = trunk->leaf;
+				}
+				trunk->leaf->next = trunk->next;
+				if (trunk->events) {
+					os_del_epoll_fd(trunk->fd);
+				}
+				kfree(trunk);
+			} else {
+				if (prev != NULL) {
+					prev->next = trunk->next;
+				} else {
+					active_fds = trunk->next;
+				}
+				if (trunk->events) {
+					os_del_epoll_fd(trunk->fd);
+				}
+				kfree(trunk);
+			}
+			/* irq + dev should be unique, it is also easier
+			   to restart than to juggle all the pointers after
+			   making holes in the list
+			*/
+			return 1;
+		}
+		prev = trunk;
+		trunk = trunk->next;
 	}
-	if (irq == NULL) {
-		printk(KERN_ERR "find_irq_by_fd doesn't have descriptor %d\n",
-		       fd);
-		goto out;
+	spin_unlock_irqrestore(&irq_lock, flags);
+	return 0;
+}
+static void free_irq_by_irq_and_dev(unsigned int irq, void *dev) {
+	while (do_free_irq_by_irq_and_dev(irq, dev) != 0) {
 	}
-	fdi = os_get_pollfd(i);
-	if ((fdi != -1) && (fdi != fd)) {
-		printk(KERN_ERR "find_irq_by_fd - mismatch between active_fds "
-		       "and pollfds, fd %d vs %d, need %d\n", irq->fd,
-		       fdi, fd);
-		irq = NULL;
-		goto out;
+}
+
+void free_irq_by_fd(int fd)
+{
+	struct irq_fd *irq, * found;
+	unsigned long flags;
+	spin_lock_irqsave(&irq_lock, flags);
+	found = find_irq_chain_by_fd(fd);
+	if (found == NULL) {
+		spin_unlock_irqrestore(&irq_lock, flags);
+		return;
 	}
-	*index_out = i;
- out:
-	return irq;
+	os_del_epoll_fd(fd);
+	/* free the whole chain */
+	while (found != NULL) {
+		irq = found;
+		found = found->leaf;
+		kfree(irq);
+	}
+	spin_unlock_irqrestore(&irq_lock, flags);
+	
 }
 
 void reactivate_fd(int fd, int irqnum)
 {
-	struct irq_fd *irq;
+	struct irq_fd *irq, * found;
 	unsigned long flags;
-	int i;
+	int acc_events = 0;
 
 	spin_lock_irqsave(&irq_lock, flags);
-	irq = find_irq_by_fd(fd, irqnum, &i);
-	if (irq == NULL) {
+	found = find_irq_chain_by_fd(fd);
+	if (found == NULL) {
 		spin_unlock_irqrestore(&irq_lock, flags);
 		return;
 	}
-	os_set_pollfd(i, irq->fd);
+	for (
+		irq = found;
+		irq != NULL;
+		irq = irq->leaf) {
+		acc_events |= irq->events;
+	}
+	if (os_add_epoll_fd(acc_events, fd, found) !=0) {
+		os_mod_epoll_fd(acc_events, fd, found);
+	}
 	spin_unlock_irqrestore(&irq_lock, flags);
-
 	add_sigio_fd(fd);
+
 }
 
 void deactivate_fd(int fd, int irqnum)
 {
 	struct irq_fd *irq;
 	unsigned long flags;
-	int i;
 
 	spin_lock_irqsave(&irq_lock, flags);
-	irq = find_irq_by_fd(fd, irqnum, &i);
+	irq = find_irq_by_fd(fd, irqnum);
 	if (irq == NULL) {
 		spin_unlock_irqrestore(&irq_lock, flags);
 		return;
 	}
 
-	os_set_pollfd(i, -1);
+	os_del_epoll_fd(irq->fd);
 	spin_unlock_irqrestore(&irq_lock, flags);
-
 	ignore_sigio_fd(fd);
+
+
 }
 EXPORT_SYMBOL(deactivate_fd);
 
@@ -272,12 +449,11 @@ int deactivate_all_fds(void)
 	int err;
 
 	for (irq = active_fds; irq != NULL; irq = irq->next) {
+		os_del_epoll_fd(irq->fd);   /* ignore err, just do it */
 		err = os_clear_fd_async(irq->fd);
 		if (err)
 			return err;
 	}
-	/* If there is a signal already queued, after unblocking ignore it */
-	os_set_ioignore();
 
 	return 0;
 }
@@ -311,13 +487,13 @@ int um_request_irq(unsigned int irq, int fd, int type,
 {
 	int err;
 
-	if (fd != -1) {
+	err = request_irq(irq, handler, irqflags, devname, dev_id);
+
+	if ((!err) && (fd != -1)) {
 		err = activate_fd(irq, fd, type, dev_id);
-		if (err)
-			return err;
 	}
 
-	return request_irq(irq, handler, irqflags, devname, dev_id);
+	return err;
 }
 
 EXPORT_SYMBOL(um_request_irq);
@@ -355,9 +531,9 @@ void __init init_IRQ(void)
 	int i;
 
 	irq_set_chip_and_handler(TIMER_IRQ, &SIGVTALRM_irq_type, handle_edge_irq);
-
-	for (i = 1; i < NR_IRQS; i++)
+	for (i = 1; i < NR_IRQS - 1 ; i++)
 		irq_set_chip_and_handler(i, &normal_irq_type, handle_edge_irq);
+	os_setup_epoll(MAX_EPOLL_EVENTS);
 }
 
 /*
@@ -385,11 +561,11 @@ void __init init_IRQ(void)
  * thread_info.
  *
  * There are three cases -
- *     The first interrupt on the stack - sets up the thread_info and
+ *	 The first interrupt on the stack - sets up the thread_info and
  * handles the interrupt
- *     A nested interrupt interrupting the copying of the thread_info -
+ *	 A nested interrupt interrupting the copying of the thread_info -
  * can't handle the interrupt, as the stack is in an unknown state
- *     A nested interrupt not interrupting the copying of the
+ *	 A nested interrupt not interrupting the copying of the
  * thread_info - doesn't do any setup, just handles the interrupt
  *
  * The first job is to figure out whether we interrupted stack setup.
diff --git a/arch/um/os-Linux/irq.c b/arch/um/os-Linux/irq.c
index b9afb74..837aa68 100644
--- a/arch/um/os-Linux/irq.c
+++ b/arch/um/os-Linux/irq.c
@@ -1,4 +1,5 @@
 /*
+ * Copyright (C) 2012 - 2014 Cisco Systems
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Licensed under the GPL
  */
@@ -6,6 +7,7 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <poll.h>
+#include <sys/epoll.h>
 #include <signal.h>
 #include <string.h>
 #include <irq_user.h>
@@ -16,117 +18,80 @@
  * Locked by irq_lock in arch/um/kernel/irq.c.  Changed by os_create_pollfd
  * and os_free_irq_by_cb, which are called under irq_lock.
  */
-static struct pollfd *pollfds = NULL;
-static int pollfds_num = 0;
-static int pollfds_size = 0;
 
-int os_waiting_for_events(struct irq_fd *active_fds)
+/* epoll support */
+
+
+static int epollfd = -1;
+
+int os_setup_epoll(int maxevents) {
+	epollfd = epoll_create(maxevents);
+	return epollfd;
+}
+
+int os_waiting_for_events_epoll(void *kernel_events, int maxevents)
 {
-	struct irq_fd *irq_fd;
-	int i, n, err;
+	int n, err;
 
-	n = poll(pollfds, pollfds_num, 0);
+	n = epoll_wait(epollfd,
+		(struct epoll_event *) kernel_events, maxevents, 0);
 	if (n < 0) {
 		err = -errno;
 		if (errno != EINTR)
-			printk(UM_KERN_ERR "os_waiting_for_events:"
-			       " poll returned %d, errno = %d\n", n, errno);
+			printk(
+				UM_KERN_ERR "os_waiting_for_events:"
+				" poll returned %d, error = %s\n", n,
+				strerror(errno)
+			);
 		return err;
 	}
 
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
+int os_add_epoll_fd (int events, int fd, void * data) {
+	struct epoll_event event;
+	int result;
 
-	pollfds[pollfds_num] = ((struct pollfd) { .fd		= fd,
-						  .events	= events,
-						  .revents	= 0 });
-	pollfds_num++;
-
-	return 0;
+	event.data.ptr = data;
+	event.events = events | EPOLLET;
+	result = epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &event);
+	if ((result) && (errno == EEXIST)) {
+		result = os_mod_epoll_fd (events, fd, data);
+	}
+	if (result) {
+		printk("epollctl add err fd %d, %s\n", fd, strerror(errno));
+	}
+	return result;
 }
 
-void os_free_irq_by_cb(int (*test)(struct irq_fd *, void *), void *arg,
-		struct irq_fd *active_fds, struct irq_fd ***last_irq_ptr2)
-{
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
+int os_mod_epoll_fd (int events, int fd, void * data) {
+	struct epoll_event event;
+	int result;
+	event.data.ptr = data;
+	event.events = events;
+	result = epoll_ctl(epollfd, EPOLL_CTL_MOD, fd, &event);
+	if (result) {
+		printk("epollctl mod err fd %d, %s\n", fd, strerror(errno));
 	}
- out:
-	return;
+	return result;
 }
 
-int os_get_pollfd(int i)
-{
-	return pollfds[i].fd;
+int os_del_epoll_fd (int fd) {
+	struct epoll_event event;
+	int result;
+	result = epoll_ctl(epollfd, EPOLL_CTL_DEL, fd, &event);
+	if (result) {
+		printk("epollctl del err %s\n", strerror(errno));
+	}
+	return result;
 }
 
-void os_set_pollfd(int i, int fd)
+void os_free_irq_by_cb(int (*test)(struct irq_fd *, void *), void *arg,
+		struct irq_fd *active_fds, struct irq_fd ***last_irq_ptr2)
 {
-	pollfds[i].fd = fd;
+	printk("Someone invoking obsolete deactivate_by_CB!!!\n");
+	return;
 }
 
 void os_set_ioignore(void)
-- 
1.7.10.4


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

