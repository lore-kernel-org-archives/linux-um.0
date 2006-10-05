Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GVayY-0006Sx-Jf for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 14:41:54 -0700
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GVayY-00025I-0r
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 14:41:54 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Thu, 05 Oct 2006 23:38:49 +0200
Message-Id: <20061005213849.17268.88029.stgit@memento.home.lan>
In-Reply-To: <20061005213212.17268.7409.stgit@memento.home.lan>
References: <20061005213212.17268.7409.stgit@memento.home.lan>
Subject: [uml-devel] [PATCH 05/14] uml: make TT mode compile after
	setjmp-related changes
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

Make TT mode compile after the introduction of klibc's implementation of setjmp.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/tt/uaccess_user.c |    6 +++---
 arch/um/os-Linux/tt.c            |    1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/um/kernel/tt/uaccess_user.c b/arch/um/kernel/tt/uaccess_user.c
index 6c92bbc..ed1abcf 100644
--- a/arch/um/kernel/tt/uaccess_user.c
+++ b/arch/um/kernel/tt/uaccess_user.c
@@ -4,13 +4,13 @@
  * Licensed under the GPL
  */
 
-#include <setjmp.h>
 #include <string.h>
 #include "user_util.h"
 #include "uml_uaccess.h"
 #include "task.h"
 #include "kern_util.h"
 #include "os.h"
+#include "longjmp.h"
 
 int __do_copy_from_user(void *to, const void *from, int n,
 			void **fault_addr, void **fault_catcher)
@@ -80,10 +80,10 @@ int __do_strnlen_user(const char *str, u
 	struct tt_regs save = TASK_REGS(get_current())->tt;
 	int ret;
 	unsigned long *faddrp = (unsigned long *)fault_addr;
-	sigjmp_buf jbuf;
+	jmp_buf jbuf;
 
 	*fault_catcher = &jbuf;
-	if(sigsetjmp(jbuf, 1) == 0)
+	if(UML_SETJMP(&jbuf) == 0)
 		ret = strlen(str) + 1;
 	else ret = *faddrp - (unsigned long) str;
 
diff --git a/arch/um/os-Linux/tt.c b/arch/um/os-Linux/tt.c
index 5461a06..3dc3a02 100644
--- a/arch/um/os-Linux/tt.c
+++ b/arch/um/os-Linux/tt.c
@@ -10,7 +10,6 @@ #include <sched.h>
 #include <errno.h>
 #include <stdarg.h>
 #include <stdlib.h>
-#include <setjmp.h>
 #include <sys/time.h>
 #include <sys/ptrace.h>
 #include <linux/ptrace.h>
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
