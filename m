Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpCz9-0001ak-En for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 13:58:31 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CpCz8-0001Ug-AE for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 13:58:31 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20050113210106.38C071FEF6@zion>
Subject: [uml-devel] [patch 08/11] uml: fix and cleanup code in ubd_kern.c
	coming from ubd_user.c
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
Date: Thu, 13 Jan 2005 22:01:06 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


* Fix the use of errno: it refers to the __errno_location glibc definition
  when in ubd_user.c, and hence works; but in ubd_kern.c it refers to
  kernel_errno, which is different. So use the return value of os_* functions,
  as we should always have done.
* Remove {read,write}_ubd_fs(), which are just silly.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/drivers/ubd_kern.c |   21 ++++-----------------
 1 files changed, 4 insertions(+), 17 deletions(-)

diff -puN arch/um/drivers/ubd_kern.c~uml-start-fixing-ubd arch/um/drivers/ubd_kern.c
--- linux-2.6.11/arch/um/drivers/ubd_kern.c~uml-start-fixing-ubd	2005-01-13 05:53:42.073259584 +0100
+++ linux-2.6.11-paolo/arch/um/drivers/ubd_kern.c	2005-01-13 05:53:42.076259128 +0100
@@ -83,8 +83,6 @@ extern int create_cow_file(char *cow_fil
 			   unsigned long *bitmap_len_out,
 			   int *data_offset_out);
 extern int read_cow_bitmap(int fd, void *buf, int offset, int len);
-extern int read_ubd_fs(int fd, void *buffer, int len);
-extern int write_ubd_fs(int fd, char *buffer, int len);
 extern void do_io(struct io_thread_req *req);
 
 static inline int ubd_test_bit(__u64 bit, unsigned char *data)
@@ -323,7 +321,7 @@ static int ubd_setup_common(char *str, i
 		}
 
 		if(!strcmp(str, "sync")){
-			global_openflags.s = 1;
+			global_openflags = of_sync(global_openflags);
 			return(0);
 		}
 		major = simple_strtoul(str, &end, 0);
@@ -513,7 +511,7 @@ static void ubd_handler(void)
 
 	do_ubd = NULL;
 	intr_count++;
-	n = read_ubd_fs(thread_fd, &req, sizeof(req));
+	n = os_read_file(thread_fd, &req, sizeof(req));
 	if(n != sizeof(req)){
 		printk(KERN_ERR "Pid %d - spurious interrupt in ubd_handler, "
 		       "err = %d\n", os_getpid(), -n);
@@ -1155,7 +1153,7 @@ static void do_ubd_request(request_queue
 		err = prepare_request(req, &io_req);
 		if(!err){
 			do_ubd = ubd_handler;
-			n = write_ubd_fs(thread_fd, (char *) &io_req, 
+			n = os_write_file(thread_fd, (char *) &io_req,
 					 sizeof(io_req));
 			if(n != sizeof(io_req))
 				printk("write to io thread failed, "
@@ -1436,7 +1434,7 @@ int open_ubd_file(char *file, struct ope
 		if((fd == -ENOENT) && (create_cow_out != NULL))
 			*create_cow_out = 1;
                 if(!openflags->w ||
-                   ((errno != EROFS) && (errno != EACCES))) return(-errno);
+                   ((fd != -EROFS) && (fd != -EACCES))) return(fd);
 		openflags->w = 0;
 		fd = os_open_file(file, *openflags, mode);
 		if(fd < 0)
@@ -1513,17 +1511,6 @@ int create_cow_file(char *cow_file, char
 	return(err);
 }
 
-/* XXX Just trivial wrappers around os_read_file and os_write_file */
-int read_ubd_fs(int fd, void *buffer, int len)
-{
-	return(os_read_file(fd, buffer, len));
-}
-
-int write_ubd_fs(int fd, char *buffer, int len)
-{
-	return(os_write_file(fd, buffer, len));
-}
-
 static int update_bitmap(struct io_thread_req *req)
 {
 	int n;
_


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
