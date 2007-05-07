Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hl9lj-0001d7-6j for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 May 2007 13:25:15 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hl9li-0007a7-6G
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 May 2007 13:25:14 -0700
Date: Mon, 7 May 2007 16:20:19 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070507202019.GA8512@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 4/5] Fix Linuxdoc comment
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

A linuxdoc comment had fallen out of date - it refers to an argument
which no longer exists.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 kernel/irq/handle.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-2.6.21-mm/kernel/irq/handle.c
===================================================================
--- linux-2.6.21-mm.orig/kernel/irq/handle.c	2007-05-02 11:21:45.000000000 -0400
+++ linux-2.6.21-mm/kernel/irq/handle.c	2007-05-04 14:53:58.000000000 -0400
@@ -22,7 +22,6 @@
  * handle_bad_irq - handle spurious and unhandled irqs
  * @irq:       the interrupt number
  * @desc:      description of the interrupt
- * @regs:      pointer to a register structure
  *
  * Handles spurious and unhandled IRQ's. It also prints a debugmessage.
  */

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
