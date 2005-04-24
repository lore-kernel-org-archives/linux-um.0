Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DPli4-0004rl-4R for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 11:20:00 -0700
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DPli2-0006Sx-Cx for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 11:20:00 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050424180959.3F78A55CFB@zion>
Subject: [uml-devel] [patch 2/6] uml: add nfsd syscall when nfsd is modular
	[for 2.6.12]
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
Date: Sun, 24 Apr 2005 20:09:58 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


This trick is useless, because sys_ni.c will handle this problem by itself,
like it does even on UML for other syscalls.
Also, it does not provide the NFSD syscall when NFSD is compiled as a module,
which is a big problem.

This should be merged currently in both 2.6.11-stable and the current tree.

I already sent it for -stable, it's already in -mm but not in -rc3, now it
should be merged in 2.6.12. It has already been tested in 2.6.11-bs4 and it's
fairly trivial.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/kernel/sys_call_table.c |    8 +-------
 1 files changed, 1 insertion(+), 7 deletions(-)

diff -puN arch/um/kernel/sys_call_table.c~uml-nfsd-syscall arch/um/kernel/sys_call_table.c
--- linux-2.6.12/arch/um/kernel/sys_call_table.c~uml-nfsd-syscall	2005-04-24 19:32:15.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/kernel/sys_call_table.c	2005-04-24 19:32:15.000000000 +0200
@@ -14,12 +14,6 @@
 #include "sysdep/syscalls.h"
 #include "kern_util.h"
 
-#ifdef CONFIG_NFSD
-#define NFSSERVCTL sys_nfsservctl
-#else
-#define NFSSERVCTL sys_ni_syscall
-#endif
-
 #define LAST_GENERIC_SYSCALL __NR_keyctl
 
 #if LAST_GENERIC_SYSCALL > LAST_ARCH_SYSCALL
@@ -189,7 +183,7 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_getresuid ] = (syscall_handler_t *) sys_getresuid16,
 	[ __NR_query_module ] = (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_poll ] = (syscall_handler_t *) sys_poll,
-	[ __NR_nfsservctl ] = (syscall_handler_t *) NFSSERVCTL,
+	[ __NR_nfsservctl ] = (syscall_handler_t *) sys_nfsservctl,
 	[ __NR_setresgid ] = (syscall_handler_t *) sys_setresgid16,
 	[ __NR_getresgid ] = (syscall_handler_t *) sys_getresgid16,
 	[ __NR_prctl ] = (syscall_handler_t *) sys_prctl,
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
