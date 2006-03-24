Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMqn8-0003aT-ES for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 10:13:42 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FMqn7-0001LI-Ay
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 10:13:42 -0800
Message-Id: <200603241814.k2OIEoKG005540@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 9/16] UML - Move tty logging to os-Linux
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
Date: Fri, 24 Mar 2006 13:14:50 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Gennady Sharapov <Gennady.V.Sharapov@intel.com>

The serial UML OS-abstraction layer patch (um/kernel dir).

This moves all systemcalls from tty_log.c file under os-Linux dir

Signed-off-by: Gennady Sharapov <Gennady.V.Sharapov@intel.com>

Index: linux-2.6.16/arch/um/kernel/exec_kern.c
===================================================================
--- linux-2.6.16.orig/arch/um/kernel/exec_kern.c	2006-03-23 17:15:05.000000000 -0500
+++ linux-2.6.16/arch/um/kernel/exec_kern.c	2006-03-23 17:31:59.000000000 -0500
@@ -30,8 +30,6 @@ void start_thread(struct pt_regs *regs, 
 	CHOOSE_MODE_PROC(start_thread_tt, start_thread_skas, regs, eip, esp);
 }
 
-extern void log_exec(char **argv, void *tty);
-
 static long execve1(char *file, char __user * __user *argv,
 		    char __user *__user *env)
 {
Index: linux-2.6.16/arch/um/kernel/tty_log.c
===================================================================
--- linux-2.6.16.orig/arch/um/kernel/tty_log.c	2006-03-23 17:15:05.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,230 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com) and 
- * geoffrey hing <ghing@net.ohio-state.edu>
- * Licensed under the GPL
- */
-
-#include <errno.h>
-#include <string.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <sys/time.h>
-#include "init.h"
-#include "user.h"
-#include "kern_util.h"
-#include "os.h"
-
-#define TTY_LOG_DIR "./"
-
-/* Set early in boot and then unchanged */
-static char *tty_log_dir = TTY_LOG_DIR;
-static int tty_log_fd = -1;
-
-#define TTY_LOG_OPEN 1
-#define TTY_LOG_CLOSE 2
-#define TTY_LOG_WRITE 3
-#define TTY_LOG_EXEC 4
-
-#define TTY_READ 1
-#define TTY_WRITE 2
-
-struct tty_log_buf {
-	int what;
-	unsigned long tty;
-	int len;
-	int direction;
-	unsigned long sec;
-	unsigned long usec;
-};
-
-int open_tty_log(void *tty, void *current_tty)
-{
-	struct timeval tv;
-	struct tty_log_buf data;
-	char buf[strlen(tty_log_dir) + sizeof("01234567890-01234567\0")];
-	int fd;
-
-	gettimeofday(&tv, NULL);
-	if(tty_log_fd != -1){
-		data = ((struct tty_log_buf) { .what 	= TTY_LOG_OPEN,
-					       .tty  = (unsigned long) tty,
-					       .len  = sizeof(current_tty),
-					       .direction = 0,
-					       .sec = tv.tv_sec,
-					       .usec = tv.tv_usec } );
-		os_write_file(tty_log_fd, &data, sizeof(data));
-		os_write_file(tty_log_fd, &current_tty, data.len);
-		return(tty_log_fd);
-	}
-
-	sprintf(buf, "%s/%0u-%0u", tty_log_dir, (unsigned int) tv.tv_sec, 
- 		(unsigned int) tv.tv_usec);
-
-	fd = os_open_file(buf, of_append(of_create(of_rdwr(OPENFLAGS()))),
-			  0644);
-	if(fd < 0){
-		printk("open_tty_log : couldn't open '%s', errno = %d\n",
-		       buf, -fd);
-	}
-	return(fd);
-}
-
-void close_tty_log(int fd, void *tty)
-{
-	struct tty_log_buf data;
-	struct timeval tv;
-
-	if(tty_log_fd != -1){
-		gettimeofday(&tv, NULL);
-		data = ((struct tty_log_buf) { .what 	= TTY_LOG_CLOSE,
-					       .tty  = (unsigned long) tty,
-					       .len  = 0,
-					       .direction = 0,
-					       .sec = tv.tv_sec,
-					       .usec = tv.tv_usec } );
-		os_write_file(tty_log_fd, &data, sizeof(data));
-		return;
-	}
-	os_close_file(fd);
-}
-
-static int log_chunk(int fd, const char *buf, int len)
-{
-	int total = 0, try, missed, n;
-	char chunk[64];
-
-	while(len > 0){
-		try = (len > sizeof(chunk)) ? sizeof(chunk) : len;
-		missed = copy_from_user_proc(chunk, (char *) buf, try);
-		try -= missed;
-		n = os_write_file(fd, chunk, try);
-		if(n != try) {
-			if(n < 0)
-				return(n);
-			return(-EIO);
-		}
-		if(missed != 0)
-			return(-EFAULT);
-
-		len -= try;
-		total += try;
-		buf += try;
-	}
-
-	return(total);
-}
-
-int write_tty_log(int fd, const char *buf, int len, void *tty, int is_read)
-{
-	struct timeval tv;
-	struct tty_log_buf data;
-	int direction;
-
-	if(fd == tty_log_fd){
-		gettimeofday(&tv, NULL);
-		direction = is_read ? TTY_READ : TTY_WRITE;
-		data = ((struct tty_log_buf) { .what 	= TTY_LOG_WRITE,
-					       .tty  = (unsigned long) tty,
-					       .len  = len,
-					       .direction = direction,
-					       .sec = tv.tv_sec,
-					       .usec = tv.tv_usec } );
-		os_write_file(tty_log_fd, &data, sizeof(data));
-	}
-
-	return(log_chunk(fd, buf, len));
-}
-
-void log_exec(char **argv, void *tty)
-{
-	struct timeval tv;
-	struct tty_log_buf data;
-	char **ptr,*arg;
-	int len;
-
-	if(tty_log_fd == -1) return;
-
-	gettimeofday(&tv, NULL);
-
-	len = 0;
-	for(ptr = argv; ; ptr++){
-		if(copy_from_user_proc(&arg, ptr, sizeof(arg)))
-			return;
-		if(arg == NULL) break;
-		len += strlen_user_proc(arg);
-	}
-
-	data = ((struct tty_log_buf) { .what 	= TTY_LOG_EXEC,
-				       .tty  = (unsigned long) tty,
-				       .len  = len,
-				       .direction = 0,
-				       .sec = tv.tv_sec,
-				       .usec = tv.tv_usec } );
-	os_write_file(tty_log_fd, &data, sizeof(data));
-
-	for(ptr = argv; ; ptr++){
-		if(copy_from_user_proc(&arg, ptr, sizeof(arg)))
-			return;
-		if(arg == NULL) break;
-		log_chunk(tty_log_fd, arg, strlen_user_proc(arg));
-	}
-}
-
-extern void register_tty_logger(int (*opener)(void *, void *),
-				int (*writer)(int, const char *, int,
-					      void *, int),
-				void (*closer)(int, void *));
-
-static int register_logger(void)
-{
-	register_tty_logger(open_tty_log, write_tty_log, close_tty_log);
-	return(0);
-}
-
-__uml_initcall(register_logger);
-
-static int __init set_tty_log_dir(char *name, int *add)
-{
-	tty_log_dir = name;
-	return 0;
-}
-
-__uml_setup("tty_log_dir=", set_tty_log_dir,
-"tty_log_dir=<directory>\n"
-"    This is used to specify the directory where the logs of all pty\n"
-"    data from this UML machine will be written.\n\n"
-);
-
-static int __init set_tty_log_fd(char *name, int *add)
-{
-	char *end;
-
-	tty_log_fd = strtoul(name, &end, 0);
-	if((*end != '\0') || (end == name)){
-		printf("set_tty_log_fd - strtoul failed on '%s'\n", name);
-		tty_log_fd = -1;
-	}
-
-	*add = 0;
-	return 0;
-}
-
-__uml_setup("tty_log_fd=", set_tty_log_fd,
-"tty_log_fd=<fd>\n"
-"    This is used to specify a preconfigured file descriptor to which all\n"
-"    tty data will be written.  Preconfigure the descriptor with something\n"
-"    like '10>tty_log tty_log_fd=10'.\n\n"
-);
-
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.16/arch/um/os-Linux/tty_log.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16/arch/um/os-Linux/tty_log.c	2006-03-23 17:34:04.000000000 -0500
@@ -0,0 +1,218 @@
+/*
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com) and
+ * geoffrey hing <ghing@net.ohio-state.edu>
+ * Licensed under the GPL
+ */
+
+#include <errno.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/time.h>
+#include "init.h"
+#include "user.h"
+#include "kern_util.h"
+#include "os.h"
+
+#define TTY_LOG_DIR "./"
+
+/* Set early in boot and then unchanged */
+static char *tty_log_dir = TTY_LOG_DIR;
+static int tty_log_fd = -1;
+
+#define TTY_LOG_OPEN 1
+#define TTY_LOG_CLOSE 2
+#define TTY_LOG_WRITE 3
+#define TTY_LOG_EXEC 4
+
+#define TTY_READ 1
+#define TTY_WRITE 2
+
+struct tty_log_buf {
+	int what;
+	unsigned long tty;
+	int len;
+	int direction;
+	unsigned long sec;
+	unsigned long usec;
+};
+
+int open_tty_log(void *tty, void *current_tty)
+{
+	struct timeval tv;
+	struct tty_log_buf data;
+	char buf[strlen(tty_log_dir) + sizeof("01234567890-01234567\0")];
+	int fd;
+
+	gettimeofday(&tv, NULL);
+	if(tty_log_fd != -1){
+		data = ((struct tty_log_buf) { .what 	= TTY_LOG_OPEN,
+					       .tty  = (unsigned long) tty,
+					       .len  = sizeof(current_tty),
+					       .direction = 0,
+					       .sec = tv.tv_sec,
+					       .usec = tv.tv_usec } );
+		os_write_file(tty_log_fd, &data, sizeof(data));
+		os_write_file(tty_log_fd, &current_tty, data.len);
+		return(tty_log_fd);
+	}
+
+	sprintf(buf, "%s/%0u-%0u", tty_log_dir, (unsigned int) tv.tv_sec,
+ 		(unsigned int) tv.tv_usec);
+
+	fd = os_open_file(buf, of_append(of_create(of_rdwr(OPENFLAGS()))),
+			  0644);
+	if(fd < 0){
+		printk("open_tty_log : couldn't open '%s', errno = %d\n",
+		       buf, -fd);
+	}
+	return(fd);
+}
+
+void close_tty_log(int fd, void *tty)
+{
+	struct tty_log_buf data;
+	struct timeval tv;
+
+	if(tty_log_fd != -1){
+		gettimeofday(&tv, NULL);
+		data = ((struct tty_log_buf) { .what 	= TTY_LOG_CLOSE,
+					       .tty  = (unsigned long) tty,
+					       .len  = 0,
+					       .direction = 0,
+					       .sec = tv.tv_sec,
+					       .usec = tv.tv_usec } );
+		os_write_file(tty_log_fd, &data, sizeof(data));
+		return;
+	}
+	os_close_file(fd);
+}
+
+static int log_chunk(int fd, const char *buf, int len)
+{
+	int total = 0, try, missed, n;
+	char chunk[64];
+
+	while(len > 0){
+		try = (len > sizeof(chunk)) ? sizeof(chunk) : len;
+		missed = copy_from_user_proc(chunk, (char *) buf, try);
+		try -= missed;
+		n = os_write_file(fd, chunk, try);
+		if(n != try) {
+			if(n < 0)
+				return(n);
+			return(-EIO);
+		}
+		if(missed != 0)
+			return(-EFAULT);
+
+		len -= try;
+		total += try;
+		buf += try;
+	}
+
+	return(total);
+}
+
+int write_tty_log(int fd, const char *buf, int len, void *tty, int is_read)
+{
+	struct timeval tv;
+	struct tty_log_buf data;
+	int direction;
+
+	if(fd == tty_log_fd){
+		gettimeofday(&tv, NULL);
+		direction = is_read ? TTY_READ : TTY_WRITE;
+		data = ((struct tty_log_buf) { .what 	= TTY_LOG_WRITE,
+					       .tty  = (unsigned long) tty,
+					       .len  = len,
+					       .direction = direction,
+					       .sec = tv.tv_sec,
+					       .usec = tv.tv_usec } );
+		os_write_file(tty_log_fd, &data, sizeof(data));
+	}
+
+	return(log_chunk(fd, buf, len));
+}
+
+void log_exec(char **argv, void *tty)
+{
+	struct timeval tv;
+	struct tty_log_buf data;
+	char **ptr,*arg;
+	int len;
+
+	if(tty_log_fd == -1) return;
+
+	gettimeofday(&tv, NULL);
+
+	len = 0;
+	for(ptr = argv; ; ptr++){
+		if(copy_from_user_proc(&arg, ptr, sizeof(arg)))
+			return;
+		if(arg == NULL) break;
+		len += strlen_user_proc(arg);
+	}
+
+	data = ((struct tty_log_buf) { .what 	= TTY_LOG_EXEC,
+				       .tty  = (unsigned long) tty,
+				       .len  = len,
+				       .direction = 0,
+				       .sec = tv.tv_sec,
+				       .usec = tv.tv_usec } );
+	os_write_file(tty_log_fd, &data, sizeof(data));
+
+	for(ptr = argv; ; ptr++){
+		if(copy_from_user_proc(&arg, ptr, sizeof(arg)))
+			return;
+		if(arg == NULL) break;
+		log_chunk(tty_log_fd, arg, strlen_user_proc(arg));
+	}
+}
+
+extern void register_tty_logger(int (*opener)(void *, void *),
+				int (*writer)(int, const char *, int,
+					      void *, int),
+				void (*closer)(int, void *));
+
+static int register_logger(void)
+{
+	register_tty_logger(open_tty_log, write_tty_log, close_tty_log);
+	return(0);
+}
+
+__uml_initcall(register_logger);
+
+static int __init set_tty_log_dir(char *name, int *add)
+{
+	tty_log_dir = name;
+	return 0;
+}
+
+__uml_setup("tty_log_dir=", set_tty_log_dir,
+"tty_log_dir=<directory>\n"
+"    This is used to specify the directory where the logs of all pty\n"
+"    data from this UML machine will be written.\n\n"
+);
+
+static int __init set_tty_log_fd(char *name, int *add)
+{
+	char *end;
+
+	tty_log_fd = strtoul(name, &end, 0);
+	if((*end != '\0') || (end == name)){
+		printf("set_tty_log_fd - strtoul failed on '%s'\n", name);
+		tty_log_fd = -1;
+	}
+
+	*add = 0;
+	return 0;
+}
+
+__uml_setup("tty_log_fd=", set_tty_log_fd,
+"tty_log_fd=<fd>\n"
+"    This is used to specify a preconfigured file descriptor to which all\n"
+"    tty data will be written.  Preconfigure the descriptor with something\n"
+"    like '10>tty_log tty_log_fd=10'.\n\n"
+);
Index: linux-2.6.16/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.16.orig/arch/um/kernel/Makefile	2006-03-23 17:26:25.000000000 -0500
+++ linux-2.6.16/arch/um/kernel/Makefile	2006-03-23 17:31:59.000000000 -0500
@@ -15,15 +15,12 @@ obj-y = config.o exec_kern.o exitcode.o 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
 obj-$(CONFIG_GCOV)	+= gmon_syms.o
