Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpBSK-0005bi-Sy for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 12:20:32 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CpBSI-0008QT-0C for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 12:20:32 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20050113202046.A08F24B46@zion>
Subject: [uml-devel] [patch 1/1] uml: fix compilation for missing headers
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
Date: Thu, 13 Jan 2005 21:20:44 +0100
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Readd some needed headers inclusion deleted in
http://linux.bkbits.net:8080/linux-2.5/cset@41e49628dGbOWX-bT9yZII4f19GT6A

If you think it cannot make sense to include both <sys/ptrace.h> and
<linux/ptrace.h> (as userspace process, i.e. host includes), go complaining
with glibc, or follow the linux-abi includes idea.

However, the compilation failure is possibly glibc-version (or better glibc
includes version) related - what I now is that the failure happens on my
system with a glibc 2.3.4 (from Gentoo).

Also, remove some syscalls from the syscall table, since some syscalls were
added which are only inside -mm currently, and this prevents currently
compilation.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/process.c        |    4 ++++
 linux-2.6.11-paolo/arch/um/kernel/sys_call_table.c |   13 +++++++++++++
 2 files changed, 17 insertions(+)

diff -puN arch/um/kernel/process.c~uml-fix-compilation-for-missing-headers arch/um/kernel/process.c
--- linux-2.6.11/arch/um/kernel/process.c~uml-fix-compilation-for-missing-headers	2005-01-13 19:57:51.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/process.c	2005-01-13 19:59:30.000000000 +0100
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
diff -puN arch/um/kernel/sys_call_table.c~uml-fix-compilation-for-missing-headers arch/um/kernel/sys_call_table.c
--- linux-2.6.11/arch/um/kernel/sys_call_table.c~uml-fix-compilation-for-missing-headers	2005-01-13 20:48:02.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/sys_call_table.c	2005-01-13 21:17:23.866866296 +0100
@@ -20,7 +20,11 @@
 #define NFSSERVCTL sys_ni_syscall
 #endif
 
+#if 0
 #define LAST_GENERIC_SYSCALL __NR_vperfctr_read
+#else
+#define LAST_GENERIC_SYSCALL __NR_keyctl
+#endif
 
 #if LAST_GENERIC_SYSCALL > LAST_ARCH_SYSCALL
 #define LAST_SYSCALL LAST_GENERIC_SYSCALL
@@ -54,11 +58,14 @@ extern syscall_handler_t sys_get_mempoli
 extern syscall_handler_t sys_set_mempolicy;
 extern syscall_handler_t sys_sys_kexec_load;
 extern syscall_handler_t sys_sys_setaltroot;
+
+#if 0
 extern syscall_handler_t sys_vperfctr_open;
 extern syscall_handler_t sys_vperfctr_control;
 extern syscall_handler_t sys_vperfctr_unlink;
 extern syscall_handler_t sys_vperfctr_iresume;
 extern syscall_handler_t sys_vperfctr_read;
+#endif
 
 syscall_handler_t *sys_call_table[] = {
 	[ __NR_restart_syscall ] = (syscall_handler_t *) sys_restart_syscall,
@@ -273,7 +280,10 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_mq_timedreceive ] = (syscall_handler_t *) sys_mq_timedreceive,
 	[ __NR_mq_notify ] = (syscall_handler_t *) sys_mq_notify,
 	[ __NR_mq_getsetattr ] = (syscall_handler_t *) sys_mq_getsetattr,
+#if 0
 	[ __NR_sys_kexec_load ] = (syscall_handler_t *) sys_kexec_load,
+#endif
+	[ __NR_sys_kexec_load ] = (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_waitid ] = (syscall_handler_t *) sys_waitid,
 #if 0
 	[ __NR_sys_setaltroot ] = (syscall_handler_t *) sys_sys_setaltroot,
@@ -281,11 +291,14 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_add_key ] = (syscall_handler_t *) sys_add_key,
 	[ __NR_request_key ] = (syscall_handler_t *) sys_request_key,
 	[ __NR_keyctl ] = (syscall_handler_t *) sys_keyctl,
+	/* These syscalls are still in -mm only*/
+#if 0
 	[ __NR_vperfctr_open ] = (syscall_handler_t *) sys_vperfctr_open,
 	[ __NR_vperfctr_control ] = (syscall_handler_t *) sys_vperfctr_control,
 	[ __NR_vperfctr_unlink ] = (syscall_handler_t *) sys_vperfctr_unlink,
 	[ __NR_vperfctr_iresume ] = (syscall_handler_t *) sys_vperfctr_iresume,
 	[ __NR_vperfctr_read ] = (syscall_handler_t *) sys_vperfctr_read,
+#endif
 
 	ARCH_SYSCALLS
 	[ LAST_SYSCALL + 1 ... NR_syscalls ] = 
_


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
