Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C1szu-0006ig-7K for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Aug 2004 13:43:26 -0700
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C1szs-0003tY-KD for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Aug 2004 13:43:25 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20040830203547.9527EBD22@zion.localdomain>
Subject: [uml-devel] [patch 1/4] sysemu_cmdParam
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
Date: Mon, 30 Aug 2004 22:35:47 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: blaisorblade_spam@yahoo.it, for_spam@gmx.de


From: "roland" <for_spam@gmx.de> and me.
Adds the "nosysemu" command line parameter to disable SYSEMU.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/kernel/process.c |   26 +++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

diff -puN arch/um/kernel/process.c~sysemu_cmdParam arch/um/kernel/process.c
--- uml-linux-2.6.8.1/arch/um/kernel/process.c~sysemu_cmdParam	2004-08-29 14:40:47.318018344 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/process.c	2004-08-29 14:40:47.320018040 +0200
@@ -186,6 +186,22 @@ static void stop_ptraced_child(int pid, 
 		panic("check_ptrace : munmap failed, errno = %d", errno);
 }
 
+static int force_sysemu_disabled = 0;
+
+static int __init nosysemu_cmd_param(char *str, int* add)
+{
+	force_sysemu_disabled = 1;
+	return 0;
+}
+
+__uml_setup("nosysemu", nosysemu_cmd_param,
+		"nosysemu\n"
+		"    Turns off syscall emulation patch for ptrace (SYSEMU) on.\n"
+		"    SYSEMU is a performance-patch introduced by Laurent Vivier. It changes\n"
+		"    behaviour of ptrace() and helps reducing host context switch rate.\n"
+		"    To make it working, you need a kernel patch for your host, too.\n"
+		"    See http://perso.wanadoo.fr/laurent.vivier/UML/ for further information.\n");
+
 void __init check_ptrace(void)
 {
 	void *stack;
@@ -219,7 +235,6 @@ void __init check_ptrace(void)
 	stop_ptraced_child(pid, stack, 0);
 	printk("OK\n");
 
-#ifdef PTRACE_SYSEMU
 	printk("Checking syscall emulation patch for ptrace...");
 	use_sysemu = 0;
 	pid = start_ptraced_child(&stack);
@@ -242,8 +257,12 @@ void __init check_ptrace(void)
 
 		stop_ptraced_child(pid, stack, 0);
 
-		printk("OK\n");
-		use_sysemu = 1;
+		if (!force_sysemu_disabled) {
+			printk("found\n");
+			use_sysemu = 1;
+		} else {
+			printk("found but disabled\n");
+		}
 	}
 	else
 	{
@@ -251,7 +270,6 @@ void __init check_ptrace(void)
 		stop_ptraced_child(pid, stack, 1);
 	}
 
-# endif /* PTRACE_SYSEMU */
 }
 
 int run_kernel_thread(int (*fn)(void *), void *arg, void **jmp_ptr)
_


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
