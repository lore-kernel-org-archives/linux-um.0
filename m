Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7u1-0007Pz-FG
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:05:17 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7u0-0004sg-K7
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:05:17 +0000
Date: Thu, 18 Aug 2011 20:05:09 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7tt-0007gc-GD@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 37/91] um: start switching the
	references to host mcontext_t to its userland type
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/include/shared/process.h              |    5 ---
 arch/um/os-Linux/internal.h                   |    1 +
 arch/um/os-Linux/signal.c                     |   35 +++++++++++-------------
 arch/um/os-Linux/time.c                       |    2 +-
 arch/um/sys-x86/shared/sysdep/sigcontext_32.h |    7 +++++
 arch/um/sys-x86/shared/sysdep/sigcontext_64.h |    7 +++++
 arch/um/sys-x86/stub_segv.c                   |    2 +-
 7 files changed, 33 insertions(+), 26 deletions(-)
 create mode 100644 arch/um/os-Linux/internal.h

diff --git a/arch/um/include/shared/process.h b/arch/um/include/shared/process.h
index 2821530..2ba310e 100644
--- a/arch/um/include/shared/process.h
+++ b/arch/um/include/shared/process.h
@@ -6,9 +6,4 @@
 #ifndef __PROCESS_H__
 #define __PROCESS_H__
 
-#include <signal.h>
-
-extern void sig_handler(int sig, struct sigcontext *sc);
-extern void alarm_handler(int sig, struct sigcontext *sc);
-
 #endif
diff --git a/arch/um/os-Linux/internal.h b/arch/um/os-Linux/internal.h
new file mode 100644
index 0000000..2c3c3ec
--- /dev/null
+++ b/arch/um/os-Linux/internal.h
@@ -0,0 +1 @@
+void alarm_handler(int, mcontext_t *);
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 08d3061..07d9905 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -26,7 +26,7 @@ void (*sig_info[NSIG])(int, struct uml_pt_regs *) = {
 	[SIGIO]		= sigio_handler,
 	[SIGVTALRM]	= timer_handler };
 
-static void sig_handler_common(int sig, struct sigcontext *sc)
+static void sig_handler_common(int sig, mcontext_t *mc)
 {
 	struct uml_pt_regs r;
 	int save_errno = errno;
@@ -34,8 +34,8 @@ static void sig_handler_common(int sig, struct sigcontext *sc)
 	r.is_user = 0;
 	if (sig == SIGSEGV) {
 		/* For segfaults, we want the data from the sigcontext. */
-		copy_sc(&r, sc);
-		GET_FAULTINFO_FROM_SC(r.faultinfo, sc);
+		copy_sc(&r, (struct sigcontext *)mc);
+		GET_FAULTINFO_FROM_MC(r.faultinfo, mc);
 	}
 
 	/* enable signals if sig isn't IRQ signal */
@@ -62,7 +62,7 @@ static void sig_handler_common(int sig, struct sigcontext *sc)
 static int signals_enabled;
 static unsigned int signals_pending;
 
-void sig_handler(int sig, struct sigcontext *sc)
+void sig_handler(int sig, mcontext_t *mc)
 {
 	int enabled;
 
@@ -74,23 +74,23 @@ void sig_handler(int sig, struct sigcontext *sc)
 
 	block_signals();
 
-	sig_handler_common(sig, sc);
+	sig_handler_common(sig, mc);
 
 	set_signals(enabled);
 }
 
-static void real_alarm_handler(struct sigcontext *sc)
+static void real_alarm_handler(mcontext_t *mc)
 {
 	struct uml_pt_regs regs;
 
-	if (sc != NULL)
-		copy_sc(&regs, sc);
+	if (mc != NULL)
+		copy_sc(&regs, (struct sigcontext *)mc);
 	regs.is_user = 0;
 	unblock_signals();
 	timer_handler(SIGVTALRM, &regs);
 }
 
-void alarm_handler(int sig, struct sigcontext *sc)
+void alarm_handler(int sig, mcontext_t *mc)
 {
 	int enabled;
 
@@ -102,7 +102,7 @@ void alarm_handler(int sig, struct sigcontext *sc)
 
 	block_signals();
 
-	real_alarm_handler(sc);
+	real_alarm_handler(mc);
 	set_signals(enabled);
 }
 
@@ -121,7 +121,7 @@ void set_sigstack(void *sig_stack, int size)
 		panic("enabling signal stack failed, errno = %d\n", errno);
 }
 
