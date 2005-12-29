Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Es0pf-0000Sk-Og for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Dec 2005 08:40:51 -0800
Received: from host3-98.pool876.interbusiness.it ([87.6.98.3]
	helo=zion.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Es0pe-0001BG-NM for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Dec 2005 08:40:51 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051229163950.4985.1271.stgit@zion.home.lan>
In-Reply-To: <20051229163803.4985.66742.stgit@zion.home.lan>
References: <20051229163803.4985.66742.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 1/5] uml: fix random segfaults at bootup
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
Date: Thu, 29 Dec 2005 17:39:51 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Don't use printk() where "current_thread_info()" is crap.

Until when we switch to running on init_stack, current_thread_info() evaluates
to crap. Printk uses "current" at times (in detail, &current is evaluated with
CONFIG_DEBUG_SPINLOCK to check the spinlock owner task).

And this leads to random segmentation faults.

Exactly, what happens is that &current = *(current_thread_info()), i.e. round
down $esp and dereference the value. I.e. access the stack below $esp, which
causes SIGSEGV on a VM_GROWSDOWN vma (see arch/i386/mm/fault.c).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/os-Linux/start_up.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 37517d4..29a9e3f 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -116,16 +116,16 @@ static int stop_ptraced_child(int pid, v
 	if(!WIFEXITED(status) || (WEXITSTATUS(status) != exitcode)) {
 		int exit_with = WEXITSTATUS(status);
 		if (exit_with == 2)
-			printk("check_ptrace : child exited with status 2. "
+			printf("check_ptrace : child exited with status 2. "
 			       "Serious trouble happening! Try updating your "
 			       "host skas patch!\nDisabling SYSEMU support.");
-		printk("check_ptrace : child exited with exitcode %d, while "
+		printf("check_ptrace : child exited with exitcode %d, while "
 		      "expecting %d; status 0x%x", exit_with,
 		      exitcode, status);
 		if (mustpanic)
 			panic("\n");
 		else
-			printk("\n");
+			printf("\n");
 		ret = -1;
 	}
 
@@ -183,7 +183,7 @@ static void __init check_sysemu(void)
 	void *stack;
  	int pid, n, status, count=0;
 
-	printk("Checking syscall emulation patch for ptrace...");
+	printf("Checking syscall emulation patch for ptrace...");
 	sysemu_supported = 0;
 	pid = start_ptraced_child(&stack);
 
@@ -207,10 +207,10 @@ static void __init check_sysemu(void)
 		goto fail_stopped;
 
 	sysemu_supported = 1;
-	printk("OK\n");
+	printf("OK\n");
 	set_using_sysemu(!force_sysemu_disabled);
 
-	printk("Checking advanced syscall emulation patch for ptrace...");
+	printf("Checking advanced syscall emulation patch for ptrace...");
 	pid = start_ptraced_child(&stack);
 
 	if(ptrace(PTRACE_OLDSETOPTIONS, pid, 0,
@@ -246,7 +246,7 @@ static void __init check_sysemu(void)
 		goto fail_stopped;
 
 	sysemu_supported = 2;
-	printk("OK\n");
+	printf("OK\n");
 
 	if ( !force_sysemu_disabled )
 		set_using_sysemu(sysemu_supported);
@@ -255,7 +255,7 @@ static void __init check_sysemu(void)
 fail:
 	stop_ptraced_child(pid, stack, 1, 0);
 fail_stopped:
-	printk("missing\n");
+	printf("missing\n");
 }
 
 static void __init check_ptrace(void)
@@ -263,7 +263,7 @@ static void __init check_ptrace(void)
 	void *stack;
 	int pid, syscall, n, status;
 
-	printk("Checking that ptrace can change system call numbers...");
+	printf("Checking that ptrace can change system call numbers...");
 	pid = start_ptraced_child(&stack);
 
 	if(ptrace(PTRACE_OLDSETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
@@ -292,7 +292,7 @@ static void __init check_ptrace(void)
 		}
 	}
 	stop_ptraced_child(pid, stack, 0, 1);
-	printk("OK\n");
+	printf("OK\n");
 	check_sysemu();
 }
 
@@ -472,6 +472,8 @@ int can_do_skas(void)
 
 int have_devanon = 0;
 
+/* Runs on boot kernel stack - already safe to use printk. */
+
 void check_devanon(void)
 {
 	int fd;



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
