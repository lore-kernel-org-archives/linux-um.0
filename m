Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7yh-00089V-GO
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:10:07 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7yg-00052r-Pv
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:10:07 +0000
Date: Thu, 18 Aug 2011 20:09:59 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7yZ-0007wi-RH@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 66/91] um: sanitize paths in
 sys_call_table* includes
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/um/sys_call_table_32.S |    2 +-
 arch/x86/um/sys_call_table_64.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/um/sys_call_table_32.S b/arch/x86/um/sys_call_table_32.S
index de27407..c3431cf 100644
--- a/arch/x86/um/sys_call_table_32.S
+++ b/arch/x86/um/sys_call_table_32.S
@@ -22,7 +22,7 @@
 
 .section .rodata,"a"
 
-#include "../../x86/kernel/syscall_table_32.S"
+#include "../kernel/syscall_table_32.S"
 
 ENTRY(syscall_table_size)
 .long .-sys_call_table
diff --git a/arch/x86/um/sys_call_table_64.c b/arch/x86/um/sys_call_table_64.c
index f46de82..99522f7 100644
--- a/arch/x86/um/sys_call_table_64.c
+++ b/arch/x86/um/sys_call_table_64.c
@@ -58,7 +58,7 @@ extern void sys_ni_syscall(void);
  */
 
 sys_call_ptr_t sys_call_table[] __cacheline_aligned = {
-#include "../../x86/include/asm/unistd_64.h"
+#include <asm/unistd_64.h>
 };
 
 int syscall_table_size = sizeof(sys_call_table);
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

