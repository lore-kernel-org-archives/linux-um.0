Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7qc-0006lA-QL
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:01:46 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7qc-0003is-1w
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:01:46 +0000
Date: Thu, 18 Aug 2011 20:01:39 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7qV-0007Xh-8M@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 16/91] um: kill a couple of useless
 includes of kern_constants.h
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/sys-x86_64/shared/sysdep/syscalls.h |    1 -
 arch/um/sys-x86_64/syscall_table.c          |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/um/sys-x86_64/shared/sysdep/syscalls.h b/arch/um/sys-x86_64/shared/sysdep/syscalls.h
index 7cfb0b0..8a7d5e1 100644
--- a/arch/um/sys-x86_64/shared/sysdep/syscalls.h
+++ b/arch/um/sys-x86_64/shared/sysdep/syscalls.h
@@ -9,7 +9,6 @@
 
 #include <linux/msg.h>
 #include <linux/shm.h>
-#include <kern_constants.h>
 
 typedef long syscall_handler_t(void);
 
diff --git a/arch/um/sys-x86_64/syscall_table.c b/arch/um/sys-x86_64/syscall_table.c
index 47d469e..f46de82 100644
--- a/arch/um/sys-x86_64/syscall_table.c
+++ b/arch/um/sys-x86_64/syscall_table.c
@@ -6,7 +6,6 @@
 #include <linux/linkage.h>
 #include <linux/sys.h>
 #include <linux/cache.h>
-#include <kern_constants.h>
 
 #define __NO_STUBS
 
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

