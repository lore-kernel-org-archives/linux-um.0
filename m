Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J1mvj-0007GX-A9 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Dec 2007 10:00:35 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J1mvi-0000g2-Or
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Dec 2007 10:00:35 -0800
Date: Mon, 10 Dec 2007 13:00:09 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071210180009.GA9333@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 5/5] UML - use barrier() instead of mb()
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

signals_enabled and pending have requirements on the order in which
they are modified.  This used to be done by declaring them volatile
and putting an mb() where the ordering requirements were in effect.

After getting a better (I hope) understanding of how to do this
correctly, the volatile declarations are gone and the mb()'s replaced
by barrier()'s.

One of the mb()'s was deleted because I see no problematic writes that
could be re-ordered past that point.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/os-Linux/signal.c |   28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

Index: linux-2.6-git/arch/um/os-Linux/signal.c
===================================================================
--- linux-2.6-git.orig/arch/um/os-Linux/signal.c	2007-12-07 16:53:18.000000000 -0500
+++ linux-2.6-git/arch/um/os-Linux/signal.c	2007-12-07 17:37:10.000000000 -0500
@@ -15,6 +15,9 @@
 #include "sysdep/sigcontext.h"
 #include "user.h"
 
+/* Copied from linux/compiler-gcc.h since we can't include it directly */
+#define barrier() __asm__ __volatile__("": : :"memory")
+
 /*
  * These are the asynchronous signals.  SIGPROF is excluded because we want to
  * be able to profile all of UML, not just the non-critical sections.  If
@@ -27,13 +30,8 @@
 #define SIGVTALRM_BIT 1
 #define SIGVTALRM_MASK (1 << SIGVTALRM_BIT)
 
-/*
- * These are used by both the signal handlers and
- * block/unblock_signals.  I don't want modifications cached in a
- * register - they must go straight to memory.
- */
-static volatile int signals_enabled = 1;
-static volatile int pending = 0;
+static int signals_enabled;
+static unsigned int pending;
 
 void sig_handler(int sig, struct sigcontext *sc)
 {
@@ -198,7 +196,7 @@ void block_signals(void)
 	 * This might matter if gcc figures out how to inline this and
 	 * decides to shuffle this code into the caller.
 	 */
-	mb();
+	barrier();
 }
 
 void unblock_signals(void)
@@ -224,21 +222,11 @@ void unblock_signals(void)
 		 * Setting signals_enabled and reading pending must
 		 * happen in this order.
 		 */
-		mb();
+		barrier();
 
 		save_pending = pending;
-		if (save_pending == 0) {
-			/*
-			 * This must return with signals enabled, so
-			 * this barrier ensures that writes are
-			 * flushed out before the return.  This might
-			 * matter if gcc figures out how to inline
-			 * this (unlikely, given its size) and decides
-			 * to shuffle this code into the caller.
-			 */
-			mb();
+		if (save_pending == 0)
 			return;
-		}
 
 		pending = 0;
 

-------------------------------------------------------------------------
SF.Net email is sponsored by: 
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
