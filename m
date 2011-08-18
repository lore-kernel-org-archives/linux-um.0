Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7r7-0007ZS-4y
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:02:17 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7r6-0003k3-B1
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:02:17 +0000
Date: Thu, 18 Aug 2011 20:02:09 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7qz-0007YJ-92@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 19/91] um: get rid of sysdep/checksum.h
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Move those to sys-.../asm/checksum.h, kill include/asm/checksum.h

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/include/asm/checksum.h                     |    6 ------
 arch/um/sys-i386/{shared/sysdep => asm}/checksum.h |    2 +-
 .../sys-x86_64/{shared/sysdep => asm}/checksum.h   |    0
 3 files changed, 1 insertions(+), 7 deletions(-)
 delete mode 100644 arch/um/include/asm/checksum.h
 rename arch/um/sys-i386/{shared/sysdep => asm}/checksum.h (99%)
 rename arch/um/sys-x86_64/{shared/sysdep => asm}/checksum.h (100%)

diff --git a/arch/um/include/asm/checksum.h b/arch/um/include/asm/checksum.h
deleted file mode 100644
index 5b50136..0000000
--- a/arch/um/include/asm/checksum.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __UM_CHECKSUM_H
-#define __UM_CHECKSUM_H
-
-#include "sysdep/checksum.h"
-
-#endif
diff --git a/arch/um/sys-i386/shared/sysdep/checksum.h b/arch/um/sys-i386/asm/checksum.h
similarity index 99%
rename from arch/um/sys-i386/shared/sysdep/checksum.h
rename to arch/um/sys-i386/asm/checksum.h
index ed47445..caab742 100644
--- a/arch/um/sys-i386/shared/sysdep/checksum.h
+++ b/arch/um/sys-i386/asm/checksum.h
@@ -1,4 +1,4 @@
-/* 
+/*
  * Licensed under the GPL
  */
 
diff --git a/arch/um/sys-x86_64/shared/sysdep/checksum.h b/arch/um/sys-x86_64/asm/checksum.h
similarity index 100%
rename from arch/um/sys-x86_64/shared/sysdep/checksum.h
rename to arch/um/sys-x86_64/asm/checksum.h
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

