Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KP3Jl-0004ii-4m for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Aug 2008 15:41:49 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KP3Jk-0004MC-Ks
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Aug 2008 15:41:49 -0700
Date: Fri, 1 Aug 2008 18:41:35 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080801224135.GA13735@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 13/14] UML - Fix boot crash
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
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

From 7ca5503f5ee32fb3cd6aa6eca21a8edfe09a7717 Mon Sep 17 00:00:00 2001

My copying of linux/init.h didn't go far enough.  The definition of
__used singled out gcc minor version 3, but didn't care what the major
version was.  This broke when unit-at-a-time was added and gcc started
throwing out initcalls.

This results in an early boot crash when ptrace tries to initialize a
process with an empty, uninitialized register set.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/um/include/init.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/um/include/init.h b/arch/um/include/init.h
index b00a957..37dd097 100644
--- a/arch/um/include/init.h
+++ b/arch/um/include/init.h
@@ -45,6 +45,8 @@ typedef void (*exitcall_t)(void);
 # define __section(S) __attribute__ ((__section__(#S)))
 #endif
 
+#if __GNUC__ == 3
+
 #if __GNUC_MINOR__ >= 3
 # define __used			__attribute__((__used__))
 #else
@@ -52,6 +54,12 @@ typedef void (*exitcall_t)(void);
 #endif
 
 #else
+#if __GNUC__ == 4
+# define __used			__attribute__((__used__))
+#endif
+#endif
+
+#else
 #include <linux/compiler.h>
 #endif
 /* These are for everybody (although not all archs will actually
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
