Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzHSA-0001cL-2L for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 08:46:06 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CzHS7-0006bA-WC for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 08:46:05 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050210164037.E43784B51@zion>
Subject: [uml-devel] [patch 1/1] Uml: fix makefile typo [before 2.6.11]
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
Date: Thu, 10 Feb 2005 17:40:37 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Jeff Dike <jdike@addtoit.com>

Fix a typo in the Makefile cleanup merged earlier, which causes compile
failures in some edge cases.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/um/Makefile~uml-fix-mode-makefile arch/um/Makefile
--- linux-2.6.11/arch/um/Makefile~uml-fix-mode-makefile	2005-02-10 17:38:46.273481568 +0100
+++ linux-2.6.11-paolo/arch/um/Makefile	2005-02-10 17:38:46.276481112 +0100
@@ -39,8 +39,8 @@ MODE_INCLUDE	+= $(foreach mode,$(um-mode
 MAKEFILES-INCL	+= $(foreach mode,$(um-modes-y),\
 		   $(srctree)/$(ARCH_DIR)/Makefile-$(mode))
 
-ifneq ($(MAKEFILE-INCL),)
-  include $(MAKEFILE-INCL)
+ifneq ($(MAKEFILES-INCL),)
+  include $(MAKEFILES-INCL)
 endif
 
 ARCH_INCLUDE	:= -I$(ARCH_DIR)/include
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
