Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ip7c3-0006lK-4P for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Nov 2007 11:27:55 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ip7c1-00058t-Vh
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Nov 2007 11:27:55 -0800
Date: Mon, 5 Nov 2007 14:27:46 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071105192746.GA8783@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/6] UML - const and other tidying
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
To: Andrew Morton <akpm@osdl.org>
Cc: WANG Cong <xiyou.wangcong@gmail.com>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

From: WANG Cong <xiyou.wangcong@gmail.com>

This patch also does some improvements for uml code. Improvements include
dropping unnecessary cast, killing some unnecessary code and still some
constifying for pointers etc..

Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/drivers/ubd_kern.c             |    6 +++---
 arch/um/include/kern_util.h            |    2 +-
 arch/um/kernel/mem.c                   |    2 +-
 arch/um/kernel/process.c               |    4 +---
 arch/um/os-Linux/drivers/tuntap_user.c |    2 +-
 arch/um/os-Linux/mem.c                 |    7 ++++---
 arch/um/os-Linux/sigio.c               |    2 +-
 7 files changed, 12 insertions(+), 13 deletions(-)

Index: linux-2.6/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.orig/arch/um/drivers/ubd_kern.c	2007-11-05 14:08:07.000000000 -0500
+++ linux-2.6/arch/um/drivers/ubd_kern.c	2007-11-05 14:08:08.000000000 -0500
@@ -229,7 +229,7 @@ static int proc_ide_read_media(char *pag
 	return len;
 }
 
-static void make_ide_entries(char *dev_name)
+static void make_ide_entries(const char *dev_name)
 {
 	struct proc_dir_entry *dir, *ent;
 	char name[64];
@@ -244,7 +244,7 @@ static void make_ide_entries(char *dev_n
 	ent->data = NULL;
 	ent->read_proc = proc_ide_read_media;
 	ent->write_proc = NULL;
-	sprintf(name,"ide0/%s", dev_name);
+	snprintf(name, sizeof(name), "ide0/%s", dev_name);
 	proc_symlink(dev_name, proc_ide_root, name);
 }
 
@@ -443,7 +443,7 @@ __uml_help(ubd_setup,
 "    cluster filesystem and inappropriate at almost all other times.\n\n"
 );
 
-static int udb_setup(char *str)
+static int udb_setup(const char *str)
 {
 	printk("udb%s specified on command line is almost certainly a ubd -> "
 	       "udb TYPO\n", str);
Index: linux-2.6/arch/um/include/kern_util.h
===================================================================
--- linux-2.6.orig/arch/um/include/kern_util.h	2007-11-05 14:08:07.000000000 -0500
+++ linux-2.6/arch/um/include/kern_util.h	2007-11-05 14:08:08.000000000 -0500
@@ -81,7 +81,7 @@ extern void do_uml_exitcalls(void);
 extern int attach_debugger(int idle_pid, int pid, int stop);
 extern int config_gdb(char *str);
 extern int remove_gdb(void);
-extern char *uml_strdup(char *string);
+extern char *uml_strdup(const char *string);
 extern void unprotect_kernel_mem(void);
 extern void protect_kernel_mem(void);
 extern void uml_cleanup(void);
Index: linux-2.6/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.orig/arch/um/kernel/mem.c	2007-11-05 14:08:07.000000000 -0500
+++ linux-2.6/arch/um/kernel/mem.c	2007-11-05 14:08:08.000000000 -0500
@@ -65,7 +65,7 @@ static void setup_highmem(unsigned long 
 void __init mem_init(void)
 {
 	/* clear the zero-page */
-	memset((void *) empty_zero_page, 0, PAGE_SIZE);
+	memset(empty_zero_page, 0, PAGE_SIZE);
 
 	/* Map in the area just after the brk now that kmalloc is about
 	 * to be turned on.
Index: linux-2.6/arch/um/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/um/kernel/process.c	2007-11-05 14:08:07.000000000 -0500
+++ linux-2.6/arch/um/kernel/process.c	2007-11-05 14:08:08.000000000 -0500
@@ -60,8 +60,6 @@ unsigned long alloc_stack(int order, int
 	if (atomic)
 		flags = GFP_ATOMIC;
 	page = __get_free_pages(flags, order);
-	if (page == 0)
-		return 0;
 
 	return page;
 }
@@ -331,7 +329,7 @@ void do_uml_exitcalls(void)
 		(*call)();
 }
 
-char *uml_strdup(char *string)
+char *uml_strdup(const char *string)
 {
 	return kstrdup(string, GFP_KERNEL);
 }
Index: linux-2.6/arch/um/os-Linux/drivers/tuntap_user.c
===================================================================
--- linux-2.6.orig/arch/um/os-Linux/drivers/tuntap_user.c	2007-11-05 14:08:07.000000000 -0500
+++ linux-2.6/arch/um/os-Linux/drivers/tuntap_user.c	2007-11-05 14:08:08.000000000 -0500
@@ -148,7 +148,7 @@ static int tuntap_open(void *data)
 		memset(&ifr, 0, sizeof(ifr));
 		ifr.ifr_flags = IFF_TAP | IFF_NO_PI;
 		strlcpy(ifr.ifr_name, pri->dev_name, sizeof(ifr.ifr_name));
-		if (ioctl(pri->fd, TUNSETIFF, (void *) &ifr) < 0) {
+		if (ioctl(pri->fd, TUNSETIFF, &ifr) < 0) {
 			err = -errno;
 			printk(UM_KERN_ERR "TUNSETIFF failed, errno = %d\n",
 			       errno);
Index: linux-2.6/arch/um/os-Linux/mem.c
===================================================================
--- linux-2.6.orig/arch/um/os-Linux/mem.c	2007-11-05 14:08:07.000000000 -0500
+++ linux-2.6/arch/um/os-Linux/mem.c	2007-11-05 14:08:08.000000000 -0500
@@ -30,7 +30,7 @@ static char *tempdir = NULL;
 
 static void __init find_tempdir(void)
 {
-	char *dirs[] = { "TMP", "TEMP", "TMPDIR", NULL };
+	const char *dirs[] = { "TMP", "TEMP", "TMPDIR", NULL };
 	int i;
 	char *dir = NULL;
 
@@ -59,9 +59,10 @@ static void __init find_tempdir(void)
  * read the file as needed.  If there's an error, -errno is returned;
  * if the end of the file is reached, 0 is returned.
  */
-static int next(int fd, char *buf, int size, char c)
+static int next(int fd, char *buf, size_t size, char c)
 {
-	int n, len;
+	ssize_t n;
+	size_t len;
 	char *ptr;
 
 	while((ptr = strchr(buf, c)) == NULL){
Index: linux-2.6/arch/um/os-Linux/sigio.c
===================================================================
--- linux-2.6.orig/arch/um/os-Linux/sigio.c	2007-11-05 14:08:07.000000000 -0500
+++ linux-2.6/arch/um/os-Linux/sigio.c	2007-11-05 14:08:08.000000000 -0500
@@ -407,7 +407,7 @@ static int async_pty(int master, int sla
 	if((fcntl(slave, F_SETFL, flags | O_NONBLOCK) < 0))
 		return -errno;
 
-	return(0);
+	return 0;
 }
 
 static void __init check_one_sigio(void (*proc)(int, int))

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
