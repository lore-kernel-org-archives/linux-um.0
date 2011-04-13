Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <richard@nod.at>) id 1Q9zOi-0008Ch-W3
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Apr 2011 12:42:16 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.74) id 1Q9zOc-0005Iw-UR
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Apr 2011 12:42:16 +0000
From: Richard Weinberger <richard@nod.at>
Date: Wed, 13 Apr 2011 14:41:51 +0200
Message-Id: <1302698512-11979-1-git-send-email-richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 1/2] um: Fix call tracer and bug handler
To: akpm@linux-foundation.com
Cc: Richard Weinberger <richard@nod.at>, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Commit 1de1502c (x86, um: now we can get rid of trivial uml headers)
removed accidentally bug.h which broke UML's call tracer and
bug handler.
Without asm-generic/bug.h UML uses BUG() from arch/x86/
which makes use of ud2.
UML cannot use ud2, it raises SIGILL in user mode.
As UML has a different stack for handling signals the call trace
will be cut off.

Reported-by: Sergei Trofimovich <slyich@gmail.com>
Tested-by: Sergei Trofimovich <slyich@gmail.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/include/asm/bug.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)
 create mode 100644 arch/um/include/asm/bug.h

diff --git a/arch/um/include/asm/bug.h b/arch/um/include/asm/bug.h
new file mode 100644
index 0000000..9e33b86
--- /dev/null
+++ b/arch/um/include/asm/bug.h
@@ -0,0 +1,6 @@
+#ifndef __UM_BUG_H
+#define __UM_BUG_H
+
+#include <asm-generic/bug.h>
+
+#endif
-- 
1.6.6.1


------------------------------------------------------------------------------
Forrester Wave Report - Recovery time is now measured in hours and minutes
not days. Key insights are discussed in the 2010 Forrester Wave Report as
part of an in-depth evaluation of disaster recovery service providers.
Forrester found the best-in-class provider in terms of services and vision.
Read this report now!  http://p.sf.net/sfu/ibm-webcastpromo
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

