Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khHwu-0006f1-E7
 for linux-um@lists.infradead.org; Mon, 23 Nov 2020 19:56:33 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 1/7] um: support dynamic IRQ allocation
Date: Mon, 23 Nov 2020 20:56:15 +0100
Message-Id: <20201123205445.1568a46e8f64.I146af7c40025c748c020888df792d22c80b161e8@changeid>
In-Reply-To: <20201123195621.275470-1-johannes@sipsolutions.net>
References: <20201123195621.275470-1-johannes@sipsolutions.net>
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

It's cumbersome and error-prone to keep adding fixed IRQ numbers,
and for proper device wakeup support for the virtio/vhost-user
support we need to have different IRQs for each device. Even if
in theory two IRQs (with and without wake) might be sufficient,
it's much easier to reason about it when we have dynamic number
assignment. It also makes it easier to add new devices that may
dynamically exist or depending on the configuration, etc.

Add support for this, up to 64 IRQs (the same limit as epoll FDs
we have right now). Since it's not easy to port all the existing
places to dynamic allocation (some data is statically initialized)
keep the low numbers are reserved for the existing hard-coded IRQ
numbers.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/line.c            | 18 ++++++++++-----
 arch/um/drivers/mconsole_kern.c   |  2 +-
 arch/um/drivers/net_kern.c        |  2 +-
 arch/um/drivers/port_kern.c       |  4 ++--
 arch/um/drivers/random.c          |  2 +-
 arch/um/drivers/ubd_kern.c        |  2 +-
 arch/um/drivers/vector_kern.c     |  4 ++--
 arch/um/drivers/virtio_uml.c      |  4 ++--
 arch/um/drivers/xterm_kern.c      |  2 +-
 arch/um/include/asm/irq.h         |  6 ++---
 arch/um/include/shared/irq_kern.h | 12 +++++-----
 arch/um/kernel/irq.c              | 37 ++++++++++++++++++++++++++-----
 arch/um/kernel/sigio.c            |  2 +-
 13 files changed, 65 insertions(+), 32 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 14ad9f495fe6..2d68f58ac54b 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -262,19 +262,25 @@ static irqreturn_t line_write_interrupt(int irq, void *data)
 int line_setup_irq(int fd, int input, int output, struct line *line, void *data)
 {
 	const struct line_driver *driver = line->driver;
-	int err = 0;
+	int err;
 
-	if (input)
+	if (input) {
 		err = um_request_irq(driver->read_irq, fd, IRQ_READ,
 				     line_interrupt, IRQF_SHARED,
 				     driver->read_irq_name, data);
-	if (err)
-		return err;
-	if (output)
+		if (err < 0)
+			return err;
+	}
+
+	if (output) {
 		err = um_request_irq(driver->write_irq, fd, IRQ_WRITE,
 				     line_write_interrupt, IRQF_SHARED,
 				     driver->write_irq_name, data);
-	return err;
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
 }
 
 static int line_activate(struct tty_port *port, struct tty_struct *tty)
diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index a2e680f7d39f..6d00af25ec6b 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -738,7 +738,7 @@ static int __init mconsole_init(void)
 
 	err = um_request_irq(MCONSOLE_IRQ, sock, IRQ_READ, mconsole_interrupt,
 			     IRQF_SHARED, "mconsole", (void *)sock);
-	if (err) {
+	if (err < 0) {
 		printk(KERN_ERR "Failed to get IRQ for management console\n");
 		goto out;
 	}
diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 1802cf4ef5a5..2fc0b038ff8a 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -160,7 +160,7 @@ static int uml_net_open(struct net_device *dev)
 
 	err = um_request_irq(dev->irq, lp->fd, IRQ_READ, uml_net_interrupt,
 			     IRQF_SHARED, dev->name, dev);
-	if (err != 0) {
+	if (err < 0) {
 		printk(KERN_ERR "uml_net_open: failed to get irq(%d)\n", err);
 		err = -ENETUNREACH;
 		goto out_close;
diff --git a/arch/um/drivers/port_kern.c b/arch/um/drivers/port_kern.c
index a47ca5376d9d..efa8b7304090 100644
--- a/arch/um/drivers/port_kern.c
+++ b/arch/um/drivers/port_kern.c
@@ -100,7 +100,7 @@ static int port_accept(struct port_list *port)
 		  .port 	= port });
 
 	if (um_request_irq(TELNETD_IRQ, socket[0], IRQ_READ, pipe_interrupt,
-			  IRQF_SHARED, "telnetd", conn)) {
+			  IRQF_SHARED, "telnetd", conn) < 0) {
 		printk(KERN_ERR "port_accept : failed to get IRQ for "
 		       "telnetd\n");
 		goto out_free;
@@ -182,7 +182,7 @@ void *port_data(int port_num)
 	}
 
 	if (um_request_irq(ACCEPT_IRQ, fd, IRQ_READ, port_interrupt,
-			  IRQF_SHARED, "port", port)) {
+			  IRQF_SHARED, "port", port) < 0) {
 		printk(KERN_ERR "Failed to get IRQ for port %d\n", port_num);
 		goto out_close;
 	}
