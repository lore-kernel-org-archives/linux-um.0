Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GeGD9-000691-A9 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Oct 2006 11:20:47 -0800
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GeGD7-0005xx-CY
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Oct 2006 11:20:47 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Sun, 29 Oct 2006 20:20:43 +0100
Message-Id: <20061029192043.12292.76166.stgit@americanbeauty.home.lan>
In-Reply-To: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
References: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
Subject: [uml-devel] [PATCH 08/11] uml ubd driver: convert do_ubd to a
	boolean variable
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

do_ubd is actually just a boolean variable - the way it is used currently is a
leftover from the old 2.4 block layer, but it is still used; its use is
suspicious, but removing it would be too intrusive for now and needs more
thinking.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/ubd_kern.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 48b2a4f..1a85d39 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -112,7 +112,9 @@ static DEFINE_SPINLOCK(ubd_io_lock);
 
 static DEFINE_MUTEX(ubd_lock);
 
-static void (*do_ubd)(void);
+/* XXX - this made sense in 2.4 days, now it's only used as a boolean, and
+ * probably it doesn't make sense even for that. */
+static int do_ubd;
 
 static int ubd_open(struct inode * inode, struct file * filp);
 static int ubd_release(struct inode * inode, struct file * file);
@@ -508,6 +510,7 @@ static inline void ubd_finish(struct req
 	spin_unlock(&ubd_io_lock);
 }
 
+/* XXX - move this inside ubd_intr. */
 /* Called without ubd_io_lock held, and only in interrupt context. */
 static void ubd_handler(void)
 {
@@ -515,7 +518,7 @@ static void ubd_handler(void)
 	struct request *rq = elv_next_request(ubd_queue);
 	int n;
 
-	do_ubd = NULL;
+	do_ubd = 0;
 	intr_count++;
 	n = os_read_file(thread_fd, &req, sizeof(req));
 	if(n != sizeof(req)){
@@ -1058,7 +1061,7 @@ static void do_ubd_request(request_queue
 			return;
 		err = prepare_request(req, &io_req);
 		if(!err){
-			do_ubd = ubd_handler;
+			do_ubd = 1;
 			n = os_write_file(thread_fd, (char *) &io_req,
 					 sizeof(io_req));
 			if(n != sizeof(io_req))
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
