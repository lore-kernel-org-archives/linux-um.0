Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GeGDH-00069C-7f for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Oct 2006 11:20:55 -0800
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GeGDE-0007Qw-Jg
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Oct 2006 11:20:55 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Sun, 29 Oct 2006 20:20:49 +0100
Message-Id: <20061029192049.12292.24192.stgit@americanbeauty.home.lan>
In-Reply-To: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
References: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
Subject: [uml-devel] [PATCH 10/11] uml ubd driver: do not store error codes
	as ->fd
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

To simplify error handling, make sure fd is saved into ubd_dev->fd only when we
are sure it is an fd and not an error code.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/ubd_kern.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 66dc23d..641782e 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -578,33 +578,36 @@ static int ubd_open_dev(struct ubd *ubd_
 	struct openflags flags;
 	char **back_ptr;
 	int err, create_cow, *create_ptr;
+	int fd;
 
 	ubd_dev->openflags = ubd_dev->boot_openflags;
 	create_cow = 0;
 	create_ptr = (ubd_dev->cow.file != NULL) ? &create_cow : NULL;
 	back_ptr = ubd_dev->no_cow ? NULL : &ubd_dev->cow.file;
-	ubd_dev->fd = open_ubd_file(ubd_dev->file, &ubd_dev->openflags, ubd_dev->shared,
+
+	fd = open_ubd_file(ubd_dev->file, &ubd_dev->openflags, ubd_dev->shared,
 				back_ptr, &ubd_dev->cow.bitmap_offset,
 				&ubd_dev->cow.bitmap_len, &ubd_dev->cow.data_offset,
 				create_ptr);
 
-	if((ubd_dev->fd == -ENOENT) && create_cow){
-		ubd_dev->fd = create_cow_file(ubd_dev->file, ubd_dev->cow.file,
+	if((fd == -ENOENT) && create_cow){
+		fd = create_cow_file(ubd_dev->file, ubd_dev->cow.file,
 					  ubd_dev->openflags, 1 << 9, PAGE_SIZE,
 					  &ubd_dev->cow.bitmap_offset,
 					  &ubd_dev->cow.bitmap_len,
 					  &ubd_dev->cow.data_offset);
-		if(ubd_dev->fd >= 0){
+		if(fd >= 0){
 			printk(KERN_INFO "Creating \"%s\" as COW file for "
 			       "\"%s\"\n", ubd_dev->file, ubd_dev->cow.file);
 		}
 	}
 
-	if(ubd_dev->fd < 0){
+	if(fd < 0){
 		printk("Failed to open '%s', errno = %d\n", ubd_dev->file,
-		       -ubd_dev->fd);
-		return(ubd_dev->fd);
+		       -fd);
+		return fd;
 	}
+	ubd_dev->fd = fd;
 
 	if(ubd_dev->cow.file != NULL){
 		err = -ENOMEM;
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
