Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cx9d2-0004Vf-TQ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 12:00:32 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Cx9d0-0000yL-RN for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 12:00:32 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050204183541.52C972125F@zion>
Subject: [uml-devel] [patch 1/8] uml: fix compilation for missing headers
	[before 2.6.11]
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
Date: Fri, 04 Feb 2005 19:35:40 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Readd some needed headers inclusion deleted in
http://linux.bkbits.net:8080/linux-2.5/cset@41e49628dGbOWX-bT9yZII4f19GT6A

If you think it cannot make sense to include both <sys/ptrace.h> and
<linux/ptrace.h> (as userspace process, i.e. host includes), go complaining
with glibc, or follow the linux-abi includes idea.

However, the compilation failure is possibly glibc-version (or better glibc
includes version) related - what I now is that the failure happens on my
system with a glibc 2.3.4 (from Gentoo).

Also, fix the syscall table to both compile and have no empty slot (which
could cause Oopses).

Acked-by: Jeff Dike <jdike@addtoit.com>

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/process.c        |   15 ++++-----------
 linux-2.6.11-paolo/arch/um/kernel/sys_call_table.c |   16 ++--------------
 2 files changed, 6 insertions(+), 25 deletions(-)

diff -puN arch/um/kernel/process.c~uml-fix-compilation-for-missing-headers arch/um/kernel/process.c
--- linux-2.6.11/arch/um/kernel/process.c~uml-fix-compilation-for-missing-headers	2005-02-04 03:28:51.973132912 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/process.c	2005-02-04 03:28:58.254178048 +0100
@@ -13,6 +13,10 @@
 #include <setjmp.h>
 #include <sys/time.h>
 #include <sys/ptrace.h>
+
+/*Userspace header, must be after sys/ptrace.h, and both must be included. */
+#include <linux/ptrace.h>
+
 #include <sys/wait.h>
 #include <sys/mman.h>
 #include <asm/unistd.h>
@@ -422,14 +426,3 @@ int can_do_skas(void)
 	return(0);
 }
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
diff -puN arch/um/kernel/sys_call_table.c~uml-fix-compilation-for-missing-headers arch/um/kernel/sys_call_table.c
--- linux-2.6.11/arch/um/kernel/sys_call_table.c~uml-fix-compilation-for-missing-headers	2005-02-04 03:28:51.975132608 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/sys_call_table.c	2005-02-04 03:29:05.565066624 +0100
@@ -267,10 +267,9 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_mq_timedreceive ] = (syscall_handler_t *) sys_mq_timedreceive,
 	[ __NR_mq_notify ] = (syscall_handler_t *) sys_mq_notify,
 	[ __NR_mq_getsetattr ] = (syscall_handler_t *) sys_mq_getsetattr,
+	[ __NR_sys_kexec_load ] = (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_waitid ] = (syscall_handler_t *) sys_waitid,
-#if 0
-	[ __NR_sys_setaltroot ] = (syscall_handler_t *) sys_sys_setaltroot,
-#endif
+	[ 285 ] = (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_add_key ] = (syscall_handler_t *) sys_add_key,
 	[ __NR_request_key ] = (syscall_handler_t *) sys_request_key,
 	[ __NR_keyctl ] = (syscall_handler_t *) sys_keyctl,
@@ -279,14 +278,3 @@ syscall_handler_t *sys_call_table[] = {
 	[ LAST_SYSCALL + 1 ... NR_syscalls ] = 
 	        (syscall_handler_t *) sys_ni_syscall
 };
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
_


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
