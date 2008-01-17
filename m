Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFcU1-00017v-DF for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:09 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFcU0-0001lU-Pq
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:09 -0800
Date: Thu, 17 Jan 2008 16:40:46 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080117214046.GA6762@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 15/20] UML - Fix infinite mconsole loop
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
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Karol Swietlicki <magotari@gmail.com>

From: Karol Swietlicki <magotari@gmail.com>

This patch takes care of a problem with the stopping code.

The function inside the while condition returns 0 to signify a problem.
A problem could be for example a bad command or a bad version of the
mconsole client.
A bad command would terminate the stopping loop and resume the kernel.
This is a problem.

A better solution is to make the loop infinite and don't leave it
until we are explicitly told to.

Signed-off-by: Karol Swietlicki <magotari@gmail.com>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/drivers/mconsole_kern.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6.22/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/mconsole_kern.c	2007-12-12 13:44:20.000000000 -0500
+++ linux-2.6.22/arch/um/drivers/mconsole_kern.c	2007-12-12 15:53:08.000000000 -0500
@@ -305,7 +305,9 @@ void mconsole_stop(struct mc_request *re
 	deactivate_fd(req->originating_fd, MCONSOLE_IRQ);
 	os_set_fd_block(req->originating_fd, 1);
 	mconsole_reply(req, "stopped", 0, 0);
-	while (mconsole_get_request(req->originating_fd, req)) {
+	for (;;) {
+		if (!mconsole_get_request(req->originating_fd, req))
+			continue;
 		if (req->cmd->handler == mconsole_go)
 			break;
 		if (req->cmd->handler == mconsole_stop) {

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
