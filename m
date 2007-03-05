Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOKG7-0006r1-3h for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 12:58:28 -0800
Received: from mbox.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HOKG5-0000Kl-Fi
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 12:58:15 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Mon, 05 Mar 2007 21:49:05 +0100
Message-Id: <20070305204905.9072.7715.stgit@americanbeauty.home.lan>
In-Reply-To: <20070305204229.9072.17032.stgit@americanbeauty.home.lan>
References: <20070305204229.9072.17032.stgit@americanbeauty.home.lan>
Subject: [uml-devel] [PATCH 07/11] uml: remove dead code about
	os_usr1_signal() and os_usr1_process()
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

os_usr1_signal() is totally unused, os_usr1_process() is used only by TT mode.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/os.h       |    3 ++-
 arch/um/os-Linux/process.c |    3 +++
 arch/um/os-Linux/signal.c  |    5 -----
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/um/include/os.h b/arch/um/include/os.h
index 8629bd1..5c74da4 100644
--- a/arch/um/include/os.h
+++ b/arch/um/include/os.h
@@ -192,7 +192,9 @@ extern int os_process_parent(int pid);
 extern void os_stop_process(int pid);
 extern void os_kill_process(int pid, int reap_child);
 extern void os_kill_ptraced_process(int pid, int reap_child);
+#ifdef UML_CONFIG_MODE_TT
 extern void os_usr1_process(int pid);
+#endif
 extern long os_ptrace_ldt(long pid, long addr, long data);
 
 extern int os_getpid(void);
@@ -261,7 +263,6 @@ extern void block_signals(void);
 extern void unblock_signals(void);
 extern int get_signals(void);
 extern int set_signals(int enable);
-extern void os_usr1_signal(int on);
 
 /* trap.c */
 extern void os_fill_handlinfo(struct kern_handlers h);
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index c692a19..76bdd67 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -21,6 +21,7 @@
 #include "longjmp.h"
 #include "skas_ptrace.h"
 #include "kern_constants.h"
+#include "uml-config.h"
 
 #define ARBITRARY_ADDR -1
 #define FAILURE_PID    -1
@@ -131,10 +132,12 @@ void os_kill_ptraced_process(int pid, int reap_child)
 		CATCH_EINTR(waitpid(pid, NULL, 0));
 }
 
+#ifdef UML_CONFIG_MODE_TT
 void os_usr1_process(int pid)
 {
 	kill(pid, SIGUSR1);
 }
+#endif
 
 /* Don't use the glibc version, which caches the result in TLS. It misses some
  * syscalls, and also breaks with clone(), which does not unshare the TLS.
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index b897e85..2667686 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -243,8 +243,3 @@ int set_signals(int enable)
 
 	return ret;
 }
-
-void os_usr1_signal(int on)
-{
-	change_sig(SIGUSR1, on);
-}


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
