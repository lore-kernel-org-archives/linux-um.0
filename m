Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EvnYX-0000nE-Gi for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Jan 2006 19:18:49 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EvnYX-0004EH-0h
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Jan 2006 19:18:49 -0800
Message-Id: <200601090411.k094B90A001202@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 5/6] UML - Fix debug output on x86_64
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 08 Jan 2006 23:11:09 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

The debug-stub patch was broken on x86_64 because it thinks the
frame size there is 168 words.  In reality, it is 168 bytes, and
using HOST_FRAME_SIZE, which is expressed in consistent units across
architectures, fixes this.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/kernel/skas/process.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/skas/process.c	2006-01-05 16:19:59.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/skas/process.c	2006-01-05 17:44:53.000000000 -0500
@@ -68,7 +68,7 @@ void wait_stub_done(int pid, int sig, ch
 
         if((n < 0) || !WIFSTOPPED(status) ||
            (WSTOPSIG(status) != SIGUSR1 && WSTOPSIG(status) != SIGTRAP)){
-		unsigned long regs[FRAME_SIZE];
+		unsigned long regs[HOST_FRAME_SIZE];
 		if(ptrace(PTRACE_GETREGS, pid, 0, regs) < 0)
 			printk("Failed to get registers from stub, "
 			       "errno = %d\n", errno);
@@ -76,7 +76,7 @@ void wait_stub_done(int pid, int sig, ch
 			int i;
 
 			printk("Stub registers -\n");
-			for(i = 0; i < FRAME_SIZE; i++)
+			for(i = 0; i < HOST_FRAME_SIZE; i++)
 				printk("\t%d - %lx\n", i, regs[i]);
 		}
                 panic("%s : failed to wait for SIGUSR1/SIGTRAP, "



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
