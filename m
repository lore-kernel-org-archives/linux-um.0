Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOeaj-0007JK-Un for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Mar 2007 10:40:54 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HOeag-0006oi-8s
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Mar 2007 10:40:50 -0800
Message-Id: <200703061832.l26IW6Ua006554@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Tue, 06 Mar 2007 13:32:06 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/5] UML - print coredump limits
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Print out core dump limits at boot time.  This is to allow core dumps
to be collected if something goes very wrong and to tell if a core
dump isn't going to happen because of a resource limit.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/os-Linux/start_up.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

Index: test/arch/um/os-Linux/start_up.c
===================================================================
--- test.orig/arch/um/os-Linux/start_up.c	2007-03-06 10:21:43.000000000 -0500
+++ test/arch/um/os-Linux/start_up.c	2007-03-06 10:43:02.000000000 -0500
@@ -17,6 +17,7 @@
 #include <sys/time.h>
 #include <sys/wait.h>
 #include <sys/mman.h>
+#include <sys/resource.h>
 #include <asm/unistd.h>
 #include <asm/page.h>
 #include <sys/types.h>
@@ -329,8 +330,32 @@ static void __init check_ptrace(void)
 
 extern void check_tmpexec(void);
 
+static void check_coredump_limit(void)
+{
+	struct rlimit lim;
+	int err = getrlimit(RLIMIT_CORE, &lim);
+
+	if(err){
+		perror("Getting core dump limit");
+		return;
+	}
+
+	printf("Core dump limits :\n\tsoft - ");
+	if(lim.rlim_cur == RLIM_INFINITY)
+		printf("NONE\n");
+	else printf("%lu\n", lim.rlim_cur);
+
+	printf("\thard - ");
+	if(lim.rlim_max == RLIM_INFINITY)
+		printf("NONE\n");
+	else printf("%lu\n", lim.rlim_max);
+}
+
 void os_early_checks(void)
 {
+	/* Print out the core dump limits early */
+	check_coredump_limit();
+
 	check_ptrace();
 
 	/* Need to check this early because mmapping happens before the


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
