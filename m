Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ID3eg-0005q1-3F for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Jul 2007 12:33:20 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ID3ee-0002Uv-Hz
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Jul 2007 12:33:18 -0700
Date: Mon, 23 Jul 2007 15:33:11 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070723193311.GA12383@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/3] UML - Fix string exporting on UML/i386
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
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

In 2.6.23-rc1, i386 fiddled its string support such that UML started
getting undefined references from modules.  The UML asm/string.h was
including the i386 string.h, which defined __HAVE_ARCH_STR*, but the
corresponding implementations weren't being pulled in.

This is fixed by adding arch/i386/lib/string.h to the list of host
architecture files to be pulled in to UML.

A complication is that the libc exports file assumed that the generic
strlen and strstr weren't in use (i.e. __HAVE_ARCH_STR is defined),
then they aren't exported.  This is untrue for strlen, which is
exported in either case, so this logic is not needed.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/os-Linux/user_syms.c |    5 +----
 arch/um/sys-i386/Makefile    |    2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

Index: linux-2.6.17/arch/um/sys-i386/Makefile
===================================================================
--- linux-2.6.17.orig/arch/um/sys-i386/Makefile	2007-07-23 14:58:46.000000000 -0400
+++ linux-2.6.17/arch/um/sys-i386/Makefile	2007-07-23 14:58:56.000000000 -0400
@@ -4,7 +4,7 @@ obj-y = bug.o bugs.o checksum.o delay.o 
 
 obj-$(CONFIG_MODE_SKAS) += stub.o stub_segv.o
 
-subarch-obj-y = lib/bitops.o lib/semaphore.o
+subarch-obj-y = lib/bitops.o lib/semaphore.o lib/string.o
 subarch-obj-$(CONFIG_HIGHMEM) += mm/highmem.o
 subarch-obj-$(CONFIG_MODULES) += kernel/module.o
 
Index: linux-2.6.17/arch/um/os-Linux/user_syms.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/user_syms.c	2007-07-23 14:58:18.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/user_syms.c	2007-07-23 14:59:22.000000000 -0400
@@ -19,10 +19,7 @@ extern void *memmove(void *, const void 
 extern void *memset(void *, int, size_t);
 extern int printf(const char *, ...);
 
-/* If they're not defined, the export is included in lib/string.c.*/
-#ifdef __HAVE_ARCH_STRLEN
-EXPORT_SYMBOL(strlen);
-#endif
+/* If it's not defined, the export is included in lib/string.c.*/
 #ifdef __HAVE_ARCH_STRSTR
 EXPORT_SYMBOL(strstr);
 #endif

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