-static void (*handlers[_NSIG])(int sig, struct sigcontext *sc) = {
+static void (*handlers[_NSIG])(int sig, mcontext_t *mc) = {
 	[SIGSEGV] = sig_handler,
 	[SIGBUS] = sig_handler,
 	[SIGILL] = sig_handler,
@@ -133,8 +133,11 @@ static void (*handlers[_NSIG])(int sig, struct sigcontext *sc) = {
 	[SIGVTALRM] = alarm_handler
 };
 
-static void handle_signal(int sig, struct sigcontext *sc)
+
+static void hard_handler(int sig, siginfo_t *info, void *p)
 {
+	struct ucontext *uc = p;
+	mcontext_t *mc = &uc->uc_mcontext;
 	unsigned long pending = 1UL << sig;
 
 	do {
@@ -160,7 +163,7 @@ static void handle_signal(int sig, struct sigcontext *sc)
 		while ((sig = ffs(pending)) != 0){
 			sig--;
 			pending &= ~(1 << sig);
-			(*handlers[sig])(sig, sc);
+			(*handlers[sig])(sig, mc);
 		}
 
 		/*
@@ -174,12 +177,6 @@ static void handle_signal(int sig, struct sigcontext *sc)
 	} while (pending);
 }
 
-static void hard_handler(int sig, siginfo_t *info, void *p)
-{
-	struct ucontext *uc = p;
-	handle_signal(sig, (struct sigcontext *) &uc->uc_mcontext);
-}
-
 void set_handler(int sig)
 {
 	struct sigaction action;
diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index 995ca30..910499d 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -10,7 +10,7 @@
 #include <sys/time.h>
 #include "kern_util.h"
 #include "os.h"
-#include "process.h"
+#include "internal.h"
 
 int set_interval(void)
 {
diff --git a/arch/um/sys-x86/shared/sysdep/sigcontext_32.h b/arch/um/sys-x86/shared/sysdep/sigcontext_32.h
index aebc2dd..548c3cd 100644
--- a/arch/um/sys-x86/shared/sysdep/sigcontext_32.h
+++ b/arch/um/sys-x86/shared/sysdep/sigcontext_32.h
@@ -22,4 +22,11 @@
 		(fi).trap_no = SC_TRAPNO(sc); \
 	}
 
+#define GET_FAULTINFO_FROM_MC(fi, mc) \
+	{ \
+		(fi).cr2 = (mc)->cr2; \
+		(fi).error_code = (mc)->gregs[REG_ERR]; \
+		(fi).trap_no = (mc)->gregs[REG_TRAPNO]; \
+	}
+
 #endif
diff --git a/arch/um/sys-x86/shared/sysdep/sigcontext_64.h b/arch/um/sys-x86/shared/sysdep/sigcontext_64.h
index 60d89a2..5c4a6a3 100644
--- a/arch/um/sys-x86/shared/sysdep/sigcontext_64.h
+++ b/arch/um/sys-x86/shared/sysdep/sigcontext_64.h
@@ -22,4 +22,11 @@
 		(fi).trap_no = SC_TRAPNO(sc); \
 	}
 
+#define GET_FAULTINFO_FROM_MC(fi, mc) \
+	{ \
+		(fi).cr2 = (mc)->gregs[REG_CR2]; \
+		(fi).error_code = (mc)->gregs[REG_ERR]; \
+		(fi).trap_no = (mc)->gregs[REG_TRAPNO]; \
+	}
+
 #endif
diff --git a/arch/um/sys-x86/stub_segv.c b/arch/um/sys-x86/stub_segv.c
index f62771c..bd2eaf6 100644
--- a/arch/um/sys-x86/stub_segv.c
+++ b/arch/um/sys-x86/stub_segv.c
@@ -12,7 +12,7 @@ stub_segv_handler(int sig, siginfo_t *info, void *p)
 {
 	struct ucontext *uc = p;
 
-	GET_FAULTINFO_FROM_SC(*((struct faultinfo *) STUB_DATA),
+	GET_FAULTINFO_FROM_MC(*((struct faultinfo *) STUB_DATA),
 			      &uc->uc_mcontext);
 	trap_myself();
 }
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

