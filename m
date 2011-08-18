Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7tr-0007vN-4a
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:05:07 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7tq-00009D-Cg
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:05:07 +0000
Date: Thu, 18 Aug 2011 20:04:59 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7tj-0007gP-Fy@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 36/91] um: take userland definition of
 barrier() to user.h
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/include/shared/process.h |    3 ---
 arch/um/include/shared/user.h    |    3 +++
 arch/um/os-Linux/signal.c        |    3 ---
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/um/include/shared/process.h b/arch/um/include/shared/process.h
index bb873a5..2821530 100644
--- a/arch/um/include/shared/process.h
+++ b/arch/um/include/shared/process.h
@@ -8,9 +8,6 @@
 
 #include <signal.h>
 
-/* Copied from linux/compiler-gcc.h since we can't include it directly */
-#define barrier() __asm__ __volatile__("": : :"memory")
-
 extern void sig_handler(int sig, struct sigcontext *sc);
 extern void alarm_handler(int sig, struct sigcontext *sc);
 
diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/user.h
index 58c0581..4fa82c0 100644
--- a/arch/um/include/shared/user.h
+++ b/arch/um/include/shared/user.h
@@ -40,4 +40,7 @@ extern int in_aton(char *str);
 extern size_t strlcpy(char *, const char *, size_t);
 extern size_t strlcat(char *, const char *, size_t);
 
+/* Copied from linux/compiler-gcc.h since we can't include it directly */
+#define barrier() __asm__ __volatile__("": : :"memory")
+
 #endif
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index c4a4e20..08d3061 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -16,9 +16,6 @@
 #include "sysdep/barrier.h"
 #include "sysdep/sigcontext.h"
 
-/* Copied from linux/compiler-gcc.h since we can't include it directly */
-#define barrier() __asm__ __volatile__("": : :"memory")
-
 void (*sig_info[NSIG])(int, struct uml_pt_regs *) = {
 	[SIGTRAP]	= relay_signal,
 	[SIGFPE]	= relay_signal,
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

