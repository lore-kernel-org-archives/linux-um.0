Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AxQ1v-0003r1-HI for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Feb 2004 04:26:47 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AxPaV-00031H-8T for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Feb 2004 03:58:27 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [PATCH] Removing user_syms.c altogether
References: <200402282010.41036.blaisorblade_spam@yahoo.it>
	<20040228223333.GB7716@ccure.user-mode-linux.org>
In-Reply-To: <20040228223333.GB7716@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pjdQAuFIH9/mxqD"
Message-Id: <200402291319.53584.blaisorblade_spam@yahoo.it>
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
Date: Sun, 29 Feb 2004 13:19:53 +0100
To: user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_pjdQAuFIH9/mxqD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Alle 23:33, sabato 28 febbraio 2004, Jeff Dike ha scritto:
> On Sat, Feb 28, 2004 at 08:10:40PM +0100, BlaisorBlade wrote:
> > I've moved the EXPORT_SYMBOLS from ksyms.c to user_ksyms.c, with fake
> > prototypes. The reason is to avoid copying code from linux/module.h and
> > to remove one user-objs for the cleanup - that one cannot go away with
> > the os_* expansion.
>
> Umm, was there supposed to be a patch attached to that? :-)

Eeehm - yes! Note however the comment about genksyms: what I say is my idea, 
but possibly a wrong one.

Anyhow, the possible problem with genksyms matters only with 
CONFIG_MODVERSIONS, which is not supported on 2.6 and has never on 2.4. So I 
have not tested that. Better, I have not yet checked the module loading with 
it applied (ksyms.o however builds correctly).

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_pjdQAuFIH9/mxqD
Content-Type: text/x-diff; charset="iso-8859-1"; name="MoveUserSyms.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="MoveUserSyms.patch"

