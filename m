Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GVayz-0006ZJ-T9 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 14:42:21 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GVayz-0000PL-Aw
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 14:42:21 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Thu, 05 Oct 2006 23:39:16 +0200
Message-Id: <20061005213916.17268.53832.stgit@memento.home.lan>
In-Reply-To: <20061005213212.17268.7409.stgit@memento.home.lan>
References: <20061005213212.17268.7409.stgit@memento.home.lan>
Subject: [uml-devel] [PATCH 13/14] uml: deprecate CONFIG_MODE_TT
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Deprecate TT mode in Kconfig so that users won't select it, update the MODE_SKAS
description (it was largely obsolete and misleadin) and btw describe advantages
for high memory usage with CONFIG_STATIC_LINK.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Kconfig |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 450547a..78fb619 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -50,13 +50,15 @@ config IRQ_RELEASE_METHOD
 menu "UML-specific options"
 
 config MODE_TT
-	bool "Tracing thread support"
+	bool "Tracing thread support (DEPRECATED)"
 	default n
 	help
 	This option controls whether tracing thread support is compiled
-	into UML.  This option is largely obsolete, given that skas0 provides
+	into UML. This option is largely obsolete, given that skas0 provides
 	skas security and performance without needing to patch the host.
-	It is safe to say 'N' here.
+	It is safe to say 'N' here; saying 'Y' may cause additional problems
+	with the resulting binary even if you run UML in SKAS mode, and running
+	in TT mode is strongly *NOT RECOMMENDED*.
 
 config STATIC_LINK
 	bool "Force a static link"
@@ -69,6 +71,9 @@ config STATIC_LINK
 	for use in a chroot jail.  So, if you intend to run UML inside a
 	chroot, and you disable CONFIG_MODE_TT, you probably want to say Y
 	here.
+	Additionally, this option enables using higher memory spaces (up to
+	2.75G) for UML - disabling CONFIG_MODE_TT and enabling this option leads
+	to best results for this.
 
 config KERNEL_HALF_GIGS
 	int "Kernel address space size (in .5G units)"
@@ -85,10 +90,13 @@ config MODE_SKAS
 	default y
 	help
 	This option controls whether skas (separate kernel address space)
-	support is compiled in.  If you have applied the skas patch to the
-	host, then you certainly want to say Y here (and consider saying N
-	to CONFIG_MODE_TT).  Otherwise, it is safe to say Y.  Disabling this
-	option will shrink the UML binary slightly.
+	support is compiled in.
+	Unless you have specific needs to use TT mode (which applies almost only
+	to developers), you should say Y here.
+	SKAS mode will make use of the SKAS3 patch if it is applied on the host
+	(and your UML will run in SKAS3 mode), but if no SKAS patch is applied
+	on the host it will run in SKAS0 mode, which is anyway faster than TT
+	mode.
 
 source "arch/um/Kconfig.arch"
 source "mm/Kconfig"
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
