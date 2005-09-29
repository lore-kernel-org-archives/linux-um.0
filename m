Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EL49E-0008Gc-T1	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Sep 2005 12:32:52 -0700
Received: from ppp-62-11-74-97.dialup.tiscali.it ([62.11.74.97]
	helo=zion.home.lan)	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EL49A-0002kD-Le	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Sep 2005 12:32:52 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20050929193036.14528.92621.stgit@zion.home.lan>
In-Reply-To: <200509292102.44942.blaisorblade@yahoo.it>
References: <200509292102.44942.blaisorblade@yahoo.it>
Subject: [uml-devel] [PATCH 2/5] uml: fix page faults in SKAS3 mode.
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
Date: Thu, 29 Sep 2005 21:30:37 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

I hadn't been running a SKAS3 host when testing the "uml: fix hang in TT mode on
fault" patch (commit 546fe1cbf91d4d62e3849517c31a2327c992e5c5), and I didn't
think enough to the missing trap_no in SKAS3 mode.

In fact, the resulting kernel doesn't work at all in SKAS3 mode.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/sysdep-i386/sigcontext.h   |   10 +++++++++-
 arch/um/include/sysdep-x86_64/sigcontext.h |    5 ++++-
 arch/um/kernel/trap_kern.c                 |    5 ++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/um/include/sysdep-i386/sigcontext.h b/arch/um/include/sysdep-i386/sigcontext.h
--- a/arch/um/include/sysdep-i386/sigcontext.h
+++ b/arch/um/include/sysdep-i386/sigcontext.h
@@ -6,6 +6,7 @@
 #ifndef __SYS_SIGCONTEXT_I386_H
 #define __SYS_SIGCONTEXT_I386_H
 
+#include "uml-config.h"
 #include <sysdep/sc.h>
 
 #define IP_RESTART_SYSCALL(ip) ((ip) -= 2)
@@ -26,7 +27,14 @@
 #define SC_START_SYSCALL(sc) do SC_EAX(sc) = -ENOSYS; while(0)
 
 /* This is Page Fault */
-#define SEGV_IS_FIXABLE(fi) ((fi)->trap_no == 14)
+#define SEGV_IS_FIXABLE(fi)	((fi)->trap_no == 14)
+
+/* SKAS3 has no trap_no on i386, but get_skas_faultinfo() sets it to 0. */
+#ifdef UML_CONFIG_MODE_SKAS
+#define SEGV_MAYBE_FIXABLE(fi)	((fi)->trap_no == 0 && ptrace_faultinfo)
+#else
+#define SEGV_MAYBE_FIXABLE(fi)	0
+#endif
 
 extern unsigned long *sc_sigmask(void *sc_ptr);
 extern int sc_get_fpregs(unsigned long buf, void *sc_ptr);
diff --git a/arch/um/include/sysdep-x86_64/sigcontext.h b/arch/um/include/sysdep-x86_64/sigcontext.h
--- a/arch/um/include/sysdep-x86_64/sigcontext.h
+++ b/arch/um/include/sysdep-x86_64/sigcontext.h
@@ -31,7 +31,10 @@
 #define SC_START_SYSCALL(sc) do SC_RAX(sc) = -ENOSYS; while(0)
 
 /* This is Page Fault */
-#define SEGV_IS_FIXABLE(fi) ((fi)->trap_no == 14)
+#define SEGV_IS_FIXABLE(fi)	((fi)->trap_no == 14)
+
+/* No broken SKAS API, which doesn't pass trap_no, here. */
+#define SEGV_MAYBE_FIXABLE(fi)	0
 
 extern unsigned long *sc_sigmask(void *sc_ptr);
 
diff --git a/arch/um/kernel/trap_kern.c b/arch/um/kernel/trap_kern.c
--- a/arch/um/kernel/trap_kern.c
+++ b/arch/um/kernel/trap_kern.c
@@ -26,6 +26,9 @@
 #include "mconsole_kern.h"
 #include "mem.h"
 #include "mem_kern.h"
+#ifdef CONFIG_MODE_SKAS
+#include "skas.h"
+#endif
 
 /* Note this is constrained to return 0, -EFAULT, -EACCESS, -ENOMEM by segv(). */
 int handle_page_fault(unsigned long address, unsigned long ip, 
@@ -134,7 +137,7 @@ unsigned long segv(struct faultinfo fi, 
 	else if(current->mm == NULL)
 		panic("Segfault with no mm");
 
-	if (SEGV_IS_FIXABLE(&fi))
+	if (SEGV_IS_FIXABLE(&fi) || SEGV_MAYBE_FIXABLE(&fi))
 		err = handle_page_fault(address, ip, is_write, is_user, &si.si_code);
 	else {
 		err = -EFAULT;



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
