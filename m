Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] um: remove unused AIO code
Date: Wed, 11 Jul 2018 09:32:39 +0200
Message-Id: <20180711073239.31875-1-hch@lst.de>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: richard@nod.at
Cc: linux-um@lists.infradead.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/include/shared/aio.h |  28 ---
 arch/um/os-Linux/Makefile    |   8 +-
 arch/um/os-Linux/aio.c       | 390 -----------------------------------
 3 files changed, 2 insertions(+), 424 deletions(-)
 delete mode 100644 arch/um/include/shared/aio.h
 delete mode 100644 arch/um/os-Linux/aio.c

diff --git a/arch/um/include/shared/aio.h b/arch/um/include/shared/aio.h
deleted file mode 100644
index 423bae9153f8..000000000000
--- a/arch/um/include/shared/aio.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * Copyright (C) 2004 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef AIO_H__
-#define AIO_H__
-
-enum aio_type { AIO_READ, AIO_WRITE, AIO_MMAP };
-
-struct aio_thread_reply {
-	void *data;
-	int err;
-};
-
-struct aio_context {
-	int reply_fd;
-	struct aio_context *next;
-};
-
-#define INIT_AIO_CONTEXT { .reply_fd	= -1, \
-			   .next	= NULL }
-
-extern int submit_aio(enum aio_type type, int fd, char *buf, int len,
-		      unsigned long long offset, int reply_fd,
-                      struct aio_context *aio);
-
-#endif
diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index ada473bf6f46..455b500afe97 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -6,18 +6,14 @@
 # Don't instrument UML-specific code
 KCOV_INSTRUMENT                := n
 
-obj-y = aio.o execvp.o file.o helper.o irq.o main.o mem.o process.o \
+obj-y = execvp.o file.o helper.o irq.o main.o mem.o process.o \
 	registers.o sigio.o signal.o start_up.o time.o tty.o \
 	umid.o user_syms.o util.o drivers/ skas/
 
 obj-$(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA) += elf_aux.o
 
-USER_OBJS := $(user-objs-y) aio.o elf_aux.o execvp.o file.o helper.o irq.o \
+USER_OBJS := $(user-objs-y) elf_aux.o execvp.o file.o helper.o irq.o \
 	main.o mem.o process.o registers.o sigio.o signal.o start_up.o time.o \
 	tty.o umid.o util.o
 
-HAVE_AIO_ABI := $(shell [ -r /usr/include/linux/aio_abi.h ] && \
-	echo -DHAVE_AIO_ABI )
-CFLAGS_aio.o += $(HAVE_AIO_ABI)
-
 include arch/um/scripts/Makefile.rules
