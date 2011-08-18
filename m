Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7th-0002s9-2E
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:04:57 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7tg-0002Md-8s
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:04:57 +0000
Date: Thu, 18 Aug 2011 20:04:49 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7tZ-0007gB-Fi@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 35/91] um: take system.h out of
	shared/sysdep
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/include/asm/{system.h => system-um.h}   |    2 --
 arch/um/sys-x86/{shared/sysdep => asm}/system.h |    1 +
 2 files changed, 1 insertions(+), 2 deletions(-)
 rename arch/um/include/asm/{system.h => system-um.h} (96%)
 rename arch/um/sys-x86/{shared/sysdep => asm}/system.h (99%)

diff --git a/arch/um/include/asm/system.h b/arch/um/include/asm/system-um.h
similarity index 96%
rename from arch/um/include/asm/system.h
rename to arch/um/include/asm/system-um.h
index 68a90ec..0eec245 100644
--- a/arch/um/include/asm/system.h
+++ b/arch/um/include/asm/system-um.h
@@ -1,8 +1,6 @@
 #ifndef __UM_SYSTEM_GENERIC_H
 #define __UM_SYSTEM_GENERIC_H
 
-#include "sysdep/system.h"
-
 extern int get_signals(void);
 extern int set_signals(int enable);
 extern void block_signals(void);
diff --git a/arch/um/sys-x86/shared/sysdep/system.h b/arch/um/sys-x86/asm/system.h
similarity index 99%
rename from arch/um/sys-x86/shared/sysdep/system.h
rename to arch/um/sys-x86/asm/system.h
index d1b93c4..a89113b 100644
--- a/arch/um/sys-x86/shared/sysdep/system.h
+++ b/arch/um/sys-x86/asm/system.h
@@ -6,6 +6,7 @@
 #include <asm/cpufeature.h>
 #include <asm/cmpxchg.h>
 #include <asm/nops.h>
+#include <asm/system-um.h>
 
 #include <linux/kernel.h>
 #include <linux/irqflags.h>
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

