Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
From: Yong Zhang <yong.zhang0@gmail.com>
Date: Wed,  7 Sep 2011 16:10:18 +0800
Message-Id: <1315383059-3673-22-git-send-email-yong.zhang0@gmail.com>
In-Reply-To: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
References: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
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
Subject: [uml-devel] [PATCH 21/62] um: irq: Remove IRQF_DISABLED
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, user-mode-linux-user@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, "David S. Miller" <davem@davemloft.net>, Yong Zhang <yong.zhang0@gmail.com>, Will Newton <will.newton@gmail.com>, user-mode-linux-devel@lists.sourceforge.net, Tejun Heo <tj@kernel.org>, WANG Cong <xiyou.wangcong@gmail.com>, tglx@linutronix.de, Jens Axboe <jaxboe@fusionio.com>, mingo@elte.hu, Al Viro <viro@zeniv.linux.org.uk>

This flag is a NOOP and can be removed now.

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
---
 arch/um/drivers/line.c          |    8 ++++----
 arch/um/drivers/mconsole_kern.c |    2 +-
 arch/um/drivers/net_kern.c      |    2 +-
 arch/um/drivers/port_kern.c     |    4 ++--
 arch/um/drivers/random.c        |    2 +-
 arch/um/drivers/ubd_kern.c      |    2 +-
 arch/um/drivers/xterm_kern.c    |    2 +-
 arch/um/kernel/sigio.c          |    2 +-
 arch/um/kernel/time.c           |    2 +-
 9 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index d51c404..6198719 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -347,8 +347,8 @@ static irqreturn_t line_write_interrupt(int irq, void *data)
 	int err;
 
 	/*
-	 * Interrupts are disabled here because we registered the interrupt with
-	 * IRQF_DISABLED (see line_setup_irq).
+	 * Interrupts are disabled here because genirq keep irqs disabled when
+	 * calling the action handler.
 	 */
 
 	spin_lock(&line->lock);
@@ -371,7 +371,7 @@ static irqreturn_t line_write_interrupt(int irq, void *data)
 int line_setup_irq(int fd, int input, int output, struct line *line, void *data)
 {
 	const struct line_driver *driver = line->driver;
-	int err = 0, flags = IRQF_DISABLED | IRQF_SHARED | IRQF_SAMPLE_RANDOM;
+	int err = 0, flags = IRQF_SHARED | IRQF_SAMPLE_RANDOM;
 
 	if (input)
 		err = um_request_irq(driver->read_irq, fd, IRQ_READ,
@@ -796,7 +796,7 @@ void register_winch_irq(int fd, int tty_fd, int pid, struct tty_struct *tty,
 				   .stack	= stack });
 
 	if (um_request_irq(WINCH_IRQ, fd, IRQ_READ, winch_interrupt,
-			   IRQF_DISABLED | IRQF_SHARED | IRQF_SAMPLE_RANDOM,
+			   IRQF_SHARED | IRQF_SAMPLE_RANDOM,
 			   "winch", winch) < 0) {
 		printk(KERN_ERR "register_winch_irq - failed to register "
 		       "IRQ\n");
diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index c70e047..e672bd6 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -773,7 +773,7 @@ static int __init mconsole_init(void)
 	register_reboot_notifier(&reboot_notifier);
 
 	err = um_request_irq(MCONSOLE_IRQ, sock, IRQ_READ, mconsole_interrupt,
-			     IRQF_DISABLED | IRQF_SHARED | IRQF_SAMPLE_RANDOM,
+			     IRQF_SHARED | IRQF_SAMPLE_RANDOM,
 			     "mconsole", (void *)sock);
 	if (err) {
 		printk(KERN_ERR "Failed to get IRQ for management console\n");
diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 22745b4..7681df7 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -161,7 +161,7 @@ static int uml_net_open(struct net_device *dev)
 	}
 
 	err = um_request_irq(dev->irq, lp->fd, IRQ_READ, uml_net_interrupt,
-			     IRQF_DISABLED | IRQF_SHARED, dev->name, dev);
+			     IRQF_SHARED, dev->name, dev);
 	if (err != 0) {
 		printk(KERN_ERR "uml_net_open: failed to get irq(%d)\n", err);
 		err = -ENETUNREACH;
diff --git a/arch/um/drivers/port_kern.c b/arch/um/drivers/port_kern.c
index a11573b..e31680e 100644
--- a/arch/um/drivers/port_kern.c
+++ b/arch/um/drivers/port_kern.c
@@ -100,7 +100,7 @@ static int port_accept(struct port_list *port)
 		  .port 	= port });
 
 	if (um_request_irq(TELNETD_IRQ, socket[0], IRQ_READ, pipe_interrupt,
-			  IRQF_DISABLED | IRQF_SHARED | IRQF_SAMPLE_RANDOM,
+			  IRQF_SHARED | IRQF_SAMPLE_RANDOM,
 			  "telnetd", conn)) {
 		printk(KERN_ERR "port_accept : failed to get IRQ for "
 		       "telnetd\n");
@@ -184,7 +184,7 @@ void *port_data(int port_num)
 	}
 
 	if (um_request_irq(ACCEPT_IRQ, fd, IRQ_READ, port_interrupt,
-			  IRQF_DISABLED | IRQF_SHARED | IRQF_SAMPLE_RANDOM,
+			  IRQF_SHARED | IRQF_SAMPLE_RANDOM,
 			  "port", port)) {
 		printk(KERN_ERR "Failed to get IRQ for port %d\n", port_num);
 		goto out_close;
diff --git a/arch/um/drivers/random.c b/arch/um/drivers/random.c
index 981085a..b25296e 100644
--- a/arch/um/drivers/random.c
+++ b/arch/um/drivers/random.c
@@ -131,7 +131,7 @@ static int __init rng_init (void)
 	random_fd = err;
 
 	err = um_request_irq(RANDOM_IRQ, random_fd, IRQ_READ, random_interrupt,
-			     IRQF_DISABLED | IRQF_SAMPLE_RANDOM, "random",
+			     IRQF_SAMPLE_RANDOM, "random",
 			     NULL);
 	if (err)
 		goto err_out_cleanup_hw;
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 620f5b7..c9dae89 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1088,7 +1088,7 @@ static int __init ubd_driver_init(void){
 		return 0;
 	}
 	err = um_request_irq(UBD_IRQ, thread_fd, IRQ_READ, ubd_intr,
-			     IRQF_DISABLED, "ubd", ubd_devs);
+			     0, "ubd", ubd_devs);
 	if(err != 0)
 		printk(KERN_ERR "um_request_irq failed - errno = %d\n", -err);
 	return 0;
