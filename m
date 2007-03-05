Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOM0J-0002Db-M1 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 14:50:03 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HOM0I-00015q-1z
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 14:50:03 -0800
Message-Id: <200703052241.l25MfL46008440@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 05 Mar 2007 17:41:21 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/4] UML - Comment the initialization of a global
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

Comment the fact that sig_info is initialized early in boot, and thus doesn't
need any locking.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/os-Linux/trap.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.18-mm/arch/um/os-Linux/trap.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/trap.c	2006-12-30 04:20:14.000000000 +1100
+++ linux-2.6.18-mm/arch/um/os-Linux/trap.c	2007-01-16 10:38:21.000000000 +1100
@@ -16,6 +16,7 @@ void usr2_handler(int sig, union uml_pt_
 	CHOOSE_MODE(syscall_handler_tt(sig, regs), (void) 0);
 }
 
+/* Initialized from linux_main() */
 void (*sig_info[NSIG])(int, union uml_pt_regs *);
 
 void os_fill_handlinfo(struct kern_handlers h)


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
