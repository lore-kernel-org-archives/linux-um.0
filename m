Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JgLgg-0001vW-8R for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Mar 2008 08:12:42 -0700
Received: from qb-out-0506.google.com ([72.14.204.235])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JgLgf-0005GP-3D
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Mar 2008 08:12:42 -0700
Received: by qb-out-0506.google.com with SMTP id c8so97563qbc.4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 31 Mar 2008 08:12:40 -0700 (PDT)
Date: Mon, 31 Mar 2008 23:10:01 +0800 (CST)
Message-Id: <20080331.231001.18971784.xiyou.wangcong@gmail.com>
From: WANG Cong <xiyou.wangcong@gmail.com>
Mime-Version: 1.0
Subject: [uml-devel] [PATCH] arch/um/os-Linux/start_up.c: various improvements.
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
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net


This patch

 - lets ptrace_child become void
 - adds checking for the return value of change_sig
 - moves errors info into stderr instead of stdout.


Cc: jdike@addtoit.com
Signed-off-by: WANG Cong <wangcong@zeuux.org>

---
 arch/um/os-Linux/start_up.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index b616e15..997d019 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -25,15 +25,15 @@
 #include "registers.h"
 #include "skas_ptrace.h"
 
-static int ptrace_child(void)
+static void ptrace_child(void)
 {
 	int ret;
 	/* Calling os_getpid because some libcs cached getpid incorrectly */
 	int pid = os_getpid(), ppid = getppid();
 	int sc_result;
 
-	change_sig(SIGWINCH, 0);
-	if (ptrace(PTRACE_TRACEME, 0, 0, 0) < 0) {
+	if (change_sig(SIGWINCH, 0) < 0 ||
+	    ptrace(PTRACE_TRACEME, 0, 0, 0) < 0) {
 		perror("ptrace");
 		kill(pid, SIGKILL);
 	}
@@ -75,9 +75,8 @@ static void fatal(char *fmt, ...)
 	va_list list;
 
 	va_start(list, fmt);
-	vprintf(fmt, list);
+	vfprintf(stderr, fmt, list);
 	va_end(list);
-	fflush(stdout);
 
 	exit(1);
 }
@@ -87,9 +86,8 @@ static void non_fatal(char *fmt, ...)
 	va_list list;
 
 	va_start(list, fmt);
-	vprintf(fmt, list);
+	vfprintf(stderr, fmt, list);
 	va_end(list);
-	fflush(stdout);
 }
 
 static int start_ptraced_child(void)
@@ -495,7 +493,7 @@ int __init parse_iomem(char *str, int *add)
 	driver = str;
 	file = strchr(str,',');
 	if (file == NULL) {
-		printf("parse_iomem : failed to parse iomem\n");
+		fprintf(stderr, "parse_iomem : failed to parse iomem\n");
 		goto out;
 	}
 	*file = '\0';
-- 
1.5.2.4


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
