Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hlspw-0008Jt-Oa for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 May 2007 13:32:36 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hlspu-0003VX-5a
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 May 2007 13:32:36 -0700
Date: Wed, 9 May 2007 16:27:20 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070509202720.GA22449@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 2/6] UML - Use UM_THREAD_SIZE in userspace code
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
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Now that we have UM_THREAD_SIZE, we can replace the calculations in
user-space code (an earlier patch took care of the kernel side of the
house).

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/kernel/init_task.c      |    3 +--
 arch/um/os-Linux/skas/process.c |    7 +++----
 2 files changed, 4 insertions(+), 6 deletions(-)

Index: linux-2.6.21-mm/arch/um/kernel/init_task.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/init_task.c	2007-05-07 15:01:10.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/init_task.c	2007-05-08 10:06:07.000000000 -0400
@@ -44,8 +44,7 @@ __attribute__((__section__(".data.init_t
 
 void unprotect_stack(unsigned long stack)
 {
-	os_protect_memory((void *) stack, (1 << CONFIG_KERNEL_STACK_ORDER) * PAGE_SIZE,
-		       1, 1, 0);
+	os_protect_memory((void *) stack, THREAD_SIZE, 1, 1, 0);
 }
 
 /*
Index: linux-2.6.21-mm/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/skas/process.c	2007-05-07 15:35:31.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/skas/process.c	2007-05-08 10:06:07.000000000 -0400
@@ -490,8 +490,8 @@ void map_stub_pages(int fd, unsigned lon
 void new_thread(void *stack, jmp_buf *buf, void (*handler)(void))
 {
 	(*buf)[0].JB_IP = (unsigned long) handler;
-	(*buf)[0].JB_SP = (unsigned long) stack +
-		(PAGE_SIZE << UML_CONFIG_KERNEL_STACK_ORDER) - sizeof(void *);
+	(*buf)[0].JB_SP = (unsigned long) stack + UM_THREAD_SIZE -
+		sizeof(void *);
 }
 
 #define INIT_JMP_NEW_THREAD 0
@@ -533,8 +533,7 @@ int start_idle_thread(void *stack, jmp_b
 	case INIT_JMP_NEW_THREAD:
 		(*switch_buf)[0].JB_IP = (unsigned long) new_thread_handler;
 		(*switch_buf)[0].JB_SP = (unsigned long) stack +
-			(PAGE_SIZE << UML_CONFIG_KERNEL_STACK_ORDER) -
-			sizeof(void *);
+			UM_THREAD_SIZE - sizeof(void *);
 		break;
 	case INIT_JMP_CALLBACK:
 		(*cb_proc)(cb_arg);

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
