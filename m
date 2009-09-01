Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rmy@tigress.co.uk>) id 1MiWA8-0003mD-3B
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Sep 2009 16:24:52 +0000
Received: from mail.tigress.co.uk ([195.172.168.163] helo=intgat.tigress.co.uk)
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MiW9z-0000Y2-Ey
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Sep 2009 16:24:52 +0000
From: Ron Yorston <rmy@tigress.co.uk>
Message-Id: <200909011623.n81GNsKl004676@tiffany.internal.tigress.co.uk>
Date: Tue, 01 Sep 2009 17:23:53 +0100
MIME-Version: 1.0
Subject: [uml-devel] [PATCH] uml: clean up OS wrapper functions
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com
Cc: rmy@tigress.co.uk

Several OS wrapper functions are no longer used.

Signed-off-by: Ron Yorston <rmy@tigress.co.uk>
---
diff -up linux-2.6.30.5/arch/um/include/shared/os.h.os-wrapper-cleanup linux-2.6.30.5/arch/um/include/shared/os.h
--- linux-2.6.30.5/arch/um/include/shared/os.h.os-wrapper-cleanup	2009-08-16 22:19:38.000000000 +0100
+++ linux-2.6.30.5/arch/um/include/shared/os.h	2009-09-01 15:39:30.000000000 +0100
@@ -22,13 +22,6 @@
 #define OS_TYPE_FIFO 6
 #define OS_TYPE_SOCK 7
 
-/* os_access() flags */
-#define OS_ACC_F_OK    0       /* Test for existence.  */
-#define OS_ACC_X_OK    1       /* Test for execute permission.  */
-#define OS_ACC_W_OK    2       /* Test for write permission.  */
-#define OS_ACC_R_OK    4       /* Test for read permission.  */
-#define OS_ACC_RW_OK   (OS_ACC_W_OK | OS_ACC_R_OK) /* Test for RW permission */
-
 /*
  * types taken from stat_file() in hostfs_user.c
  * (if they are wrong here, they are wrong there...).
@@ -124,13 +117,10 @@ static inline struct openflags of_cloexe
 
 /* file.c */
 extern int os_stat_file(const char *file_name, struct uml_stat *buf);
-extern int os_stat_fd(const int fd, struct uml_stat *buf);
-extern int os_access(const char *file, int mode);
 extern int os_set_exec_close(int fd);
 extern int os_ioctl_generic(int fd, unsigned int cmd, unsigned long arg);
 extern int os_get_ifname(int fd, char *namebuf);
 extern int os_set_slip(int fd);
-extern int os_mode_fd(int fd, int mode);
 
 extern int os_seek_file(int fd, unsigned long long offset);
 extern int os_open_file(const char *file, struct openflags flags, int mode);
