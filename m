Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K3bn0-00063f-TI for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jun 2008 12:03:23 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K3bmz-0004x8-9S
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jun 2008 12:03:22 -0700
Date: Tue, 3 Jun 2008 15:02:38 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080603190237.GA9521@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 6/6] UML - PATH_MAX needs limits.h
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
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Ingo Molnar <mingo@elte.hu>

From: Ingo Molnar <mingo@elte.hu>

Include limits.h to get a definition of PATH_MAX.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/os-Linux/helper.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6-git/arch/um/os-Linux/helper.c
===================================================================
--- linux-2.6-git.orig/arch/um/os-Linux/helper.c	2008-05-14 10:44:02.000000000 -0400
+++ linux-2.6-git/arch/um/os-Linux/helper.c	2008-06-02 15:50:10.000000000 -0400
@@ -7,6 +7,7 @@
 #include <unistd.h>
 #include <errno.h>
 #include <sched.h>
+#include <linux/limits.h>
 #include <sys/socket.h>
 #include <sys/wait.h>
 #include "kern_constants.h"

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
