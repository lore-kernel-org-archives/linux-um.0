Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jkj4p-0003eG-Bc for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Apr 2008 09:59:43 -0700
Received: from qb-out-0506.google.com ([72.14.204.234])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jkj4o-0004H6-Hx
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Apr 2008 09:59:43 -0700
Received: by qb-out-0506.google.com with SMTP id a33so259562qbd.0
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 12 Apr 2008 09:59:41 -0700 (PDT)
Date: Sun, 13 Apr 2008 00:55:59 +0800 (CST)
Message-Id: <20080413.005559.143852921.xiyou.wangcong@gmail.com>
From: WANG Cong <xiyou.wangcong@gmail.com>
Mime-Version: 1.0
Subject: [uml-devel] [Patch] UML: Clean up arch/um/drivers/ubd_kern.c
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
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net


Make some global functions and variables static.

And remove some useless declarations for local functions, since we just
need to move their definitions ahead.

Compile testing passed.

Cc: Jeff Dike <jdike@addtoit.com>
Signed-off-by: WANG Cong <wangcong@zeuux.org>

---
 arch/um/drivers/ubd_kern.c |  379 +++++++++++++++++++++-----------------------
 1 files changed, 184 insertions(+), 195 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index be3a279..df5aa37 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -72,18 +72,6 @@ struct io_thread_req {
 	int error;
 };
 
