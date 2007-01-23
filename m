Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H9RPJ-0003Th-2C for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Jan 2007 11:34:13 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H9RPH-0005i5-4Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Jan 2007 11:34:13 -0800
Message-Id: <200701231927.l0NJRj1w005358@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Tue, 23 Jan 2007 14:27:45 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 5/7] UML - style fixes in startup code
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

Some style fixes in startup.c.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/os-Linux/start_up.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6.18-mm/arch/um/os-Linux/start_up.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/start_up.c	2007-01-13 17:58:49.000000000 +1100
+++ linux-2.6.18-mm/arch/um/os-Linux/start_up.c	2007-01-13 18:00:47.000000000 +1100
@@ -95,7 +95,7 @@ static int start_ptraced_child(void **st
 		      status);
 
 	*stack_out = stack;
-	return(pid);
+	return pid;
 }
 
 /* When testing for SYSEMU support, if it is one of the broken versions, we
@@ -182,7 +182,7 @@ __uml_setup("nosysemu", nosysemu_cmd_par
 static void __init check_sysemu(void)
 {
 	void *stack;
- 	int pid, n, status, count=0;
+	int pid, n, status, count=0;
 
 	printf("Checking syscall emulation patch for ptrace...");
 	sysemu_supported = 0;
@@ -418,7 +418,7 @@ static inline void check_skas3_proc_mm(v
 {
 	printf("  - /proc/mm...");
 	if (os_access("/proc/mm", OS_ACC_W_OK) < 0) {
- 		proc_mm = 0;
+		proc_mm = 0;
 		printf("not found\n");
 	}
 	else {
@@ -445,7 +445,7 @@ int can_do_skas(void)
 #else
 int can_do_skas(void)
 {
-	return(0);
+	return 0;
 }
 #endif
 
@@ -493,11 +493,11 @@ int __init parse_iomem(char *str, int *a
 	iomem_regions = new;
 	iomem_size += new->size + UM_KERN_PAGE_SIZE;
 
-	return(0);
+	return 0;
  out_close:
 	os_close_file(fd);
  out:
-	return(1);
+	return 1;
 }
 
 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
