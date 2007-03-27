Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HWN7u-0002oh-0E for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Mar 2007 18:39:02 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HWGRW-0004B1-Kh
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Mar 2007 11:30:51 -0700
Date: Tue, 27 Mar 2007 14:27:46 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070327182746.GA8395@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/6] i386 - fix cmpxchg warning
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
To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

I started getting warnings from atomic.h about cmpxchg not having a
prototype.  It's declared in system.h, so including that fixes the UML
build warnings and has no noticable ill effects on the i386 build.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 include/asm-i386/atomic.h |    1 +
 1 file changed, 1 insertion(+)

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--

Index: linux-2.6.21-mm/include/asm-i386/atomic.h
===================================================================
--- linux-2.6.21-mm.orig/include/asm-i386/atomic.h	2007-03-27 12:25:16.000000000 -0400
+++ linux-2.6.21-mm/include/asm-i386/atomic.h	2007-03-27 12:26:38.000000000 -0400
@@ -3,6 +3,7 @@
 
 #include <linux/compiler.h>
 #include <asm/processor.h>
+#include <asm/system.h>
 
 /*
  * Atomic operations that C can't guarantee us.  Useful for

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
