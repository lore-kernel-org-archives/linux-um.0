Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOM0E-0002Bh-H2 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 14:49:58 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HOM0C-0005Xx-Ur
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 14:49:58 -0800
Message-Id: <200703052241.l25MfKju008425@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 05 Mar 2007 17:41:20 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/4] linux/audit.h needs linux/types.h
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
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Include linux/types.h here because we need a definition of __u32.  This file
appears not be exported verbatim by libc, so I think this doesn't have any
userspace consequences.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 include/linux/audit.h |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.18-mm/include/linux/audit.h
===================================================================
--- linux-2.6.18-mm.orig/include/linux/audit.h	2007-02-20 16:16:03.000000000 -0500
+++ linux-2.6.18-mm/include/linux/audit.h	2007-02-20 16:16:25.000000000 -0500
@@ -24,6 +24,7 @@
 #ifndef _LINUX_AUDIT_H_
 #define _LINUX_AUDIT_H_
 
+#include <linux/types.h>
 #include <linux/elf-em.h>
 
 /* The netlink messages for the audit system is divided into blocks:


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