-obj-$(CONFIG_TTY_LOG)	+= tty_log.o
 obj-$(CONFIG_SYSCALL_DEBUG) += syscall.o
 
 obj-$(CONFIG_MODE_TT) += tt/
 obj-$(CONFIG_MODE_SKAS) += skas/
 
-user-objs-$(CONFIG_TTY_LOG) += tty_log.o
-
-USER_OBJS := $(user-objs-y) config.o tty_log.o
+USER_OBJS := config.o
 
 include arch/um/scripts/Makefile.rules
 
Index: linux-2.6.16/arch/um/os-Linux/Makefile
===================================================================
--- linux-2.6.16.orig/arch/um/os-Linux/Makefile	2006-03-23 17:26:25.000000000 -0500
+++ linux-2.6.16/arch/um/os-Linux/Makefile	2006-03-23 17:31:59.000000000 -0500
@@ -8,10 +8,12 @@ obj-y = aio.o elf_aux.o file.o helper.o 
 	user_syms.o util.o drivers/ sys-$(SUBARCH)/
 
 obj-$(CONFIG_MODE_SKAS) += skas/
+obj-$(CONFIG_TTY_LOG) += tty_log.o
+user-objs-$(CONFIG_TTY_LOG) += tty_log.o
 
-USER_OBJS := aio.o elf_aux.o file.o helper.o irq.o main.o mem.o process.o \
-	sigio.o signal.o start_up.o time.o trap.o tt.o tty.o uaccess.o umid.o \
-	util.o
+USER_OBJS := $(user-objs-y) aio.o elf_aux.o file.o helper.o irq.o main.o mem.o \
+	process.o sigio.o signal.o start_up.o time.o trap.o tt.o tty.o \
+	uaccess.o umid.o util.o
 
 elf_aux.o: $(ARCH_DIR)/kernel-offsets.h
 CFLAGS_elf_aux.o += -I$(objtree)/arch/um



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
