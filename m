Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDnc7-0005Yx-2M for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 09:56:23 -0800
Received: from mail-relay-1.tiscali.it ([213.205.33.41])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DDnc6-0005is-8r for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 09:56:22 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050322162142.16F94C4B86@zion>
Subject: [uml-devel] [patch 10/12] uml: add kconfig debug deps
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
Date: Tue, 22 Mar 2005 17:21:41 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


Add some needed dependencies for some debug options and hide the MAGIC_SYSRQ
option for UML, since it displays this option in another menu.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/Kconfig.debug |    6 +++---
 linux-2.6.11-paolo/lib/Kconfig.debug     |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff -puN arch/um/Kconfig.debug~uml-kbuild-debug-deps arch/um/Kconfig.debug
--- linux-2.6.11/arch/um/Kconfig.debug~uml-kbuild-debug-deps	2005-03-22 10:28:03.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/Kconfig.debug	2005-03-22 10:30:46.000000000 +0100
@@ -8,7 +8,7 @@ config FRAME_POINTER
 
 config PT_PROXY
 	bool "Enable ptrace proxy"
-	depends on XTERM_CHAN && DEBUG_INFO
+	depends on XTERM_CHAN && DEBUG_INFO && MODE_TT
 	help
 	This option enables a debugging interface which allows gdb to debug
 	the kernel without needing to actually attach to kernel threads.
@@ -16,7 +16,7 @@ config PT_PROXY
 
 config GPROF
 	bool "Enable gprof support"
-	depends on DEBUG_INFO
+	depends on DEBUG_INFO && MODE_SKAS
 	help
         This allows profiling of a User-Mode Linux kernel with the gprof
         utility.
@@ -29,7 +29,7 @@ config GPROF
 
 config GCOV
 	bool "Enable gcov support"
-	depends on DEBUG_INFO
+	depends on DEBUG_INFO && MODE_SKAS
 	help
         This option allows developers to retrieve coverage data from a UML
         session.
diff -puN lib/Kconfig.debug~uml-kbuild-debug-deps lib/Kconfig.debug
--- linux-2.6.11/lib/Kconfig.debug~uml-kbuild-debug-deps	2005-03-22 10:28:03.000000000 +0100
+++ linux-2.6.11-paolo/lib/Kconfig.debug	2005-03-22 10:30:50.000000000 +0100
@@ -17,7 +17,7 @@ config DEBUG_KERNEL
 
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && !UML
 	help
 	  If you say Y here, you will have some control over the system even
 	  if the system crashes for example during kernel debugging (e.g., you
_


-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