diff --git a/arch/um/drivers/random.c b/arch/um/drivers/random.c
index ce115fce52f0..385cb08d7ec2 100644
--- a/arch/um/drivers/random.c
+++ b/arch/um/drivers/random.c
@@ -129,7 +129,7 @@ static int __init rng_init (void)
 
 	err = um_request_irq(RANDOM_IRQ, random_fd, IRQ_READ, random_interrupt,
 			     0, "random", NULL);
-	if (err)
+	if (err < 0)
 		goto err_out_cleanup_hw;
 
 	sigio_broken(random_fd, 1);
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index eae8c83364f7..d4c39e595c72 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1204,7 +1204,7 @@ static int __init ubd_driver_init(void){
 	}
 	err = um_request_irq(UBD_IRQ, thread_fd, IRQ_READ, ubd_intr,
 			     0, "ubd", ubd_devs);
-	if(err != 0)
+	if(err < 0)
 		printk(KERN_ERR "um_request_irq failed - errno = %d\n", -err);
 	return 0;
 }
diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 555203e3e7b4..e78a54ea72a4 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1271,7 +1271,7 @@ static int vector_net_open(struct net_device *dev)
 		irq_rr + VECTOR_BASE_IRQ, vp->fds->rx_fd,
 			IRQ_READ, vector_rx_interrupt,
 			IRQF_SHARED, dev->name, dev);
