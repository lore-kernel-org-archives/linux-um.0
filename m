Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHALh-0002I5-NE for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:17:05 -0700
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CHALa-0008Gr-KP for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:17:05 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041012001629.0C80B868D@zion.localdomain>
Subject: [uml-devel] [patch 3/6] uml: finish update for 2.6.8 API changes
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
Date: Tue, 12 Oct 2004 02:16:28 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Add some updates for API changes in 2.6.8 which were not included in the original
UML patch; these fixes were detected by some warnings, so I probably missed some more
ones.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/include/asm-um/dma-mapping.h |    2 ++
 1 files changed, 2 insertions(+)

diff -puN include/asm-um/dma-mapping.h~uml-update-2.6.8-finish include/asm-um/dma-mapping.h
--- linux-2.6.9-current/include/asm-um/dma-mapping.h~uml-update-2.6.8-finish	2004-10-12 01:06:00.296443160 +0200
+++ linux-2.6.9-current-paolo/include/asm-um/dma-mapping.h	2004-10-12 01:06:00.298442856 +0200
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
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
