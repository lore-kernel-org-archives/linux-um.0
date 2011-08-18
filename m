Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu80n-0002Tc-MH
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:12:17 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu80m-00045D-Up
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:12:17 +0000
Date: Thu, 18 Aug 2011 20:12:09 +0100
MIME-Version: 1.0
Message-Id: <E1Qu80f-00083z-Uy@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 79/91] um: unify KSTK_...
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


... and switch get_thread_register() to HOST_... for register numbers

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/um/asm/processor.h      |    4 ++++
 arch/x86/um/asm/processor_32.h   |    4 ----
 arch/x86/um/asm/processor_64.h   |    3 ---
 arch/x86/um/os-Linux/registers.c |   12 ++++++------
 4 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/x86/um/asm/processor.h b/arch/x86/um/asm/processor.h
index f34c4b2..118c143 100644
--- a/arch/x86/um/asm/processor.h
+++ b/arch/x86/um/asm/processor.h
@@ -10,6 +10,10 @@
 # include "processor_64.h"
 #endif
 
+#define KSTK_EIP(tsk) KSTK_REG(tsk, HOST_IP)
+#define KSTK_ESP(tsk) KSTK_REG(tsk, HOST_IP)
+#define KSTK_EBP(tsk) KSTK_REG(tsk, HOST_BP)
+
 #define ARCH_IS_STACKGROW(address) \
        (address + 65536 + 32 * sizeof(unsigned long) >= UPT_SP(&current->thread.regs.regs))
 
diff --git a/arch/x86/um/asm/processor_32.h b/arch/x86/um/asm/processor_32.h
index c4078b5..018f732 100644
--- a/arch/x86/um/asm/processor_32.h
+++ b/arch/x86/um/asm/processor_32.h
@@ -63,8 +63,4 @@ static inline void rep_nop(void)
 #define current_text_addr() \
 	({ void *pc; __asm__("movl $1f,%0\n1:":"=g" (pc)); pc; })
 
-#define KSTK_EIP(tsk) KSTK_REG(tsk, EIP)
-#define KSTK_ESP(tsk) KSTK_REG(tsk, UESP)
-#define KSTK_EBP(tsk) KSTK_REG(tsk, EBP)
-
 #endif
diff --git a/arch/x86/um/asm/processor_64.h b/arch/x86/um/asm/processor_64.h
index 0186c61..61de92d 100644
--- a/arch/x86/um/asm/processor_64.h
+++ b/arch/x86/um/asm/processor_64.h
@@ -42,7 +42,4 @@ static inline void arch_copy_thread(struct arch_thread *from,
 #define current_text_addr() \
 	({ void *pc; __asm__("movq $1f,%0\n1:":"=g" (pc)); pc; })
 
-#define KSTK_EIP(tsk) KSTK_REG(tsk, RIP)
-#define KSTK_ESP(tsk) KSTK_REG(tsk, RSP)
-
 #endif
diff --git a/arch/x86/um/os-Linux/registers.c b/arch/x86/um/os-Linux/registers.c
index 3a9b624..fa2e5a6 100644
--- a/arch/x86/um/os-Linux/registers.c
+++ b/arch/x86/um/os-Linux/registers.c
@@ -89,18 +89,18 @@ unsigned long get_thread_reg(int reg, jmp_buf *buf)
 {
 	switch (reg) {
 #ifdef __i386__
-	case EIP:
+	case HOST_IP:
 		return buf[0]->__eip;
-	case UESP:
+	case HOST_SP:
 		return buf[0]->__esp;
-	case EBP:
+	case HOST_BP:
 		return buf[0]->__ebp;
 #else
-	case RIP:
+	case HOST_IP:
 		return buf[0]->__rip;
-	case RSP:
+	case HOST_SP:
 		return buf[0]->__rsp;
-	case RBP:
+	case HOST_BP:
 		return buf[0]->__rbp;
 #endif
 	default:
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

