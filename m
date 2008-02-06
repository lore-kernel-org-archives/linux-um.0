Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JMoKY-0004uz-2S for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Feb 2008 09:45:06 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JMoKV-0001Oz-K7
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Feb 2008 09:45:06 -0800
Date: Wed, 6 Feb 2008 12:44:47 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080206174447.GA7856@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 4/5] UML - x86_64 should copy %fs during fork
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

%fs needs to be copied from parent to child during fork.

Tidied up some whitespace while I was here.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 include/asm-um/processor-x86_64.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6-git/include/asm-um/processor-x86_64.h
===================================================================
--- linux-2.6-git.orig/include/asm-um/processor-x86_64.h	2008-02-06 11:17:20.000000000 -0500
+++ linux-2.6-git/include/asm-um/processor-x86_64.h	2008-02-06 12:17:21.000000000 -0500
@@ -26,7 +26,7 @@ static inline void rep_nop(void)
 #define cpu_relax()   rep_nop()
 
 #define INIT_ARCH_THREAD { .debugregs  		= { [ 0 ... 7 ] = 0 }, \
-                           .debugregs_seq	= 0,			       \
+			   .debugregs_seq	= 0, \
 			   .fs			= 0, \
 			   .faultinfo		= { 0, 0, 0 } }
 
@@ -37,6 +37,7 @@ static inline void arch_flush_thread(str
 static inline void arch_copy_thread(struct arch_thread *from,
                                     struct arch_thread *to)
 {
+	to->fs = from->fs;
 }
 
 #include "asm/arch/user.h"

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
