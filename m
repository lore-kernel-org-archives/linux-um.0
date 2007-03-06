Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOeag-0007JJ-HK for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Mar 2007 10:40:50 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HOeag-0006oh-1r
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Mar 2007 10:40:50 -0800
Message-Id: <200703061832.l26IW6BK006549@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Tue, 06 Mar 2007 13:32:06 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/5] UML - Mark tt-mode code for future removal
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Mark some tt-mode-only code as such.

Also cleaned up some formatting.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/sys-i386/ptrace_user.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

Index: linux-2.6.18-mm/arch/um/sys-i386/ptrace_user.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/sys-i386/ptrace_user.c	2007-03-02 21:18:13.000000000 -0500
+++ linux-2.6.18-mm/arch/um/sys-i386/ptrace_user.c	2007-03-02 21:23:19.000000000 -0500
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -45,7 +45,8 @@ int ptrace_setfpregs(long pid, unsigned 
 	return 0;
 }
 
-/* All the below stuff is of interest for TT mode only */
+#ifdef UML_CONFIG_MODE_TT
+
 static void write_debugregs(int pid, unsigned long *regs)
 {
 	struct user *dummy;
@@ -128,13 +129,4 @@ void update_debugregs(int seq)
 }
 #endif
 
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
+#endif


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
