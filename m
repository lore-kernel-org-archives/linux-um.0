Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EaziL-0004go-V3 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 10:02:57 -0800
Received: from host20-103.pool873.interbusiness.it ([87.3.103.20]
	helo=zion.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EaziL-000220-78 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 10:02:58 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051112180727.20133.58958.stgit@zion.home.lan>
In-Reply-To: <20051112180711.20133.68166.stgit@zion.home.lan>
References: <20051112180711.20133.68166.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 4/9] uml - fixups for "reuse i386 cpu-specific
	tuning"
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
Date: Sat, 12 Nov 2005 19:07:29 +0100
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

A few fixups - show the new submenu only for x86 subarchitecture (it does not
make sense to show it for x86_64 users) and remove X86_CMPXCHG, which is now a
duplicate of Kconfig.i386, even though Kconfig doesn't complain (we also
miss the dependency on !M386 CPU).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Kconfig       |    6 ------
 arch/um/Kconfig.i386  |   10 ++++++----
 arch/um/Makefile-i386 |    1 -
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 018f076..563301f 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -35,12 +35,6 @@ config IRQ_RELEASE_METHOD
 	bool
 	default y
 
-menu "Host processor type and features"
-
-source "arch/i386/Kconfig.cpu"
-
-endmenu
-
 menu "UML-specific options"
 
 config MODE_TT
diff --git a/arch/um/Kconfig.i386 b/arch/um/Kconfig.i386
index 5d92cac..c71b39a 100644
--- a/arch/um/Kconfig.i386
+++ b/arch/um/Kconfig.i386
@@ -1,3 +1,9 @@
+menu "Host processor type and features"
+
+source "arch/i386/Kconfig.cpu"
+
+endmenu
+
 config UML_X86
 	bool
 	default y
@@ -42,7 +48,3 @@ config ARCH_HAS_SC_SIGNALS
 config ARCH_REUSE_HOST_VSYSCALL_AREA
 	bool
 	default y
-
-config X86_CMPXCHG
-	bool
-	default y
diff --git a/arch/um/Makefile-i386 b/arch/um/Makefile-i386
index 1f7dcb0..7a0e04e 100644
--- a/arch/um/Makefile-i386
+++ b/arch/um/Makefile-i386
@@ -35,4 +35,3 @@ cflags-y += $(call cc-option,-mpreferred
 
 CFLAGS += $(cflags-y)
 USER_CFLAGS += $(cflags-y)
-



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
