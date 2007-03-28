Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HWNXv-00071i-Rh for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Mar 2007 19:05:56 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HWNXv-00026e-8y
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Mar 2007 19:05:55 -0700
Date: Tue, 27 Mar 2007 22:02:47 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070328020247.GA12299@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] UML - fix I/O hang when multiple devices are in
	use
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

[ This patch needs to get into 2.6.21, as it fixes a serious bug
introduced soon after 2.6.20 ]

Commit 62f96cb01e8de7a5daee472e540f726db2801499 introduced per-devices
queues and locks, which was fine as far as it went, but left in place
a global which controlled access to submitting requests to the host.
This should have been made per-device as well, since it causes I/O
hangs when multiple block devices are in use.

This patch fixes that by replacing the global with an activity flag in
the device structure in order to tell whether the queue is currently
being run.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/drivers/ubd_kern.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

Index: linux-2.6.21-mm/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/ubd_kern.c	2007-03-27 20:27:16.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/ubd_kern.c	2007-03-27 20:28:29.000000000 -0400
@@ -108,10 +108,6 @@ static inline void ubd_set_bit(__u64 bit
 
 static DEFINE_MUTEX(ubd_lock);
 
-/* XXX - this made sense in 2.4 days, now it's only used as a boolean, and
- * probably it doesn't make sense even for that. */
-static int do_ubd;
-
 static int ubd_open(struct inode * inode, struct file * filp);
 static int ubd_release(struct inode * inode, struct file * file);
 static int ubd_ioctl(struct inode * inode, struct file * file,
@@ -168,6 +164,7 @@ struct ubd {
 	struct platform_device pdev;
 	struct request_queue *queue;
 	spinlock_t lock;
+	int active;
 };
 
 #define DEFAULT_COW { \
@@ -189,6 +186,7 @@ struct ubd {
 	.shared =		0, \
         .cow =			DEFAULT_COW, \
 	.lock =			SPIN_LOCK_UNLOCKED,	\
+	.active =		0, \
 }
 
 /* Protected by ubd_lock */
@@ -506,7 +504,6 @@ static void ubd_handler(void)
 	struct ubd *dev;
 	int n;
 
-	do_ubd = 0;
 	n = os_read_file(thread_fd, &req, sizeof(req));
 	if(n != sizeof(req)){
 		printk(KERN_ERR "Pid %d - spurious interrupt in ubd_handler, "
@@ -516,6 +513,7 @@ static void ubd_handler(void)
 
 	rq = req.req;
 	dev = rq->rq_disk->private_data;
+	dev->active = 0;
 
 	ubd_finish(rq, req.error);
 	reactivate_fd(thread_fd, UBD_IRQ);
@@ -1081,11 +1079,12 @@ static void do_ubd_request(request_queue
 		}
 	}
 	else {
-		if(do_ubd || (req = elv_next_request(q)) == NULL)
+		struct ubd *dev = q->queuedata;
+		if(dev->active || (req = elv_next_request(q)) == NULL)
 			return;
 		err = prepare_request(req, &io_req);
 		if(!err){
-			do_ubd = 1;
+			dev->active = 1;
 			n = os_write_file(thread_fd, (char *) &io_req,
 					 sizeof(io_req));
 			if(n != sizeof(io_req))

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
