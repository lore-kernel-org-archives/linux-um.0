Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GeGD0-00068j-IB for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Oct 2006 11:20:38 -0800
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GeGCy-0007NL-TC
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Oct 2006 11:20:38 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Sun, 29 Oct 2006 20:20:33 +0100
Message-Id: <20061029192033.12292.72082.stgit@americanbeauty.home.lan>
In-Reply-To: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
References: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
Subject: [uml-devel] [PATCH 04/11] uml ubd driver: give better names to some
	functions.
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

To rethink locking, I needed to understand well what each function does. While
doing this I renamed some:

* ubd_close -> ubd_close_dev (since it pairs with ubd_open_dev)

* ubd_new_disk -> ubd_disk_register (it handles registration with the block
  layer - one hopes this makes clearer the difference with ubd_add())

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/ubd_kern.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 50385cc..23663b7 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -552,7 +552,7 @@ static int ubd_file_size(struct ubd *ubd
 	return(os_file_size(file, size_out));
 }
 
-static void ubd_close(struct ubd *ubd_dev)
+static void ubd_close_dev(struct ubd *ubd_dev)
 {
 	os_close_file(ubd_dev->fd);
 	if(ubd_dev->cow.file == NULL)
@@ -629,7 +629,7 @@ static void dummy_device_release(struct
 {
 }
 
-static int ubd_new_disk(int major, u64 size, int unit,
+static int ubd_disk_register(int major, u64 size, int unit,
 			struct gendisk **disk_out)
 			
 {
@@ -682,12 +682,12 @@ static int ubd_add(int n)
 
 	ubd_dev->size = ROUND_BLOCK(ubd_dev->size);
 
-	err = ubd_new_disk(MAJOR_NR, ubd_dev->size, n, &ubd_gendisk[n]);
+	err = ubd_disk_register(MAJOR_NR, ubd_dev->size, n, &ubd_gendisk[n]);
 	if(err)
 		goto out;
 
 	if(fake_major != MAJOR_NR)
-		ubd_new_disk(fake_major, ubd_dev->size, n,
+		ubd_disk_register(fake_major, ubd_dev->size, n,
 			     &fake_gendisk[n]);
 
 	/* perhaps this should also be under the "if (fake_major)" above */
@@ -904,7 +904,7 @@ static int ubd_open(struct inode *inode,
 	/* This should no more be needed. And it didn't work anyway to exclude
 	 * read-write remounting of filesystems.*/
 	/*if((filp->f_mode & FMODE_WRITE) && !ubd_dev->openflags.w){
-	        if(--ubd_dev->count == 0) ubd_close(ubd_dev);
+	        if(--ubd_dev->count == 0) ubd_close_dev(ubd_dev);
 	        err = -EROFS;
 	}*/
  out:
@@ -917,7 +917,7 @@ static int ubd_release(struct inode * in
 	struct ubd *ubd_dev = disk->private_data;
 
 	if(--ubd_dev->count == 0)
-		ubd_close(ubd_dev);
+		ubd_close_dev(ubd_dev);
 	return(0);
 }
 
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
