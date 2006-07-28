Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G6IgS-0005cC-OV for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Jul 2006 20:06:41 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G6IgS-0007dw-5L
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Jul 2006 20:06:40 -0700
Message-Id: <200607280306.k6S36UcA007951@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Thu, 27 Jul 2006 23:06:30 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 7/7] UML - Improve SIGBUS diagnostics
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

UML can get a SIGBUS anywhere if the tmpfs mount being used for its
memory runs out of space.  This patch adds a printk before the panic
to provide a clue as to what likely went wrong.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/kernel/trap.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/trap.c	2006-07-12 10:47:56.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/trap.c	2006-07-13 16:27:40.000000000 -0400
@@ -227,9 +227,16 @@ void bad_segv(struct faultinfo fi, unsig
 
 void relay_signal(int sig, union uml_pt_regs *regs)
 {
-	if(arch_handle_signal(sig, regs)) return;
-	if(!UPT_IS_USER(regs))
+	if(arch_handle_signal(sig, regs))
+		return;
+
+	if(!UPT_IS_USER(regs)){
+		if(sig == SIGBUS)
+			printk("Bus error - the /dev/shm or /tmp mount likely "
+			       "just ran out of space\n");
 		panic("Kernel mode signal %d", sig);
+	}
+
         current->thread.arch.faultinfo = *UPT_FAULTINFO(regs);
 	force_sig(sig, current);
 }


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
