Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C7thW-0008Gr-MM for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Sep 2004 03:41:18 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1C7thV-0001tB-MN
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Sep 2004 03:41:18 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20040916102932.GB12111@bytesex>
References: <20040820122445.GA21790@bytesex>
	<200408201901.i7KJ1eIF003843@ccure.user-mode-linux.org>
	<20040822111745.GA10736@bytesex> <4133C57D.6060201@enterasys.com>
	<20040914123658.GB29562@bytesex> <4148AD24.1040408@enterasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4148AD24.1040408@enterasys.com>
Subject: [uml-devel] [patch] core-on-panic next take ;)
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
Date: Thu, 16 Sep 2004 12:29:32 +0200
To: "D. Bahi" <dbahi@enterasys.com>
Cc: Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, Sep 15, 2004 at 04:59:16PM -0400, D. Bahi wrote:
> actually it's worse than that in my current implementation:

Thanks for the comments, merged that into my current version.  Attached
below.

I've also moved it all into a single source file, so it is nicely
separated and also can be trivialy made a compile time option if
someone wants this.

  Gerd

Index: uml-2.6.9-rc2/arch/um/kernel/Makefile
===================================================================
--- uml-2.6.9-rc2.orig/arch/um/kernel/Makefile	2004-09-15 08:36:20.000000000 +0200
+++ uml-2.6.9-rc2/arch/um/kernel/Makefile	2004-09-15 08:36:20.000000000 +0200
@@ -11,7 +11,7 @@ obj-y = checksum.o config.o exec_kern.o 
 	sigio_user.o sigio_kern.o signal_kern.o signal_user.o smp.o \
 	syscall_kern.o syscall_user.o sysrq.o sys_call_table.o tempfile.o \
 	time.o time_kern.o tlb.o trap_kern.o trap_user.o uaccess_user.o \
-	um_arch.o umid.o user_util.o
+	um_arch.o umid.o user_util.o core-on-panic.o
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd_kern.o initrd_user.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
Index: uml-2.6.9-rc2/arch/um/kernel/core-on-panic.c
===================================================================
--- uml-2.6.9-rc2.orig/arch/um/kernel/core-on-panic.c	2004-04-06 15:27:52.000000000 +0200
+++ uml-2.6.9-rc2/arch/um/kernel/core-on-panic.c	2004-09-16 12:19:08.303422237 +0200
@@ -0,0 +1,63 @@
+/*
+ * allow user mode linux kernels dump core on kernel panics,
+ * for later analysis of the crash.
+ *
+ * (c) 2004 Gerd Knorr + D. Bahi
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/notifier.h>
+
+#include "init.h"
+#include "os.h"
+
+static int core_on_panic_func(struct notifier_block *self, unsigned long unused1,
+		              void *unused2)
+{
+	static int recurse = 0;
+
+        /* cleanup so we have less to cleanup [linux] on the host */
+	/* could panic in uml_cleanup though so we need a check */
+        if (0 == recurse++)
+		uml_cleanup();
+
+	/* to prevent keyboard from causing terminal to spew during dump */
+	block_signals();
+
+	/* actually dump ... */
+	abort();
+
+	/* not reached */
+	return 0;
+}
+
+static struct notifier_block core_on_panic_notifier = {
+	.notifier_call 		= core_on_panic_func,
+	.priority 		= 1,
+};
+
+static int core_on_panic = 0;
+
+static int __init core_on_panic_setup(char *str)
+{
+	core_on_panic = 1;
+	return 0;
+}
+
+static int __init core_on_panic_init(void)
+{
+	if (core_on_panic)
+		notifier_chain_register(&panic_notifier_list, &core_on_panic_notifier);
+	return 0;
+}
+
+__initcall(core_on_panic_init);
+__setup("coreonpanic", core_on_panic_setup);
+__uml_help(core_on_panic_setup,
+	"coreonpanic\n"
+	"    This flag make it so that UML will dump core on a kernel panic or segfault.\n"
+	"    Shell environment restrictions on cores (limit or ulimit) still apply.\n"
+	"\n"
+	"    Beware that your UML will not reboot with this flag.\n"
+);
+


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
