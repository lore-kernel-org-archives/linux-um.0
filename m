Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1VB1Bk-0003T8-Rk
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Aug 2013 11:30:28 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VB1Bj-0006hG-93 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Aug 2013 11:30:28 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sun, 18 Aug 2013 13:30:07 +0200
Message-Id: <1376825409-18570-2-git-send-email-richard@nod.at>
In-Reply-To: <1376825409-18570-1-git-send-email-richard@nod.at>
References: <1376825409-18570-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 2/4] um: ubd: Introduce submit_request()
To: richard@nod.at
Cc: user-mode-linux-devel@lists.sourceforge.net

Just a clean-up patch to remove the open coded
variants and to ensure that all requests are submitted the
same way.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/drivers/ubd_kern.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index d27c703..1812bc8 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1252,12 +1252,28 @@ static void prepare_flush_request(struct request *req,
 	io_req->op = UBD_FLUSH;
 }
 
+static bool submit_request(struct io_thread_req *io_req, struct ubd *dev)
+{
+	int n = os_write_file(thread_fd, &io_req,
+			     sizeof(io_req));
+	if (n != sizeof(io_req)) {
+		if (n != -EAGAIN)
+			printk("write to io thread failed, "
+			       "errno = %d\n", -n);
+		else if (list_empty(&dev->restart))
+			list_add(&dev->restart, &restart);
+
+		kfree(io_req);
+		return false;
+	}
+	return true;
+}
+
 /* Called with dev->lock held */
 static void do_ubd_request(struct request_queue *q)
 {
 	struct io_thread_req *io_req;
 	struct request *req;
-	int n;
 
 	while(1){
 		struct ubd *dev = q->queuedata;
@@ -1283,8 +1299,7 @@ static void do_ubd_request(struct request_queue *q)
 				return;
 			}
 			prepare_flush_request(req, io_req);
-			os_write_file(thread_fd, &io_req,
-					  sizeof(struct io_thread_req *));
+			submit_request(io_req, dev);
 		}
 
 		while(dev->start_sg < dev->end_sg){
@@ -1301,17 +1316,8 @@ static void do_ubd_request(struct request_queue *q)
 					(unsigned long long)dev->rq_pos << 9,
 					sg->offset, sg->length, sg_page(sg));
 
-			n = os_write_file(thread_fd, &io_req,
-					  sizeof(struct io_thread_req *));
-			if(n != sizeof(struct io_thread_req *)){
-				if(n != -EAGAIN)
-					printk("write to io thread failed, "
-					       "errno = %d\n", -n);
-				else if(list_empty(&dev->restart))
-					list_add(&dev->restart, &restart);
-				kfree(io_req);
+			if (submit_request(io_req, dev) == false)
 				return;
-			}
 
 			dev->rq_pos += sg->length >> 9;
 			dev->start_sg++;
-- 
1.8.3.1


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

