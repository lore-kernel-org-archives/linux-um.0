Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KZDMQ-00069F-QT for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 16:26:34 -0700
Received: from abydos.nerdbox.net ([216.151.149.55])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KZDMQ-0005MZ-Ib
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 16:26:34 -0700
Date: Fri, 29 Aug 2008 16:26:33 -0700 (PDT)
From: Steve VanDeBogart <vandebo-lkml@NerdBox.Net>
Message-ID: <alpine.DEB.1.00.0808291624290.15543@abydos.NerdBox.Net>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH] uml: ubd can access uninitialized memory
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
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

ubd_kern.c:do_io() may access uninitialized memory and divide requests
into smaller chunks than necessary.  Found with Valgrind.

Signed-off-by: Steve VanDeBogart <vandebo-lkml@nerdbox.net>
---

Index: linux-2.6.27-rc5/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.27-rc5.orig/arch/um/drivers/ubd_kern.c	2008-08-29 15:50:19.000000000 -0700
+++ linux-2.6.27-rc5/arch/um/drivers/ubd_kern.c	2008-08-29 15:51:48.000000000 -0700
@@ -1218,8 +1218,7 @@
  	struct ubd *ubd_dev = disk->private_data;

  	io_req->req = req;
-	io_req->fds[0] = (ubd_dev->cow.file != NULL) ? ubd_dev->cow.fd :
-		ubd_dev->fd;
+	io_req->fds[0] = (ubd_dev->cow.file == NULL) ? -1 : ubd_dev->cow.fd;
  	io_req->fds[1] = ubd_dev->fd;
  	io_req->cow_offset = -1;
  	io_req->offset = offset;
@@ -1374,12 +1373,18 @@
  	nsectors = req->length / req->sectorsize;
  	start = 0;
  	do {
-		bit = ubd_test_bit(start, (unsigned char *) &req->sector_mask);
-		end = start;
-		while((end < nsectors) &&
-		      (ubd_test_bit(end, (unsigned char *)
-				    &req->sector_mask) == bit))
-			end++;
+		if (req->fds[0] == -1) {
+			bit = 1;
+			end = nsectors;
+		} else {
+			bit = ubd_test_bit(start,
+					(unsigned char *) &req->sector_mask);
+			end = start;
+			while ((end < nsectors) &&
+					(ubd_test_bit(end, (unsigned char *)
+						  &req->sector_mask) == bit))
+				end++;
+		}

  		off = req->offset + req->offsets[bit] +
  			start * req->sectorsize;

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
