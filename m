Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7uV-0007zW-9Z
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:05:47 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7uU-0003sB-FZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:05:47 +0000
Date: Thu, 18 Aug 2011 20:05:39 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7uN-0007jc-JI@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 40/91] um: sysdep/barrier.h is not used
 for anything
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/os-Linux/signal.c                  |    1 -
 arch/um/sys-x86/shared/sysdep/barrier.h    |    5 -----
 arch/um/sys-x86/shared/sysdep/barrier_32.h |    9 ---------
 arch/um/sys-x86/shared/sysdep/barrier_64.h |    7 -------
 4 files changed, 0 insertions(+), 22 deletions(-)
 delete mode 100644 arch/um/sys-x86/shared/sysdep/barrier.h
 delete mode 100644 arch/um/sys-x86/shared/sysdep/barrier_32.h
 delete mode 100644 arch/um/sys-x86/shared/sysdep/barrier_64.h

diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 4d31688..2d22f1f 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -12,7 +12,6 @@
 #include "as-layout.h"
 #include "kern_util.h"
 #include "os.h"
-#include "sysdep/barrier.h"
 #include "sysdep/mcontext.h"
 
 void (*sig_info[NSIG])(int, struct uml_pt_regs *) = {
diff --git a/arch/um/sys-x86/shared/sysdep/barrier.h b/arch/um/sys-x86/shared/sysdep/barrier.h
deleted file mode 100644
index 89ee23b..0000000
--- a/arch/um/sys-x86/shared/sysdep/barrier.h
+++ /dev/null
@@ -1,5 +0,0 @@
-#ifdef __i386__
-#include "barrier_32.h"
-#else
-#include "barrier_64.h"
-#endif
diff --git a/arch/um/sys-x86/shared/sysdep/barrier_32.h b/arch/um/sys-x86/shared/sysdep/barrier_32.h
deleted file mode 100644
index b58d52c..0000000
--- a/arch/um/sys-x86/shared/sysdep/barrier_32.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef __SYSDEP_I386_BARRIER_H
-#define __SYSDEP_I386_BARRIER_H
-
-/* Copied from include/asm-i386 for use by userspace.  i386 has the option
- * of using mfence, but I'm just using this, which works everywhere, for now.
- */
-#define mb() asm volatile("lock; addl $0,0(%esp)")
-
-#endif
diff --git a/arch/um/sys-x86/shared/sysdep/barrier_64.h b/arch/um/sys-x86/shared/sysdep/barrier_64.h
deleted file mode 100644
index 7b610be..0000000
--- a/arch/um/sys-x86/shared/sysdep/barrier_64.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __SYSDEP_X86_64_BARRIER_H
-#define __SYSDEP_X86_64_BARRIER_H
-
-/* Copied from include/asm-x86_64 for use by userspace. */
-#define mb() 	asm volatile("mfence":::"memory")
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

