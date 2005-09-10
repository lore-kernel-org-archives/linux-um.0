Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EE9iO-0006lc-16	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Sep 2005 11:04:36 -0700
Received: from ppp-62-11-72-160.dialup.tiscali.it ([62.11.72.160]
	helo=zion.home.lan)	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EE9iM-0002YW-6X	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Sep 2005 11:04:36 -0700
Message-Id: <20050910174628.104571000@zion.home.lan>
References: <20050910174452.907256000@zion.home.lan>
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Content-Disposition: inline; filename=x86-64-link-script-cleanup
Subject: [uml-devel] [patch 3/7] x86_64 linker script cleanups for debug
	sections
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
Date: Sat, 10 Sep 2005 19:44:55 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, Sam Ravnborg <sam@ravnborg.org>, Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

Use the new macros for x86_64 too.

Note that the current scripts includes different definitions; more exactly,
it only contains part of the DWARF2 sections and the .comment one from
Stabs. Shouldn't be a problem, anyway.

Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/x86_64/kernel/vmlinux.lds.S |   17 ++---------------
 1 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/x86_64/kernel/vmlinux.lds.S b/arch/x86_64/kernel/vmlinux.lds.S
--- a/arch/x86_64/kernel/vmlinux.lds.S
+++ b/arch/x86_64/kernel/vmlinux.lds.S
@@ -194,20 +194,7 @@ SECTIONS
 #endif
 	}
 
-  /* DWARF 2 */
-  .debug_info     0 : { *(.debug_info) }
-  .debug_abbrev   0 : { *(.debug_abbrev) }
-  .debug_line     0 : { *(.debug_line) }
-  .debug_frame    0 : { *(.debug_frame) }
-  .debug_str      0 : { *(.debug_str) }
-  .debug_loc      0 : { *(.debug_loc) }
-  .debug_macinfo  0 : { *(.debug_macinfo) }
-  /* SGI/MIPS DWARF 2 extensions */
-  .debug_weaknames 0 : { *(.debug_weaknames) }
-  .debug_funcnames 0 : { *(.debug_funcnames) }
-  .debug_typenames 0 : { *(.debug_typenames) }
-  .debug_varnames  0 : { *(.debug_varnames) }
+  STABS_DEBUG
 
-
-  .comment 0 : { *(.comment) }
+  DWARF_DEBUG
 }

--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
