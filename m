Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu81v-0000DU-RS
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:13:27 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu81v-00047W-4B
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:13:27 +0000
Date: Thu, 18 Aug 2011 20:13:20 +0100
MIME-Version: 1.0
Message-Id: <E1Qu81o-00088K-1x@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 86/91] um: hw_irq.h can go generic as
	well
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/include/asm/Kbuild   |    2 +-
 arch/um/include/asm/hw_irq.h |    7 -------
 2 files changed, 1 insertions(+), 8 deletions(-)
 delete mode 100644 arch/um/include/asm/hw_irq.h

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index e16895d..5962826 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -1,2 +1,2 @@
 generic-y += bug.h cputime.h device.h emergency-restart.h futex.h hardirq.h
-generic-y += irq_regs.h kdebug.h percpu.h sections.h topology.h xor.h
+generic-y += hw_irq.h irq_regs.h kdebug.h percpu.h sections.h topology.h xor.h
diff --git a/arch/um/include/asm/hw_irq.h b/arch/um/include/asm/hw_irq.h
deleted file mode 100644
index 1cf84cf..0000000
--- a/arch/um/include/asm/hw_irq.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef _ASM_UM_HW_IRQ_H
-#define _ASM_UM_HW_IRQ_H
-
-#include "asm/irq.h"
-#include "asm/archparam.h"
-
-#endif
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

