Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H9RPP-0003UL-Bn for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Jan 2007 11:34:19 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H9RPN-0003QY-MS
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Jan 2007 11:34:19 -0800
Message-Id: <200701231927.l0NJRlEH005363@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Tue, 23 Jan 2007 14:27:47 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 6/7] UML - libc-dependent code should call libc
	directly
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

We shouldn't be using the os wrappers from os code - we can use libc
directly.  This patch replaces wrapper calls with libc calls.

It turns out that os_sigio_async had only one caller, which was in
startup.c, so that function is moved there and its name changed.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/include/os.h        |    1 -
 arch/um/os-Linux/file.c     |   19 -------------------
 arch/um/os-Linux/start_up.c |   39 ++++++++++++++++++++++++++++-----------
 3 files changed, 28 insertions(+), 31 deletions(-)

Index: linux-2.6.18-mm/arch/um/include/os.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/os.h	2007-01-13 17:29:40.000000000 +1100
+++ linux-2.6.18-mm/arch/um/include/os.h	2007-01-14 10:50:06.000000000 +1100
@@ -137,7 +137,6 @@ extern int os_new_tty_pgrp(int fd, int p
 extern int os_get_ifname(int fd, char *namebuf);
 extern int os_set_slip(int fd);
 extern int os_set_owner(int fd, int pid);
-extern int os_sigio_async(int master, int slave);
 extern int os_mode_fd(int fd, int mode);
 
 extern int os_seek_file(int fd, __u64 offset);
Index: linux-2.6.18-mm/arch/um/os-Linux/file.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/file.c	2007-01-13 17:28:41.000000000 +1100
+++ linux-2.6.18-mm/arch/um/os-Linux/file.c	2007-01-14 10:50:06.000000000 +1100
@@ -162,25 +162,6 @@ int os_set_owner(int fd, int pid)
 	return 0;
 }
 
-/* FIXME? moved wholesale from sigio_user.c to get fcntls out of that file */
-int os_sigio_async(int master, int slave)
-{
-	int flags;
-
-	flags = fcntl(master, F_GETFL);
-	if(flags < 0)
-		return -errno;
-
-	if((fcntl(master, F_SETFL, flags | O_NONBLOCK | O_ASYNC) < 0) ||
-	   (fcntl(master, F_SETOWN, os_getpid()) < 0))
-		return -errno;
-
-	if((fcntl(slave, F_SETFL, flags | O_NONBLOCK) < 0))
-		return -errno;
-
-	return(0);
-}
-
 int os_mode_fd(int fd, int mode)
 {
 	int err;
Index: linux-2.6.18-mm/arch/um/os-Linux/start_up.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/start_up.c	2007-01-13 18:00:47.000000000 +1100
+++ linux-2.6.18-mm/arch/um/os-Linux/start_up.c	2007-01-14 10:50:14.000000000 +1100
@@ -54,7 +54,7 @@ static int ptrace_child(void *arg)
 		perror("ptrace");
 		os_kill_process(pid, 0);
 	}
-	os_stop_process(pid);
+	kill(pid, SIGSTOP);
 
 	/*This syscall will be intercepted by the parent. Don't call more than
 	 * once, please.*/
@@ -417,7 +417,7 @@ static inline void check_skas3_ptrace_ld
 static inline void check_skas3_proc_mm(void)
 {
 	printf("  - /proc/mm...");
-	if (os_access("/proc/mm", OS_ACC_W_OK) < 0) {
+	if (access("/proc/mm", W_OK) < 0) {
 		proc_mm = 0;
 		printf("not found\n");
 	}
@@ -452,9 +452,9 @@ int can_do_skas(void)
 int __init parse_iomem(char *str, int *add)
 {
 	struct iomem_region *new;
-	struct uml_stat buf;
+	struct stat64 buf;
 	char *file, *driver;
-	int fd, err, size;
+	int fd, size;
 
 	driver = str;
 	file = strchr(str,',');
@@ -464,15 +464,14 @@ int __init parse_iomem(char *str, int *a
 	}
 	*file = '\0';
 	file++;
-	fd = os_open_file(file, of_rdwr(OPENFLAGS()), 0);
+	fd = open(file, O_RDWR, 0);
 	if(fd < 0){
 		os_print_error(fd, "parse_iomem - Couldn't open io file");
 		goto out;
 	}
 
-	err = os_stat_fd(fd, &buf);
-	if(err < 0){
-		os_print_error(err, "parse_iomem - cannot stat_fd file");
+	if(fstat64(fd, &buf) < 0){
+		perror("parse_iomem - cannot stat_fd file");
 		goto out_close;
 	}
 
@@ -482,7 +481,7 @@ int __init parse_iomem(char *str, int *a
 		goto out_close;
 	}
 
-	size = (buf.ust_size + UM_KERN_PAGE_SIZE) & ~(UM_KERN_PAGE_SIZE - 1);
+	size = (buf.st_size + UM_KERN_PAGE_SIZE) & ~(UM_KERN_PAGE_SIZE - 1);
 
 	*new = ((struct iomem_region) { .next		= iomem_regions,
 					.driver		= driver,
@@ -495,7 +494,7 @@ int __init parse_iomem(char *str, int *a
 
 	return 0;
  out_close:
-	os_close_file(fd);
+	close(fd);
  out:
 	return 1;
 }
@@ -528,6 +527,24 @@ static void openpty_cb(void *arg)
 		info->err = -errno;
 }
 
+static int async_pty(int master, int slave)
+{
+	int flags;
+
+	flags = fcntl(master, F_GETFL);
+	if(flags < 0)
+		return -errno;
+
+	if((fcntl(master, F_SETFL, flags | O_NONBLOCK | O_ASYNC) < 0) ||
+	   (fcntl(master, F_SETOWN, os_getpid()) < 0))
+		return -errno;
+
+	if((fcntl(slave, F_SETFL, flags | O_NONBLOCK) < 0))
+		return -errno;
+
+	return(0);
+}
+
 static void __init check_one_sigio(void (*proc)(int, int))
 {
 	struct sigaction old, new;
@@ -553,7 +570,7 @@ static void __init check_one_sigio(void 
 	if (err < 0)
 		panic("check_sigio : __raw failed, errno = %d\n", -err);
 
-	err = os_sigio_async(master, slave);
+	err = async_pty(master, slave);
 	if(err < 0)
 		panic("tty_fds : sigio_async failed, err = %d\n", -err);
 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
