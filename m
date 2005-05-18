Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYG7k-00073q-CY	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 21:25:36 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DYG7j-0006LV-P8	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 21:25:36 -0700
Message-Id: <200505180420.j4I4KRBG017327@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 5/9] UML - initrd cleanup
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
Date: Wed, 18 May 2005 00:20:27 -0400
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Gennady Sharapov <Gennady.V.Sharapov@intel.com>

The serial UML OS-abstraction layer patch (um/kernel dir).

This moves all systemcalls from initrd_user.c file under os-Linux dir
and join initrd_user.c and initrd_kern.c files in new file initrd.c

Signed-off-by: Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/Makefile	2005-05-17 18:02:25.000000000 -0400
+++ linux-2.6.12-rc/arch/um/kernel/Makefile	2005-05-17 18:12:26.000000000 -0400
@@ -14,7 +14,7 @@ obj-y = config.o exec_kern.o exitcode.o 
 	tlb.o trap_kern.o trap_user.o uaccess_user.o um_arch.o umid.o \
 	user_util.o
 
-obj-$(CONFIG_BLK_DEV_INITRD) += initrd_kern.o initrd_user.o
+obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
 obj-$(CONFIG_GCOV)	+= gmon_syms.o
 obj-$(CONFIG_TTY_LOG)	+= tty_log.o
Index: linux-2.6.12-rc/arch/um/kernel/initrd.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/initrd.c	2003-09-15 09:40:47.000000000 -0400
+++ linux-2.6.12-rc/arch/um/kernel/initrd.c	2005-05-17 18:12:26.000000000 -0400
@@ -0,0 +1,78 @@
+/*
+ * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include "linux/init.h"
+#include "linux/bootmem.h"
+#include "linux/initrd.h"
+#include "asm/types.h"
+#include "user_util.h"
+#include "kern_util.h"
+#include "initrd.h"
+#include "init.h"
+#include "os.h"
+
+/* Changed by uml_initrd_setup, which is a setup */
+static char *initrd __initdata = NULL;
+
+static int __init read_initrd(void)
+{
+	void *area;
+	long long size;
+	int err;
+
+	if(initrd == NULL) return 0;
+	err = os_file_size(initrd, &size);
+	if(err) return 0;
+	area = alloc_bootmem(size);
+	if(area == NULL) return 0;
+	if(load_initrd(initrd, area, size) == -1) return 0;
+	initrd_start = (unsigned long) area;
+	initrd_end = initrd_start + size;
+	return 0;
+}
+
+__uml_postsetup(read_initrd);
+
+static int __init uml_initrd_setup(char *line, int *add)
+{
+	initrd = line;
+	return 0;
+}
+
+__uml_setup("initrd=", uml_initrd_setup, 
+"initrd=<initrd image>\n"
+"    This is used to boot UML from an initrd image.  The argument is the\n"
+"    name of the file containing the image.\n\n"
+);
+
+int load_initrd(char *filename, void *buf, int size)
+{
+	int fd, n;
+
+	fd = os_open_file(filename, of_read(OPENFLAGS()), 0);
+	if(fd < 0){
+		printk("Opening '%s' failed - err = %d\n", filename, -fd);
+		return(-1);
+	}
+	n = os_read_file(fd, buf, size);
+	if(n != size){
+		printk("Read of %d bytes from '%s' failed, err = %d\n", size,
+		       filename, -n);
+		return(-1);
+	}
+
+	os_close_file(fd);
+	return(0);
+}
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
