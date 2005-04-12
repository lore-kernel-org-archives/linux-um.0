Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DLPS1-0003bK-HE for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Apr 2005 10:45:25 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DLPRw-0005Y5-81 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Apr 2005 10:45:25 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050412175209.10A11126095@zion>
Subject: [uml-devel] [patch 1/1] uml: add nfsd syscall when nfsd is modular
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
Date: Tue, 12 Apr 2005 19:52:08 +0200
To: akpm@osdl.org
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, blaisorblade@yahoo.it, stable@kernel.org


CC: <stable@kernel.org>

This trick is useless, because sys_ni.c will handle this problem by itself,
like it does even on UML for other syscalls.
Also, it does not provide the NFSD syscall when NFSD is compiled as a module,
which is a big problem.

This should be merged currently in both 2.6.11-stable and the current tree.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 clean-linux-2.6.11-paolo/arch/um/kernel/sys_call_table.c |    8 +-------
 1 files changed, 1 insertion(+), 7 deletions(-)

diff -puN arch/um/kernel/sys_call_table.c~uml-nfsd-syscall arch/um/kernel/sys_call_table.c
--- clean-linux-2.6.11/arch/um/kernel/sys_call_table.c~uml-nfsd-syscall	2005-04-10 13:50:29.000000000 +0200
+++ clean-linux-2.6.11-paolo/arch/um/kernel/sys_call_table.c	2005-04-10 13:51:19.000000000 +0200
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
@@ -190,7 +184,7 @@ syscall_handler_t *sys_call_table[] = {
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
