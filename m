Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GZwT6-0001zC-Jn for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Oct 2006 14:27:24 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GZwT4-0002UI-VU
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Oct 2006 14:27:24 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Tue, 17 Oct 2006 23:27:17 +0200
Message-Id: <20061017212717.26445.77935.stgit@americanbeauty.home.lan>
In-Reply-To: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
References: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
Subject: [uml-devel] [PATCH 07/10] uml: use DEFCONFIG_LIST to avoid reading
	host's config
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

Given the existence of options, it could be interesting to implement
(additionally) "option required" - with it, Kconfig will refuse reading a
.config file (from wherever it comes) if the given option is not set. With this,
one could mark with it the option characteristic of the given architecture (it
was an old proposal of Roman Zippel, when I pointed out our problem):

config UML
	option required
	default y

However this should be further discussed:
*) for x86, it must support constructs like:

==arch/i386/Kconfig==
config 64BIT
	option required
	default n
where Kconfig must require that CONFIG_64BIT is disabled or not present in the
read .config.

*) do we want to do such checks only for the starting defconfig or also for
   .config? Which leads to:
*) I may want to port a x86_64 .config to x86 and viceversa, or even among more
   different archs. Should that be allowed, and in which measure (the user may
   force skipping the check for a .config or it is only given a warning by
   default)?

Cc: Roman Zippel <zippel@linux-m68k.org>
Cc: kbuild-devel@lists.sourceforge.net
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Kconfig |    5 +++++
 init/Kconfig    |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 78fb619..1e068b4 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -1,3 +1,8 @@
+config DEFCONFIG_LIST
+	string
+	option defconfig_list
+	default "arch/$ARCH/defconfig"
+
 # UML uses the generic IRQ sugsystem
 config GENERIC_HARDIRQS
 	bool
diff --git a/init/Kconfig b/init/Kconfig
index 1038293..c8b2624 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1,5 +1,6 @@
 config DEFCONFIG_LIST
 	string
+	depends on !UML
 	option defconfig_list
 	default "/lib/modules/$UNAME_RELEASE/.config"
 	default "/etc/kernel-config"
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
