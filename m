Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPWrX-0004kA-QZ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:56:31 -0800
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CPWrW-0004S6-BG for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:56:31 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20041103231744.CFFC355C81@zion.localdomain>
Subject: [uml-devel] [patch 13/20] Uml: revert compile-only changes for other
	ones
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
Date: Thu, 04 Nov 2004 00:17:44 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org, blaisorblade_spam@yahoo.it


I'm reverting the compile-time fixes to replace them with a bigger change,
which also happens to fix the compilation problem. The change is in next
patches.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/kernel/process.c |   13 -------------
 1 files changed, 13 deletions(-)

diff -puN arch/um/kernel/process.c~uml-revert-wrong-build-fix arch/um/kernel/process.c
--- vanilla-linux-2.6.9/arch/um/kernel/process.c~uml-revert-wrong-build-fix	2004-11-03 23:45:15.493083424 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/process.c	2004-11-03 23:45:15.496082968 +0100
@@ -202,11 +202,6 @@ __uml_setup("nosysemu", nosysemu_cmd_par
 		"    To make it working, you need a kernel patch for your host, too.\n"
 		"    See http://perso.wanadoo.fr/laurent.vivier/UML/ for further information.\n");
 
-/* Ugly hack for now... --cw */
-#ifndef PTRACE_SYSEMU
-#define PTRACE_SYSEMU 31
-#endif
-
 static void __init check_sysemu(void)
 {
 	void *stack;
@@ -216,9 +211,7 @@ static void __init check_sysemu(void)
 		return;
 
 	printk("Checking syscall emulation patch for ptrace...");
-#ifdef CONFIG_MODE_SKAS
 	sysemu_supported = 0;
-#endif /* CONFIG_MODE_SKAS */
 	pid = start_ptraced_child(&stack);
 	if(ptrace(PTRACE_SYSEMU, pid, 0, 0) >= 0) {
 		struct user_regs_struct regs;
@@ -240,23 +233,17 @@ static void __init check_sysemu(void)
 
 		stop_ptraced_child(pid, stack, 0);
 
-#ifdef CONFIG_MODE_SKAS
 		sysemu_supported = 1;
-#endif /* CONFIG_MODE_SKAS */
 		printk("found\n");
 	}
 	else
 	{
 		stop_ptraced_child(pid, stack, 1);
-#ifdef CONFIG_MODE_SKAS
 		sysemu_supported = 0;
-#endif /* CONFIG_MODE_SKAS */
 		printk("missing\n");
 	}
 
-#ifdef CONFIG_MODE_SKAS
 	set_using_sysemu(!force_sysemu_disabled);
-#endif
 }
 
 void __init check_ptrace(void)
_


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
