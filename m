Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7z1-0003Qh-Gy
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:10:27 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7z0-00053r-QC
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:10:27 +0000
Date: Thu, 18 Aug 2011 20:10:19 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7yt-0007xO-Rm@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 68/91] um: increase stack growth
 cushion in pagefault
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


analog of [PATCH] i386: let usermode execute the "enter" instruction from
circa 2006.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/um/asm/processor.h    |    3 +++
 arch/x86/um/asm/processor_32.h |    3 ---
 arch/x86/um/asm/processor_64.h |    3 ---
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/um/asm/processor.h b/arch/x86/um/asm/processor.h
index d3ac1ce..f34c4b2 100644
--- a/arch/x86/um/asm/processor.h
+++ b/arch/x86/um/asm/processor.h
@@ -10,6 +10,9 @@
 # include "processor_64.h"
 #endif
 
+#define ARCH_IS_STACKGROW(address) \
+       (address + 65536 + 32 * sizeof(unsigned long) >= UPT_SP(&current->thread.regs.regs))
+
 #include <asm/processor-generic.h>
 
 #endif
diff --git a/arch/x86/um/asm/processor_32.h b/arch/x86/um/asm/processor_32.h
index ae0d189..e5b72fa 100644
--- a/arch/x86/um/asm/processor_32.h
+++ b/arch/x86/um/asm/processor_32.h
@@ -63,9 +63,6 @@ static inline void rep_nop(void)
 #define current_text_addr() \
 	({ void *pc; __asm__("movl $1f,%0\n1:":"=g" (pc)); pc; })
 
-#define ARCH_IS_STACKGROW(address) \
-       (address + 32 >= UPT_SP(&current->thread.regs.regs))
-
 #define KSTK_EIP(tsk) KSTK_REG(tsk, EIP)
 #define KSTK_ESP(tsk) KSTK_REG(tsk, UESP)
 #define KSTK_EBP(tsk) KSTK_REG(tsk, EBP)
diff --git a/arch/x86/um/asm/processor_64.h b/arch/x86/um/asm/processor_64.h
index 6db812b..0186c61 100644
--- a/arch/x86/um/asm/processor_64.h
+++ b/arch/x86/um/asm/processor_64.h
@@ -42,9 +42,6 @@ static inline void arch_copy_thread(struct arch_thread *from,
 #define current_text_addr() \
 	({ void *pc; __asm__("movq $1f,%0\n1:":"=g" (pc)); pc; })
 
-#define ARCH_IS_STACKGROW(address) \
-        (address + 128 >= UPT_SP(&current->thread.regs.regs))
-
 #define KSTK_EIP(tsk) KSTK_REG(tsk, RIP)
 #define KSTK_ESP(tsk) KSTK_REG(tsk, RSP)
 
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

