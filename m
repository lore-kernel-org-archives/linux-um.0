Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu825-0003qK-V2
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:13:37 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu825-0000Qm-2z
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:13:37 +0000
Date: Thu, 18 Aug 2011 20:13:30 +0100
MIME-Version: 1.0
Message-Id: <E1Qu81y-00088a-2D@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] Subject: [PATCH 87/91] um: asm/pda.h is not needed
	anymore
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/include/asm/pda.h |   21 ---------------------
 1 files changed, 0 insertions(+), 21 deletions(-)
 delete mode 100644 arch/um/include/asm/pda.h

diff --git a/arch/um/include/asm/pda.h b/arch/um/include/asm/pda.h
deleted file mode 100644
index ddcd774..0000000
--- a/arch/um/include/asm/pda.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * Copyright 2003 PathScale, Inc.
- *
- * Licensed under the GPL
- */
-
-#ifndef __UM_PDA_X86_64_H
-#define __UM_PDA_X86_64_H
-
-/* XXX */
-struct foo {
-	unsigned int __softirq_pending;
-	unsigned int __nmi_count;
-};
-
-extern struct foo me;
-
-#define read_pda(me) (&me)
-
-#endif
-
-- 
1.7.2.5



------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