diff --git a/arch/um/os-Linux/aio.c b/arch/um/os-Linux/aio.c
deleted file mode 100644
index 014eb35fd13b..000000000000
--- a/arch/um/os-Linux/aio.c
+++ /dev/null
@@ -1,390 +0,0 @@
-/*
- * Copyright (C) 2004 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
- */
-
-#include <unistd.h>
-#include <sched.h>
-#include <signal.h>
-#include <errno.h>
-#include <sys/time.h>
-#include <asm/unistd.h>
-#include <aio.h>
-#include <init.h>
-#include <kern_util.h>
-#include <os.h>
-
-struct aio_thread_req {
-	enum aio_type type;
-	int io_fd;
-	unsigned long long offset;
-	char *buf;
-	int len;
-	struct aio_context *aio;
-};
-
-#if defined(HAVE_AIO_ABI)
-#include <linux/aio_abi.h>
-
-/*
- * If we have the headers, we are going to build with AIO enabled.
- * If we don't have aio in libc, we define the necessary stubs here.
- */
-
-#if !defined(HAVE_AIO_LIBC)
-
-static long io_setup(int n, aio_context_t *ctxp)
-{
-	return syscall(__NR_io_setup, n, ctxp);
-}
-
-static long io_submit(aio_context_t ctx, long nr, struct iocb **iocbpp)
-{
-	return syscall(__NR_io_submit, ctx, nr, iocbpp);
-}
-
-static long io_getevents(aio_context_t ctx_id, long min_nr, long nr,
-			 struct io_event *events, struct timespec *timeout)
-{
-	return syscall(__NR_io_getevents, ctx_id, min_nr, nr, events, timeout);
-}
-
-#endif
-
-/*
- * The AIO_MMAP cases force the mmapped page into memory here
- * rather than in whatever place first touches the data.  I used
- * to do this by touching the page, but that's delicate because
- * gcc is prone to optimizing that away.  So, what's done here
- * is we read from the descriptor from which the page was
- * mapped.  The caller is required to pass an offset which is
- * inside the page that was mapped.  Thus, when the read
- * returns, we know that the page is in the page cache, and
- * that it now backs the mmapped area.
- */
-
-static int do_aio(aio_context_t ctx, enum aio_type type, int fd, char *buf,
-		  int len, unsigned long long offset, struct aio_context *aio)
-{
-	struct iocb *iocbp = & ((struct iocb) {
-				    .aio_data       = (unsigned long) aio,
-				    .aio_fildes     = fd,
-				    .aio_buf        = (unsigned long) buf,
-				    .aio_nbytes     = len,
-				    .aio_offset     = offset
-			     });
-	char c;
-
-	switch (type) {
-	case AIO_READ:
-		iocbp->aio_lio_opcode = IOCB_CMD_PREAD;
-		break;
-	case AIO_WRITE:
-		iocbp->aio_lio_opcode = IOCB_CMD_PWRITE;
-		break;
-	case AIO_MMAP:
-		iocbp->aio_lio_opcode = IOCB_CMD_PREAD;
-		iocbp->aio_buf = (unsigned long) &c;
-		iocbp->aio_nbytes = sizeof(c);
-		break;
-	default:
-		printk(UM_KERN_ERR "Bogus op in do_aio - %d\n", type);
-		return -EINVAL;
-	}
-
-	return (io_submit(ctx, 1, &iocbp) > 0) ? 0 : -errno;
-}
-
-/* Initialized in an initcall and unchanged thereafter */
-static aio_context_t ctx = 0;
-
-static int aio_thread(void *arg)
-{
-	struct aio_thread_reply reply;
-	struct io_event event;
-	int err, n, reply_fd;
-
-	os_fix_helper_signals();
-	while (1) {
-		n = io_getevents(ctx, 1, 1, &event, NULL);
-		if (n < 0) {
-			if (errno == EINTR)
-				continue;
-			printk(UM_KERN_ERR "aio_thread - io_getevents failed, "
-			       "errno = %d\n", errno);
-		}
-		else {
-			reply = ((struct aio_thread_reply)
-				{ .data = (void *) (long) event.data,
-						.err	= event.res });
-			reply_fd = ((struct aio_context *) reply.data)->reply_fd;
-			err = write(reply_fd, &reply, sizeof(reply));
-			if (err != sizeof(reply))
-				printk(UM_KERN_ERR "aio_thread - write failed, "
-				       "fd = %d, err = %d\n", reply_fd, errno);
-		}
-	}
-	return 0;
-}
-
-#endif
-
-static int do_not_aio(struct aio_thread_req *req)
-{
-	char c;
-	unsigned long long actual;
-	int n;
-
-	actual = lseek64(req->io_fd, req->offset, SEEK_SET);
-	if (actual != req->offset)
-		return -errno;
-
-	switch (req->type) {
-	case AIO_READ:
-		n = read(req->io_fd, req->buf, req->len);
-		break;
-	case AIO_WRITE:
-		n = write(req->io_fd, req->buf, req->len);
-		break;
-	case AIO_MMAP:
-		n = read(req->io_fd, &c, sizeof(c));
-		break;
-	default:
-		printk(UM_KERN_ERR "do_not_aio - bad request type : %d\n",
-		       req->type);
-		return -EINVAL;
-	}
-
-	if (n < 0)
-		return -errno;
-	return 0;
-}
-
-/* These are initialized in initcalls and not changed */
-static int aio_req_fd_r = -1;
-static int aio_req_fd_w = -1;
-static int aio_pid = -1;
-static unsigned long aio_stack;
-
-static int not_aio_thread(void *arg)
-{
-	struct aio_thread_req req;
-	struct aio_thread_reply reply;
-	int err;
-
-	os_fix_helper_signals();
-	while (1) {
-		err = read(aio_req_fd_r, &req, sizeof(req));
-		if (err != sizeof(req)) {
-			if (err < 0)
-				printk(UM_KERN_ERR "not_aio_thread - "
-				       "read failed, fd = %d, err = %d\n",
-				       aio_req_fd_r,
-				       errno);
-			else {
-				printk(UM_KERN_ERR "not_aio_thread - short "
-				       "read, fd = %d, length = %d\n",
-				       aio_req_fd_r, err);
-			}
-			continue;
-		}
-		err = do_not_aio(&req);
-		reply = ((struct aio_thread_reply) { .data 	= req.aio,
-						     .err	= err });
-		err = write(req.aio->reply_fd, &reply, sizeof(reply));
-		if (err != sizeof(reply))
-			printk(UM_KERN_ERR "not_aio_thread - write failed, "
-			       "fd = %d, err = %d\n", req.aio->reply_fd, errno);
-	}
-
-	return 0;
-}
-
-static int init_aio_24(void)
-{
-	int fds[2], err;
-
-	err = os_pipe(fds, 1, 1);
-	if (err)
-		goto out;
-
-	aio_req_fd_w = fds[0];
-	aio_req_fd_r = fds[1];
-
-	err = os_set_fd_block(aio_req_fd_w, 0);
-	if (err)
-		goto out_close_pipe;
-
-	err = run_helper_thread(not_aio_thread, NULL,
-				CLONE_FILES | CLONE_VM, &aio_stack);
-	if (err < 0)
-		goto out_close_pipe;
-
-	aio_pid = err;
-	goto out;
-
-out_close_pipe:
-	close(fds[0]);
-	close(fds[1]);
-	aio_req_fd_w = -1;
-	aio_req_fd_r = -1;
-out:
-#ifndef HAVE_AIO_ABI
-	printk(UM_KERN_INFO "/usr/include/linux/aio_abi.h not present during "
-	       "build\n");
-#endif
-	printk(UM_KERN_INFO "2.6 host AIO support not used - falling back to "
-	       "I/O thread\n");
-	return 0;
-}
-
-#ifdef HAVE_AIO_ABI
-#define DEFAULT_24_AIO 0
-static int init_aio_26(void)
-{
-	int err;
-
-	if (io_setup(256, &ctx)) {
-		err = -errno;
-		printk(UM_KERN_ERR "aio_thread failed to initialize context, "
-		       "err = %d\n", errno);
-		return err;
-	}
-
-	err = run_helper_thread(aio_thread, NULL,
-				CLONE_FILES | CLONE_VM, &aio_stack);
-	if (err < 0)
-		return err;
-
-	aio_pid = err;
-
-	printk(UM_KERN_INFO "Using 2.6 host AIO\n");
-	return 0;
-}
-
-static int submit_aio_26(enum aio_type type, int io_fd, char *buf, int len,
-			 unsigned long long offset, struct aio_context *aio)
-{
-	struct aio_thread_reply reply;
-	int err;
-
-	err = do_aio(ctx, type, io_fd, buf, len, offset, aio);
-	if (err) {
-		reply = ((struct aio_thread_reply) { .data = aio,
-					 .err  = err });
-		err = write(aio->reply_fd, &reply, sizeof(reply));
-		if (err != sizeof(reply)) {
-			err = -errno;
-			printk(UM_KERN_ERR "submit_aio_26 - write failed, "
-			       "fd = %d, err = %d\n", aio->reply_fd, -err);
-		}
-		else err = 0;
-	}
-
-	return err;
-}
-
-#else
-#define DEFAULT_24_AIO 1
-static int init_aio_26(void)
-{
-	return -ENOSYS;
-}
-
-static int submit_aio_26(enum aio_type type, int io_fd, char *buf, int len,
-			 unsigned long long offset, struct aio_context *aio)
-{
-	return -ENOSYS;
-}
-#endif
-
-/* Initialized in an initcall and unchanged thereafter */
-static int aio_24 = DEFAULT_24_AIO;
-
-static int __init set_aio_24(char *name, int *add)
-{
-	aio_24 = 1;
-	return 0;
-}
-
-__uml_setup("aio=2.4", set_aio_24,
-"aio=2.4\n"
-"    This is used to force UML to use 2.4-style AIO even when 2.6 AIO is\n"
-"    available.  2.4 AIO is a single thread that handles one request at a\n"
-"    time, synchronously.  2.6 AIO is a thread which uses the 2.6 AIO \n"
-"    interface to handle an arbitrary number of pending requests.  2.6 AIO \n"
-"    is not available in tt mode, on 2.4 hosts, or when UML is built with\n"
-"    /usr/include/linux/aio_abi.h not available.  Many distributions don't\n"
-"    include aio_abi.h, so you will need to copy it from a kernel tree to\n"
-"    your /usr/include/linux in order to build an AIO-capable UML\n\n"
-);
-
-static int init_aio(void)
-{
-	int err;
-
-	if (!aio_24) {
-		err = init_aio_26();
-		if (err && (errno == ENOSYS)) {
-			printk(UM_KERN_INFO "2.6 AIO not supported on the "
-			       "host - reverting to 2.4 AIO\n");
-			aio_24 = 1;
-		}
-		else return err;
-	}
-
-	if (aio_24)
-		return init_aio_24();
-
-	return 0;
-}
-
-/*
- * The reason for the __initcall/__uml_exitcall asymmetry is that init_aio
- * needs to be called when the kernel is running because it calls run_helper,
- * which needs get_free_page.  exit_aio is a __uml_exitcall because the generic
- * kernel does not run __exitcalls on shutdown, and can't because many of them
- * break when called outside of module unloading.
- */
-__initcall(init_aio);
-
-static void exit_aio(void)
-{
-	if (aio_pid != -1) {
-		os_kill_process(aio_pid, 1);
-		free_stack(aio_stack, 0);
-	}
-}
-
-__uml_exitcall(exit_aio);
-
-static int submit_aio_24(enum aio_type type, int io_fd, char *buf, int len,
-			 unsigned long long offset, struct aio_context *aio)
-{
-	struct aio_thread_req req = { .type 		= type,
-				      .io_fd		= io_fd,
-				      .offset		= offset,
-				      .buf		= buf,
-				      .len		= len,
-				      .aio		= aio,
-	};
-	int err;
-
-	err = write(aio_req_fd_w, &req, sizeof(req));
-	if (err == sizeof(req))
-		err = 0;
-	else err = -errno;
-
-	return err;
-}
-
-int submit_aio(enum aio_type type, int io_fd, char *buf, int len,
-	       unsigned long long offset, int reply_fd,
-	       struct aio_context *aio)
-{
-	aio->reply_fd = reply_fd;
-	if (aio_24)
-		return submit_aio_24(type, io_fd, buf, len, offset, aio);
-	else
-		return submit_aio_26(type, io_fd, buf, len, offset, aio);
-}
-- 
2.18.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

