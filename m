Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GVaT9-0003QZ-VL for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 14:09:28 -0700
Received: from host253-106-dynamic.55-82-r.retail.telecomitalia.it
	([82.55.106.253] helo=memento.home.lan)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GVaT9-0003dl-AH
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 14:09:27 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Thu,  5 Oct 2006 22:01:47 +0200
Message-Id: <11600785071661-git-send-email-blaisorblade@yahoo.it>
Subject: [uml-devel] uml: use DEFCONFIG_LIST to avoid reading host's config
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
To: stable@kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This should make sure that, for UML, host's configuration files are not
considered, which avoids various pains to the user. Our dependency are such that
the obtained Kconfig will be valid and will lead to successful compilation -
however they cannot prevent an user from disabling any boot device, and if an
option is not set in the read .config (say /boot/config-XXX), with make
menuconfig ARCH=um, it is not set. This always disables UBD and all console I/O
channels, which leads to non-working UML kernels, so this bothers users -
especially now, since it will happen on almost every machine
(/boot/config-`uname -r` exists almost on every machine). It can be workarounded
with make defconfig ARCH=um, but it is non-obvious and can be avoided, so please
_do_ merge this patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/arch/um/Kconfig
===================================================================
--- linux-2.6.git.orig/arch/um/Kconfig
+++ linux-2.6.git/arch/um/Kconfig
@@ -1,3 +1,8 @@
+config DEFCONFIG_LIST
+	string
+	option defconfig_list
+	default "arch/$ARCH/defconfig"
+
 # UML uses the generic IRQ sugsystem
 config GENERIC_HARDIRQS
 	bool
Index: linux-2.6.git/init/Kconfig
===================================================================
--- linux-2.6.git.orig/init/Kconfig
+++ linux-2.6.git/init/Kconfig
@@ -1,5 +1,6 @@
 config DEFCONFIG_LIST
 	string
+	depends on !UML
 	option defconfig_list
 	default "/lib/modules/$UNAME_RELEASE/.config"
 	default "/etc/kernel-config"

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
