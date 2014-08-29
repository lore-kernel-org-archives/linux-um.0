Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1XNGx4-0007N8-4s
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Aug 2014 07:50:30 +0000
Received: from ivanoab3.miniserver.com ([89.200.143.206])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XNGx3-0001xG-Cn
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Aug 2014 07:50:30 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Fri, 29 Aug 2014 08:05:13 +0100
Message-Id: <1409295915-130538-8-git-send-email-anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <1409295915-130538-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
References: <1409295915-130538-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
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
Subject: [uml-devel] [PATCH 08/10] Minor performance optimization for ubd
To: user-mode-linux-devel@lists.sourceforge.net

From: Anton Ivanov <antivano@cisco.com>

Obvious performance optimization - it is not necessary
to read the requests one at a time in the IRQ handler

Signed-off-by: Anton Ivanov <antivano@cisco.com>
---
 arch/um/drivers/ubd_kern.c |   29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 35ba00b..66d424a 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -443,6 +443,8 @@ static void do_ubd_request(struct request_queue * q);
 static int thread_fd = -1;
 static LIST_HEAD(restart);
 
+static struct io_thread_req  * ubd_request_list[MAX_SG];
+
 /* XXX - move this inside ubd_intr. */
 /* Called without dev->lock held, and only in interrupt context. */
 static void ubd_handler(void)
@@ -451,21 +453,34 @@ static void ubd_handler(void)
 	struct ubd *ubd;
 	struct list_head *list, *next_ele;
 	unsigned long flags;
-	int n;
+	int n, i;
+
+	/* 
+	 * obvious optimization - we do not need to read the reqs one at a time
+	 * we can read all pending reqs in one interrupt and handle them in bulk
+	 */
 
 	while(1){
-		n = os_read_file(thread_fd, &req,
-				 sizeof(struct io_thread_req *));
-		if(n != sizeof(req)){
+        do {
+		n = os_read_file(thread_fd, &ubd_request_list,
+				 sizeof(struct io_thread_req *) * MAX_SG);
+        } while (n == -EINTR);
+		if(n < 0){
 			if(n == -EAGAIN)
 				break;
 			printk(KERN_ERR "spurious interrupt in ubd_handler, "
 			       "err = %d\n", -n);
 			return;
+		} else if (n % sizeof(struct io_thread_req *) != 0)  {
+			printk(KERN_ERR "spurious interrupt in ubd_handler, "
+			       "err = %d\n", -n);
+			return;
+		}
+		for (i = 0; i < n / sizeof(struct io_thread_req *); i++) {
+			req = ubd_request_list[i];
+			blk_end_request(req->req, 0, req->length);
+			kfree(req);
 		}
-
-		blk_end_request(req->req, 0, req->length);
-		kfree(req);
 	}
 
 	list_for_each_safe(list, next_ele, &restart){
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

