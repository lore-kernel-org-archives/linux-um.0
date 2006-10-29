Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GeGD2-00068p-Hw for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Oct 2006 11:20:40 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GeGD1-0005xI-TM
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Oct 2006 11:20:40 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Sun, 29 Oct 2006 20:20:38 +0100
Message-Id: <20061029192038.12292.46985.stgit@americanbeauty.home.lan>
In-Reply-To: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
References: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
Subject: [uml-devel] [PATCH 06/11] uml ubd driver: ubd_io_lock usage fixup
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Add some comments about requirements for ubd_io_lock and expand its use.

When an irq signals that the "controller" (i.e. another thread on the host,
which does the actual requests and is the only one blocked on I/O on the host)
has done some work, we call again the request function ourselves
(do_ubd_request).

We now do that with ubd_io_lock held - that's useful to protect against
concurrent calls to elv_next_request and so on.

XXX: Maybe we shouldn't call at all the request function. Input needed on this.
Are we supposed to plug and unplug the queue? That code "indirectly" does that
by setting a flag, called do_ubd, which makes the request function return (it's
a residual of 2.4 block layer interface).

Meanwhile, however, merge this patch, which improves things.

Cc: Jens Axboe <axboe@suse.de>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/ubd_kern.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index e4fd29a..1202592 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -106,6 +106,8 @@ static inline void ubd_set_bit(__u64 bit
 
 #define DRIVER_NAME "uml-blkdev"
 
+/* Can be taken in interrupt context, and is passed to the block layer to lock
+ * the request queue. Kernel side code knows that. */
 static DEFINE_SPINLOCK(ubd_io_lock);
 
 static DEFINE_MUTEX(ubd_lock);
@@ -497,6 +499,8 @@ static void __ubd_finish(struct request
 	end_request(req, 1);
 }
 
+/* Callable only from interrupt context - otherwise you need to do
+ * spin_lock_irq()/spin_lock_irqsave() */
 static inline void ubd_finish(struct request *req, int error)
 {
  	spin_lock(&ubd_io_lock);
@@ -504,7 +508,7 @@ static inline void ubd_finish(struct req
 	spin_unlock(&ubd_io_lock);
 }
 
-/* Called without ubd_io_lock held */
+/* Called without ubd_io_lock held, and only in interrupt context. */
 static void ubd_handler(void)
 {
 	struct io_thread_req req;
@@ -525,7 +529,9 @@ static void ubd_handler(void)
 
 	ubd_finish(rq, req.error);
 	reactivate_fd(thread_fd, UBD_IRQ);	
+	spin_lock(&ubd_io_lock);
 	do_ubd_request(ubd_queue);
+	spin_unlock(&ubd_io_lock);
 }
 
 static irqreturn_t ubd_intr(int irq, void *dev)
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
