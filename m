Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JP0I2-0004OP-9r for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Feb 2008 10:55:34 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JP0Hz-0002ht-QV
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Feb 2008 10:55:34 -0800
Date: Tue, 12 Feb 2008 13:55:28 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080212185528.GA2074@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 3/4] UML - Fix helper_wait calls in watchdog
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
Cc: Johann Felix Soden <johfel@users.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

From: Johann Felix Soden <johfel@users.sourceforge.net>

In 1aa351a308d2c3ddb92b6cc45083fc54271d0010 the arguments of helper_wait() were
changed. The adaptation of harddog_user.c was forgotten, so this errors occur:

/arch/um/drivers/harddog_user.c: In function 'start_watchdog':
/arch/um/drivers/harddog_user.c:82: error: too many arguments to function 'helper_wait'
/arch/um/drivers/harddog_user.c:89: error: too many arguments to function 'helper_wait'

Signed-off-by: Johann Felix Soden <johfel@users.sourceforge.net>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/drivers/harddog_user.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.22/arch/um/drivers/harddog_user.c
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/harddog_user.c	2008-01-17 12:50:20.000000000 -0500
+++ linux-2.6.22/arch/um/drivers/harddog_user.c	2008-02-11 18:46:05.000000000 -0500
@@ -79,14 +79,14 @@ int start_watchdog(int *in_fd_ret, int *
 	n = read(in_fds[0], &c, sizeof(c));
 	if (n == 0) {
 		printk("harddog_open - EOF on watchdog pipe\n");
-		helper_wait(pid, 1, NULL);
+		helper_wait(pid);
 		err = -EIO;
 		goto out_close_out;
 	}
 	else if (n < 0) {
 		printk("harddog_open - read of watchdog pipe failed, "
 		       "err = %d\n", errno);
-		helper_wait(pid, 1, NULL);
+		helper_wait(pid);
 		err = n;
 		goto out_close_out;
 	}

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
