Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5Sut-0002Fm-RX for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 10:41:03 -0700
Received: from mail-relay-1.tiscali.it ([213.205.33.41])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C5Suq-0004Q4-Cl for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 10:41:02 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20040908173855.68F518D0B@zion.localdomain>
Subject: [uml-devel] [patch 1/1] uml-update-2.6.8-finish
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
Date: Wed, 08 Sep 2004 19:38:55 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Add some updates for API changes in 2.6.8 which were not included in the original
UML patch; these fixes were detected by some warnings, so I probably missed some more
ones.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/include/asm-um/dma-mapping.h |    2 ++
 1 files changed, 2 insertions(+)

diff -puN include/asm-um/dma-mapping.h~uml-update-2.6.8-finish include/asm-um/dma-mapping.h
--- uml-linux-2.6.8.1/include/asm-um/dma-mapping.h~uml-update-2.6.8-finish	2004-09-07 15:17:57.593456048 +0200
+++ uml-linux-2.6.8.1-paolo/include/asm-um/dma-mapping.h	2004-09-07 15:17:57.595455744 +0200
@@ -1,6 +1,8 @@
 #ifndef _ASM_DMA_MAPPING_H
 #define _ASM_DMA_MAPPING_H
 
+#include <asm/scatterlist.h>
+
 static inline int
 dma_supported(struct device *dev, u64 mask)
 {
_


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
