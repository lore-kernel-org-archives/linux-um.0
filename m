Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IrbUC-0008T8-00 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Nov 2007 07:46:04 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IrbU9-0005l6-9a
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Nov 2007 07:46:03 -0800
Date: Mon, 12 Nov 2007 10:45:43 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071112154543.GA5571@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/2] UML - Fix recvmsg return value checking
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

Stupid bug - we need to compare the return value of recvmsg to the
value of iov_len, not its size.  This caused port_helper processes not
to be killed on shutdown on x86_64 because the pids weren't being
passed out properly.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/os-Linux/file.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6/arch/um/os-Linux/file.c
===================================================================
--- linux-2.6.orig/arch/um/os-Linux/file.c	2007-11-12 10:26:26.000000000 -0500
+++ linux-2.6/arch/um/os-Linux/file.c	2007-11-12 10:32:30.000000000 -0500
@@ -496,8 +496,7 @@ int os_rcv_fd(int fd, int *helper_pid_ou
 	n = recvmsg(fd, &msg, 0);
 	if(n < 0)
 		return -errno;
-
-	else if(n != sizeof(iov.iov_len))
+	else if(n != iov.iov_len)
 		*helper_pid_out = -1;
 
 	cmsg = CMSG_FIRSTHDR(&msg);

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