diff --git a/arch/um/drivers/xterm_kern.c b/arch/um/drivers/xterm_kern.c
index b646bcc..8bd130f 100644
--- a/arch/um/drivers/xterm_kern.c
+++ b/arch/um/drivers/xterm_kern.c
@@ -50,7 +50,7 @@ int xterm_fd(int socket, int *pid_out)
 	init_completion(&data->ready);
 
 	err = um_request_irq(XTERM_IRQ, socket, IRQ_READ, xterm_interrupt,
-			     IRQF_DISABLED | IRQF_SHARED | IRQF_SAMPLE_RANDOM,
+			     IRQF_SHARED | IRQF_SAMPLE_RANDOM,
 			     "xterm", data);
 	if (err) {
 		printk(KERN_ERR "xterm_fd : failed to get IRQ for xterm, "
diff --git a/arch/um/kernel/sigio.c b/arch/um/kernel/sigio.c
index 2b272b6..2a16392 100644
--- a/arch/um/kernel/sigio.c
+++ b/arch/um/kernel/sigio.c
@@ -25,7 +25,7 @@ int write_sigio_irq(int fd)
 	int err;
 
 	err = um_request_irq(SIGIO_WRITE_IRQ, fd, IRQ_READ, sigio_interrupt,
-			     IRQF_DISABLED|IRQF_SAMPLE_RANDOM, "write sigio",
+			     IRQF_SAMPLE_RANDOM, "write sigio",
 			     NULL);
 	if (err) {
 		printk(KERN_ERR "write_sigio_irq : um_request_irq failed, "
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index a08d9fa..9149b5f 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -84,7 +84,7 @@ static void __init setup_itimer(void)
 {
 	int err;
 
-	err = request_irq(TIMER_IRQ, um_timer, IRQF_DISABLED, "timer", NULL);
+	err = request_irq(TIMER_IRQ, um_timer, 0, "timer", NULL);
 	if (err != 0)
 		printk(KERN_ERR "register_timer : request_irq failed - "
 		       "errno = %d\n", -err);
-- 
1.7.4.1


------------------------------------------------------------------------------
Using storage to extend the benefits of virtualization and iSCSI
Virtualization increases hardware utilization and delivers a new level of
agility. Learn what those decisions are and how to modernize your storage 
and backup environments for virtualization.
http://www.accelacomm.com/jaw/sfnl/114/51434361/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

