Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CiGAn-0000Uz-Te for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 25 Dec 2004 09:57:49 -0800
Received: from coderock.org
	([193.77.147.115] helo=trashy.coderock.org ident=postfix)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CiGAn-0001RR-B9 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 25 Dec 2004 09:57:49 -0800
From: domen@coderock.org
Message-Id: <20041225175741.C500A1F125@trashy.coderock.org>
Subject: [uml-devel] [patch 08/13] delete unused file
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
Date: Sat, 25 Dec 2004 18:57:52 +0100
To: jdike@karaya.com
Cc: user-mode-linux-devel@lists.sourceforge.net, domen@coderock.org


Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj/include/asm-um/processor-ppc.h |   15 ---------------
 1 files changed, 15 deletions(-)

diff -L include/asm-um/processor-ppc.h -puN include/asm-um/processor-ppc.h~remove_file-include_asm_um_processor_ppc.h /dev/null
--- kj/include/asm-um/processor-ppc.h
+++ /dev/null	2004-12-24 01:21:08.000000000 +0100
@@ -1,15 +0,0 @@
-#ifndef __UM_PROCESSOR_PPC_H
-#define __UM_PROCESSOR_PPC_H
-
-#if defined(__ASSEMBLY__)
-
-#define CONFIG_PPC_MULTIPLATFORM
-#include "arch/processor.h"
-
-#else
-
-#include "asm/processor-generic.h"
-
-#endif
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
