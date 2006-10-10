Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GXAyc-0000q5-Hb for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Oct 2006 23:20:30 -0700
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GXAyb-0006O7-KX
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Oct 2006 23:20:30 -0700
From: <gregkh@suse.de>
Date: Mon, 09 Oct 2006 23:20:08 -0700
In-Reply-To: <11600785071661-git-send-email-blaisorblade@yahoo.it>
Message-Id: <20061010062022.AE3F38BBB1B@imap.suse.de>
Subject: [uml-devel] patch
	uml-use-defconfig_list-to-avoid-reading-host-s-config.patch
	queued to -stable tree
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
To: blaisorblade@yahoo.it, gregkh@suse.de, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net
Cc: stable@kernel.org


This is a note to let we have just queued up the patch titled

     Subject: uml: use DEFCONFIG_LIST to avoid reading host's config

to the -stable tree.  Its filename is

     uml-use-defconfig_list-to-avoid-reading-host-s-config.patch

A git repo of this tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/stable/stable-queue/


From stable-bounces@linux.kernel.org Thu Oct  5 14:10:16 2006
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
To: stable@kernel.org
Date: Thu,  5 Oct 2006 22:01:47 +0200
Message-Id: <11600785071661-git-send-email-blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>,
        "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
        <user-mode-linux-devel@lists.sourceforge.net>
Subject: uml: use DEFCONFIG_LIST to avoid reading host's config

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
Acked-by: Jeff Dike <jdike@addtoit.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/um/Kconfig |    5 +++++
 init/Kconfig    |    1 +
 2 files changed, 6 insertions(+)

--- linux-2.6.18.orig/arch/um/Kconfig
+++ linux-2.6.18/arch/um/Kconfig
@@ -1,3 +1,8 @@
+config DEFCONFIG_LIST
+	string
+	option defconfig_list
+	default "arch/$ARCH/defconfig"
+
 # UML uses the generic IRQ sugsystem
 config GENERIC_HARDIRQS
 	bool
--- linux-2.6.18.orig/init/Kconfig
+++ linux-2.6.18/init/Kconfig
@@ -1,5 +1,6 @@
 config DEFCONFIG_LIST
 	string
+	depends on !UML
 	option defconfig_list
 	default "/lib/modules/$UNAME_RELEASE/.config"
 	default "/etc/kernel-config"


Patches currently in stable-queue which might be from blaisorblade@yahoo.it are

queue-2.6.18/uml-allow-using-again-x86-x86_64-crypto-code.patch
queue-2.6.18/uml-use-defconfig_list-to-avoid-reading-host-s-config.patch
queue-2.6.18/uml-fix-uml-build-failure.patch

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
