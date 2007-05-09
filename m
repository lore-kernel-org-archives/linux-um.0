Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hlspz-0008KC-Il for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 May 2007 13:32:39 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hlspw-0005rn-Qx
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 May 2007 13:32:39 -0700
Date: Wed, 9 May 2007 16:27:22 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070509202722.GA22469@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 6/6] UML - Shrink kernel stacks
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

Make kernel stacks be 1 page on i386 and 2 pages on x86_64.  These
matche the host values.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/Kconfig   |    2 +-
 arch/um/defconfig |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.21-mm/arch/um/Kconfig
===================================================================
--- linux-2.6.21-mm.orig/arch/um/Kconfig	2007-05-09 15:45:56.000000000 -0400
+++ linux-2.6.21-mm/arch/um/Kconfig	2007-05-09 16:06:03.000000000 -0400
@@ -277,7 +277,8 @@ config HIGHMEM
 
 config KERNEL_STACK_ORDER
 	int "Kernel stack size order"
-	default 2
+	default 1 if 64BIT
+	default 0 if !64BIT
 	help
 	This option determines the size of UML kernel stacks.  They will
 	be 1 << order pages.  The default is OK unless you're running Valgrind
Index: linux-2.6.21-mm/arch/um/defconfig
===================================================================
--- linux-2.6.21-mm.orig/arch/um/defconfig	2007-05-09 15:45:56.000000000 -0400
+++ linux-2.6.21-mm/arch/um/defconfig	2007-05-09 15:57:20.000000000 -0400
@@ -86,7 +86,7 @@ CONFIG_MCONSOLE=y
 # CONFIG_MAGIC_SYSRQ is not set
 CONFIG_NEST_LEVEL=0
 # CONFIG_HIGHMEM is not set
-CONFIG_KERNEL_STACK_ORDER=2
+CONFIG_KERNEL_STACK_ORDER=0
 CONFIG_UML_REAL_TIME_CLOCK=y
 
 #

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
