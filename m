Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CiGAw-0000bx-W3 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 25 Dec 2004 09:57:58 -0800
Received: from coderock.org
	([193.77.147.115] helo=trashy.coderock.org ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CiGAw-0004IY-FO for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 25 Dec 2004 09:57:58 -0800
From: domen@coderock.org
Message-Id: <20041225175752.BFBF71ED41@trashy.coderock.org>
Subject: [uml-devel] [patch 11/13] delete unused file
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
Date: Sat, 25 Dec 2004 18:58:03 +0100
To: jdike@karaya.com
Cc: user-mode-linux-devel@lists.sourceforge.net, domen@coderock.org


Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj/include/asm-um/sigcontext-ppc.h |   10 ----------
 1 files changed, 10 deletions(-)

diff -L include/asm-um/sigcontext-ppc.h -puN include/asm-um/sigcontext-ppc.h~remove_file-include_asm_um_sigcontext_ppc.h /dev/null
--- kj/include/asm-um/sigcontext-ppc.h
+++ /dev/null	2004-12-24 01:21:08.000000000 +0100
@@ -1,10 +0,0 @@
-#ifndef __UM_SIGCONTEXT_PPC_H
-#define __UM_SIGCONTEXT_PPC_H
-
-#define pt_regs sys_pt_regs
-
-#include "asm/sigcontext-generic.h"
-
-#undef pt_regs
-
-#endif
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
