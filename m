Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHANl-0002iH-M1 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:19:13 -0700
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CHANj-0000KE-1o for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:19:13 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041012001803.E2A9B8699@zion.localdomain>
Subject: [uml-devel] [patch 09/10] uml: fix ubd deadlock on SMP
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 12 Oct 2004 02:18:03 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it, chrisw@osdl.org


From: BlaisorBlade <blaisorblade_spam@yahoo.it>, Chris Wright <chrisw@osdl.org>

Avoid deadlocking onto the request lock in the UBD driver, i.e. don't lock the
queue spinlock when called from the request function.

In detail:
Rename ubd_finish() to __ubd_finish() and remove ubd_io_lock from it.
Add wrapper, ubd_finish(), which grabs lock before calling __ubd_finish().
Update do_ubd_request to use the lock free __ubd_finish() to avoid
deadlock.  Also, apparently prepare_request is called with ubd_io_lock
held, so remove locks there.

Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/drivers/ubd_kern.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff -puN arch/um/drivers/ubd_kern.c~uml-ubd-deadlock-revised arch/um/drivers/ubd_kern.c
--- linux-2.6.9-current/arch/um/drivers/ubd_kern.c~uml-ubd-deadlock-revised	2004-10-12 01:22:16.360058936 +0200
+++ linux-2.6.9-current-paolo/arch/um/drivers/ubd_kern.c	2004-10-12 01:52:22.521480664 +0200
@@ -396,14 +396,13 @@ int thread_fd = -1;
  */
 int intr_count = 0;
 
-static void ubd_finish(struct request *req, int error)
+/* call ubd_finish if you need to serialize */
+static void __ubd_finish(struct request *req, int error)
 {
 	int nsect;
 
 	if(error){
- 		spin_lock(&ubd_io_lock);
 		end_request(req, 0);
- 		spin_unlock(&ubd_io_lock);
 		return;
 	}
 	nsect = req->current_nr_sectors;
@@ -412,11 +411,17 @@ static void ubd_finish(struct request *r
 	req->errors = 0;
 	req->nr_sectors -= nsect;
 	req->current_nr_sectors = 0;
-	spin_lock(&ubd_io_lock);
 	end_request(req, 1);
+}
+
+static inline void ubd_finish(struct request *req, int error)
+{
+ 	spin_lock(&ubd_io_lock);
+	__ubd_finish(req, error);
 	spin_unlock(&ubd_io_lock);
 }
 
+/* Called without ubd_io_lock held */
 static void ubd_handler(void)
 {
 	struct io_thread_req req;
@@ -965,6 +970,7 @@ static int prepare_mmap_request(struct u
 	return(0);
 }
 
+/* Called with ubd_io_lock held */
 static int prepare_request(struct request *req, struct io_thread_req *io_req)
 {
 	struct gendisk *disk = req->rq_disk;
@@ -977,9 +983,7 @@ static int prepare_request(struct reques
 	if((rq_data_dir(req) == WRITE) && !dev->openflags.w){
 		printk("Write attempted on readonly ubd device %s\n", 
 		       disk->disk_name);
- 		spin_lock(&ubd_io_lock);
 		end_request(req, 0);
- 		spin_unlock(&ubd_io_lock);
 		return(1);
 	}
 
@@ -1029,6 +1033,7 @@ static int prepare_request(struct reques
 	return(0);
 }
 
+/* Called with ubd_io_lock held */
 static void do_ubd_request(request_queue_t *q)
 {
 	struct io_thread_req io_req;
@@ -1040,7 +1045,7 @@ static void do_ubd_request(request_queue
 			err = prepare_request(req, &io_req);
 			if(!err){
 				do_io(&io_req);
-				ubd_finish(req, io_req.error);
+				__ubd_finish(req, io_req.error);
 			}
 		}
 	}
_


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