-	if (err != 0) {
+	if (err < 0) {
 		netdev_err(dev, "vector_open: failed to get rx irq(%d)\n", err);
 		err = -ENETUNREACH;
 		goto out_close;
@@ -1286,7 +1286,7 @@ static int vector_net_open(struct net_device *dev)
 			irq_rr + VECTOR_BASE_IRQ, vp->fds->tx_fd,
 				IRQ_WRITE, vector_tx_interrupt,
 				IRQF_SHARED, dev->name, dev);
-		if (err != 0) {
+		if (err < 0) {
 			netdev_err(dev,
 				"vector_open: failed to get tx irq(%d)\n", err);
 			err = -ENETUNREACH;
diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index a6c4bb6c2c01..f76b8da28d20 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -412,7 +412,7 @@ static int vhost_user_init_slave_req(struct virtio_uml_device *vu_dev)
 	rc = um_request_irq(VIRTIO_IRQ, vu_dev->req_fd, IRQ_READ,
 			    vu_req_interrupt, IRQF_SHARED,
 			    vu_dev->pdev->name, vu_dev);
-	if (rc)
+	if (rc < 0)
 		goto err_close;
 
 	rc = vhost_user_send_no_payload_fd(vu_dev, VHOST_USER_SET_SLAVE_REQ_FD,
@@ -854,7 +854,7 @@ static int vu_setup_vq_call_fd(struct virtio_uml_device *vu_dev,
 	info->call_fd = call_fds[0];
 	rc = um_request_irq(VIRTIO_IRQ, info->call_fd, IRQ_READ,
 			    vu_interrupt, IRQF_SHARED, info->name, vq);
-	if (rc)
+	if (rc < 0)
 		goto close_both;
 
 	rc = vhost_user_set_vring_call(vu_dev, vq->index, call_fds[1]);
diff --git a/arch/um/drivers/xterm_kern.c b/arch/um/drivers/xterm_kern.c
index d64ef6d0d463..50f11b7b4774 100644
--- a/arch/um/drivers/xterm_kern.c
+++ b/arch/um/drivers/xterm_kern.c
@@ -51,7 +51,7 @@ int xterm_fd(int socket, int *pid_out)
 
 	err = um_request_irq(XTERM_IRQ, socket, IRQ_READ, xterm_interrupt,
 			     IRQF_SHARED, "xterm", data);
-	if (err) {
+	if (err < 0) {
 		printk(KERN_ERR "xterm_fd : failed to get IRQ for xterm, "
 		       "err = %d\n",  err);
 		ret = err;
diff --git a/arch/um/include/asm/irq.h b/arch/um/include/asm/irq.h
index 42c6205e2dc4..b6fa6301c75b 100644
--- a/arch/um/include/asm/irq.h
+++ b/arch/um/include/asm/irq.h
@@ -24,14 +24,14 @@
 #define VECTOR_BASE_IRQ		(VIRTIO_IRQ + 1)
 #define VECTOR_IRQ_SPACE	8
 
-#define LAST_IRQ (VECTOR_IRQ_SPACE + VECTOR_BASE_IRQ - 1)
+#define UM_FIRST_DYN_IRQ (VECTOR_IRQ_SPACE + VECTOR_BASE_IRQ)
 
 #else
 
-#define LAST_IRQ VIRTIO_IRQ
+#define UM_FIRST_DYN_IRQ (VIRTIO_IRQ + 1)
 
 #endif
 
-#define NR_IRQS (LAST_IRQ + 1)
+#define NR_IRQS			64
 
 #endif
diff --git a/arch/um/include/shared/irq_kern.h b/arch/um/include/shared/irq_kern.h
index 7cd1a10c6244..7c04a0fd3a27 100644
--- a/arch/um/include/shared/irq_kern.h
+++ b/arch/um/include/shared/irq_kern.h
@@ -9,10 +9,10 @@
 #include <linux/interrupt.h>
 #include <asm/ptrace.h>
 
-extern int um_request_irq(unsigned int irq, int fd, int type,
-			  irq_handler_t handler,
-			  unsigned long irqflags,  const char * devname,
-			  void *dev_id);
-void um_free_irq(unsigned int irq, void *dev);
-#endif
+#define UM_IRQ_ALLOC	-1
 
+int um_request_irq(int irq, int fd, int type, irq_handler_t handler,
+		   unsigned long irqflags,  const char * devname,
+		   void *dev_id);
+void um_free_irq(int irq, void *dev_id);
+#endif
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 3577118bb4a5..b94c72f56617 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -19,6 +19,7 @@
 #include <kern_util.h>
 #include <os.h>
 #include <irq_user.h>
+#include <irq_kern.h>
 
 
 extern void free_irqs(void);
@@ -38,6 +39,7 @@ struct irq_entry {
 static struct irq_entry *active_fds;
 
 static DEFINE_SPINLOCK(irq_lock);
+static DECLARE_BITMAP(irqs_allocated, NR_IRQS);
 
 static void irq_io_loop(struct irq_fd *irq, struct uml_pt_regs *regs)
 {
@@ -421,27 +423,52 @@ unsigned int do_IRQ(int irq, struct uml_pt_regs *regs)
 	return 1;
 }
 
-void um_free_irq(unsigned int irq, void *dev)
+void um_free_irq(int irq, void *dev)
 {
+	if (WARN(irq < 0 || irq > NR_IRQS, "freeing invalid irq %d", irq))
+		return;
+
 	free_irq_by_irq_and_dev(irq, dev);
 	free_irq(irq, dev);
+	clear_bit(irq, irqs_allocated);
 }
 EXPORT_SYMBOL(um_free_irq);
 
-int um_request_irq(unsigned int irq, int fd, int type,
+int um_request_irq(int irq, int fd, int type,
 		   irq_handler_t handler,
 		   unsigned long irqflags, const char * devname,
 		   void *dev_id)
 {
 	int err;
 
+	if (irq == UM_IRQ_ALLOC) {
+		int i;
+
+		for (i = UM_FIRST_DYN_IRQ; i < NR_IRQS; i++) {
+			if (!test_and_set_bit(i, irqs_allocated)) {
+				irq = i;
+				break;
+			}
+		}
+	}
+
+	if (irq < 0)
+		return -ENOSPC;
+
 	if (fd != -1) {
 		err = activate_fd(irq, fd, type, dev_id);
 		if (err)
-			return err;
+			goto error;
 	}
 
-	return request_irq(irq, handler, irqflags, devname, dev_id);
+	err = request_irq(irq, handler, irqflags, devname, dev_id);
+	if (err < 0)
+		goto error;
+
+	return irq;
+error:
+	clear_bit(irq, irqs_allocated);
+	return err;
 }
 
 EXPORT_SYMBOL(um_request_irq);
@@ -480,7 +507,7 @@ void __init init_IRQ(void)
 	irq_set_chip_and_handler(TIMER_IRQ, &SIGVTALRM_irq_type, handle_edge_irq);
 
 
-	for (i = 1; i <= LAST_IRQ; i++)
+	for (i = 1; i < NR_IRQS; i++)
 		irq_set_chip_and_handler(i, &normal_irq_type, handle_edge_irq);
 	/* Initialize EPOLL Loop */
 	os_setup_epoll();
diff --git a/arch/um/kernel/sigio.c b/arch/um/kernel/sigio.c
index d1cffc2a7f21..5085a50c3b8c 100644
--- a/arch/um/kernel/sigio.c
+++ b/arch/um/kernel/sigio.c
@@ -25,7 +25,7 @@ int write_sigio_irq(int fd)
 
 	err = um_request_irq(SIGIO_WRITE_IRQ, fd, IRQ_READ, sigio_interrupt,
 			     0, "write sigio", NULL);
-	if (err) {
+	if (err < 0) {
 		printk(KERN_ERR "write_sigio_irq : um_request_irq failed, "
 		       "err = %d\n", err);
 		return -1;
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

