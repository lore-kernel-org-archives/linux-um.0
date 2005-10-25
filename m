Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUX0q-00051k-HF	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 15:11:20 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EUX0p-0000Yv-4O
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 15:11:20 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051025221351.21106.57194.stgit@zion.home.lan>
In-Reply-To: <20051025221105.21106.95194.stgit@zion.home.lan>
References: <20051025221105.21106.95194.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 6/6] x86_64: enable xchg optimization for x86_64
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 26 Oct 2005 00:13:52 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

i386 enables the xchg based implementation of r/w semaphores for any processor
as good as 486. So it was quite interesting to see x86_64 never using it! And it
was even more interesting to see, in rwsem.h:

/* rwsem.h: R/W semaphores implemented using XADD/CMPXCHG for x86_64+
 *
 * Written by David Howells (dhowells@redhat.com).
 * Ported by Andi Kleen <ak@suse.de> to x86-64.

I.e. the implementation was written, is present in the tree, but due to this:

#ifdef CONFIG_RWSEM_GENERIC_SPINLOCK
#include <linux/rwsem-spinlock.h> /* use a generic implementation */
#else
#include <asm/rwsem.h> /* use an arch-specific implementation */
#endif

it was probably _NEVER_ compiled!!!

So, handle with care this one-liner, and test it properly.

CC: Andi Kleen <ak@suse.de>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/x86_64/Kconfig |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -39,11 +39,10 @@ config SBUS
 	bool
 
 config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y
+	def_bool n
 
 config RWSEM_XCHGADD_ALGORITHM
-	bool
+	def_bool y
 
 config GENERIC_CALIBRATE_DELAY
 	bool



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
