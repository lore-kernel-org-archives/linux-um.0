Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IxSDM-0001QZ-Ko for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 11:04:56 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IxSDK-000398-Oo
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 11:04:52 -0800
Date: Wed, 28 Nov 2007 14:04:39 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071128190439.GA8303@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 2/4] UML - Add !UML dependencies
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Al Viro <viro@zeniv.linux.org.uk>

From: Al Viro <viro@zeniv.linux.org.uk>

That's not enough, unfortunately.  If we go that way, we need to add
dependencies on !UML for several options.

[ jdike - "not enough" refers to my patch which enables X86_32 and
RWSEM_XCHGADD_ALGORITHM in UML's Kconfig.i386 ]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 drivers/crypto/Kconfig         |    2 +-
 kernel/Kconfig.instrumentation |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.22/drivers/crypto/Kconfig
===================================================================
--- linux-2.6.22.orig/drivers/crypto/Kconfig	2007-11-21 11:49:37.000000000 -0500
+++ linux-2.6.22/drivers/crypto/Kconfig	2007-11-26 11:54:18.000000000 -0500
@@ -12,7 +12,7 @@ if CRYPTO_HW
 
 config CRYPTO_DEV_PADLOCK
 	tristate "Support for VIA PadLock ACE"
-	depends on X86_32
+	depends on X86_32 && !UML
 	select CRYPTO_ALGAPI
 	help
 	  Some VIA processors come with an integrated crypto engine
Index: linux-2.6.22/kernel/Kconfig.instrumentation
===================================================================
--- linux-2.6.22.orig/kernel/Kconfig.instrumentation	2007-11-14 10:33:42.000000000 -0500
+++ linux-2.6.22/kernel/Kconfig.instrumentation	2007-11-26 11:54:18.000000000 -0500
@@ -21,7 +21,7 @@ config PROFILING
 config OPROFILE
 	tristate "OProfile system profiling (EXPERIMENTAL)"
 	depends on PROFILING
-	depends on ALPHA || ARM || BLACKFIN || X86_32 || IA64 || M32R || MIPS || PARISC || PPC || S390 || SUPERH || SPARC || X86_64
+	depends on (ALPHA || ARM || BLACKFIN || X86_32 || IA64 || M32R || MIPS || PARISC || PPC || S390 || SUPERH || SPARC || X86_64) && !UML
 	help
 	  OProfile is a profiling system capable of profiling the
 	  whole system, include the kernel, kernel modules, libraries,
@@ -32,7 +32,7 @@ config OPROFILE
 config KPROBES
 	bool "Kprobes"
 	depends on KALLSYMS && MODULES
-	depends on X86_32 || IA64 || PPC || S390 || SPARC64 || X86_64 || AVR32
+	depends on (X86_32 || IA64 || PPC || S390 || SPARC64 || X86_64 || AVR32) && !UML
 	help
 	  Kprobes allows you to trap at almost any kernel address and
 	  execute a callback function.  register_kprobe() establishes

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
