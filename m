Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkQnl-0008Ok-QS
 for linux-um@lists.infradead.org; Wed, 02 Dec 2020 12:00:09 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 7/7] um: simplify IRQ handling code
Date: Wed,  2 Dec 2020 12:59:56 +0100
Message-Id: <20201202125915.762ac2a43be6.I811873233b8d71fbde9154b84c85b498521e3b12@changeid>
In-Reply-To: <20201202115956.42963-1-johannes@sipsolutions.net>
References: <20201202115956.42963-1-johannes@sipsolutions.net>
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
Cc: Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

Reduce dynamic allocations (and thereby cache misses) by simply
embedding the registration data for IRQs in the irq_entry, we
never supported these being really dynamic anyway as only one
was ever allowed ("Trying to reregister ...").

Lockless behaviour is preserved by removing the FD from the poll
set appropriately, but we use reg->events to indicate whether or
not this entry is used, rather than dynamically allocating them.

Also port the list of IRQ entries to list_head instead of the
current open-coded singly-linked list implementation, just for
sanity.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/irq.c | 370 +++++++++++++++----------------------------
 1 file changed, 128 insertions(+), 242 deletions(-)

diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 9e8f776bb43a..482269580b79 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -29,26 +29,23 @@ extern void free_irqs(void);
  * This is why we keep a small irq_reg array for each fd -
  * one entry per IRQ type
  */
-
 struct irq_reg {
 	void *id;
-	enum um_irq_type type;
 	int irq;
+	/* it's cheaper to store this than to query it */
 	int events;
 	bool active;
 	bool pending;
-	bool purge;
 };
 
 struct irq_entry {
-	struct irq_entry *next;
+	struct list_head list;
 	int fd;
-	struct irq_reg *irq_array[NUM_IRQ_TYPES];
+	struct irq_reg reg[NUM_IRQ_TYPES];
 };
 
-static struct irq_entry *active_fds;
-
 static DEFINE_SPINLOCK(irq_lock);
+static LIST_HEAD(active_fds);
 static DECLARE_BITMAP(irqs_allocated, NR_IRQS);
 
 static void irq_io_loop(struct irq_reg *irq, struct uml_pt_regs *regs)
@@ -61,12 +58,13 @@ static void irq_io_loop(struct irq_reg *irq, struct uml_pt_regs *regs)
  */
 	if (irq->active) {
 		irq->active = false;
+
 		do {
 			irq->pending = false;
 			do_IRQ(irq->irq, regs);
-		} while (irq->pending && (!irq->purge));
-		if (!irq->purge)
-			irq->active = true;
+		} while (irq->pending);
+
+		irq->active = true;
 	} else {
 		irq->pending = true;
 	}
@@ -75,9 +73,7 @@ static void irq_io_loop(struct irq_reg *irq, struct uml_pt_regs *regs)
 void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 {
 	struct irq_entry *irq_entry;
-	struct irq_reg *irq;
-
-	int n, i, j;
+	int n, i;
 
 	while (1) {
 		/* This is now lockless - epoll keeps back-referencesto the irqs
@@ -96,21 +92,18 @@ void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 		}
 
 		for (i = 0; i < n ; i++) {
-			/* Epoll back reference is the entry with 2 irq_reg
-			 * leaves - one for each irq type.
-			 */
-			irq_entry = (struct irq_entry *)
-				os_epoll_get_data_pointer(i);
-			for (j = 0; j < NUM_IRQ_TYPES ; j++) {
-				irq = irq_entry->irq_array[j];
-				if (irq == NULL)
+			enum um_irq_type t;
+
+			irq_entry = os_epoll_get_data_pointer(i);
+
+			for (t = 0; t < NUM_IRQ_TYPES; t++) {
+				int events = irq_entry->reg[t].events;
+
+				if (!events)
 					continue;
-				if (os_epoll_triggered(i, irq->events) > 0)
-					irq_io_loop(irq, regs);
-				if (irq->purge) {
-					irq_entry->irq_array[j] = NULL;
-					kfree(irq);
-				}
+
+				if (os_epoll_triggered(i, events) > 0)
+					irq_io_loop(&irq_entry->reg[t], regs);
 			}
 		}
 	}
@@ -118,32 +111,59 @@ void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 	free_irqs();
 }
 
