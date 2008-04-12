Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JkbvS-0002Rw-Vo for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Apr 2008 02:21:35 -0700
Received: from qb-out-0506.google.com ([72.14.204.235])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JkbvS-0006FP-IO
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Apr 2008 02:21:34 -0700
Received: by qb-out-0506.google.com with SMTP id c8so846433qbc.4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 12 Apr 2008 02:21:33 -0700 (PDT)
Date: Sat, 12 Apr 2008 17:17:47 +0800 (CST)
Message-Id: <20080412.171747.26924099.xiyou.wangcong@gmail.com>
From: WANG Cong <xiyou.wangcong@gmail.com>
Mime-Version: 1.0
Subject: [uml-devel] [Patch] arch/um/os-Linux/sys-i386/task_size.c: improve
	a bit
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
Cc: akpm@osdl.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net


Improve this code a bit: check sigaction's return value and remove a useless
fflush().

Cc: Jeff Dike <jdike@addtoit.com>
Signed-off-by: WANG Cong <wangcong@zeuux.org>

---

diff --git a/arch/um/os-Linux/sys-i386/task_size.c b/arch/um/os-Linux/sys-i386/task_size.c
index 48d211b..2b5bba5 100644
--- a/arch/um/os-Linux/sys-i386/task_size.c
+++ b/arch/um/os-Linux/sys-i386/task_size.c
@@ -88,7 +88,10 @@ unsigned long os_get_task_size(void)
 	sa.sa_handler = segfault;
 	sigemptyset(&sa.sa_mask);
 	sa.sa_flags = SA_NODEFER;
-	sigaction(SIGSEGV, &sa, &old);
+	if (sigaction(SIGSEGV, &sa, &old)) {
+		perror("os_get_task_size");
+		exit(1);
+	}
 
 	if (!page_ok(bottom)) {
 		fprintf(stderr, "Address 0x%x no good?\n",
@@ -110,11 +113,12 @@ unsigned long os_get_task_size(void)
 
 out:
 	/* Restore the old SIGSEGV handling */
-	sigaction(SIGSEGV, &old, NULL);
-
+	if (sigaction(SIGSEGV, &old, NULL)) {
+		perror("os_get_task_size");
+		exit(1);
+	}
 	top <<= UM_KERN_PAGE_SHIFT;
 	printf("0x%x\n", top);
-	fflush(stdout);
 
 	return top;
 }

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
