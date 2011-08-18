Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7rG-0007bH-TZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:02:26 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7rG-0002BL-4x
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:02:26 +0000
Date: Thu, 18 Aug 2011 20:02:19 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7r9-0007Yf-9F@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 20/91] um: take vm-flags.h to sys-*/asm
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/include/asm/page.h                         |    2 +-
 arch/um/sys-i386/{shared/sysdep => asm}/vm-flags.h |    0
 .../sys-x86_64/{shared/sysdep => asm}/vm-flags.h   |    0
 3 files changed, 1 insertions(+), 1 deletions(-)
 rename arch/um/sys-i386/{shared/sysdep => asm}/vm-flags.h (100%)
 rename arch/um/sys-x86_64/{shared/sysdep => asm}/vm-flags.h (100%)

diff --git a/arch/um/include/asm/page.h b/arch/um/include/asm/page.h
index 4cc9b6c..7cfc3ce 100644
--- a/arch/um/include/asm/page.h
+++ b/arch/um/include/asm/page.h
@@ -19,7 +19,7 @@
 struct page;
 
 #include <linux/types.h>
-#include <sysdep/vm-flags.h>
+#include <asm/vm-flags.h>
 
 /*
  * These are used to make use of C type-checking..
diff --git a/arch/um/sys-i386/shared/sysdep/vm-flags.h b/arch/um/sys-i386/asm/vm-flags.h
similarity index 100%
rename from arch/um/sys-i386/shared/sysdep/vm-flags.h
rename to arch/um/sys-i386/asm/vm-flags.h
diff --git a/arch/um/sys-x86_64/shared/sysdep/vm-flags.h b/arch/um/sys-x86_64/asm/vm-flags.h
similarity index 100%
rename from arch/um/sys-x86_64/shared/sysdep/vm-flags.h
rename to arch/um/sys-x86_64/asm/vm-flags.h
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

