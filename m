Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cx9d5-0004W0-Ce for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 12:00:35 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Cx9d4-0000z8-ES for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 12:00:35 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050204183543.D8A78310B6@zion>
Subject: [uml-devel] [patch 2/8] uml: kconfig fixes [before 2.6.11]
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
Date: Fri, 04 Feb 2005 19:35:43 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


Change some config text (hide CONFIG_MODVERSION which is broken on UML and fix
a dummy prompt).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/Kconfig |    6 ++----
 linux-2.6.11-paolo/init/Kconfig    |    2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff -puN init/Kconfig~uml-kconfig-fixes init/Kconfig
--- linux-2.6.11/init/Kconfig~uml-kconfig-fixes	2005-02-04 03:21:03.000000000 +0100
+++ linux-2.6.11-paolo/init/Kconfig	2005-02-04 03:23:37.000000000 +0100
@@ -410,7 +410,7 @@ config OBSOLETE_MODPARM
 
 config MODVERSIONS
 	bool "Module versioning support (EXPERIMENTAL)"
-	depends on MODULES && EXPERIMENTAL
+	depends on MODULES && EXPERIMENTAL && !USERMODE
 	help
 	  Usually, you have to use modules compiled with your kernel.
 	  Saying Y here makes it sometimes possible to use modules
diff -puN arch/um/Kconfig~uml-kconfig-fixes arch/um/Kconfig
--- linux-2.6.11/arch/um/Kconfig~uml-kconfig-fixes	2005-02-04 03:26:44.762471872 +0100
+++ linux-2.6.11-paolo/arch/um/Kconfig	2005-02-04 03:26:44.764471568 +0100
@@ -313,11 +313,9 @@ if BROKEN
 	source "drivers/mtd/Kconfig"
 endif
 
+#This is just to shut up some Kconfig warnings, so no prompt.
 config INPUT
-	bool "Dummy option"
-	depends BROKEN
+	bool
 	default n
-	help
-	This is a dummy option to get rid of warnings.
 
 source "arch/um/Kconfig.debug"
_


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