-extern int open_ubd_file(char *file, struct openflags *openflags, int shared,
-			 char **backing_file_out, int *bitmap_offset_out,
-			 unsigned long *bitmap_len_out, int *data_offset_out,
-			 int *create_cow_out);
-extern int create_cow_file(char *cow_file, char *backing_file,
-			   struct openflags flags, int sectorsize,
-			   int alignment, int *bitmap_offset_out,
-			   unsigned long *bitmap_len_out,
-			   int *data_offset_out);
-extern int read_cow_bitmap(int fd, void *buf, int offset, int len);
-extern void do_io(struct io_thread_req *req);
-
 static inline int ubd_test_bit(__u64 bit, unsigned char *data)
 {
 	__u64 n;
@@ -200,7 +188,7 @@ struct ubd {
 }
 
 /* Protected by ubd_lock */
-struct ubd ubd_devs[MAX_DEV] = { [ 0 ... MAX_DEV - 1 ] = DEFAULT_UBD };
+static struct ubd ubd_devs[MAX_DEV] = { [ 0 ... MAX_DEV - 1 ] = DEFAULT_UBD };
 
 /* Only changed by fake_ide_setup which is a setup */
 static int fake_ide = 0;
@@ -463,7 +451,7 @@ __uml_help(udb_setup,
 static void do_ubd_request(struct request_queue * q);
 
 /* Only changed by ubd_init, which is an initcall. */
-int thread_fd = -1;
+static int thread_fd = -1;
 
 static void ubd_end_request(struct request *req, int bytes, int error)
 {
@@ -531,7 +519,7 @@ static irqreturn_t ubd_intr(int irq, void *dev)
 /* Only changed by ubd_init, which is an initcall. */
 static int io_pid = -1;
 
-void kill_io_thread(void)
+static void kill_io_thread(void)
 {
 	if(io_pid != -1)
 		os_kill_process(io_pid, 1);
@@ -547,6 +535,186 @@ static inline int ubd_file_size(struct ubd *ubd_dev, __u64 *size_out)
 	return os_file_size(file, size_out);
 }
 
+static int read_cow_bitmap(int fd, void *buf, int offset, int len)
+{
+	int err;
+
+	err = os_seek_file(fd, offset);
+	if(err < 0)
+		return err;
+
+	err = os_read_file(fd, buf, len);
+	if(err < 0)
+		return err;
+
+	return 0;
+}
+
+static int backing_file_mismatch(char *file, __u64 size, time_t mtime)
+{
+	unsigned long modtime;
+	unsigned long long actual;
+	int err;
+
+	err = os_file_modtime(file, &modtime);
+	if(err < 0){
+		printk("Failed to get modification time of backing file "
+		       "\"%s\", err = %d\n", file, -err);
+		return err;
+	}
+
+	err = os_file_size(file, &actual);
+	if(err < 0){
+		printk("Failed to get size of backing file \"%s\", "
+		       "err = %d\n", file, -err);
+		return err;
+	}
+
+	if(actual != size){
+		/*__u64 can be a long on AMD64 and with %lu GCC complains; so
+		 * the typecast.*/
+		printk("Size mismatch (%llu vs %llu) of COW header vs backing "
+		       "file\n", (unsigned long long) size, actual);
+		return -EINVAL;
+	}
+	if(modtime != mtime){
+		printk("mtime mismatch (%ld vs %ld) of COW header vs backing "
+		       "file\n", mtime, modtime);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int path_requires_switch(char *from_cmdline, char *from_cow, char *cow)
+{
+	struct uml_stat buf1, buf2;
+	int err;
+
+	if(from_cmdline == NULL)
+		return 0;
+	if(!strcmp(from_cmdline, from_cow))
+		return 0;
+
+	err = os_stat_file(from_cmdline, &buf1);
+	if(err < 0){
+		printk("Couldn't stat '%s', err = %d\n", from_cmdline, -err);
+		return 0;
+	}
+	err = os_stat_file(from_cow, &buf2);
+	if(err < 0){
+		printk("Couldn't stat '%s', err = %d\n", from_cow, -err);
+		return 1;
+	}
+	if((buf1.ust_dev == buf2.ust_dev) && (buf1.ust_ino == buf2.ust_ino))
+		return 0;
+
+	printk("Backing file mismatch - \"%s\" requested,\n"
+	       "\"%s\" specified in COW header of \"%s\"\n",
+	       from_cmdline, from_cow, cow);
+	return 1;
+}
+
+static int open_ubd_file(char *file, struct openflags *openflags, int shared,
+		  char **backing_file_out, int *bitmap_offset_out,
+		  unsigned long *bitmap_len_out, int *data_offset_out,
+		  int *create_cow_out)
+{
+	time_t mtime;
+	unsigned long long size;
+	__u32 version, align;
+	char *backing_file;
+	int fd, err, sectorsize, asked_switch, mode = 0644;
+
+	fd = os_open_file(file, *openflags, mode);
+	if (fd < 0) {
+		if ((fd == -ENOENT) && (create_cow_out != NULL))
+			*create_cow_out = 1;
+		if (!openflags->w ||
+		    ((fd != -EROFS) && (fd != -EACCES)))
+			return fd;
+		openflags->w = 0;
+		fd = os_open_file(file, *openflags, mode);
+		if (fd < 0)
+			return fd;
+	}
+
+	if(shared)
+		printk("Not locking \"%s\" on the host\n", file);
+	else {
+		err = os_lock_file(fd, openflags->w);
+		if(err < 0){
+			printk("Failed to lock '%s', err = %d\n", file, -err);
+			goto out_close;
+		}
+	}
+
+	/* Successful return case! */
+	if(backing_file_out == NULL)
+		return fd;
+
+	err = read_cow_header(file_reader, &fd, &version, &backing_file, &mtime,
+			      &size, &sectorsize, &align, bitmap_offset_out);
+	if(err && (*backing_file_out != NULL)){
+		printk("Failed to read COW header from COW file \"%s\", "
+		       "errno = %d\n", file, -err);
+		goto out_close;
+	}
+	if(err)
+		return fd;
+
+	asked_switch = path_requires_switch(*backing_file_out, backing_file, file);
+
+	/* Allow switching only if no mismatch. */
+	if (asked_switch && !backing_file_mismatch(*backing_file_out, size, mtime)) {
+		printk("Switching backing file to '%s'\n", *backing_file_out);
+		err = write_cow_header(file, fd, *backing_file_out,
+				       sectorsize, align, &size);
+		if (err) {
+			printk("Switch failed, errno = %d\n", -err);
+			goto out_close;
+		}
+	} else {
+		*backing_file_out = backing_file;
+		err = backing_file_mismatch(*backing_file_out, size, mtime);
+		if (err)
+			goto out_close;
+	}
+
+	cow_sizes(version, size, sectorsize, align, *bitmap_offset_out,
+		  bitmap_len_out, data_offset_out);
+
+	return fd;
+ out_close:
+	os_close_file(fd);
+	return err;
+}
+
+static int create_cow_file(char *cow_file, char *backing_file,
+		    struct openflags flags,
+		    int sectorsize, int alignment, int *bitmap_offset_out,
+		    unsigned long *bitmap_len_out, int *data_offset_out)
+{
+	int err, fd;
+
+	flags.c = 1;
+	fd = open_ubd_file(cow_file, &flags, 0, NULL, NULL, NULL, NULL, NULL);
+	if(fd < 0){
+		err = fd;
+		printk("Open of COW file '%s' failed, errno = %d\n", cow_file,
+		       -err);
+		goto out;
+	}
+
+	err = init_cow_file(fd, cow_file, backing_file, sectorsize, alignment,
+			    bitmap_offset_out, bitmap_len_out,
+			    data_offset_out);
+	if(!err)
+		return fd;
+	os_close_file(fd);
+ out:
+	return err;
+}
+
 static void ubd_close_dev(struct ubd *ubd_dev)
 {
 	os_close_file(ubd_dev->fd);
@@ -1166,185 +1334,6 @@ static int ubd_ioctl(struct inode * inode, struct file * file,
 	return -EINVAL;
 }
 
-static int path_requires_switch(char *from_cmdline, char *from_cow, char *cow)
-{
-	struct uml_stat buf1, buf2;
-	int err;
-
-	if(from_cmdline == NULL)
-		return 0;
-	if(!strcmp(from_cmdline, from_cow))
-		return 0;
-
-	err = os_stat_file(from_cmdline, &buf1);
-	if(err < 0){
-		printk("Couldn't stat '%s', err = %d\n", from_cmdline, -err);
-		return 0;
-	}
-	err = os_stat_file(from_cow, &buf2);
-	if(err < 0){
-		printk("Couldn't stat '%s', err = %d\n", from_cow, -err);
-		return 1;
-	}
-	if((buf1.ust_dev == buf2.ust_dev) && (buf1.ust_ino == buf2.ust_ino))
-		return 0;
-
-	printk("Backing file mismatch - \"%s\" requested,\n"
-	       "\"%s\" specified in COW header of \"%s\"\n",
-	       from_cmdline, from_cow, cow);
-	return 1;
-}
-
-static int backing_file_mismatch(char *file, __u64 size, time_t mtime)
-{
-	unsigned long modtime;
-	unsigned long long actual;
-	int err;
-
-	err = os_file_modtime(file, &modtime);
-	if(err < 0){
-		printk("Failed to get modification time of backing file "
-		       "\"%s\", err = %d\n", file, -err);
-		return err;
-	}
-
-	err = os_file_size(file, &actual);
-	if(err < 0){
-		printk("Failed to get size of backing file \"%s\", "
-		       "err = %d\n", file, -err);
-		return err;
-	}
-
-	if(actual != size){
-		/*__u64 can be a long on AMD64 and with %lu GCC complains; so
-		 * the typecast.*/
-		printk("Size mismatch (%llu vs %llu) of COW header vs backing "
-		       "file\n", (unsigned long long) size, actual);
-		return -EINVAL;
-	}
-	if(modtime != mtime){
-		printk("mtime mismatch (%ld vs %ld) of COW header vs backing "
-		       "file\n", mtime, modtime);
-		return -EINVAL;
-	}
-	return 0;
-}
-
-int read_cow_bitmap(int fd, void *buf, int offset, int len)
-{
-	int err;
-
-	err = os_seek_file(fd, offset);
-	if(err < 0)
-		return err;
-
-	err = os_read_file(fd, buf, len);
-	if(err < 0)
-		return err;
-
-	return 0;
-}
-
-int open_ubd_file(char *file, struct openflags *openflags, int shared,
-		  char **backing_file_out, int *bitmap_offset_out,
-		  unsigned long *bitmap_len_out, int *data_offset_out,
-		  int *create_cow_out)
-{
-	time_t mtime;
-	unsigned long long size;
-	__u32 version, align;
-	char *backing_file;
-	int fd, err, sectorsize, asked_switch, mode = 0644;
-
-	fd = os_open_file(file, *openflags, mode);
-	if (fd < 0) {
-		if ((fd == -ENOENT) && (create_cow_out != NULL))
-			*create_cow_out = 1;
-		if (!openflags->w ||
-		    ((fd != -EROFS) && (fd != -EACCES)))
-			return fd;
-		openflags->w = 0;
-		fd = os_open_file(file, *openflags, mode);
-		if (fd < 0)
-			return fd;
-	}
-
-	if(shared)
-		printk("Not locking \"%s\" on the host\n", file);
-	else {
-		err = os_lock_file(fd, openflags->w);
-		if(err < 0){
-			printk("Failed to lock '%s', err = %d\n", file, -err);
-			goto out_close;
-		}
-	}
-
-	/* Successful return case! */
-	if(backing_file_out == NULL)
-		return fd;
-
-	err = read_cow_header(file_reader, &fd, &version, &backing_file, &mtime,
-			      &size, &sectorsize, &align, bitmap_offset_out);
-	if(err && (*backing_file_out != NULL)){
-		printk("Failed to read COW header from COW file \"%s\", "
-		       "errno = %d\n", file, -err);
-		goto out_close;
-	}
-	if(err)
-		return fd;
-
-	asked_switch = path_requires_switch(*backing_file_out, backing_file, file);
-
-	/* Allow switching only if no mismatch. */
-	if (asked_switch && !backing_file_mismatch(*backing_file_out, size, mtime)) {
-		printk("Switching backing file to '%s'\n", *backing_file_out);
-		err = write_cow_header(file, fd, *backing_file_out,
-				       sectorsize, align, &size);
-		if (err) {
-			printk("Switch failed, errno = %d\n", -err);
-			goto out_close;
-		}
-	} else {
-		*backing_file_out = backing_file;
-		err = backing_file_mismatch(*backing_file_out, size, mtime);
-		if (err)
-			goto out_close;
-	}
-
-	cow_sizes(version, size, sectorsize, align, *bitmap_offset_out,
-		  bitmap_len_out, data_offset_out);
-
-	return fd;
- out_close:
-	os_close_file(fd);
-	return err;
-}
-
-int create_cow_file(char *cow_file, char *backing_file, struct openflags flags,
-		    int sectorsize, int alignment, int *bitmap_offset_out,
-		    unsigned long *bitmap_len_out, int *data_offset_out)
-{
-	int err, fd;
-
-	flags.c = 1;
-	fd = open_ubd_file(cow_file, &flags, 0, NULL, NULL, NULL, NULL, NULL);
-	if(fd < 0){
-		err = fd;
-		printk("Open of COW file '%s' failed, errno = %d\n", cow_file,
-		       -err);
-		goto out;
-	}
-
-	err = init_cow_file(fd, cow_file, backing_file, sectorsize, alignment,
-			    bitmap_offset_out, bitmap_len_out,
-			    data_offset_out);
-	if(!err)
-		return fd;
-	os_close_file(fd);
- out:
-	return err;
-}
-
 static int update_bitmap(struct io_thread_req *req)
 {
 	int n;
@@ -1369,7 +1358,7 @@ static int update_bitmap(struct io_thread_req *req)
 	return 0;
 }
 
-void do_io(struct io_thread_req *req)
+static void do_io(struct io_thread_req *req)
 {
 	char *buf;
 	unsigned long len;
-- 
1.5.2.4


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
