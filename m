Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDncJ-0005Zh-Dq for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 09:56:35 -0800
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DDncI-0004GC-FW for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 09:56:34 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050322162118.C3CA4A8A0@zion>
Subject: [uml-devel] [patch 01/12] uml: fix compile
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
Date: Tue, 22 Mar 2005 17:21:13 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


Quick compile fix for i386-only change (which interacts with UML since we
include headers from include/asm-$(SUBARCH)), which keeps the old behaviour
and hence should cause no problems.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/include/asm-um/signal.h |    3 +++
 1 files changed, 3 insertions(+)

diff -puN include/asm-um/signal.h~uml-fix-compile include/asm-um/signal.h
--- linux-2.6.11/include/asm-um/signal.h~uml-fix-compile	2005-03-21 20:13:13.000000000 +0100
+++ linux-2.6.11-paolo/include/asm-um/signal.h	2005-03-21 20:13:13.000000000 +0100
@@ -11,6 +11,9 @@
 #define do_signal do_signal_renamed
 #include "asm/arch/signal.h"
 #undef do_signal
+#undef ptrace_signal_deliver
+
+#define ptrace_signal_deliver(regs, cookie) do {} while(0)
 
 #endif
 
_


-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
