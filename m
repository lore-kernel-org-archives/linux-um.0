Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPWqo-0004iW-VH for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:55:46 -0800
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CPWqn-0004Jn-KN for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:55:46 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20041103231802.625B455C8F@zion.localdomain>
Subject: [uml-devel] [patch 20/20] uml: add missing newline in help string
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
Date: Thu, 04 Nov 2004 00:18:02 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org, blaisorblade_spam@yahoo.it


Add missing newline in help string for "nosysemu" param. Run ./vmlinux --help
before and after to see the difference. Trivial - must go in.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/kernel/process.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/kernel/process.c~uml-add-missing-newline-in-help arch/um/kernel/process.c
--- vanilla-linux-2.6.9/arch/um/kernel/process.c~uml-add-missing-newline-in-help	2004-11-03 23:30:40.100163376 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/process.c	2004-11-03 23:30:40.102163072 +0100
@@ -235,7 +235,7 @@ __uml_setup("nosysemu", nosysemu_cmd_par
 		"    SYSEMU is a performance-patch introduced by Laurent Vivier. It changes\n"
 		"    behaviour of ptrace() and helps reducing host context switch rate.\n"
 		"    To make it working, you need a kernel patch for your host, too.\n"
-		"    See http://perso.wanadoo.fr/laurent.vivier/UML/ for further information.\n");
+		"    See http://perso.wanadoo.fr/laurent.vivier/UML/ for further information.\n\n");
 
 static void __init check_sysemu(void)
 {
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
