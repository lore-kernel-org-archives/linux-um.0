Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HYPn8-0005kb-6s for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2007 09:54:02 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HYPn7-0003c4-Hu
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2007 09:54:02 -0700
Date: Mon, 2 Apr 2007 12:50:10 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070402165010.GA7611@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/4] UML - no locking needed in tls.c
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
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

Comment the lack of locking on a couple of globals.

Also fix the formatting of __setup_host_supports_tls.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/sys-i386/tls.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

Index: linux-2.6.21-mm/arch/um/sys-i386/tls.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/sys-i386/tls.c	2007-03-30 15:26:36.000000000 -0400
+++ linux-2.6.21-mm/arch/um/sys-i386/tls.c	2007-03-30 16:01:35.000000000 -0400
@@ -23,9 +23,13 @@
 #include "skas.h"
 #endif
 
-/* If needed we can detect when it's uninitialized. */
+/*
+ * If needed we can detect when it's uninitialized.
+ *
+ * These are initialized in an initcall and unchanged thereafter.
+ */
 static int host_supports_tls = -1;
-int host_gdt_entry_tls_min = -1;
+int host_gdt_entry_tls_min;
 
 #ifdef CONFIG_MODE_SKAS
 int do_set_thread_area_skas(struct user_desc *info)
@@ -361,7 +365,8 @@ out:
 
 /* XXX: This part is probably common to i386 and x86-64. Don't create a common
  * file for now, do that when implementing x86-64 support.*/
-static int __init __setup_host_supports_tls(void) {
+static int __init __setup_host_supports_tls(void)
+{
 	check_host_supports_tls(&host_supports_tls, &host_gdt_entry_tls_min);
 	if (host_supports_tls) {
 		printk(KERN_INFO "Host TLS support detected\n");

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
