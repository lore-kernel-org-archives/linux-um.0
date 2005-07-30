Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dywbu-0002iQ-Lz	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Jul 2005 12:03:02 -0700
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1Dywbu-0005sg-3y
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Jul 2005 12:03:02 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050730190537.22C771AE9B@zion.home.lan>
Subject: [uml-devel] [patch 2/3] uml: workaround GDB problems on debugging
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
Date: Sat, 30 Jul 2005 21:05:36 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Apparently, GDB gets confused when we do an execvp() on ourselves.

Since it's simply done to allocate further space for command line arguments
(which we'll use to allow gathering the startup command line for guest
processes through the host), allow the user to disable that to get a
debuggable UML binary.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/Kconfig.debug    |   11 +++++++++++
 linux-2.6.git-paolo/arch/um/kernel/main.c    |    2 +-
 linux-2.6.git-paolo/arch/um/kernel/um_arch.c |    6 +++---
 3 files changed, 15 insertions(+), 4 deletions(-)

diff -puN arch/um/Kconfig.debug~uml-fix-host-debug-on-TT-binaries arch/um/Kconfig.debug
--- linux-2.6.git/arch/um/Kconfig.debug~uml-fix-host-debug-on-TT-binaries	2005-07-30 16:50:53.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/Kconfig.debug	2005-07-30 16:58:52.000000000 +0200
@@ -2,6 +2,17 @@ menu "Kernel hacking"
 
 source "lib/Kconfig.debug"
 
+config CMDLINE_ON_HOST
+	bool "Show command line arguments on the host in TT mode"
+	depends on MODE_TT
+	default !DEBUG_INFO
+	help
+	This controls whether arguments in guest processes should be shown on
+	the host's ps output.
+	Enabling this option hinders debugging on some recent GDB versions
+	(because GDB gets "confused" when we do an execvp()). So probably you
+	should disable it.
+
 config PT_PROXY
 	bool "Enable ptrace proxy"
 	depends on XTERM_CHAN && DEBUG_INFO && MODE_TT
diff -puN arch/um/kernel/main.c~uml-fix-host-debug-on-TT-binaries arch/um/kernel/main.c
--- linux-2.6.git/arch/um/kernel/main.c~uml-fix-host-debug-on-TT-binaries	2005-07-30 16:50:53.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/main.c	2005-07-30 16:50:53.000000000 +0200
@@ -97,7 +97,7 @@ int main(int argc, char **argv, char **e
 		exit(1);
 	}
 
-#ifdef UML_CONFIG_MODE_TT
+#ifdef UML_CONFIG_CMDLINE_ON_HOST
 	/* Allocate memory for thread command lines */
 	if(argc < 2 || strlen(argv[1]) < THREAD_NAME_LEN - 1){
 
diff -puN arch/um/kernel/um_arch.c~uml-fix-host-debug-on-TT-binaries arch/um/kernel/um_arch.c
--- linux-2.6.git/arch/um/kernel/um_arch.c~uml-fix-host-debug-on-TT-binaries	2005-07-30 16:50:53.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/um_arch.c	2005-07-30 16:50:53.000000000 +0200
@@ -126,7 +126,7 @@ unsigned long start_vm;
 unsigned long end_vm;
 int ncpus = 1;
 
-#ifdef CONFIG_MODE_TT
+#ifdef CONFIG_CMDLINE_ON_HOST
 /* Pointer set in linux_main, the array itself is private to each thread,
  * and changed at address space creation time so this poses no concurrency
  * problems.
@@ -141,7 +141,7 @@ long physmem_size = 32 * 1024 * 1024;
 
 void set_cmdline(char *cmd)
 {
-#ifdef CONFIG_MODE_TT
+#ifdef CONFIG_CMDLINE_ON_HOST
 	char *umid, *ptr;
 
 	if(CHOOSE_MODE(honeypot, 0)) return;
@@ -385,7 +385,7 @@ int linux_main(int argc, char **argv)
 
 	setup_machinename(system_utsname.machine);
 
-#ifdef CONFIG_MODE_TT
+#ifdef CONFIG_CMDLINE_ON_HOST
 	argv1_begin = argv[1];
 	argv1_end = &argv[1][strlen(argv[1])];
 #endif
_


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
