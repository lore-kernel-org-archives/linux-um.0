Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <aivanov@brocade.com>) id 1ZvRlm-0001dl-GM
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Nov 2015 15:20:38 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZvRll-0004Xf-A6
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Nov 2015 15:20:38 +0000
From: Anton Ivanov <aivanov@brocade.com>
Date: Sun,  8 Nov 2015 15:20:12 +0000
Message-Id: <1446996012-31444-1-git-send-email-aivanov@brocade.com>
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
Subject: [uml-devel] [PATCH] Update UBD to use pread/pwrite family of
	functions
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Anton Ivanov <aivanov@brocade.com>

This decreases the number of syscalls per read/write by half.

Signed-off-by: Anton Ivanov <aivanov@brocade.com>
---
 arch/um/drivers/ubd_kern.c  | 27 +++++----------------------
 arch/um/include/shared/os.h |  2 ++
 arch/um/os-Linux/file.c     | 19 +++++++++++++++++++
 3 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index e8ab93c..39ba207 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -535,11 +535,7 @@ static int read_cow_bitmap(int fd, void *buf, int offset, int len)
 {
 	int err;
 
-	err = os_seek_file(fd, offset);
-	if (err < 0)
-		return err;
-
-	err = os_read_file(fd, buf, len);
+	err = os_pread_file(fd, buf, len, offset);
 	if (err < 0)
 		return err;
 
@@ -1377,14 +1373,8 @@ static int update_bitmap(struct io_thread_req *req)
 	if(req->cow_offset == -1)
 		return 0;
 
-	n = os_seek_file(req->fds[1], req->cow_offset);
-	if(n < 0){
-		printk("do_io - bitmap lseek failed : err = %d\n", -n);
-		return 1;
-	}
-
-	n = os_write_file(req->fds[1], &req->bitmap_words,
-			  sizeof(req->bitmap_words));
+	n = os_pwrite_file(req->fds[1], &req->bitmap_words,
+			  sizeof(req->bitmap_words), req->cow_offset);
 	if(n != sizeof(req->bitmap_words)){
 		printk("do_io - bitmap update failed, err = %d fd = %d\n", -n,
 		       req->fds[1]);
@@ -1399,7 +1389,6 @@ static void do_io(struct io_thread_req *req)
 	char *buf;
 	unsigned long len;
 	int n, nsectors, start, end, bit;
-	int err;
 	__u64 off;
 
 	if (req->op == UBD_FLUSH) {
@@ -1428,18 +1417,12 @@ static void do_io(struct io_thread_req *req)
 		len = (end - start) * req->sectorsize;
 		buf = &req->buffer[start * req->sectorsize];
 
-		err = os_seek_file(req->fds[bit], off);
-		if(err < 0){
-			printk("do_io - lseek failed : err = %d\n", -err);
-			req->error = 1;
-			return;
-		}
 		if(req->op == UBD_READ){
 			n = 0;
 			do {
 				buf = &buf[n];
 				len -= n;
-				n = os_read_file(req->fds[bit], buf, len);
+				n = os_pread_file(req->fds[bit], buf, len, off);
 				if (n < 0) {
 					printk("do_io - read failed, err = %d "
 					       "fd = %d\n", -n, req->fds[bit]);
@@ -1449,7 +1432,7 @@ static void do_io(struct io_thread_req *req)
 			} while((n < len) && (n != 0));
 			if (n < len) memset(&buf[n], 0, len - n);
 		} else {
-			n = os_write_file(req->fds[bit], buf, len);
+			n = os_pwrite_file(req->fds[bit], buf, len, off);
 			if(n != len){
 				printk("do_io - write failed err = %d "
 				       "fd = %d\n", -n, req->fds[bit]);
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 21d704b..de5d572 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -146,6 +146,8 @@ extern int os_read_file(int fd, void *buf, int len);
 extern int os_write_file(int fd, const void *buf, int count);
 extern int os_sync_file(int fd);
 extern int os_file_size(const char *file, unsigned long long *size_out);
+extern int os_pread_file(int fd, void *buf, int len, unsigned long long offset);
+extern int os_pwrite_file(int fd, const void *buf, int count, unsigned long long offset);
 extern int os_file_modtime(const char *file, unsigned long *modtime);
 extern int os_pipe(int *fd, int stream, int close_on_exec);
 extern int os_set_fd_async(int fd);
diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index 26e0164..2db18cb 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -264,6 +264,15 @@ int os_read_file(int fd, void *buf, int len)
 	return n;
 }
 
+int os_pread_file(int fd, void *buf, int len, unsigned long long offset)
+{
+	int n = pread(fd, buf, len, offset);
+
+	if (n < 0)
+		return -errno;
+	return n;
+}
+
 int os_write_file(int fd, const void *buf, int len)
 {
 	int n = write(fd, (void *) buf, len);
@@ -282,6 +291,16 @@ int os_sync_file(int fd)
 	return n;
 }
 
+int os_pwrite_file(int fd, const void *buf, int len, unsigned long long offset)
+{
+	int n = pwrite(fd, (void *) buf, len, offset);
+
+	if (n < 0)
+		return -errno;
+	return n;
+}
+
+
 int os_file_size(const char *file, unsigned long long *size_out)
 {
 	struct uml_stat buf;
-- 
2.1.4


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

