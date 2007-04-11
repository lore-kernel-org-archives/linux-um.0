Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HbfL6-00025H-4x for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Apr 2007 09:06:32 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HbfL5-0001U4-J8
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Apr 2007 09:06:32 -0700
Date: Wed, 11 Apr 2007 12:01:26 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070411160126.GA6329@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 3/4] UML - Dump core on panic
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

Dump core after a panic.  This will provide better debugging
information than is currently available.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/include/os.h     |    1 +
 arch/um/kernel/um_arch.c |    2 +-
 arch/um/os-Linux/util.c  |    6 ++++++
 3 files changed, 8 insertions(+), 1 deletion(-)

Index: linux-2.6.21-mm/arch/um/include/os.h
===================================================================
--- linux-2.6.21-mm.orig/arch/um/include/os.h	2007-04-06 10:36:33.000000000 -0400
+++ linux-2.6.21-mm/arch/um/include/os.h	2007-04-06 10:38:54.000000000 -0400
@@ -281,6 +281,7 @@ extern void setup_machinename(char *mach
 extern void setup_hostinfo(char *buf, int len);
 extern int setjmp_wrapper(void (*proc)(void *, void *), ...);
 extern void os_log_info(char *fmt, va_list ap);
+extern void os_dump_core(void);
 
 /* time.c */
 #define BILLION (1000 * 1000 * 1000)
Index: linux-2.6.21-mm/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/um_arch.c	2007-04-06 10:37:48.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/um_arch.c	2007-04-06 10:38:05.000000000 -0400
@@ -474,7 +474,7 @@ static int panic_exit(struct notifier_bl
 	show_regs(&(current->thread.regs));
 	bust_spinlocks(0);
 	uml_exitcode = 1;
-	machine_halt();
+	os_dump_core();
 	return 0;
 }
 
Index: linux-2.6.21-mm/arch/um/os-Linux/util.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/util.c	2007-04-05 13:25:28.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/util.c	2007-04-06 10:57:55.000000000 -0400
@@ -148,3 +148,9 @@ void os_log_info(char *fmt, va_list ap)
 	vsnprintf(&logging_buf[len], sizeof(logging_buf) - len, fmt, ap);
 	write(logging_fd, logging_buf, strlen(logging_buf));
 }
+
+void os_dump_core(void)
+{
+	signal(SIGSEGV, SIG_DFL);
+	abort();
+}

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
