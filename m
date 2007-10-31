Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1InJj7-0005Xm-JF for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 Oct 2007 12:59:45 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1InJj7-00054J-0a
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 Oct 2007 12:59:45 -0700
Date: Wed, 31 Oct 2007 15:59:38 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071031195938.GA9630@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/4] UML - Fix spurious IRQ testing
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

The spurious IRQ testing in request_irq is mishandled in
um_request_irq, which sets the incoming file descriptors non-blocking
only after request_irq succeeds.  This results in the spurious irq
calling read on a blocking descriptor, and a hang.

Fixed by reversing the O_NONBLOCK setting and the request_irq call.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/kernel/irq.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

Index: linux-2.6.22/arch/um/kernel/irq.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/irq.c	2007-10-25 12:23:09.000000000 -0400
+++ linux-2.6.22/arch/um/kernel/irq.c	2007-10-29 13:00:18.000000000 -0400
@@ -347,14 +347,15 @@ int um_request_irq(unsigned int irq, int
 {
 	int err;
 
-	err = request_irq(irq, handler, irqflags, devname, dev_id);
-	if (err)
-		return err;
-
-	if (fd != -1)
+	if (fd != -1) {
 		err = activate_fd(irq, fd, type, dev_id);
-	return err;
+		if (err)
+			return err;
+	}
+
+	return request_irq(irq, handler, irqflags, devname, dev_id);
 }
+
 EXPORT_SYMBOL(um_request_irq);
 EXPORT_SYMBOL(reactivate_fd);
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
