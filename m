Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5w8L-00053I-DT for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Sep 2004 17:52:53 -0700
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C5qG8-0002p6-5I for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Sep 2004 11:36:37 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20040910171400.8CF87C744@zion.localdomain>
Subject: [uml-devel] [patch 1/1] UML: remove commented old code in Kconfig
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
Date: Fri, 10 Sep 2004 19:14:00 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Drop a config option which has disappeared from all archs. Btw, this shouldn't
be in the UML-specific part, but since we cannot include generic Kconfigs to
avoid problem with hardware-related configs, it's duplicated for now.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/Kconfig_char |    5 -----
 1 files changed, 5 deletions(-)

diff -puN arch/um/Kconfig_char~remove-commented-old-code arch/um/Kconfig_char
--- linux-2.6.9-current/arch/um/Kconfig_char~remove-commented-old-code	2004-09-10 19:11:24.388299224 +0200
+++ linux-2.6.9-current-paolo/arch/um/Kconfig_char	2004-09-10 19:11:24.390298920 +0200
@@ -158,11 +158,6 @@ config LEGACY_PTY_COUNT
 	  When not in use, each legacy PTY occupies 12 bytes on 32-bit
 	  architectures and 24 bytes on 64-bit architectures.
 
-#config UNIX98_PTY_COUNT
-#	int "Maximum number of Unix98 PTYs in use (0-2048)"
-#	depends on UNIX98_PTYS
-#	default "256"
-
 config WATCHDOG
 	bool "Watchdog Timer Support"
 
_


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
