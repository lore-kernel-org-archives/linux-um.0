Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KZDBd-000596-3Z for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 16:15:25 -0700
Received: from abydos.nerdbox.net ([216.151.149.55])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KZDBc-0005dr-Sj
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 16:15:25 -0700
Date: Fri, 29 Aug 2008 16:15:24 -0700 (PDT)
From: Steve VanDeBogart <vandebo-lkml@NerdBox.Net>
In-Reply-To: <alpine.DEB.1.00.0808281139420.15543@abydos.NerdBox.Net>
Message-ID: <alpine.DEB.1.00.0808291614430.15543@abydos.NerdBox.Net>
References: <alpine.DEB.1.00.0808281139420.15543@abydos.NerdBox.Net>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH 2/6] UML: Don't valgrind userspace
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, jiayingz@google.com, dkegel@google.com

Add a flag to tell Valgrind to run the forked child natively.  Necessary
because Valgrind makes additional system calls to instrumented processes,
which confuse UML.

Signed-off-by: Steve VanDeBogart <vandebo-lkml@nerdbox.net>
---

Index: linux-2.6.27-rc5/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.27-rc5.orig/arch/um/os-Linux/skas/process.c	2008-08-29 15:50:24.000000000 -0700
+++ linux-2.6.27-rc5/arch/um/os-Linux/skas/process.c	2008-08-29 15:51:45.000000000 -0700
@@ -26,6 +26,7 @@
  #include "skas_ptrace.h"
  #include "user.h"
  #include "sysdep/stub.h"
+#include "valgrind.h"

  int is_skas_winch(int pid, int fd, void *data)
  {
@@ -297,8 +298,12 @@
  	flags = CLONE_FILES;
  	if (proc_mm)
  		flags |= CLONE_VM;
-	else
+	else {
  		flags |= SIGCHLD;
+#ifdef UML_CONFIG_VALGRIND_SUPPORT
+		flags |= VALGRIND_CLONE_LETGO;
+#endif
+	}

  	pid = clone(userspace_tramp, (void *) sp, flags, (void *) stub_stack);
  	if (pid < 0) {

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
