Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JP0I4-0004OY-R7 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Feb 2008 10:55:37 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JP0I2-0001o6-9B
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Feb 2008 10:55:36 -0800
Date: Tue, 12 Feb 2008 13:55:27 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080212185527.GA2084@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/4] UML - Fix initrd printk
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
Cc: Johann Felix Soden <johfel@users.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, WANG Cong <xiyou.wangcong@gmail.com>

From: Johann Felix Soden <johfel@users.sourceforge.net>

If the initrd file has zero-length, the error message should contain
the filepath.

Cc: WANG Cong <xiyou.wangcong@gmail.com>
Signed-off-by: Johann Felix Soden <johfel@users.sourceforge.net>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/kernel/initrd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Index: linux-2.6-git/arch/um/kernel/initrd.c
===================================================================
--- linux-2.6-git.orig/arch/um/kernel/initrd.c	2008-02-12 12:44:44.000000000 -0500
+++ linux-2.6-git/arch/um/kernel/initrd.c	2008-02-12 13:19:11.000000000 -0500
@@ -32,7 +32,7 @@ static int __init read_initrd(void)
 	 * ask for no memory.
 	 */
 	if (size == 0) {
-		printk(KERN_ERR "\"%\" is a zero-size initrd\n");
+		printk(KERN_ERR "\"%s\" is a zero-size initrd\n", initrd);
 		return 0;
 	}
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
