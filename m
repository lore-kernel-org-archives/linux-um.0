Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DqYdP-0001Fp-PP	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jul 2005 08:49:55 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx1-new.sourceforge.net with esmtp (Exim 4.44)
	id 1DqYdM-0000sQ-Rt	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jul 2005 08:49:55 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050707155353.2AC3521AD6C@zion.home.lan>
Subject: [uml-devel] [patch 1/1] uml:remove user_constants.h on clean
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
Date: Thu, 07 Jul 2005 17:53:50 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

make clean ARCH=um does not remove the generated file
arch/um/include/user_constants.h, fix this.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/um/Makefile~uml-remove-user-constants_h arch/um/Makefile
--- linux-2.6.git/arch/um/Makefile~uml-remove-user-constants_h	2005-07-07 17:52:09.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/Makefile	2005-07-07 17:52:09.000000000 +0200
@@ -140,7 +140,8 @@ endef
 #When cleaning we don't include .config, so we don't include
 #TT or skas makefiles and don't clean skas_ptregs.h.
 CLEAN_FILES += linux x.i gmon.out $(ARCH_DIR)/include/uml-config.h \
-	$(GEN_HEADERS) $(ARCH_DIR)/include/skas_ptregs.h
+	$(GEN_HEADERS) $(ARCH_DIR)/include/skas_ptregs.h \
+	$(ARCH_DIR)/include/user_constants.h
 
 MRPROPER_FILES += $(SYMLINK_HEADERS) $(ARCH_SYMLINKS) \
 	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS)) $(ARCH_DIR)/os \
_


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
