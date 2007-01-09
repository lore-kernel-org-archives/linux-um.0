Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H46SM-0006eU-Al for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Jan 2007 18:11:18 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H46SL-0000z4-Pk
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Jan 2007 18:11:18 -0800
Message-Id: <200701090205.l0925lx1024391@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 08 Jan 2007 21:05:47 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/7] UML - Remove unused variable and function
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

syscall_index and next_syscall_index turn out not to be used.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/include/kern_util.h |    1 -
 arch/um/kernel/syscall.c    |   16 ----------------
 2 files changed, 17 deletions(-)

Index: linux-2.6.18-mm/arch/um/include/kern_util.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/kern_util.h	2007-01-08 16:15:33.000000000 -0500
+++ linux-2.6.18-mm/arch/um/include/kern_util.h	2007-01-08 16:29:07.000000000 -0500
@@ -61,7 +61,6 @@ extern int set_signals(int enable);
 extern void force_sigbus(void);
 extern int pid_to_processor_id(int pid);
 extern void deliver_signals(void *t);
-extern int next_syscall_index(int max);
 extern int next_trap_index(int max);
 extern void default_idle(void);
 extern void finish_fork(void);
Index: linux-2.6.18-mm/arch/um/kernel/syscall.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/syscall.c	2006-12-29 12:20:14.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/syscall.c	2007-01-08 16:29:14.000000000 -0500
@@ -149,22 +149,6 @@ long sys_olduname(struct oldold_utsname 
 	return error;
 }
 
-DEFINE_SPINLOCK(syscall_lock);
-
-static int syscall_index = 0;
-
-int next_syscall_index(int limit)
-{
-	int ret;
-
-	spin_lock(&syscall_lock);
-	ret = syscall_index;
-	if(++syscall_index == limit)
-		syscall_index = 0;
-	spin_unlock(&syscall_lock);
-	return(ret);
-}
-
 int kernel_execve(const char *filename, char *const argv[], char *const envp[])
 {
 	mm_segment_t fs;


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
