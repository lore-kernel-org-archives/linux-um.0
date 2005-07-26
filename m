Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DxVpa-0005nW-Ke	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Jul 2005 13:15:14 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1DxVpX-0000qA-94
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Jul 2005 13:15:14 -0700
Message-Id: <200507262003.j6QK3oZU010061@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/4] UML - Fix rc3-mm1 build
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
Date: Tue, 26 Jul 2005 16:03:50 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, olh@suse.de

From: Olaf Hering <olh@suse.de>

New in 2.6.13-rc3-git4:

scripts/Makefile.build:13: /Makefile: No such file or directory
scripts/Makefile.build:64: kbuild: Makefile.build is included improperly

the define was removed, but its still required to build some targets.

Signed-off-by: Olaf Hering <olh@suse.de>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/Makefile-i386
===================================================================
--- linux-2.6.12.orig/arch/um/Makefile-i386	2005-07-18 11:53:17.000000000 -0400
+++ linux-2.6.12/arch/um/Makefile-i386	2005-07-18 11:54:30.000000000 -0400
@@ -33,6 +33,7 @@
 ARCH_CFLAGS += -DUM_FASTCALL
 endif
 
+SYS_UTIL_DIR	:= $(ARCH_DIR)/sys-i386/util
 SYS_HEADERS	:= $(SYS_DIR)/sc.h $(SYS_DIR)/thread.h
 
 prepare: $(SYS_HEADERS)



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
