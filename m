Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7tD-0001Wf-CE
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:04:27 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7tC-0003pr-Hc
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:04:27 +0000
Date: Thu, 18 Aug 2011 20:04:19 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7t5-0007fX-F1@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 32/91] um: don't bother blocking
 SIGARLM and SIGUSR1
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


We used to generate those, but we hadn't done that for a long
time.  No need to bother blocking them for signal handlers.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/os-Linux/process.c      |   13 ++++++-------
 arch/um/os-Linux/signal.c       |    2 +-
 arch/um/os-Linux/skas/process.c |    2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index 0ced30c..c1a8fa7 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -236,20 +236,19 @@ out:
 void init_new_thread_signals(void)
 {
 	set_handler(SIGSEGV, (__sighandler_t) sig_handler, SA_ONSTACK,
-		    SIGUSR1, SIGIO, SIGWINCH, SIGVTALRM, -1);
+		    SIGIO, SIGWINCH, SIGVTALRM, -1);
 	set_handler(SIGTRAP, (__sighandler_t) sig_handler, SA_ONSTACK,
-		    SIGUSR1, SIGIO, SIGWINCH, SIGVTALRM, -1);
+		    SIGIO, SIGWINCH, SIGVTALRM, -1);
 	set_handler(SIGFPE, (__sighandler_t) sig_handler, SA_ONSTACK,
-		    SIGUSR1, SIGIO, SIGWINCH, SIGVTALRM, -1);
+		    SIGIO, SIGWINCH, SIGVTALRM, -1);
 	set_handler(SIGILL, (__sighandler_t) sig_handler, SA_ONSTACK,
-		    SIGUSR1, SIGIO, SIGWINCH, SIGVTALRM, -1);
+		    SIGIO, SIGWINCH, SIGVTALRM, -1);
 	set_handler(SIGBUS, (__sighandler_t) sig_handler, SA_ONSTACK,
-		    SIGUSR1, SIGIO, SIGWINCH, SIGVTALRM, -1);
+		    SIGIO, SIGWINCH, SIGVTALRM, -1);
 	signal(SIGHUP, SIG_IGN);
 
 	set_handler(SIGIO, (__sighandler_t) sig_handler,
-		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH, SIGALRM,
-		    SIGVTALRM, -1);
+		    SA_ONSTACK | SA_RESTART, SIGIO, SIGWINCH, SIGVTALRM, -1);
 	signal(SIGWINCH, SIG_IGN);
 	signal(SIGTERM, SIG_DFL);
 }
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 2dde9f6..75c3e9c 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -112,7 +112,7 @@ void alarm_handler(int sig, struct sigcontext *sc)
 void timer_init(void)
 {
 	set_handler(SIGVTALRM, (__sighandler_t) alarm_handler,
-		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH, -1);
+		    SA_ONSTACK | SA_RESTART, SIGIO, SIGWINCH, -1);
 }
 
 void set_sigstack(void *sig_stack, int size)
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 896312d..6f9fc0d 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -643,7 +643,7 @@ int start_idle_thread(void *stack, jmp_buf *switch_buf)
 	int n;
 
 	set_handler(SIGWINCH, (__sighandler_t) sig_handler,
-		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGVTALRM, -1);
+		    SA_ONSTACK | SA_RESTART, SIGIO, SIGVTALRM, -1);
 
 	/*
 	 * Can't use UML_SETJMP or UML_LONGJMP here because they save
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