--- ./arch/um/kernel/user_syms.c.fix	2004-02-20 18:43:26.000000000 +0100
+++ ./arch/um/kernel/user_syms.c	2004-02-28 18:58:50.000000000 +0100
@@ -1,141 +0,0 @@
-#include <stdio.h>
-#include <unistd.h>
-#include <dirent.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <utime.h>
-#include <string.h>
-#include <sys/stat.h>
-#include <sys/vfs.h>
-#include <sys/ioctl.h>
-#include "user_util.h"
-#include "mem_user.h"
-#include "uml-config.h"
-
-/* Had to steal this from linux/module.h because that file can't be included
- * since this includes various user-level headers.
- */
-
-/* Had to update this: this changed in late 2.5 to add CRC and other beasts
- * and was never updated here- 13 Dec 2003-Blaisorblade
- */
-
-/* v850 toolchain uses a `_' prefix for all user symbols */
-#ifndef MODULE_SYMBOL_PREFIX
-#define MODULE_SYMBOL_PREFIX ""
-#endif
-
-struct kernel_symbol
-{
-	unsigned long value;
-	const char *name;
-};
-
-#if !defined(UML_CONFIG_MODULES)
-#define EXPORT_SYMBOL(sym)
-#define EXPORT_SYMBOL_GPL(sym)
-#define EXPORT_SYMBOL_NOVERS(sym)
-
-#else /*UML_CONFIG_MODULES*/
-#ifndef __GENKSYMS__
-#ifdef UML_CONFIG_MODVERSIONS
-/* Mark the CRC weak since genksyms apparently decides not to
- * generate a checksums for some symbols */
-#define __CRC_SYMBOL(sym, sec)					\
-	extern void *__crc_##sym __attribute__((weak));		\
-	static const unsigned long __kcrctab_##sym		\
-	__attribute__((section("__kcrctab" sec), unused))	\
-	= (unsigned long) &__crc_##sym;
-#else
-#define __CRC_SYMBOL(sym, sec)
-#endif
-
-/* For every exported symbol, place a struct in the __ksymtab section */
-#define __EXPORT_SYMBOL(sym, sec)				\
-	__CRC_SYMBOL(sym, sec)					\
-	static const char __kstrtab_##sym[]			\
-	__attribute__((section("__ksymtab_strings")))		\
-	= MODULE_SYMBOL_PREFIX #sym;                    	\
-	static const struct kernel_symbol __ksymtab_##sym	\
-	__attribute__((section("__ksymtab" sec), unused))	\
-	= { (unsigned long)&sym, __kstrtab_##sym }
-
-#define EXPORT_SYMBOL(sym)					\
-	__EXPORT_SYMBOL(sym, "")
-
-#define EXPORT_SYMBOL_GPL(sym)					\
-	__EXPORT_SYMBOL(sym, "_gpl")
-
-#endif
-
-/* We don't mangle the actual symbol anymore, so no need for
- * special casing EXPORT_SYMBOL_NOVERS.  FIXME: Deprecated */
-#define EXPORT_SYMBOL_NOVERS(sym) EXPORT_SYMBOL(sym)
-#endif
-
-EXPORT_SYMBOL(__errno_location);
-
-EXPORT_SYMBOL(access);
-EXPORT_SYMBOL(open);
-EXPORT_SYMBOL(open64);
-EXPORT_SYMBOL(close);
-EXPORT_SYMBOL(read);
-EXPORT_SYMBOL(write);
-EXPORT_SYMBOL(dup2);
-EXPORT_SYMBOL(__xstat);
-EXPORT_SYMBOL(__lxstat);
-EXPORT_SYMBOL(__lxstat64);
-EXPORT_SYMBOL(lseek);
-EXPORT_SYMBOL(lseek64);
-EXPORT_SYMBOL(chown);
-EXPORT_SYMBOL(truncate);
-EXPORT_SYMBOL(utime);
-EXPORT_SYMBOL(chmod);
-EXPORT_SYMBOL(rename);
-EXPORT_SYMBOL(__xmknod);
-
-EXPORT_SYMBOL(symlink);
-EXPORT_SYMBOL(link);
-EXPORT_SYMBOL(unlink);
-EXPORT_SYMBOL(readlink);
-
-EXPORT_SYMBOL(mkdir);
-EXPORT_SYMBOL(rmdir);
-EXPORT_SYMBOL(opendir);
-EXPORT_SYMBOL(readdir);
-EXPORT_SYMBOL(closedir);
-EXPORT_SYMBOL(seekdir);
-EXPORT_SYMBOL(telldir);
-
-EXPORT_SYMBOL(ioctl);
-
-extern ssize_t pread64 (int __fd, void *__buf, size_t __nbytes,
-			__off64_t __offset);
-extern ssize_t pwrite64 (int __fd, __const void *__buf, size_t __n,
-			 __off64_t __offset);
-EXPORT_SYMBOL(pread64);
-EXPORT_SYMBOL(pwrite64);
-
-EXPORT_SYMBOL(statfs);
-EXPORT_SYMBOL(statfs64);
-
-EXPORT_SYMBOL(memcpy);
-EXPORT_SYMBOL(getuid);
-
-EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(strstr);
-EXPORT_SYMBOL(printf);
-EXPORT_SYMBOL(strlen);
-
-EXPORT_SYMBOL(find_iomem);
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
--- ./arch/um/kernel/ksyms.c.fix	2004-02-20 18:43:26.000000000 +0100
+++ ./arch/um/kernel/ksyms.c	2004-02-28 20:07:47.000000000 +0100
@@ -8,7 +8,8 @@
 #include "linux/string.h"
 #include "linux/smp_lock.h"
 #include "linux/spinlock.h"
-#include <linux/highmem.h>
+#include "linux/highmem.h"
+#include "linux/types.h"
 #include "asm/current.h"
 #include "asm/delay.h"
 #include "asm/processor.h"
@@ -21,6 +22,7 @@
 #include "user_util.h"
 #include "os.h"
 #include "helper.h"
+#include "mem_user.h"
 
 EXPORT_SYMBOL(stop);
 EXPORT_SYMBOL(uml_physmem);
@@ -46,6 +48,7 @@
 EXPORT_SYMBOL(to_virt);
 EXPORT_SYMBOL(mode_tt);
 EXPORT_SYMBOL(handle_page_fault);
+EXPORT_SYMBOL(find_iomem);
 
 #ifdef CONFIG_MODE_TT
 EXPORT_SYMBOL(copy_from_user_tt);
@@ -119,6 +122,82 @@
 EXPORT_SYMBOL(kmap_atomic_to_page);
 #endif
 
+/* Here userspace symbols start. They used to be in user_ksyms.c */
+
+/* Some of this are builtin function (some are not but could in the future),
+ * so I *must* declare good prototypes for them and then EXPORT them.
+ * The kernel code uses the macro defined by include/linux/string.h,
+ * so I undef macros; the userspace code does not include that and I
+ * add an EXPORT for the glibc one.*/
+
+#undef strlen
+#undef strstr
+#undef memcpy
+#undef memset
+
+extern size_t strlen(const char *);
+extern void *memcpy(void *, const void *, size_t);
+extern void *memset(void *, int, size_t);
+extern int printf(const char *, ...);
+
+EXPORT_SYMBOL(strlen);
+EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(printf);
+
+EXPORT_SYMBOL(strstr);
+
+/* Here, instead, I can provide a fake prototype. Yes, someone cares: genksyms.
+ * However, the modules will use the CRC defined *here*, no matter if it is good;
+ * so the versions of these symbols will always match*/
+#define EXPORT_SYMBOL_PROTO(sym)	\
+	int sym(void);			\
+	EXPORT_SYMBOL(sym);
+
+EXPORT_SYMBOL_PROTO(__errno_location);
+
+EXPORT_SYMBOL_PROTO(access);
+EXPORT_SYMBOL_PROTO(open);
+EXPORT_SYMBOL_PROTO(open64);
+EXPORT_SYMBOL_PROTO(close);
+EXPORT_SYMBOL_PROTO(read);
+EXPORT_SYMBOL_PROTO(write);
+EXPORT_SYMBOL_PROTO(dup2);
+EXPORT_SYMBOL_PROTO(__xstat);
+EXPORT_SYMBOL_PROTO(__lxstat);
+EXPORT_SYMBOL_PROTO(__lxstat64);
+EXPORT_SYMBOL_PROTO(lseek);
+EXPORT_SYMBOL_PROTO(lseek64);
+EXPORT_SYMBOL_PROTO(chown);
+EXPORT_SYMBOL_PROTO(truncate);
+EXPORT_SYMBOL_PROTO(utime);
+EXPORT_SYMBOL_PROTO(chmod);
+EXPORT_SYMBOL_PROTO(rename);
+EXPORT_SYMBOL_PROTO(__xmknod);
+
+EXPORT_SYMBOL_PROTO(symlink);
+EXPORT_SYMBOL_PROTO(link);
+EXPORT_SYMBOL_PROTO(unlink);
+EXPORT_SYMBOL_PROTO(readlink);
+
+EXPORT_SYMBOL_PROTO(mkdir);
+EXPORT_SYMBOL_PROTO(rmdir);
+EXPORT_SYMBOL_PROTO(opendir);
+EXPORT_SYMBOL_PROTO(readdir);
+EXPORT_SYMBOL_PROTO(closedir);
+EXPORT_SYMBOL_PROTO(seekdir);
+EXPORT_SYMBOL_PROTO(telldir);
+
+EXPORT_SYMBOL_PROTO(ioctl);
+
+EXPORT_SYMBOL_PROTO(pread64);
+EXPORT_SYMBOL_PROTO(pwrite64);
+
+EXPORT_SYMBOL_PROTO(statfs);
+EXPORT_SYMBOL_PROTO(statfs64);
+
+EXPORT_SYMBOL_PROTO(getuid);
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
--- ./arch/um/kernel/Makefile.fix	2004-02-26 20:44:39.000000000 +0100
+++ ./arch/um/kernel/Makefile	2004-02-28 19:01:11.000000000 +0100
@@ -11,7 +11,7 @@
 	sigio_user.o sigio_kern.o signal_kern.o signal_user.o smp.o \
 	syscall_kern.o syscall_user.o sysrq.o sys_call_table.o tempfile.o \
 	time.o time_kern.o tlb.o trap_kern.o trap_user.o uaccess_user.o \
-	um_arch.o umid.o user_syms.o user_util.o
+	um_arch.o umid.o user_util.o
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd_kern.o initrd_user.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
@@ -24,17 +24,10 @@
 user-objs-$(CONFIG_TTY_LOG) += tty_log.o
 
 USER_OBJS := $(filter %_user.o,$(obj-y))  $(user-objs-y) config.o helper.o \
-	process.o tempfile.o time.o tty_log.o umid.o user_util.o user_syms.o \
+	process.o tempfile.o time.o tty_log.o umid.o user_util.o \
 	frame.o
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
-DMODULES-$(CONFIG_MODULES) = -D__CONFIG_MODULES__
-DMODVERSIONS-$(CONFIG_MODVERSIONS) = -D__CONFIG_MODVERSIONS__
-
-
-CFLAGS_user_syms.o = -D__AUTOCONF_INCLUDED__ $(DMODULES-y) $(DMODVERSIONS-y) \
-	-I/usr/include -I../include
-
 # This has to be compiled with frame pointers regardless of how the rest of
 # the kernel is built.
 

--Boundary-00=_pjdQAuFIH9/mxqD--



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
