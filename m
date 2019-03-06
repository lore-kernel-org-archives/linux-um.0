Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mout.kundenserver.de ([212.227.126.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h1bHH-0003pm-1s
 for linux-um@lists.infradead.org; Wed, 06 Mar 2019 18:28:29 +0000
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH] arch: um: Kconfig: pedantic cleanups
Date: Wed,  6 Mar 2019 19:28:17 +0100
Message-Id: <1551896897-30963-1-git-send-email-info@metux.net>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: richard@nod.at, jdike@addtoit.com, linux-um@lists.infradead.org, anton.ivanov@cambridgegreys.com

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/um/Kconfig | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index ec9711d..216ee50 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -80,46 +80,46 @@ config LD_SCRIPT_DYN
 	bool
 	default y
 	depends on !LD_SCRIPT_STATIC
-        select MODULE_REL_CRCS if MODVERSIONS
+	select MODULE_REL_CRCS if MODVERSIONS
 
 config HOSTFS
 	tristate "Host filesystem"
 	help
-          While the User-Mode Linux port uses its own root file system for
-          booting and normal file access, this module lets the UML user
-          access files stored on the host.  It does not require any
-          network connection between the Host and UML.  An example use of
-          this might be:
+	  While the User-Mode Linux port uses its own root file system for
+	  booting and normal file access, this module lets the UML user
+	  access files stored on the host.  It does not require any
+	  network connection between the Host and UML.  An example use of
+	  this might be:
 
-          mount none /tmp/fromhost -t hostfs -o /tmp/umlshare
+	  mount none /tmp/fromhost -t hostfs -o /tmp/umlshare
 
-          where /tmp/fromhost is an empty directory inside UML and
-          /tmp/umlshare is a directory on the host with files the UML user
-          wishes to access.
+	  where /tmp/fromhost is an empty directory inside UML and
+	  /tmp/umlshare is a directory on the host with files the UML user
+	  wishes to access.
 
-          For more information, see
-          <http://user-mode-linux.sourceforge.net/hostfs.html>.
+	  For more information, see
+	  <http://user-mode-linux.sourceforge.net/hostfs.html>.
 
-          If you'd like to be able to work with files stored on the host,
-          say Y or M here; otherwise say N.
+	  If you'd like to be able to work with files stored on the host,
+	  say Y or M here; otherwise say N.
 
 config MCONSOLE
 	bool "Management console"
 	depends on PROC_FS
 	default y
 	help
-          The user mode linux management console is a low-level interface to
-          the kernel, somewhat like the i386 SysRq interface.  Since there is
-          a full-blown operating system running under every user mode linux
-          instance, there is much greater flexibility possible than with the
-          SysRq mechanism.
-
-          If you answer 'Y' to this option, to use this feature, you need the
-          mconsole client (called uml_mconsole) which is present in CVS in
-          2.4.5-9um and later (path /tools/mconsole), and is also in the
-          distribution RPM package in 2.4.6 and later.
-
-          It is safe to say 'Y' here.
+	  The user mode linux management console is a low-level interface to
+	  the kernel, somewhat like the i386 SysRq interface.  Since there is
+	  a full-blown operating system running under every user mode linux
+	  instance, there is much greater flexibility possible than with the
+	  SysRq mechanism.
+
+	  If you answer 'Y' to this option, to use this feature, you need the
+	  mconsole client (called uml_mconsole) which is present in CVS in
+	  2.4.5-9um and later (path /tools/mconsole), and is also in the
+	  distribution RPM package in 2.4.6 and later.
+
+	  It is safe to say 'Y' here.
 
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
-- 
1.9.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

