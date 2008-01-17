Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFcTz-00017l-FG for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:07 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFcTy-00013w-IP
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:07 -0800
Date: Thu, 17 Jan 2008 16:40:43 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080117214043.GA6732@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 9/20] UML - Add newlines to printks
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

Some printks were missing newlines.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/os-Linux/skas/process.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.22/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/skas/process.c	2007-12-19 13:13:54.000000000 -0500
+++ linux-2.6.22/arch/um/os-Linux/skas/process.c	2007-12-19 13:14:16.000000000 -0500
@@ -273,7 +273,7 @@ int start_userspace(unsigned long stub_s
 	if (stack == MAP_FAILED) {
 		err = -errno;
 		printk(UM_KERN_ERR "start_userspace : mmap failed, "
-		       "errno = %d", errno);
+		       "errno = %d\n", errno);
 		return err;
 	}
 
@@ -289,7 +289,7 @@ int start_userspace(unsigned long stub_s
 	if (pid < 0) {
 		err = -errno;
 		printk(UM_KERN_ERR "start_userspace : clone failed, "
-		       "errno = %d", errno);
+		       "errno = %d\n", errno);
 		return err;
 	}
 
@@ -298,7 +298,7 @@ int start_userspace(unsigned long stub_s
 		if (n < 0) {
 			err = -errno;
 			printk(UM_KERN_ERR "start_userspace : wait failed, "
-			       "errno = %d", errno);
+			       "errno = %d\n", errno);
 			goto out_kill;
 		}
 	} while (WIFSTOPPED(status) && (WSTOPSIG(status) == SIGVTALRM));
@@ -306,7 +306,7 @@ int start_userspace(unsigned long stub_s
 	if (!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP)) {
 		err = -EINVAL;
 		printk(UM_KERN_ERR "start_userspace : expected SIGSTOP, got "
-		       "status = %d", status);
+		       "status = %d\n", status);
 		goto out_kill;
 	}
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
