Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <nicolas.boullis@ecp.fr>) id 1KlOpe-0006ez-Vw
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Oct 2008 14:07:06 +0000
Received: from leopard.ecp.fr ([138.195.33.24])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KlOok-00011k-IH for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Oct 2008 14:07:06 +0000
Received: from localhost (localhost [127.0.0.1])
	by leopard.ecp.fr (Postfix) with ESMTP id AEFB037C91
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  2 Oct 2008 15:34:28 +0200 (CEST)
Received: from leopard.ecp.fr ([127.0.0.1])
	by localhost (leopard [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 04296-10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 2 Oct 2008 15:34:28 +0200 (CEST)
Received: from [138.195.30.9] (kheops.system.ecp.fr [138.195.30.9])
	by leopard.ecp.fr (Postfix) with ESMTP id 8A2BB37C82
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  2 Oct 2008 15:34:28 +0200 (CEST)
Message-ID: <48E4CDE3.9090502@ecp.fr>
Date: Thu, 02 Oct 2008 15:34:27 +0200
From: Nicolas Boullis <nicolas.boullis@ecp.fr>
MIME-Version: 1.0
References: <48CA7158.5080500@ecp.fr> <48CE23E5.4070308@ecp.fr>
In-Reply-To: <48CE23E5.4070308@ecp.fr>
Content-Type: multipart/mixed; boundary="------------020106050706080405010807"
Subject: Re: [uml-devel] parallel I/O
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020106050706080405010807
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I wrote:
> 
> For what it's worth, here is my quick-n-dirty proof-of-concept patch
> that enables parallel I/O. Note that it is based on 2.6.24.
> 
> If people are interested, I can try to make a clean patch out of it.

For what it's worth, I fixed a few bugs in my patch. Here is the new
patch. It's still "quick'n'dirty", but it works better, and works for me.


Cheers,

Nicolas

--------------020106050706080405010807
Content-Type: text/x-patch;
 name="uml_parallel_io.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uml_parallel_io.patch"

--- linux-source-2.6.24/arch/um/drivers/ubd_kern.c.orig	2008-09-12 10:28:52.000000000 +0200
+++ linux-source-2.6.24/arch/um/drivers/ubd_kern.c	2008-10-02 15:07:43.000000000 +0200
@@ -65,7 +65,7 @@
 	unsigned long length;
 	char *buffer;
 	int sectorsize;
-	unsigned long sector_mask;
+	unsigned long sector_mask[8];
 	unsigned long long cow_offset;
 	unsigned long bitmap_words[2];
 	int error;
@@ -172,6 +172,9 @@
 	struct scatterlist sg[MAX_SG];
 	struct request *request;
 	int start_sg, end_sg;
+	int pipe_fd[2];
+	int io_pid;
+	unsigned long stacks[17];
 };
 
 #define DEFAULT_COW { \
@@ -196,6 +199,9 @@
 	.request =		NULL, \
 	.start_sg =		0, \
 	.end_sg =		0, \
+	.pipe_fd =		{-1, -1}, \
+	.io_pid =		-1, \
+	.stacks =		{ [0 ... 16] = 0 }, \
 }
 
 /* Protected by ubd_lock */
@@ -473,7 +479,7 @@
 static void do_ubd_request(struct request_queue * q);
 
 /* Only changed by ubd_init, which is an initcall. */
