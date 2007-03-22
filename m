Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HUPqk-0003L9-Im for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Mar 2007 09:09:14 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HUPqa-0005OY-Pl
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Mar 2007 09:09:14 -0700
Date: Thu, 22 Mar 2007 12:06:47 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070322160647.GA7017@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [ PATCH 5/7 ] UML - Move remaining useful contents of
	user_util.h
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
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Rescue the useful contents of the soon-to-be-gone user-util.h.

pty.c now gets ptsname from stdlib.h like it should have always done.

CATCH_EINTR is now in os.h, although perhaps all usage should be under
os-Linux at some point.

get_pty is also in os.h.

This patch restores the old definition of ARRAY_SIZE in user.h.  This
file is included only in userspace files, so there will be no conflict
with the kernel's new ARRAY_SIZE.  The copy of the kernel's ARRAY_SIZE
and associated infrastructure is now gone.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/drivers/pty.c           |    1 +
 arch/um/include/os.h            |    6 ++++++
 arch/um/include/user.h          |   19 ++++++++-----------
 arch/um/include/user_util.h     |   18 ------------------
 arch/um/os-Linux/sys-i386/tls.c |    1 +
 5 files changed, 16 insertions(+), 29 deletions(-)

Index: linux-2.6.21-mm/arch/um/drivers/pty.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/pty.c	2007-03-22 11:18:21.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/pty.c	2007-03-22 11:21:01.000000000 -0400
@@ -4,6 +4,7 @@
  */
 
 #include <stdio.h>
+#include <stdlib.h>
 #include <unistd.h>
 #include <string.h>
 #include <errno.h>
Index: linux-2.6.21-mm/arch/um/include/os.h
===================================================================
--- linux-2.6.21-mm.orig/arch/um/include/os.h	2007-03-22 11:18:48.000000000 -0400
+++ linux-2.6.21-mm/arch/um/include/os.h	2007-03-22 11:21:01.000000000 -0400
@@ -16,6 +16,8 @@
 #include "sysdep/tls.h"
 #include "sysdep/archsetjmp.h"
 
+#define CATCH_EINTR(expr) while ((errno = 0, ((expr) < 0)) && (errno == EINTR))
+
 #define OS_TYPE_FILE 1
 #define OS_TYPE_DIR 2
 #define OS_TYPE_SYMLINK 3
@@ -341,6 +343,10 @@ extern void maybe_sigio_broken(int fd, i
 extern void sig_handler_common_skas(int sig, void *sc_ptr);
 extern void user_signal(int sig, union uml_pt_regs *regs, int pid);
 
+/* sys-x86_64/prctl.c */
 extern int os_arch_prctl(int pid, int code, unsigned long *addr);
 
+/* tty.c */
+int get_pty(void);
+
 #endif
Index: linux-2.6.21-mm/arch/um/include/user.h
===================================================================
--- linux-2.6.21-mm.orig/arch/um/include/user.h	2007-03-22 11:18:21.000000000 -0400
+++ linux-2.6.21-mm/arch/um/include/user.h	2007-03-22 11:21:01.000000000 -0400
@@ -6,6 +6,14 @@
 #ifndef __USER_H__
 #define __USER_H__
 
+/*
+ * The usual definition - copied here because the kernel provides its own,
+ * fancier, type-safe, definition.  Using that one would require
+ * copying too much infrastructure for my taste, so userspace files
+ * get less checking than kernel files.
+ */
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
 /* Both on kernelspace and userspace this will provide the size_t definition. It should, at
  * least. But on userspace it won't hurt surely. */
 #include <linux/types.h>
@@ -21,14 +29,3 @@ extern size_t strlcpy(char *, const char
 extern size_t strlcat(char *, const char *, size_t);
 
 #endif
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
Index: linux-2.6.21-mm/arch/um/include/user_util.h
===================================================================
--- linux-2.6.21-mm.orig/arch/um/include/user_util.h	2007-03-22 11:18:21.000000000 -0400
+++ linux-2.6.21-mm/arch/um/include/user_util.h	2007-03-22 11:21:01.000000000 -0400
@@ -8,31 +8,13 @@
 
 #include "sysdep/ptrace.h"
 
-/* Copied from kernel.h and compiler-gcc.h */
-
-/* Force a compilation error if condition is true, but also produce a
-   result (of value 0 and type size_t), so the expression can be used
-   e.g. in a structure initializer (or where-ever else comma expressions
-   aren't permitted). */
-#define BUILD_BUG_ON_ZERO(e) (sizeof(char[1 - 2 * !!(e)]) - 1)
-
-/* &a[0] degrades to a pointer: a different type from an array */
-#define __must_be_array(a) \
-  BUILD_BUG_ON_ZERO(__builtin_types_compatible_p(typeof(a), typeof(&a[0])))
-
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
-
-#define CATCH_EINTR(expr) while ((errno = 0, ((expr) < 0)) && (errno == EINTR))
-
 extern int mode_tt;
 
 extern int grantpt(int __fd);
 extern int unlockpt(int __fd);
-extern char *ptsname(int __fd);
 
 extern void *add_signal_handler(int sig, void (*handler)(int));
 extern void input_cb(void (*proc)(void *), void *arg, int arg_len);
-extern int get_pty(void);
 extern int switcheroo(int fd, int prot, void *from, void *to, int size);
 extern void do_exec(int old_pid, int new_pid);
 extern void tracer_panic(char *msg, ...)
Index: linux-2.6.21-mm/arch/um/os-Linux/sys-i386/tls.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/sys-i386/tls.c	2007-03-22 11:18:21.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/sys-i386/tls.c	2007-03-22 11:21:01.000000000 -0400
@@ -5,6 +5,7 @@
 #include <unistd.h>
 
 #include "sysdep/tls.h"
+#include "user.h"
 #include "user_util.h"
 
 /* Checks whether host supports TLS, and sets *tls_min according to the value

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
