Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Qy4K5-0004M3-53
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2011 16:04:29 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qy4K4-0005sw-9M
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2011 16:04:29 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 29 Aug 2011 18:03:59 +0200
Message-Id: <1314633842-24515-7-git-send-email-richard@nod.at>
In-Reply-To: <1314633842-24515-1-git-send-email-richard@nod.at>
References: <1314633842-24515-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 6/9] um: fix free_winch() mess
To: akpm@linux-foundation.org
Cc: Richard Weinberger <richard@nod.at>, Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@ftp.linux.org.uk>

From: Al Viro <viro@ftp.linux.org.uk>

while not doing free_irq() from irq handler is commendable, kfree() on
the data passed to said handler before free_irq() is Not Good(tm).
Freeing the stack it's being run on is also not nice...  Solution:
delay actually freeing stuff.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/drivers/line.c |   38 ++++++++++++++++++++++++--------------
 1 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 91bf1894..364c8a1 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -721,43 +721,53 @@ struct winch {
 	int pid;
 	struct tty_struct *tty;
 	unsigned long stack;
+	struct work_struct work;
 };
 
-static void free_winch(struct winch *winch, int free_irq_ok)
+static void __free_winch(struct work_struct *work)
 {
-	int fd = winch->fd;
-	winch->fd = -1;
-	if (free_irq_ok)
-		free_irq(WINCH_IRQ, winch);
-
-	list_del(&winch->list);
+	struct winch *winch = container_of(work, struct winch, work);
+	free_irq(WINCH_IRQ, winch);
 
 	if (winch->pid != -1)
 		os_kill_process(winch->pid, 1);
-	if (fd != -1)
-		os_close_file(fd);
 	if (winch->stack != 0)
 		free_stack(winch->stack, 0);
 	kfree(winch);
 }
 
+static void free_winch(struct winch *winch)
+{
+	int fd = winch->fd;
+	winch->fd = -1;
+	if (fd != -1)
+		os_close_file(fd);
+	list_del(&winch->list);
+	__free_winch(&winch->work);
+}
+
 static irqreturn_t winch_interrupt(int irq, void *data)
 {
 	struct winch *winch = data;
 	struct tty_struct *tty;
 	struct line *line;
+	int fd = winch->fd;
 	int err;
 	char c;
 
-	if (winch->fd != -1) {
-		err = generic_read(winch->fd, &c, NULL);
+	if (fd != -1) {
+		err = generic_read(fd, &c, NULL);
 		if (err < 0) {
 			if (err != -EAGAIN) {
+				winch->fd = -1;
+				list_del(&winch->list);
+				os_close_file(fd);
 				printk(KERN_ERR "winch_interrupt : "
 				       "read failed, errno = %d\n", -err);
 				printk(KERN_ERR "fd %d is losing SIGWINCH "
 				       "support\n", winch->tty_fd);
-				free_winch(winch, 0);
+				INIT_WORK(&winch->work, __free_winch);
+				schedule_work(&winch->work);
 				return IRQ_HANDLED;
 			}
 			goto out;
@@ -829,7 +839,7 @@ static void unregister_winch(struct tty_struct *tty)
 	list_for_each_safe(ele, next, &winch_handlers) {
 		winch = list_entry(ele, struct winch, list);
 		if (winch->tty == tty) {
-			free_winch(winch, 1);
+			free_winch(winch);
 			break;
 		}
 	}
@@ -845,7 +855,7 @@ static void winch_cleanup(void)
 
 	list_for_each_safe(ele, next, &winch_handlers) {
 		winch = list_entry(ele, struct winch, list);
-		free_winch(winch, 1);
+		free_winch(winch);
 	}
 
 	spin_unlock(&winch_handler_lock);
-- 
1.7.6.1


------------------------------------------------------------------------------
EMC VNX: the world's simplest storage, starting under $10K
The only unified storage solution that offers unified management 
Up to 160% more powerful than alternatives and 25% more efficient. 
Guaranteed. http://p.sf.net/sfu/emc-vnx-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

