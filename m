Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cp6wJ-0005bE-TO for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 07:31:11 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Cp6wJ-0007nK-0u for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 07:31:11 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20050113051327.B173A6324B@zion>
Subject: [uml-devel] [patch 2/8] uml: readd CONFIG_MAGIC_SYSRQ for UML
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
Date: Thu, 13 Jan 2005 06:13:27 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>

This config option was lost during the creation of lib/Kconfig.debug, due to a
bad expressed dependency; I also moved the option back to its original place
for UML (it is near CONFIG_MCONSOLE since it depends on that).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/Kconfig   |   19 +++++++++++++++++++
 linux-2.6.11-paolo/lib/Kconfig.debug |    1 -
 2 files changed, 19 insertions(+), 1 deletion(-)

diff -puN lib/Kconfig.debug~uml-readd-config-magic-sysrq lib/Kconfig.debug
--- linux-2.6.11/lib/Kconfig.debug~uml-readd-config-magic-sysrq	2005-01-13 01:48:41.153139144 +0100
+++ linux-2.6.11-paolo/lib/Kconfig.debug	2005-01-13 01:48:41.157138536 +0100
@@ -23,7 +23,6 @@ config MAGIC_SYSRQ
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
 	depends on DEBUG_KERNEL && (H8300 || M68KNOMMU || V850)
-	depends (USERMODE && MCONSOLE)
 	help
 	  Enables console device to interpret special characters as
 	  commands to dump state information.
diff -puN arch/um/Kconfig~uml-readd-config-magic-sysrq arch/um/Kconfig
--- linux-2.6.11/arch/um/Kconfig~uml-readd-config-magic-sysrq	2005-01-13 01:48:41.155138840 +0100
+++ linux-2.6.11-paolo/arch/um/Kconfig	2005-01-13 01:48:41.158138384 +0100
@@ -145,6 +145,25 @@ config MCONSOLE
 
         It is safe to say 'Y' here.
 
+config MAGIC_SYSRQ
+	bool "Magic SysRq key"
+	depends on MCONSOLE
+	---help---
+	If you say Y here, you will have some control over the system even
+	if the system crashes for example during kernel debugging (e.g., you
+	will be able to flush the buffer cache to disk, reboot the system
+	immediately or dump some status information). A key for each of the
+	possible requests is provided.
+
+	This is the feature normally accomplished by pressing a key
+	while holding SysRq (Alt+PrintScreen).
+
+	On UML, this is accomplished by sending a "sysrq" command with
+	mconsole, followed by the letter for the requested command.
+
+	The keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
+	unless you really know what this hack does.
+
 config HOST_2G_2G
 	bool "2G/2G host address space split"
 	default n
_


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
