Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JOIBb-0005a7-MQ for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 10 Feb 2008 11:50:00 -0800
Received: from mail.gmx.net ([213.165.64.20])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1JOIBZ-0008Kk-By
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 10 Feb 2008 11:49:59 -0800
From: Johann Felix Soden <johfel@gmx.de>
Date: Sun, 10 Feb 2008 20:49:42 +0100
Message-Id: <1202672982.28562.2.camel@localhost>
Mime-Version: 1.0
Subject: [uml-devel] [PATCH] uml: Fix calls of helper_wait in harddog_user.c
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
To: Jeff Dike <jdike@linux.intel.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

From: Johann Felix Soden <johfel@users.sourceforge.net>

In 1aa351a308d2c3ddb92b6cc45083fc54271d0010 the arguments of helper_wait() were
changed. The adaptation of harddog_user.c was forgotten, so this errors occur:

/arch/um/drivers/harddog_user.c: In function 'start_watchdog':
/arch/um/drivers/harddog_user.c:82: error: too many arguments to function 'helper_wait'
/arch/um/drivers/harddog_user.c:89: error: too many arguments to function 'helper_wait'

Signed-off-by: Johann Felix Soden <johfel@users.sourceforge.net>
---
 arch/um/drivers/harddog_user.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/harddog_user.c b/arch/um/drivers/harddog_user.c
index 448ba59..b56f8e0 100644
--- a/arch/um/drivers/harddog_user.c
+++ b/arch/um/drivers/harddog_user.c
@@ -79,14 +79,14 @@ int start_watchdog(int *in_fd_ret, int *out_fd_ret, char *sock)
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
-- 
1.5.4




-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
