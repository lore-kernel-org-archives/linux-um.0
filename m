Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KP3Jj-0004iY-Gk for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Aug 2008 15:41:47 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KP3Jj-0004Mk-1Z
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Aug 2008 15:41:47 -0700
Date: Fri, 1 Aug 2008 18:41:26 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080801224126.GA13719@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 3/14] uml: physical memory shouldn't include
	initial stack
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
To: stable@kernel.org
Cc: WANG Cong <xiyou.wangcong@gmail.com>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, "Christopher S. Aker" <caker@theshore.net>

From 57c582f7eb25314e650f143c2c5141a0cc4172eb Mon Sep 17 00:00:00 2001

The top of physical memory should be below the initial process stack, not the
top of the address space, at least for as long as the stack isn't known to the
kernel VM system and appropriately reserved.

Cc: "Christopher S. Aker" <caker@theshore.net>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
Cc: WANG Cong <xiyou.wangcong@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/um/kernel/um_arch.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index a6c1dd1..9cecb42 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -259,6 +259,7 @@ int __init linux_main(int argc, char **argv)
 	unsigned long avail, diff;
 	unsigned long virtmem_size, max_physmem;
 	unsigned int i, add;
+	unsigned long stack;
 	char * mode;
 
 	for (i = 1; i < argc; i++) {
@@ -347,7 +348,9 @@ int __init linux_main(int argc, char **argv)
 	}
 
 	virtmem_size = physmem_size;
-	avail = TASK_SIZE - start_vm;
+	stack = (unsigned long) argv;
+	stack &= ~(1024 * 1024 - 1);
+	avail = stack - start_vm;
 	if (physmem_size > avail)
 		virtmem_size = avail;
 	end_vm = start_vm + virtmem_size;
-- 
1.5.5.1


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
