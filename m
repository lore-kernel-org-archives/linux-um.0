Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JkiQn-0007oJ-Qt for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Apr 2008 09:18:22 -0700
Received: from qb-out-0506.google.com ([72.14.204.226])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JkiQn-0005c3-CI
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Apr 2008 09:18:21 -0700
Received: by qb-out-0506.google.com with SMTP id c8so927110qbc.4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 12 Apr 2008 09:18:20 -0700 (PDT)
Date: Sun, 13 Apr 2008 00:14:39 +0800 (CST)
Message-Id: <20080413.001439.130519292.xiyou.wangcong@gmail.com>
From: WANG Cong <xiyou.wangcong@gmail.com>
Mime-Version: 1.0
Subject: [uml-devel] [Patch] UML: Make several things static.
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
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net


Make several things static, because they no longer need to be global.

Cc: Jeff Dike <jdike@addtoit.com>
Signed-off-by: WANG Cong <wangcong@zeuux.org>

---
 arch/um/drivers/net_kern.c      |    6 +++---
 arch/um/drivers/slip_kern.c     |    4 ++--
 arch/um/drivers/stdio_console.c |    4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 1d43bdf..5b4ca8d 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -116,7 +116,7 @@ static void uml_dev_close(struct work_struct *work)
 	dev_close(lp->dev);
 }
 
-irqreturn_t uml_net_interrupt(int irq, void *dev_id)
+static irqreturn_t uml_net_interrupt(int irq, void *dev_id)
 {
 	struct net_device *dev = dev_id;
 	struct uml_net_private *lp = dev->priv;
@@ -296,7 +296,7 @@ static struct ethtool_ops uml_net_ethtool_ops = {
 	.get_link	= ethtool_op_get_link,
 };
 
-void uml_net_user_timer_expire(unsigned long _conn)
+static void uml_net_user_timer_expire(unsigned long _conn)
 {
 #ifdef undef
 	struct connection *conn = (struct connection *)_conn;
@@ -786,7 +786,7 @@ static int uml_inetaddr_event(struct notifier_block *this, unsigned long event,
 }
 
 /* uml_net_init shouldn't be called twice on two CPUs at the same time */
-struct notifier_block uml_inetaddr_notifier = {
+static struct notifier_block uml_inetaddr_notifier = {
 	.notifier_call		= uml_inetaddr_event,
 };
 
diff --git a/arch/um/drivers/slip_kern.c b/arch/um/drivers/slip_kern.c
index 6b4a0f9..d19faec 100644
--- a/arch/um/drivers/slip_kern.c
+++ b/arch/um/drivers/slip_kern.c
@@ -13,7 +13,7 @@ struct slip_init {
 	char *gate_addr;
 };
 
-void slip_init(struct net_device *dev, void *data)
+static void slip_init(struct net_device *dev, void *data)
 {
 	struct uml_net_private *private;
 	struct slip_data *spri;
@@ -57,7 +57,7 @@ static int slip_write(int fd, struct sk_buff *skb, struct uml_net_private *lp)
 			       (struct slip_data *) &lp->user);
 }
 
-const struct net_kern_info slip_kern_info = {
+static const struct net_kern_info slip_kern_info = {
 	.init			= slip_init,
 	.protocol		= slip_protocol,
 	.read			= slip_read,
diff --git a/arch/um/drivers/stdio_console.c b/arch/um/drivers/stdio_console.c
index cec0c33..49266f6 100644
--- a/arch/um/drivers/stdio_console.c
+++ b/arch/um/drivers/stdio_console.c
@@ -34,7 +34,7 @@
 
 static struct tty_driver *console_driver;
 
-void stdio_announce(char *dev_name, int dev)
+static void stdio_announce(char *dev_name, int dev)
 {
 	printk(KERN_INFO "Virtual console %d assigned device '%s'\n", dev,
 	       dev_name);
@@ -158,7 +158,7 @@ static struct console stdiocons = {
 	.index		= -1,
 };
 
-int stdio_init(void)
+static int stdio_init(void)
 {
 	char *new_title;
 
-- 
1.5.2.4


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
