Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hNcuL-0002eD-7G
 for linux-um@lists.infradead.org; Mon, 06 May 2019 12:39:52 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 1/5] arch: um: Fix IRQ controller regression on console read
Date: Mon,  6 May 2019 14:39:35 +0200
Message-Id: <20190506123939.21091-2-johannes@sipsolutions.net>
In-Reply-To: <20190506123939.21091-1-johannes@sipsolutions.net>
References: <20190506123939.21091-1-johannes@sipsolutions.net>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: j@w1.fi

From: Jouni Malinen <j@w1.fi>

The conversion of UML to use epoll based IRQ controller claimed that
clone_one_chan() can safely call um_free_irq() while starting to ignore
the delay_free_irq parameter that explicitly noted that the IRQ cannot
be freed because this is being called from chan_interrupt(). This
resulted in free_irq() getting called in interrupt context ("Trying to
free IRQ 6 from IRQ context!").

Fix this by restoring previously used delay_free_irq processing.

Fixes: ff6a17989c08 ("Epoll based IRQ controller")
Signed-off-by: Jouni Malinen <j@w1.fi>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/chan_kern.c | 52 +++++++++++++++++++++++++++++++------
 arch/um/kernel/irq.c        |  4 +++
 2 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/arch/um/drivers/chan_kern.c b/arch/um/drivers/chan_kern.c
index a4e64edb8f38..749d2bf59599 100644
--- a/arch/um/drivers/chan_kern.c
+++ b/arch/um/drivers/chan_kern.c
@@ -171,19 +171,55 @@ int enable_chan(struct line *line)
 	return err;
 }
 
+/* Items are added in IRQ context, when free_irq can't be called, and
+ * removed in process context, when it can.
+ * This handles interrupt sources which disappear, and which need to
+ * be permanently disabled.  This is discovered in IRQ context, but
+ * the freeing of the IRQ must be done later.
+ */
+static DEFINE_SPINLOCK(irqs_to_free_lock);
+static LIST_HEAD(irqs_to_free);
+
+void free_irqs(void)
+{
+	struct chan *chan;
+	LIST_HEAD(list);
+	struct list_head *ele;
+	unsigned long flags;
+
+	spin_lock_irqsave(&irqs_to_free_lock, flags);
+	list_splice_init(&irqs_to_free, &list);
+	spin_unlock_irqrestore(&irqs_to_free_lock, flags);
+
+	list_for_each(ele, &list) {
+		chan = list_entry(ele, struct chan, free_list);
+
+		if (chan->input && chan->enabled)
+			um_free_irq(chan->line->driver->read_irq, chan);
+		if (chan->output && chan->enabled)
+			um_free_irq(chan->line->driver->write_irq, chan);
+		chan->enabled = 0;
+	}
+}
+
 static void close_one_chan(struct chan *chan, int delay_free_irq)
 {
+	unsigned long flags;
+
 	if (!chan->opened)
 		return;
 
-    /* we can safely call free now - it will be marked
-     *  as free and freed once the IRQ stopped processing
-     */
-	if (chan->input && chan->enabled)
-		um_free_irq(chan->line->driver->read_irq, chan);
-	if (chan->output && chan->enabled)
-		um_free_irq(chan->line->driver->write_irq, chan);
-	chan->enabled = 0;
+	if (delay_free_irq) {
+		spin_lock_irqsave(&irqs_to_free_lock, flags);
+		list_add(&chan->free_list, &irqs_to_free);
+		spin_unlock_irqrestore(&irqs_to_free_lock, flags);
+	} else {
+		if (chan->input && chan->enabled)
+			um_free_irq(chan->line->driver->read_irq, chan);
+		if (chan->output && chan->enabled)
+			um_free_irq(chan->line->driver->write_irq, chan);
+		chan->enabled = 0;
+	}
 	if (chan->ops->close != NULL)
 		(*chan->ops->close)(chan->fd, chan->data);
 
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index f4874b7ec503..52444be9f162 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -21,6 +21,8 @@
 #include <irq_user.h>
 
 
+extern void free_irqs(void);
+
 /* When epoll triggers we do not know why it did so
  * we can also have different IRQs for read and write.
  * This is why we keep a small irq_fd array for each fd -
@@ -100,6 +102,8 @@ void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 			}
 		}
 	}
+
+	free_irqs();
 }
 
 static int assign_epoll_events_to_irq(struct irq_entry *irq_entry)
-- 
2.17.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