-int thread_fd = -1;
+int common_thread_fd = -1;
 
 static void ubd_end_request(struct request *req, int bytes, int uptodate)
 {
@@ -513,7 +519,7 @@
 	int n;
 
 	while(1){
-		n = os_read_file(thread_fd, &req,
+		n = os_read_file(common_thread_fd, &req,
 				 sizeof(struct io_thread_req *));
 		if(n != sizeof(req)){
 			if(n == -EAGAIN)
@@ -529,7 +535,7 @@
 			ubd_finish(rq, rq->hard_nr_sectors << 9);
 		kfree(req);
 	}
-	reactivate_fd(thread_fd, UBD_IRQ);
+	reactivate_fd(common_thread_fd, UBD_IRQ);
 
 	list_for_each_safe(list, next_ele, &restart){
 		ubd = container_of(list, struct ubd, restart);
@@ -565,6 +571,8 @@
 	return os_file_size(file, size_out);
 }
 
+extern pid_t waitpid(pid_t pid, int *status, int options);
+
 static void ubd_close_dev(struct ubd *ubd_dev)
 {
 	os_close_file(ubd_dev->fd);
@@ -576,6 +584,8 @@
 	ubd_dev->cow.bitmap = NULL;
 }
 
+int per_device_io_thread(void *arg);
+
 static int ubd_open_dev(struct ubd *ubd_dev)
 {
 	struct openflags flags;
@@ -636,6 +646,8 @@
 		if(err < 0) goto error;
 		ubd_dev->cow.fd = err;
 	}
+
+
 	return 0;
  error:
 	os_close_file(ubd_dev->fd);
@@ -938,7 +950,7 @@
 	}
 	stack = alloc_stack(0, 0);
 	io_pid = start_io_thread(stack + PAGE_SIZE - sizeof(void *),
-				 &thread_fd);
+				 &common_thread_fd);
 	if(io_pid < 0){
 		printk(KERN_ERR
 		       "ubd : Failed to start I/O thread (errno = %d) - "
@@ -946,7 +958,7 @@
 		io_pid = -1;
 		return 0;
 	}
-	err = um_request_irq(UBD_IRQ, thread_fd, IRQ_READ, ubd_intr,
+	err = um_request_irq(UBD_IRQ, common_thread_fd, IRQ_READ, ubd_intr,
 			     IRQF_DISABLED, "ubd", ubd_devs);
 	if(err != 0)
 		printk(KERN_ERR "um_request_irq failed - errno = %d\n", -err);
@@ -962,12 +974,27 @@
 	int err = 0;
 
 	if(ubd_dev->count == 0){
+		void *sp;
+		int i;
+
 		err = ubd_open_dev(ubd_dev);
 		if(err){
 			printk(KERN_ERR "%s: Can't open \"%s\": errno = %d\n",
 			       disk->disk_name, ubd_dev->file, -err);
 			goto out;
 		}
+
+		pipe(ubd_dev->pipe_fd);
+
+		for (i = 0; i <= 16; i++)
+			ubd_dev->stacks[i] = alloc_stack(0, 0);
+		sp = (void *)(ubd_dev->stacks[0] + PAGE_SIZE - sizeof(void *));
+		ubd_dev->io_pid = clone(per_device_io_thread, sp, CLONE_VM, (void *)ubd_dev);
+		os_close_file(ubd_dev->pipe_fd[0]);
+		os_set_exec_close(ubd_dev->pipe_fd[1], 1);
+		os_set_fd_block(ubd_dev->pipe_fd[1], 0);
+
+		printk("Launched I/O thread for %s.\n", disk->disk_name);
 	}
 	ubd_dev->count++;
 	set_disk_ro(disk, !ubd_dev->openflags.w);
@@ -987,12 +1014,26 @@
 	struct gendisk *disk = inode->i_bdev->bd_disk;
 	struct ubd *ubd_dev = disk->private_data;
 
-	if(--ubd_dev->count == 0)
+	if(--ubd_dev->count == 0) {
+		int i;
+		printk("Trying to stop I/O thread for %s... ", disk->disk_name);
+		os_close_file(ubd_dev->pipe_fd[1]);
+		waitpid(ubd_dev->io_pid, NULL, __WCLONE);
+		printk("done.\n");
+		ubd_dev->pipe_fd[0] = -1;
+		ubd_dev->pipe_fd[1] = -1;
+		ubd_dev->io_pid = -1;
+		for (i = 0; i <= 16; i++) {
+			free_stack(ubd_dev->stacks[i], 0);
+			ubd_dev->stacks[i] = 0;
+		}
+
 		ubd_close_dev(ubd_dev);
+	}
 	return 0;
 }
 
-static void cowify_bitmap(__u64 io_offset, int length, unsigned long *cow_mask,
+static void cowify_bitmap(__u64 io_offset, int length, unsigned long (*cow_mask)[],
 			  __u64 *cow_offset, unsigned long *bitmap,
 			  __u64 bitmap_offset, unsigned long *bitmap_words,
 			  __u64 bitmap_len)
@@ -1059,6 +1100,7 @@
 {
 	struct gendisk *disk = req->rq_disk;
 	struct ubd *ubd_dev = disk->private_data;
+	int i;
 
 	io_req->req = req;
 	io_req->fds[0] = (ubd_dev->cow.file != NULL) ? ubd_dev->cow.fd :
@@ -1068,7 +1110,8 @@
 	io_req->offset = offset;
 	io_req->length = len;
 	io_req->error = 0;
-	io_req->sector_mask = 0;
+	for (i = 0; i < 8; i++)
+		io_req->sector_mask[i] = 0;
 
 	io_req->op = (rq_data_dir(req) == READ) ? UBD_READ : UBD_WRITE;
 	io_req->offsets[0] = 0;
@@ -1120,7 +1163,7 @@
 					sg->offset, sg->length, sg_page(sg));
 
 			last_sectors = sg->length >> 9;
-			n = os_write_file(thread_fd, &io_req,
+			n = os_write_file(dev->pipe_fd[1], &io_req,
 					  sizeof(struct io_thread_req *));
 			if(n != sizeof(struct io_thread_req *)){
 				if(n != -EAGAIN)
@@ -1482,3 +1525,79 @@
 
 	return 0;
 }
+
+extern int open(const char *pathname, int flags);
+extern int dup2(int oldfd, int newfd);
+
+void reopen(int fd)
+{
+	char name[64];
+	int tmp_fd;
+
+	sprintf(name, "/proc/self/fd/%d", fd);
+	tmp_fd = open(name, O_RDWR | O_SYNC);
+	os_close_file(fd);
+	dup2(tmp_fd, fd);
+	os_close_file(tmp_fd);
+}
+
+int io_subthread(void *arg)
+{
+	struct ubd *ubd_dev = (struct ubd *)arg;
+	struct io_thread_req *req;
+	int n;
+
+	if (ubd_dev->fd >= 0)
+		reopen(ubd_dev->fd);
+
+	if (ubd_dev->cow.fd >= 0)
+		reopen(ubd_dev->cow.fd);
+
+	while(1){
+		n = os_read_file(ubd_dev->pipe_fd[0], &req,
+				 sizeof(struct io_thread_req *));
+		if(n != sizeof(struct io_thread_req *)){
+			if(n < 0)
+				printk("io_subthread - read failed, fd = %d, "
+				       "err = %d\n", ubd_dev->pipe_fd[0], -n);
+			else if (n == 0)
+				break;
+			else {
+				printk("io_subthread - short read, fd = %d, "
+				       "length = %d\n", ubd_dev->pipe_fd[0], n);
+			}
+			continue;
+		}
+		io_count++;
+		do_io(req);
+		n = os_write_file(kernel_fd, &req,
+				  sizeof(struct io_thread_req *));
+		if(n != sizeof(struct io_thread_req *))
+			printk("io_subthread - write failed, fd = %d, err = %d\n",
+			       kernel_fd, -n);
+	}
+
+	ubd_close_dev(ubd_dev);
+
+	return 0;
+}
+
+int per_device_io_thread(void *arg)
+{
+	struct ubd *ubd_dev = (struct ubd *)arg;
+	int i;
+
+	ignore_sigwinch_sig();
+
+	os_close_file(ubd_dev->pipe_fd[1]);
+
+	for (i = 0; i < 16; i++) {
+		void *sp;
+		sp = (void *)(ubd_dev->stacks[i+1] + PAGE_SIZE - sizeof(void *));
+		clone(io_subthread, sp, CLONE_VM, (void *)ubd_dev);
+	}
+
+	while (waitpid(-1, NULL, __WCLONE) != -1);
+
+	return 0;
+}

--------------020106050706080405010807
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--------------020106050706080405010807
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--------------020106050706080405010807--

