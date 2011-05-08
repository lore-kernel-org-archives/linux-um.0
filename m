Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <richard@nod.at>) id 1QJC2I-0007Wb-GL
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 May 2011 22:01:10 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.74) id 1QJC2H-0006pK-As
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 May 2011 22:01:10 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sun,  8 May 2011 23:59:43 +0200
Message-Id: <1304891985-11569-2-git-send-email-richard@nod.at>
In-Reply-To: <1304891985-11569-1-git-send-email-richard@nod.at>
References: <1304891985-11569-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 2/4] um: fix abort
To: linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net

os_dump_core() uses abort() to terminate UML in case of an
fatal error.
glibc's abort() calls raise(SIGABRT) which makes use of tgkill().
tgkill() has no effect within UML's kernel threads because they
are not pthreads. As fallback abort() executes an invalid instruction
to terminate the process. Therefore UML gets killed by SIGSEGV and
leaves a ugly log entry in the host's kernel ring buffer.

To get rid of this use our own abort routine.

 # Untracked files:

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/os-Linux/util.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index 6ea7797..42827ca 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -5,6 +5,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <unistd.h>
 #include <errno.h>
 #include <signal.h>
 #include <string.h>
@@ -75,6 +76,26 @@ void setup_hostinfo(char *buf, int len)
 		 host.release, host.version, host.machine);
 }
 
+/*
+ * We cannot use glibc's abort(). It makes use of tgkill() which
+ * has no effect within UML's kernel threads.
+ * After that glibc would execute an invalid instruction to kill
+ * the calling process and UML crashes with SIGSEGV.
+ */
+static inline void __attribute__ ((noreturn)) uml_abort(void)
+{
+	sigset_t sig;
+
+	fflush(NULL);
+
+	if (!sigemptyset(&sig) && !sigaddset(&sig, SIGABRT))
+		sigprocmask(SIG_UNBLOCK, &sig, 0);
+
+	for (;;)
+		if (kill(getpid(), SIGABRT) < 0)
+			exit(127);
+}
+
 void os_dump_core(void)
 {
 	int pid;
@@ -116,5 +137,5 @@ void os_dump_core(void)
 	while ((pid = waitpid(-1, NULL, WNOHANG | __WALL)) > 0)
 		os_kill_ptraced_process(pid, 0);
 
-	abort();
+	uml_abort();
 }
-- 
1.7.4.2


------------------------------------------------------------------------------
WhatsUp Gold - Download Free Network Management Software
The most intuitive, comprehensive, and cost-effective network 
management toolset available today.  Delivers lowest initial 
acquisition cost and overall TCO of any competing solution.
http://p.sf.net/sfu/whatsupgold-sd
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

