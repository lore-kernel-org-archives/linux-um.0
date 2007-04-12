Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hc2EY-0002AY-D8 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Apr 2007 09:33:18 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hc2EX-0000fi-Q8
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Apr 2007 09:33:18 -0700
Date: Thu, 12 Apr 2007 12:28:05 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070412162805.GA7250@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [ PATCH 5/6 ] UML - AIO deadlock avoidance
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

Allow deadlocks to be avoided in the AIO code by setting the pipe to
the I/O thread non-blocking.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/os-Linux/aio.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-2.6.21-mm/arch/um/os-Linux/aio.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/aio.c	2007-04-12 11:34:40.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/aio.c	2007-04-12 11:47:14.000000000 -0400
@@ -221,6 +221,11 @@ static int init_aio_24(void)
 
 	aio_req_fd_w = fds[0];
 	aio_req_fd_r = fds[1];
+
+	err = os_set_fd_block(aio_req_fd_w, 0);
+	if(err)
+		goto out_close_pipe;
+
 	err = run_helper_thread(not_aio_thread, NULL,
 				CLONE_FILES | CLONE_VM | SIGCHLD, &stack, 0);
 	if(err < 0)

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
