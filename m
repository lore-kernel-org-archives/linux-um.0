Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1XW6rp-0004EI-Cd
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Sep 2014 16:53:37 +0000
Received: from ivanoab3.miniserver.com ([89.200.143.206])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XW6ro-0005DT-7o
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Sep 2014 16:53:37 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Mon, 22 Sep 2014 17:53:20 +0100
Message-Id: <1411404804-871910-8-git-send-email-anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <1411404804-871910-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
References: <1411404804-871910-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
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
Subject: [uml-devel] [PATCH v4 07/11] Performance and NUMA improvements for
	ubd
To: user-mode-linux-devel@lists.sourceforge.net

From: Anton Ivanov <antivano@cisco.com>

The use of the seek()/read() and seek()/write() is a terminal
disease on NUMA. Intense use of this on shared files (f.e.
the master for a COW image) can cause anything up to and including
killing CPUs on unhandled NMIs.

This patch deals with this UML major issue (and one of UML biggest
performance pitfalls). As a result you can now run (subject to
correct pinning) 2000+ UMLs on a NUMA box without crashing it.

Signed-off-by: Anton Ivanov <antivano@cisco.com>
---
 arch/um/drivers/ubd_kern.c  |   29 ++++++++---------------------
 arch/um/include/shared/os.h |    2 ++
 arch/um/os-Linux/file.c     |   18 ++++++++++++++++++
 3 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 1cc72ae5..35ba00b 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1,4 +1,5 @@
 /*
+ * Copyright (C) 2012-2014 Cisco Systems
  * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -534,11 +535,7 @@ static int read_cow_bitmap(int fd, void *buf, int offset, int len)
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
 
@@ -1375,14 +1372,10 @@ static int update_bitmap(struct io_thread_req *req)
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
+			  sizeof(req->bitmap_words),
+			  req->cow_offset
+			);
 	if(n != sizeof(req->bitmap_words)){
 		printk("do_io - bitmap update failed, err = %d fd = %d\n", -n,
 		       req->fds[1]);
@@ -1426,18 +1419,12 @@ static void do_io(struct io_thread_req *req)
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
@@ -1447,7 +1434,7 @@ static void do_io(struct io_thread_req *req)
 			} while((n < len) && (n != 0));
 			if (n < len) memset(&buf[n], 0, len - n);
 		} else {
-			n = os_write_file(req->fds[bit], buf, len);
+			n = os_pwrite_file(req->fds[bit], buf, len, off);
 			if(n != len){
 				printk("do_io - write failed err = %d "
 				       "fd = %d\n", -n, req->fds[bit]);
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 2684d7a..d7bf791 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -142,6 +142,8 @@ extern int os_seek_file(int fd, unsigned long long offset);
 extern int os_open_file(const char *file, struct openflags flags, int mode);
 extern int os_read_file(int fd, void *buf, int len);
 extern int os_write_file(int fd, const void *buf, int count);
+extern int os_pread_file(int fd, void *buf, int len, unsigned long long offset);
+extern int os_pwrite_file(int fd, const void *buf, int count, unsigned long long offset);
 extern int os_sync_file(int fd);
 extern int os_file_size(const char *file, unsigned long long *size_out);
 extern int os_file_modtime(const char *file, unsigned long *modtime);
diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index 07a7501..64951fd 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -266,6 +266,24 @@ int os_write_file(int fd, const void *buf, int len)
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
+int os_pwrite_file(int fd, const void *buf, int len, unsigned long long offset)
+{
+	int n = pwrite(fd, (void *) buf, len, offset);
+
+	if (n < 0)
+		return -errno;
+	return n;
+}
+
 int os_sync_file(int fd)
 {
 	int n = fsync(fd);
-- 
1.7.10.4


------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