-static int assign_epoll_events_to_irq(struct irq_entry *irq_entry)
+static struct irq_entry *get_irq_entry_by_fd(int fd)
 {
-	int i;
-	int events = 0;
-	struct irq_reg *irq;
+	struct irq_entry *walk;
 
-	for (i = 0; i < NUM_IRQ_TYPES ; i++) {
-		irq = irq_entry->irq_array[i];
-		if (irq != NULL)
-			events = irq->events | events;
-	}
-	if (events > 0) {
-	/* os_add_epoll will call os_mod_epoll if this already exists */
-		return os_add_epoll_fd(events, irq_entry->fd, irq_entry);
+	lockdep_assert_held(&irq_lock);
+
+	list_for_each_entry(walk, &active_fds, list) {
+		if (walk->fd == fd)
+			return walk;
 	}
-	/* No events - delete */
-	return os_del_epoll_fd(irq_entry->fd);
+
+	return NULL;
+}
+
+static void free_irq_entry(struct irq_entry *to_free, bool remove)
+{
+	if (!to_free)
+		return;
+
+	if (remove)
+		os_del_epoll_fd(to_free->fd);
+	list_del(&to_free->list);
+	kfree(to_free);
 }
 
+static bool update_irq_entry(struct irq_entry *entry)
+{
+	enum um_irq_type i;
+	int events = 0;
+
+	for (i = 0; i < NUM_IRQ_TYPES; i++)
+		events |= entry->reg[i].events;
 
+	if (events) {
+		/* will modify (instead of add) if needed */
+		os_add_epoll_fd(events, entry->fd, entry);
+		return true;
+	}
+
+	os_del_epoll_fd(entry->fd);
+	return false;
+}
+
+static void update_or_free_irq_entry(struct irq_entry *entry)
+{
+	if (!update_irq_entry(entry))
+		free_irq_entry(entry, false);
+}
 
 static int activate_fd(int irq, int fd, enum um_irq_type type, void *dev_id)
 {
-	struct irq_reg *new_fd;
 	struct irq_entry *irq_entry;
-	int i, err, events;
+	int err, events = os_event_mask(type);
 	unsigned long flags;
 
 	err = os_set_fd_async(fd);
@@ -151,73 +171,34 @@ static int activate_fd(int irq, int fd, enum um_irq_type type, void *dev_id)
 		goto out;
 
 	spin_lock_irqsave(&irq_lock, flags);
-
-	/* Check if we have an entry for this fd */
-
-	err = -EBUSY;
-	for (irq_entry = active_fds;
-		irq_entry != NULL; irq_entry = irq_entry->next) {
-		if (irq_entry->fd == fd)
-			break;
-	}
-
-	if (irq_entry == NULL) {
-		/* This needs to be atomic as it may be called from an
-		 * IRQ context.
-		 */
-		irq_entry = kmalloc(sizeof(struct irq_entry), GFP_ATOMIC);
-		if (irq_entry == NULL) {
-			printk(KERN_ERR
-				"Failed to allocate new IRQ entry\n");
+	irq_entry = get_irq_entry_by_fd(fd);
+	if (irq_entry) {
+		/* cannot register the same FD twice with the same type */
+		if (WARN_ON(irq_entry->reg[type].events)) {
+			err = -EALREADY;
 			goto out_unlock;
 		}
-		irq_entry->fd = fd;
-		for (i = 0; i < NUM_IRQ_TYPES; i++)
-			irq_entry->irq_array[i] = NULL;
-		irq_entry->next = active_fds;
-		active_fds = irq_entry;
-	}
-
-	/* Check if we are trying to re-register an interrupt for a
-	 * particular fd
-	 */
 
-	if (irq_entry->irq_array[type] != NULL) {
-		printk(KERN_ERR
-			"Trying to reregister IRQ %d FD %d TYPE %d ID %p\n",
-			irq, fd, type, dev_id
-		);
-		goto out_unlock;
+		/* temporarily disable to avoid IRQ-side locking */
+		os_del_epoll_fd(fd);
 	} else {
-		/* New entry for this fd */
-
-		err = -ENOMEM;
-		new_fd = kmalloc(sizeof(struct irq_reg), GFP_ATOMIC);
-		if (new_fd == NULL)
+		irq_entry = kzalloc(sizeof(*irq_entry), GFP_ATOMIC);
+		if (!irq_entry) {
+			err = -ENOMEM;
 			goto out_unlock;
-
-		events = os_event_mask(type);
-
-		*new_fd = ((struct irq_reg) {
-			.id		= dev_id,
-			.irq		= irq,
-			.type		= type,
-			.events		= events,
-			.active		= true,
-			.pending	= false,
-			.purge		= false
-		});
-		/* Turn off any IO on this fd - allows us to
-		 * avoid locking the IRQ loop
-		 */
-		os_del_epoll_fd(irq_entry->fd);
-		irq_entry->irq_array[type] = new_fd;
+		}
+		irq_entry->fd = fd;
+		list_add_tail(&irq_entry->list, &active_fds);
+		maybe_sigio_broken(fd);
 	}
 
-	/* Turn back IO on with the correct (new) IO event mask */
-	assign_epoll_events_to_irq(irq_entry);
+	irq_entry->reg[type].id = dev_id;
+	irq_entry->reg[type].irq = irq;
+	irq_entry->reg[type].active = true;
+	irq_entry->reg[type].events = events;
+
+	WARN_ON(!update_irq_entry(irq_entry));
 	spin_unlock_irqrestore(&irq_lock, flags);
-	maybe_sigio_broken(fd);
 
 	return 0;
 out_unlock:
@@ -227,104 +208,10 @@ static int activate_fd(int irq, int fd, enum um_irq_type type, void *dev_id)
 }
 
 /*
- * Walk the IRQ list and dispose of any unused entries.
- * Should be done under irq_lock.
+ * Remove the entry or entries for a specific FD, if you
+ * don't want to remove all the possible entries then use
+ * um_free_irq() or deactivate_fd() instead.
  */
-
-static void garbage_collect_irq_entries(void)
-{
-	int i;
-	bool reap;
-	struct irq_entry *walk;
-	struct irq_entry *previous = NULL;
-	struct irq_entry *to_free;
-
-	if (active_fds == NULL)
-		return;
-	walk = active_fds;
-	while (walk != NULL) {
-		reap = true;
-		for (i = 0; i < NUM_IRQ_TYPES ; i++) {
-			if (walk->irq_array[i] != NULL) {
-				reap = false;
-				break;
-			}
-		}
-		if (reap) {
-			if (previous == NULL)
-				active_fds = walk->next;
-			else
-				previous->next = walk->next;
-			to_free = walk;
-		} else {
-			to_free = NULL;
-		}
-		walk = walk->next;
-		kfree(to_free);
-	}
-}
-
-/*
- * Walk the IRQ list and get the descriptor for our FD
- */
-
-static struct irq_entry *get_irq_entry_by_fd(int fd)
-{
-	struct irq_entry *walk = active_fds;
-
-	while (walk != NULL) {
-		if (walk->fd == fd)
-			return walk;
-		walk = walk->next;
-	}
-	return NULL;
-}
-
-
-/*
- * Walk the IRQ list and dispose of an entry for a specific
- * device and number. Note - if sharing an IRQ for read
- * and write for the same FD it will be disposed in either case.
- * If this behaviour is undesirable use different IRQ ids.
- */
-
-#define IGNORE_IRQ 1
-#define IGNORE_DEV (1<<1)
-
-static void do_free_by_irq_and_dev(
-	struct irq_entry *irq_entry,
-	unsigned int irq,
-	void *dev,
-	int flags
-)
-{
-	int i;
-	struct irq_reg *to_free;
-
-	for (i = 0; i < NUM_IRQ_TYPES ; i++) {
-		if (irq_entry->irq_array[i] != NULL) {
-			if (
-			((flags & IGNORE_IRQ) ||
-				(irq_entry->irq_array[i]->irq == irq)) &&
-			((flags & IGNORE_DEV) ||
-				(irq_entry->irq_array[i]->id == dev))
-			) {
-				/* Turn off any IO on this fd - allows us to
-				 * avoid locking the IRQ loop
-				 */
-				os_del_epoll_fd(irq_entry->fd);
-				to_free = irq_entry->irq_array[i];
-				irq_entry->irq_array[i] = NULL;
-				assign_epoll_events_to_irq(irq_entry);
-				if (to_free->active)
-					to_free->purge = true;
-				else
-					kfree(to_free);
-			}
-		}
-	}
-}
-
 void free_irq_by_fd(int fd)
 {
 	struct irq_entry *to_free;
@@ -332,58 +219,64 @@ void free_irq_by_fd(int fd)
 
 	spin_lock_irqsave(&irq_lock, flags);
 	to_free = get_irq_entry_by_fd(fd);
-	if (to_free != NULL) {
-		do_free_by_irq_and_dev(
-			to_free,
-			-1,
-			NULL,
-			IGNORE_IRQ | IGNORE_DEV
-		);
-	}
-	garbage_collect_irq_entries();
+	free_irq_entry(to_free, true);
 	spin_unlock_irqrestore(&irq_lock, flags);
 }
 EXPORT_SYMBOL(free_irq_by_fd);
 
 static void free_irq_by_irq_and_dev(unsigned int irq, void *dev)
 {
-	struct irq_entry *to_free;
+	struct irq_entry *entry;
 	unsigned long flags;
 
 	spin_lock_irqsave(&irq_lock, flags);
-	to_free = active_fds;
-	while (to_free != NULL) {
-		do_free_by_irq_and_dev(
-			to_free,
-			irq,
-			dev,
-			0
-		);
-		to_free = to_free->next;
+	list_for_each_entry(entry, &active_fds, list) {
+		enum um_irq_type i;
+
+		for (i = 0; i < NUM_IRQ_TYPES; i++) {
+			struct irq_reg *reg = &entry->reg[i];
+
+			if (!reg->events)
+				continue;
+			if (reg->irq != irq)
+				continue;
+			if (reg->id != dev)
+				continue;
+
+			os_del_epoll_fd(entry->fd);
+			reg->events = 0;
+			update_or_free_irq_entry(entry);
+			goto out;
+		}
 	}
-	garbage_collect_irq_entries();
+out:
 	spin_unlock_irqrestore(&irq_lock, flags);
 }
 
-
 void deactivate_fd(int fd, int irqnum)
 {
-	struct irq_entry *to_free;
+	struct irq_entry *entry;
 	unsigned long flags;
+	enum um_irq_type i;
 
 	os_del_epoll_fd(fd);
+
 	spin_lock_irqsave(&irq_lock, flags);
-	to_free = get_irq_entry_by_fd(fd);
-	if (to_free != NULL) {
-		do_free_by_irq_and_dev(
-			to_free,
-			irqnum,
-			NULL,
-			IGNORE_DEV
-		);
+	entry = get_irq_entry_by_fd(fd);
+	if (!entry)
+		goto out;
+
+	for (i = 0; i < NUM_IRQ_TYPES; i++) {
+		if (!entry->reg[i].events)
+			continue;
+		if (entry->reg[i].irq == irqnum)
+			entry->reg[i].events = 0;
 	}
-	garbage_collect_irq_entries();
+
+	update_or_free_irq_entry(entry);
+out:
 	spin_unlock_irqrestore(&irq_lock, flags);
+
 	ignore_sigio_fd(fd);
 }
 EXPORT_SYMBOL(deactivate_fd);
@@ -396,24 +289,17 @@ EXPORT_SYMBOL(deactivate_fd);
  */
 int deactivate_all_fds(void)
 {
-	struct irq_entry *to_free;
+	struct irq_entry *entry;
 
 	/* Stop IO. The IRQ loop has no lock so this is our
 	 * only way of making sure we are safe to dispose
 	 * of all IRQ handlers
 	 */
 	os_set_ioignore();
-	to_free = active_fds;
-	while (to_free != NULL) {
-		do_free_by_irq_and_dev(
-			to_free,
-			-1,
-			NULL,
-			IGNORE_IRQ | IGNORE_DEV
-		);
-		to_free = to_free->next;
-	}
-	/* don't garbage collect - we can no longer call kfree() here */
+
+	/* we can no longer call kfree() here so just deactivate */
+	list_for_each_entry(entry, &active_fds, list)
+		os_del_epoll_fd(entry->fd);
 	os_close_epoll_fd();
 	return 0;
 }
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

