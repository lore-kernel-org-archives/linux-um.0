Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DGiHs-00015t-I0 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Mar 2005 10:51:32 -0800
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DGiHY-0002a5-Mp for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Mar 2005 10:51:32 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050330173343.DBE8EEFED5@zion>
Subject: [uml-devel] [patch 2/8] uml: gprof depends on !TT
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
Date: Wed, 30 Mar 2005 19:33:43 +0200
To: torvalds@osdl.org
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


CONFIG_GPROF depends on the fact that TT mode is disabled. I just verified
this, and this dependency already exists in UML/2.4.

Depends on "uml-add-kconfig-debug-deps" in -mm.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/Kconfig.debug |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/Kconfig.debug~uml-gprof-depends-on-not-tt arch/um/Kconfig.debug
--- linux-2.6.11/arch/um/Kconfig.debug~uml-gprof-depends-on-not-tt	2005-03-24 11:37:54.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/Kconfig.debug	2005-03-24 11:37:54.000000000 +0100
@@ -16,7 +16,7 @@ config PT_PROXY
 
 config GPROF
 	bool "Enable gprof support"
-	depends on DEBUG_INFO && MODE_SKAS
+	depends on DEBUG_INFO && MODE_SKAS && !MODE_TT
 	help
         This allows profiling of a User-Mode Linux kernel with the gprof
         utility.
_


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/info/Sentarus/hamr30
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
