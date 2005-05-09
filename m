Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DVHZC-0002Y8-NT	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 16:21:38 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DVHZA-0006W7-Qn	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 16:21:38 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050509224520.C9E9613C21A@zion>
Subject: [uml-devel] [patch 5/6] uml: split CONFIG_FRAME_POINTER from
	DEBUG_INFO
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
Date: Tue, 10 May 2005 00:45:20 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


Until now, FRAME_POINTER was set = DEBUG_INFO for UML. Change it to be the
default way, so that it can be enabled alone (for instance to get better
backtraces on crashes).
The call-trace dumper which uses the frame pointer is not yet in, I'm going to
introduce it in a separate patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---


diff -puN arch/um/Kconfig.debug~uml-split-frame-pointer-option arch/um/Kconfig.debug
--- linux-2.6.git/arch/um/Kconfig.debug~uml-split-frame-pointer-option	2005-05-07 18:00:23.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/Kconfig.debug	2005-05-07 18:00:23.000000000 +0200
@@ -2,10 +2,6 @@ menu "Kernel hacking"
 
 source "lib/Kconfig.debug"
 
-config FRAME_POINTER
-	bool
-	default y if DEBUG_INFO
-
 config PT_PROXY
 	bool "Enable ptrace proxy"
 	depends on XTERM_CHAN && DEBUG_INFO && MODE_TT
diff -puN lib/Kconfig.debug~uml-split-frame-pointer-option lib/Kconfig.debug
--- linux-2.6.git/lib/Kconfig.debug~uml-split-frame-pointer-option	2005-05-07 18:00:23.000000000 +0200
+++ linux-2.6.git-paolo/lib/Kconfig.debug	2005-05-07 18:00:23.000000000 +0200
@@ -151,7 +151,8 @@ config DEBUG_FS
 
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
-	depends on DEBUG_KERNEL && ((X86 && !X86_64) || CRIS || M68K || M68KNOMMU || FRV)
+	depends on DEBUG_KERNEL && ((X86 && !X86_64) || CRIS || M68K || M68KNOMMU || FRV || UML)
+	default y if DEBUG_INFO && UML
 	help
 	  If you say Y here the resulting kernel image will be slightly larger
 	  and slower, but it will give very useful debugging information.
_


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
