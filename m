Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J2ZcO-00014V-0I for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Dec 2007 13:59:54 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J2ZcK-0005IN-Jj
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Dec 2007 13:59:51 -0800
Date: Wed, 12 Dec 2007 15:47:59 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071212204759.GA9134@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 4/6] UML - Don't allow processes to call into stub
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
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Kill a process that tries to branch into a stub and execute a system
call.  There are no security implications here - a system call in a
stub is treated the same as a system call anywhere else.  But if a
process is trying to branch into a stub, either it is trying something
nasty or it has gone haywire, so it's a good idea to get rid of it in
either case.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/os-Linux/skas/process.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6.22/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/skas/process.c	2007-12-05 12:51:53.000000000 -0500
+++ linux-2.6.22/arch/um/os-Linux/skas/process.c	2007-12-05 16:34:55.000000000 -0500
@@ -146,6 +146,9 @@ static void handle_trap(int pid, struct 
 {
 	int err, status;
 
+	if ((UPT_IP(regs) >= STUB_START) && (UPT_IP(regs) < STUB_END))
+		fatal_sigsegv();
+
 	/* Mark this as a syscall */
 	UPT_SYSCALL_NR(regs) = PT_SYSCALL_NR(regs->gp);
 

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
