Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ApwDE-0006Vw-4U
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 08 Feb 2004 13:11:32 -0800
Received: from almesberger.net ([63.105.73.238] helo=host.almesberger.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1ApwDD-0001Sn-Od
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 08 Feb 2004 13:11:31 -0800
From: Werner Almesberger <werner@almesberger.net>
Message-ID: <20040208181109.G1325@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] patch: use elv_queue_empty
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 8 Feb 2004 18:11:09 -0300
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

This patch makes UBD a little more compatible with alternative
elevators that may not use a single request queue.

It's for 2.6.1 with uml-patch-2.6.1-1.

- Werner

--- linux-2.6.1/arch/um/drivers/ubd_kern.c.orig	Sun Feb  8 17:16:51 2004
+++ linux-2.6.1/arch/um/drivers/ubd_kern.c	Sun Feb  8 17:17:32 2004
@@ -1034,7 +1034,7 @@
 	int err, n;
 
 	if(thread_fd == -1){
-		while(!list_empty(&q->queue_head)){
+		while(!elv_queue_empty(q)){
 			req = elv_next_request(q);
 			err = prepare_request(req, &io_req);
 			if(!err){
@@ -1044,7 +1044,7 @@
 		}
 	}
 	else {
-		if(do_ubd || list_empty(&q->queue_head)) return;
+		if(do_ubd || elv_queue_empty(q)) return;
 		req = elv_next_request(q);
 		err = prepare_request(req, &io_req);
 		if(!err){

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