@@ -142,7 +132,6 @@ extern int os_pipe(int *fd, int stream, 
 extern int os_set_fd_async(int fd);
 extern int os_clear_fd_async(int fd);
 extern int os_set_fd_block(int fd, int blocking);
-extern int os_accept_connection(int fd);
 extern int os_create_unix_socket(const char *file, int len, int close_on_exec);
 extern int os_shutdown_socket(int fd, int r, int w);
 extern void os_close_file(int fd);
@@ -150,7 +139,6 @@ extern int os_rcv_fd(int fd, int *helper
 extern int create_unix_socket(char *file, int len, int close_on_exec);
 extern int os_connect_socket(const char *name);
 extern int os_file_type(char *file);
-extern int os_file_mode(const char *file, struct openflags *mode_out);
 extern int os_lock_file(int fd, int excl);
 extern void os_flush_stdout(void);
 extern int os_stat_filesystem(char *path, long *bsize_out,
diff -up linux-2.6.30.5/arch/um/kernel/ksyms.c.os-wrapper-cleanup linux-2.6.30.5/arch/um/kernel/ksyms.c
--- linux-2.6.30.5/arch/um/kernel/ksyms.c.os-wrapper-cleanup	2009-08-16 22:19:38.000000000 +0100
+++ linux-2.6.30.5/arch/um/kernel/ksyms.c	2009-09-01 15:37:09.000000000 +0100
@@ -31,9 +31,7 @@ EXPORT_SYMBOL(copy_from_user);
 EXPORT_SYMBOL(clear_user);
 EXPORT_SYMBOL(uml_strdup);
 
-EXPORT_SYMBOL(os_stat_fd);
 EXPORT_SYMBOL(os_stat_file);
-EXPORT_SYMBOL(os_access);
 EXPORT_SYMBOL(os_set_exec_close);
 EXPORT_SYMBOL(os_getpid);
 EXPORT_SYMBOL(os_open_file);
@@ -44,7 +42,6 @@ EXPORT_SYMBOL(os_lock_file);
 EXPORT_SYMBOL(os_ioctl_generic);
 EXPORT_SYMBOL(os_pipe);
 EXPORT_SYMBOL(os_file_type);
-EXPORT_SYMBOL(os_file_mode);
 EXPORT_SYMBOL(os_file_size);
 EXPORT_SYMBOL(os_flush_stdout);
 EXPORT_SYMBOL(os_close_file);
@@ -54,7 +51,6 @@ EXPORT_SYMBOL(helper_wait);
 EXPORT_SYMBOL(os_shutdown_socket);
 EXPORT_SYMBOL(os_create_unix_socket);
 EXPORT_SYMBOL(os_connect_socket);
-EXPORT_SYMBOL(os_accept_connection);
 EXPORT_SYMBOL(os_rcv_fd);
 EXPORT_SYMBOL(run_helper);
 EXPORT_SYMBOL(start_thread);
diff -up linux-2.6.30.5/arch/um/os-Linux/file.c.os-wrapper-cleanup linux-2.6.30.5/arch/um/os-Linux/file.c
--- linux-2.6.30.5/arch/um/os-Linux/file.c.os-wrapper-cleanup	2009-08-16 22:19:38.000000000 +0100
+++ linux-2.6.30.5/arch/um/os-Linux/file.c	2009-09-01 15:41:42.000000000 +0100
@@ -35,20 +35,6 @@ static void copy_stat(struct uml_stat *d
 	});
 }
 
-int os_stat_fd(const int fd, struct uml_stat *ubuf)
-{
-	struct stat64 sbuf;
-	int err;
-
-	CATCH_EINTR(err = fstat64(fd, &sbuf));
-	if (err < 0)
-		return -errno;
-
-	if (ubuf != NULL)
-		copy_stat(ubuf, &sbuf);
-	return err;
-}
-
 int os_stat_file(const char *file_name, struct uml_stat *ubuf)
 {
 	struct stat64 sbuf;
@@ -63,22 +49,6 @@ int os_stat_file(const char *file_name, 
 	return err;
 }
 
-int os_access(const char *file, int mode)
-{
-	int amode, err;
-
-	amode = (mode & OS_ACC_R_OK ? R_OK : 0) |
-		(mode & OS_ACC_W_OK ? W_OK : 0) |
-		(mode & OS_ACC_X_OK ? X_OK : 0) |
-		(mode & OS_ACC_F_OK ? F_OK : 0);
-
-	err = access(file, amode);
-	if (err < 0)
-		return -errno;
-
-	return 0;
-}
-
 /* FIXME? required only by hostaudio (because it passes ioctls verbatim) */
 int os_ioctl_generic(int fd, unsigned int cmd, unsigned long arg)
 {
@@ -115,17 +85,6 @@ int os_set_slip(int fd)
 	return 0;
 }
 
-int os_mode_fd(int fd, int mode)
-{
-	int err;
-
-	CATCH_EINTR(err = fchmod(fd, mode));
-	if (err < 0)
-		return -errno;
-
-	return 0;
-}
-
 int os_file_type(char *file)
 {
 	struct uml_stat buf;
@@ -150,27 +109,6 @@ int os_file_type(char *file)
 	else return OS_TYPE_FILE;
 }
 
-int os_file_mode(const char *file, struct openflags *mode_out)
-{
-	int err;
-
-	*mode_out = OPENFLAGS();
-
-	err = access(file, W_OK);
-	if (err && (errno != EACCES))
-		return -errno;
-	else if (!err)
-		*mode_out = of_write(*mode_out);
-
-	err = access(file, R_OK);
-	if (err && (errno != EACCES))
-		return -errno;
-	else if (!err)
-		*mode_out = of_read(*mode_out);
-
-	return err;
-}
-
 int os_open_file(const char *file, struct openflags flags, int mode)
 {
 	int fd, err, f = 0;
@@ -422,16 +360,6 @@ int os_set_fd_block(int fd, int blocking
 	return 0;
 }
 
-int os_accept_connection(int fd)
-{
-	int new;
-
-	new = accept(fd, NULL, 0);
-	if (new < 0)
-		return -errno;
-	return new;
-}
-
 #ifndef SHUT_RD
 #define SHUT_RD 0
 #endif

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

